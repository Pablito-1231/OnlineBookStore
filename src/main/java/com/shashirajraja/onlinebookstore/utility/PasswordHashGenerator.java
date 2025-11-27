package com.shashirajraja.onlinebookstore.utility;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class PasswordHashGenerator {
    private static final Logger logger = LoggerFactory.getLogger(PasswordHashGenerator.class);
    public static void main(String[] args) {
        String password = args != null && args.length > 0 ? args[0] : "admin1";
        String hash = new BCryptPasswordEncoder().encode(password);
        logger.debug("Password hash generated (length={}) - value omitted", hash != null ? hash.length() : 0);
    }
}
