package com.shashirajraja.onlinebookstore.config;

import jakarta.annotation.PostConstruct;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Component;

import java.security.SecureRandom;

@Component
public class DataInitializer {

    private static final Logger log = LoggerFactory.getLogger(DataInitializer.class);

    @Autowired
    private JdbcTemplate jdbc;

    @Autowired
    private PasswordEncoder passwordEncoder;

    @PostConstruct
    public void init() {
        try {
            // Insertar roles si no existen
            jdbc.update("INSERT IGNORE INTO roles (id, name) VALUES (?, ?)", 1, "ROLE_ADMIN");
            jdbc.update("INSERT IGNORE INTO roles (id, name) VALUES (?, ?)", 2, "ROLE_CUSTOMER");
            jdbc.update("INSERT IGNORE INTO roles (id, name) VALUES (?, ?)", 3, "ROLE_PROVIDER");

            // Preparar contraseña del admin desde variable de entorno o generar una segura
            String adminPass = System.getenv("ADMIN_PASSWORD");
            boolean generated = false;
            if (adminPass == null || adminPass.isBlank()) {
                adminPass = generateRandomPassword(16);
                generated = true;
            }

            String encoded = passwordEncoder.encode(adminPass);

            // Insertar o actualizar usuario admin de forma idempotente
            jdbc.update("INSERT INTO users (username, password, enabled) VALUES (?, ?, ?) ON DUPLICATE KEY UPDATE password=VALUES(password), enabled=VALUES(enabled)", "admin", encoded, 1);
            jdbc.update("INSERT IGNORE INTO authorities (username, authority) VALUES (?, ?)", "admin", "ROLE_ADMIN");

            if (generated) {
                // No imprimir la contraseña en consola por seguridad.
                log.debug("DataInitializer: se generó una contraseña ADMIN (no mostrada). Establece ADMIN_PASSWORD en el entorno para controlarla.");
            }
        } catch (Exception e) {
            // Si las tablas no existen aún, no detener el arranque
            log.warn("DataInitializer: no fue posible insertar datos maestros ahora: {}", e.getMessage());
        }
    }

    private String generateRandomPassword(int length) {
        final String chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!@#$%&*()-_=+";
        SecureRandom rnd = new SecureRandom();
        StringBuilder sb = new StringBuilder(length);
        for (int i = 0; i < length; i++) {
            sb.append(chars.charAt(rnd.nextInt(chars.length())));
        }
        return sb.toString();
    }
}
