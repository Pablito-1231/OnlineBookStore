package com.shashirajraja.onlinebookstore.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

public class CheckUsers {
    public static void main(String[] args) throws Exception {
        String defaultUrl = "jdbc:mysql://localhost:3306/onlinebookstore?useSSL=false&serverTimezone=UTC";
        String url = System.getenv().getOrDefault("DB_URL", defaultUrl);
        String user = System.getenv().getOrDefault("DB_USERNAME", "root");
        String pass = System.getenv().getOrDefault("DB_PASSWORD", "");

        String[] candidates = new String[]{"prueba_auto","prueba1","testuser1","admin_test","admin"};

        try (Connection conn = DriverManager.getConnection(url, user, pass);
             Statement st = conn.createStatement()) {

            String inList = String.join(",", java.util.Arrays.stream(candidates).map(s -> "'" + s + "'").toArray(String[]::new));
            String sql = "SELECT username, password FROM users WHERE username IN (" + inList + ")";
            ResultSet rs = st.executeQuery(sql);
            boolean any = false;
            while (rs.next()) {
                any = true;
                String uname = rs.getString("username");
                org.slf4j.Logger logger = org.slf4j.LoggerFactory.getLogger(CheckUsers.class);
                logger.info("FOUND: {} -> [hidden]", uname);
            }
            if (!any) {
                org.slf4j.Logger logger = org.slf4j.LoggerFactory.getLogger(CheckUsers.class);
                logger.info("No se encontraron usuarios de prueba en la tabla users.");
            }
        } catch (Exception e) {
            org.slf4j.Logger logger = org.slf4j.LoggerFactory.getLogger(CheckUsers.class);
            logger.error("Error comprobando users: {}", e.getMessage(), e);
            System.exit(4);
        }
    }
}
