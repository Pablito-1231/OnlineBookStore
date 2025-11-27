package com.shashirajraja.onlinebookstore.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.util.Arrays;
import java.util.List;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class DbCleanup {

    private static final Logger logger = LoggerFactory.getLogger(DbCleanup.class);

    // Ejecutar desde proyecto con: mvn compile exec:java -Dexec.mainClass=com.shashirajraja.onlinebookstore.util.DbCleanup
    public static void main(String[] args) throws Exception {
        String url = System.getenv().getOrDefault("DB_URL", "jdbc:mysql://localhost:3306/onlinebookstore?useSSL=false&serverTimezone=UTC");
        String user = System.getenv().getOrDefault("DB_USERNAME", "root");
        String pass = System.getenv().getOrDefault("DB_PASSWORD", "");

        List<String> toDelete = Arrays.asList("prueba_auto", "prueba1", "testuser1", "prueba", "prueba_auto_old");
        if (args != null && args.length > 0) {
            toDelete = Arrays.asList(args);
        }

        try (Connection conn = DriverManager.getConnection(url, user, pass)) {
            conn.setAutoCommit(false);

            // Limpiar tablas que referencian al customer
            try (PreparedStatement p = conn.prepareStatement("DELETE FROM purchase_detail WHERE purchase_history_id IN (SELECT id FROM purchase_history WHERE customer_id = ?)")) {
                for (String u : toDelete) {
                    p.setString(1, u);
                    p.executeUpdate();
                }
            }

            try (PreparedStatement p = conn.prepareStatement("DELETE FROM purchase_history WHERE customer_id = ?")) {
                for (String u : toDelete) {
                    p.setString(1, u);
                    p.executeUpdate();
                }
            }

            try (PreparedStatement p = conn.prepareStatement("DELETE FROM shopping_cart WHERE customer_id = ?")) {
                for (String u : toDelete) {
                    p.setString(1, u);
                    p.executeUpdate();
                }
            }

            try (PreparedStatement p = conn.prepareStatement("DELETE FROM book_user WHERE customer_id = ?")) {
                for (String u : toDelete) {
                    p.setString(1, u);
                    p.executeUpdate();
                }
            }

            // Authorities must borrarse antes que users
            try (PreparedStatement p = conn.prepareStatement("DELETE FROM authorities WHERE username = ?")) {
                for (String u : toDelete) {
                    p.setString(1, u);
                    p.executeUpdate();
                }
            }

            // Finalmente users y customer
            try (PreparedStatement p = conn.prepareStatement("DELETE FROM users WHERE username = ?")) {
                for (String u : toDelete) {
                    p.setString(1, u);
                    p.executeUpdate();
                }
            }

            try (PreparedStatement p = conn.prepareStatement("DELETE FROM customer WHERE id = ?")) {
                for (String u : toDelete) {
                    p.setString(1, u);
                    p.executeUpdate();
                }
            }

            conn.commit();
            logger.info("Limpieza completada para: {}", toDelete);
        } catch (Exception e) {
            logger.error("Error durante limpieza: {}", e.getMessage(), e);
            throw e;
        }
    }
}
