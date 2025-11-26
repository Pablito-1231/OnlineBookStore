package com.shashirajraja.onlinebookstore.security;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.crypto.factory.PasswordEncoderFactories;

/**
 * Clase de utilidad para generar y verificar hashes de contraseñas
 * Ejecuta el método main para generar nuevos hashes
 */
public class PasswordHashGenerator {

    public static void main(String[] args) {
        // Crear el encoder que usa la aplicación
        PasswordEncoder encoder = PasswordEncoderFactories.createDelegatingPasswordEncoder();
        
        System.out.println("=== GENERADOR DE HASHES DE CONTRASEÑAS ===\n");
        
        // Generar hash para admin123
        String rawPasswordAdmin = "admin123";
        String encodedAdmin = encoder.encode(rawPasswordAdmin);
        System.out.println("Contraseña raw: " + rawPasswordAdmin);
        System.out.println("Hash generado: " + encodedAdmin);
        System.out.println("Para usar en SQL: INSERT INTO users VALUES ('admin', '" + encodedAdmin + "', 1);\n");
        
        // Generar hash para customer123
        String rawPasswordCustomer = "customer123";
        String encodedCustomer = encoder.encode(rawPasswordCustomer);
        System.out.println("Contraseña raw: " + rawPasswordCustomer);
        System.out.println("Hash generado: " + encodedCustomer);
        System.out.println("Para usar en SQL: INSERT INTO users VALUES ('customer', '" + encodedCustomer + "', 1);\n");
        
        // Verificar el hash existente
        String existingHash = "{bcrypt}$2a$10$QtyKIBGFIv.fg1/TRsG6jeKOxyBo3thuRbp0WVYC0tBq3sytHoMV.";
        System.out.println("=== VERIFICACIÓN DE HASH EXISTENTE ===");
        System.out.println("Hash en data.sql: " + existingHash);
        
        // Probar con BCryptPasswordEncoder directo
        BCryptPasswordEncoder bcrypt = new BCryptPasswordEncoder();
        String hashSinPrefijo = "$2a$10$QtyKIBGFIv.fg1/TRsG6jeKOxyBo3thuRbp0WVYC0tBq3sytHoMV.";
        
        boolean matches1 = bcrypt.matches("admin123", hashSinPrefijo);
        System.out.println("¿Hash sin prefijo coincide con 'admin123'? " + matches1);
        
        boolean matches2 = encoder.matches("admin123", existingHash);
        System.out.println("¿Hash con prefijo coincide con 'admin123'? " + matches2);
        
        System.out.println("\n=== HASHES ALTERNATIVOS (para testing) ===");
        System.out.println("Sin encriptar (noop): {noop}admin123");
        System.out.println("Usa esto en data.sql si bcrypt no funciona\n");
        
        System.out.println("=== INSTRUCCIONES ===");
        System.out.println("1. Copia el hash generado arriba");
        System.out.println("2. Actualiza data.sql con el nuevo hash");
        System.out.println("3. Reinicia la aplicación");
        System.out.println("4. O ejecuta fix-admin-user.sql manualmente en MySQL");
    }
}
