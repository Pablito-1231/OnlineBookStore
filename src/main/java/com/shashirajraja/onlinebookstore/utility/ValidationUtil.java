package com.shashirajraja.onlinebookstore.utility;

import java.util.regex.Pattern;

/**
 * Utilidad para validaciones comunes en el sistema
 */
public class ValidationUtil {

    // Patrón para validar email
    private static final String EMAIL_REGEX = "^[A-Za-z0-9+_.-]+@(.+)$";
    private static final Pattern EMAIL_PATTERN = Pattern.compile(EMAIL_REGEX);

    // Patrón para validar teléfono (10-12 dígitos)
    private static final String PHONE_REGEX = "^[0-9]{10,12}$";
    private static final Pattern PHONE_PATTERN = Pattern.compile(PHONE_REGEX);

    // Patrón para validar UPI (formato: username@bankname)
    private static final String UPI_REGEX = "^[a-zA-Z0-9._-]+@[a-zA-Z]+$";
    private static final Pattern UPI_PATTERN = Pattern.compile(UPI_REGEX);

    /**
     * Valida si un email es válido
     */
    public static boolean isValidEmail(String email) {
        if (email == null || email.trim().isEmpty()) {
            return false;
        }
        return EMAIL_PATTERN.matcher(email).matches();
    }

    /**
     * Valida si un teléfono es válido
     */
    public static boolean isValidPhone(String phone) {
        if (phone == null || phone.trim().isEmpty()) {
            return false;
        }
        String cleanPhone = phone.replaceAll("[^0-9]", "");
        return PHONE_PATTERN.matcher(cleanPhone).matches();
    }

    /**
     * Valida si un UPI es válido
     */
    public static boolean isValidUPI(String upi) {
        if (upi == null || upi.trim().isEmpty()) {
            return false;
        }
        return UPI_PATTERN.matcher(upi).matches();
    }

    /**
     * Valida si una contraseña cumple con requisitos mínimos
     * - Mínimo 6 caracteres
     * - Al menos una mayúscula
     * - Al menos una minúscula
     * - Al menos un número
     */
    public static boolean isValidPassword(String password) {
        if (password == null || password.length() < 6) {
            return false;
        }
        boolean hasUppercase = password.matches(".*[A-Z].*");
        boolean hasLowercase = password.matches(".*[a-z].*");
        boolean hasNumber = password.matches(".*[0-9].*");
        return hasUppercase && hasLowercase && hasNumber;
    }

    /**
     * Valida si un nombre es válido
     * - No vacío
     * - Entre 2 y 50 caracteres
     */
    public static boolean isValidName(String name) {
        if (name == null || name.trim().isEmpty()) {
            return false;
        }
        String trimmed = name.trim();
        return trimmed.length() >= 2 && trimmed.length() <= 50;
    }

    /**
     * Valida si un precio es válido
     * - Mayor a 0
     */
    public static boolean isValidPrice(double price) {
        return price > 0;
    }

    /**
     * Valida si una cantidad es válida
     * - Mayor o igual a 0
     */
    public static boolean isValidQuantity(int quantity) {
        return quantity >= 0;
    }

    /**
     * Valida si un OTP es válido (4-6 dígitos)
     */
    public static boolean isValidOTP(String otp) {
        if (otp == null || otp.trim().isEmpty()) {
            return false;
        }
        return otp.matches("^[0-9]{4,6}$");
    }

}
