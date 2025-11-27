package com.shashirajraja.onlinebookstore.util;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

public class SetAdminBcrypt {
    public static void main(String[] args) {
        String url = System.getenv().getOrDefault("DB_URL", "jdbc:mysql://localhost:3306/onlinebookstore?useSSL=false&serverTimezone=UTC");
        String user = System.getenv().getOrDefault("DB_USERNAME", "root");
        String pass = System.getenv().getOrDefault("DB_PASSWORD", "");

        String adminPlain = System.getenv().getOrDefault("ADMIN_PLAIN","admin");

        BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
        String bcryptHash = encoder.encode(adminPlain);
        String stored = "{bcrypt}" + bcryptHash;

        System.out.println("Using DB URL: " + url);
        System.out.println("Updating admin password to bcrypt-hash (not printing actual hash)");

        try (Connection c = DriverManager.getConnection(url, user, pass)) {
            String sql = "UPDATE users SET password = ? WHERE username = 'admin' OR username = ?";
            try (PreparedStatement ps = c.prepareStatement(sql)) {
                ps.setString(1, stored);
                ps.setString(2, "admin");
                int rows = ps.executeUpdate();
                System.out.println("Rows updated: " + rows);
            }
        } catch (Exception e) {
            System.err.println("Error updating admin password: " + e.getMessage());
            e.printStackTrace();
            System.exit(1);
        }

        System.out.println("Done.");
    }
}
