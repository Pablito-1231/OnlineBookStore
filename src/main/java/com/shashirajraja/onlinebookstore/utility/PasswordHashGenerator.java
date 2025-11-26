package com.shashirajraja.onlinebookstore.utility;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

public class PasswordHashGenerator {
    public static void main(String[] args) {
        String password = args != null && args.length > 0 ? args[0] : "admin1";
        String hash = new BCryptPasswordEncoder().encode(password);
        System.out.println(hash);
    }
}
