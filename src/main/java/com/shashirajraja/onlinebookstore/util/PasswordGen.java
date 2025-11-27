package com.shashirajraja.onlinebookstore.util;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

/**
 * Utility to generate bcrypt hashes from a plain password.
 * Usage (maven exec):
 * mvn org.codehaus.mojo:exec-maven-plugin:3.1.0:java -Dexec.mainClass=com.shashirajraja.onlinebookstore.util.PasswordGen -Dexec.args="MyPlainPass123!"
 */
public class PasswordGen {
    public static void main(String[] args) {
        String raw = (args != null && args.length > 0) ? args[0] : "ChangeMe123!";
        BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
        String hash = encoder.encode(raw);
        System.out.println(hash);
    }
}
