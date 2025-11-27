package com.shashirajraja.onlinebookstore.util;

import java.nio.file.Files;
import java.nio.file.Path;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;
import java.util.stream.Collectors;

public class RunCleanupSql {

    public static void main(String[] args) throws Exception {
        String defaultUrl = "jdbc:mysql://localhost:3306/onlinebookstore?useSSL=false&serverTimezone=UTC";
        String url = System.getenv().getOrDefault("DB_URL", defaultUrl);
        String user = System.getenv().getOrDefault("DB_USERNAME", "root");
        String pass = System.getenv().getOrDefault("DB_PASSWORD", "");

        Path script = Path.of("scripts", "cleanup_test_users.sql");
        if (!Files.exists(script)) {
            System.err.println("Script not found: " + script.toAbsolutePath());
            System.exit(2);
        }

        String sql = Files.lines(script).collect(Collectors.joining("\n"));

        try (Connection conn = DriverManager.getConnection(url, user, pass)) {
            conn.setAutoCommit(false);
            try (Statement st = conn.createStatement()) {
                // Split by semicolon; execute each statement separately
                String[] parts = sql.split(";\s*\n");
                for (String p : parts) {
                    String s = p.trim();
                    if (s.isEmpty()) continue;
                    // Ensure statement ends without trailing semicolon
                    if (s.endsWith(";")) s = s.substring(0, s.length()-1);
                    System.out.println("Executing: " + (s.length() > 120 ? s.substring(0, 120) + "..." : s));
                    st.executeUpdate(s);
                }
            }
            conn.commit();
            System.out.println("Cleanup script executed successfully.");
        } catch (Exception e) {
            System.err.println("Error executing script: " + e.getMessage());
            e.printStackTrace(System.err);
            System.exit(3);
        }
    }
}
