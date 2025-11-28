package com.shashirajraja.onlinebookstore.bootstrap;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.ApplicationContextInitializer;
import org.springframework.context.ConfigurableApplicationContext;
import org.springframework.core.env.Environment;

import java.net.URI;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;

public class DatabaseCreationInitializer implements ApplicationContextInitializer<ConfigurableApplicationContext> {

    private static final Logger log = LoggerFactory.getLogger(DatabaseCreationInitializer.class);

    @Override
    public void initialize(ConfigurableApplicationContext applicationContext) {
        Environment env = applicationContext.getEnvironment();

        // Control to enable automatic DB creation. Use env var AUTO_CREATE_DB=true or property autoCreateDb=true
        String autoCreate = System.getenv().containsKey("AUTO_CREATE_DB") ? System.getenv("AUTO_CREATE_DB") : env.getProperty("autoCreateDb", "false");
        if (!"true".equalsIgnoreCase(autoCreate)) {
            log.debug("AUTO_CREATE_DB not enabled; skipping automatic DB creation.");
            return;
        }

        String dbUrl = env.getProperty("DB_URL", env.getProperty("spring.datasource.url", "jdbc:mysql://localhost:3306/onlinebookstore?useSSL=false&serverTimezone=UTC"));
        String dbUser = env.getProperty("DB_USERNAME", env.getProperty("spring.datasource.username", "root"));
        String dbPass = env.getProperty("DB_PASSWORD", env.getProperty("spring.datasource.password", ""));

        try {
            // Parse DB URL to extract host, port and database
            String url = dbUrl.trim();
            // Normalize common JDBC prefixes: jdbc:mysql://host:port/db -> http://host:port/db for URI parsing
            if (url.startsWith("jdbc:")) {
                url = url.substring("jdbc:".length());
            }
            // remove vendor prefix if present
            if (url.startsWith("mysql:")) { url = url.substring("mysql:".length()); }
            if (url.startsWith("mariadb:")) { url = url.substring("mariadb:".length()); }
            if (!url.startsWith("//") && !url.startsWith("/")) { url = "//" + url; }
            String uriStr = "http:" + url;
            URI uri = new URI(uriStr);
            String host = uri.getHost();
            int port = uri.getPort() == -1 ? 3306 : uri.getPort();
            String path = uri.getPath();
            String dbName = (path != null && path.length() > 1) ? path.substring(1) : "onlinebookstore";

            String serverUrl = String.format("jdbc:mysql://%s:%d/?useSSL=false&serverTimezone=UTC", host, port);

            log.info("AUTO_CREATE_DB enabled: ensuring database '{}' exists on {}", dbName, serverUrl);

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
            } catch (ClassNotFoundException e) {
                log.warn("MySQL driver not found on classpath: {}", e.getMessage());
            }

            try (Connection conn = DriverManager.getConnection(serverUrl, dbUser, dbPass);
                 Statement stmt = conn.createStatement()) {
                String sql = String.format("CREATE DATABASE IF NOT EXISTS `%s` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;", dbName);
                stmt.executeUpdate(sql);
                log.info("Database '{}' ensured (CREATE DATABASE IF NOT EXISTS executed).", dbName);
            }
        } catch (Exception ex) {
            log.warn("Automatic DB creation failed: {}. The application will continue, but ensure the DB exists.", ex.getMessage());
        }
    }
}
