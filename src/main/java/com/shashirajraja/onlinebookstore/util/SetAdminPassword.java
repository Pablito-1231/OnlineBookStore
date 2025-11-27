package com.shashirajraja.onlinebookstore.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class SetAdminPassword {
    private static final Logger logger = LoggerFactory.getLogger(SetAdminPassword.class);
    public static void main(String[] args) throws Exception {
        String defaultUrl = "jdbc:mysql://localhost:3306/onlinebookstore?useSSL=false&serverTimezone=UTC";
        String url = System.getenv().getOrDefault("DB_URL", defaultUrl);
        String user = System.getenv().getOrDefault("DB_USERNAME", "root");
        String pass = System.getenv().getOrDefault("DB_PASSWORD", "");

        String newPwd = "{noop}admin";
        if (args.length > 0) newPwd = args[0];

        try (Connection conn = DriverManager.getConnection(url, user, pass);
             Statement st = conn.createStatement()) {
            int updated = st.executeUpdate("UPDATE users SET password = '" + newPwd.replace("'","''") + "' WHERE username = 'admin'");
            logger.info("Rows updated: {}", updated);
        }
    }
}
