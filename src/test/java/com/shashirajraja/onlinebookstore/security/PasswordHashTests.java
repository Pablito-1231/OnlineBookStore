package com.shashirajraja.onlinebookstore.security;

import org.junit.jupiter.api.Test;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

public class PasswordHashTests {

    @Test
    void printBcryptForAdmin1() {
        String raw = "admin1";
        String hash = new BCryptPasswordEncoder().encode(raw);
        System.out.println("BCRYPT_ADMIN1=" + hash);
    }
}
