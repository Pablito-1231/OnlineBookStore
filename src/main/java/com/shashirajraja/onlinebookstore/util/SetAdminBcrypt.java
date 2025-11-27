package com.shashirajraja.onlinebookstore.util;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

public class SetAdminBcrypt {
    private static final Logger logger = LoggerFactory.getLogger(SetAdminBcrypt.class);
    public static void main(String[] args) {
        String url = System.getenv().getOrDefault("DB_URL", "jdbc:mysql://localhost:3306/onlinebookstore?useSSL=false&serverTimezone=UTC");
        String user = System.getenv().getOrDefault("DB_USERNAME", "root");
        String pass = System.getenv().getOrDefault("DB_PASSWORD", "");

        String adminPlain = System.getenv().getOrDefault("ADMIN_PLAIN","admin");

        BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
        String bcryptHash = encoder.encode(adminPlain);
        String stored = "{bcrypt}" + bcryptHash;

        logger.info("Using DB URL: {}", url);
        logger.info("Updating admin password to bcrypt-hash (not printing actual hash)");

        try (Connection c = DriverManager.getConnection(url, user, pass)) {
            String sql = "UPDATE users SET password = ? WHERE username = 'admin' OR username = ?";
            try (PreparedStatement ps = c.prepareStatement(sql)) {
                ps.setString(1, stored);
                ps.setString(2, "admin");
                int rows = ps.executeUpdate();
                logger.info("Rows updated: {}", rows);
            }
        } catch (Exception e) {
            logger.error("Error updating admin password: {}", e.getMessage(), e);
            System.exit(1);
        }

        logger.info("Done.");
    }
}
