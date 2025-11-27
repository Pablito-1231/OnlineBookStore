package com.shashirajraja.onlinebookstore.util;

import java.nio.file.Files;
import java.nio.file.Path;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;
import java.util.stream.Collectors;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class ExecuteSqlScript {
    private static final Logger logger = LoggerFactory.getLogger(ExecuteSqlScript.class);
    public static void main(String[] args) throws Exception {
        String url = System.getenv().getOrDefault("DB_URL", "jdbc:mysql://localhost:3306/onlinebookstore?useSSL=false&serverTimezone=UTC");
        String user = System.getenv().getOrDefault("DB_USERNAME", "root");
        String pass = System.getenv().getOrDefault("DB_PASSWORD", "");

        Path script = Path.of("scripts", "cleanup_keep_admin.sql");
        if (!Files.exists(script)) {
            logger.error("Script no encontrado: {}", script.toAbsolutePath());
            System.exit(2);
        }

        logger.info("Connecting to DB: {}", url);
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
                        logger.info("Executed: {} -> {} rows", sql, affected);
                        total += affected;
                    } catch (Exception e) {
                        logger.error("Failed statement: {}", sql, e);
                    }
                }

                // Re-enable FK checks
                st.execute("SET FOREIGN_KEY_CHECKS=1");

                c.commit();
                logger.info("Total affected (sum of update counts): {}", total);
            }
        }

    }
}
