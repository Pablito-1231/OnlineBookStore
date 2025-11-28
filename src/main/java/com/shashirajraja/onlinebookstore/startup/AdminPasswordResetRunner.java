package com.shashirajraja.onlinebookstore.startup;

import java.sql.Connection;
import java.sql.DatabaseMetaData;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Optional;
import java.util.Set;

import javax.sql.DataSource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.event.EventListener;
import org.springframework.core.env.Environment;
import org.springframework.stereotype.Component;
import org.springframework.boot.context.event.ApplicationReadyEvent;
import org.springframework.transaction.annotation.Transactional;

import com.shashirajraja.onlinebookstore.dao.UserRepository;
import com.shashirajraja.onlinebookstore.entity.Authority;
import com.shashirajraja.onlinebookstore.entity.User;

@Component
public class AdminPasswordResetRunner {
    private static final Logger log = LoggerFactory.getLogger(AdminPasswordResetRunner.class);

    @Value("${app.admin.reset-password:false}")
    private boolean resetPassword;

    // contraseña que se aplicará cuando resetPassword=true
    @Value("${app.admin.reset-value:Admin2025!}")
    private String newAdminPassword;

    @Autowired
    private org.springframework.security.crypto.password.PasswordEncoder passwordEncoder;

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private DataSource dataSource;

    @Autowired
    private Environment env;

    @EventListener(ApplicationReadyEvent.class)
    @Transactional
    public void onApplicationReady() {
        if (!resetPassword) {
            log.debug("AdminPasswordResetRunner: propiedad app.admin.reset-password=false (no se realiza cambio)");
            return;
        }

        // Comprobar propiedad de hibernate DDL para asegurarnos de que el proceso de auto-creación/actualización está activo
        String ddlAuto = env.getProperty("spring.jpa.hibernate.ddl-auto", "").toLowerCase();
        Set<String> allowed = Set.of("create", "create-drop", "update");
        if (!allowed.contains(ddlAuto)) {
            log.info("spring.jpa.hibernate.ddl-auto='{}'. No está habilitada la auto-creación/actualización del esquema. Se omite el reset seguro de admin.", ddlAuto);
            return;
        }

        try {
            // Si el usuario admin ya existe, no realizar cambios. Esto evita sobrescribir contraseñas
            Optional<User> adminOpt = userRepository.findById("admin");
            if (adminOpt.isPresent()) {
                log.info("Usuario 'admin' ya existe; se omite el reset de contraseña para no sobrescribir credenciales existentes.");
                return;
            }

            // Intentar comprobar si la tabla 'users' existe (si queremos asegurar que la BD/tabla fue creada)
            boolean usersTableExists = false;
            try (Connection conn = dataSource.getConnection()) {
                DatabaseMetaData meta = conn.getMetaData();
                try (ResultSet rs = meta.getTables(null, null, "users", new String[] {"TABLE"})) {
                    usersTableExists = rs.next();
                }
                if (!usersTableExists) {
                    // También comprobar mayúsculas/minúsculas comunes
                    try (ResultSet rs2 = meta.getTables(null, null, "USERS", new String[] {"TABLE"})) {
                        usersTableExists = rs2.next();
                    }
                }
            } catch (SQLException sqle) {
                log.warn("No se pudo comprobar la metadata de la BD: {}. Continuando con creación si es necesario.", sqle.getMessage());
            }

            if (!usersTableExists) {
                log.info("La tabla 'users' no existe aún, asumiendo BD no inicializada. Procederé a crear el usuario admin si es posible.");
            } else {
                log.info("La tabla 'users' existe pero no se encontró el usuario 'admin'. Se creará el usuario admin.");
            }

            // Crear nuevo usuario 'admin' con ROLE_ADMIN
            String encoded = passwordEncoder.encode(newAdminPassword);
            User admin = new User();
            admin.setUsername("admin");
            admin.setPassword(encoded);
            admin.setEnabled(true);

            Authority auth = new Authority(admin, "ROLE_ADMIN");
            admin.addAuthority(auth);

            userRepository.save(admin);
            log.info("Se creó el usuario 'admin' con contraseña segura. Reinicia la aplicación sin la propiedad to avoid repetir la operación.");

        } catch (Exception e) {
            log.error("Error creando/actualizando usuario admin: {}", e.getMessage(), e);
        }
    }
}
