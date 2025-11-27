package com.shashirajraja.onlinebookstore.util;

import java.nio.file.Files;
import java.nio.file.Path;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;
import java.util.stream.Collectors;

public class ExecuteSqlScript {
    public static void main(String[] args) throws Exception {
        String url = System.getenv().getOrDefault("DB_URL", "jdbc:mysql://localhost:3306/onlinebookstore?useSSL=false&serverTimezone=UTC");
        String user = System.getenv().getOrDefault("DB_USERNAME", "root");
        String pass = System.getenv().getOrDefault("DB_PASSWORD", "");

        Path script = Path.of("scripts", "cleanup_keep_admin.sql");
        if (!Files.exists(script)) {
            System.err.println("Script no encontrado: " + script.toAbsolutePath());
            System.exit(2);
        }

        System.out.println("Connecting to DB: " + url);
        try (Connection c = DriverManager.getConnection(url, user, pass)) {
            c.setAutoCommit(false);
            try (Statement st = c.createStatement()) {
                int total = 0;

                // Ensure FK checks disabled so deletions don't fail due to ordering
                st.execute("SET FOREIGN_KEY_CHECKS=0");

                String[] ordered = new String[] {
                    "DELETE FROM purchase_detail",
                    "DELETE FROM purchase_history",
                    "DELETE FROM book_user",
                    "DELETE FROM shopping_cart",
                    "DELETE FROM customer",
                    "DELETE FROM authorities WHERE username != 'admin'",
                    "DELETE FROM users WHERE username != 'admin'"
                };

                for (String sql : ordered) {
                    try {
                        int affected = st.executeUpdate(sql);
                        System.out.println("Executed: " + sql + " -> " + affected + " rows");
                        total += affected;
                    } catch (Exception e) {
                        System.err.println("Failed statement: " + sql);
                        e.printStackTrace();
                    }
                }

                // Re-enable FK checks
                st.execute("SET FOREIGN_KEY_CHECKS=1");

                c.commit();
                System.out.println("Total affected (sum of update counts): " + total);
            }
        }

    }
}
