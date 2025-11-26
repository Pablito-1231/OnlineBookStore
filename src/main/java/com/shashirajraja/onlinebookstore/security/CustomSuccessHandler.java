package com.shashirajraja.onlinebookstore.security;

import java.io.IOException;
import java.util.Collection;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.stereotype.Component;

@Component
public class CustomSuccessHandler implements AuthenticationSuccessHandler {

    @Override
    public void onAuthenticationSuccess(
            HttpServletRequest request,
            HttpServletResponse response,
            Authentication authentication)
            throws IOException, ServletException {

        Collection<? extends GrantedAuthority> roles = authentication.getAuthorities();
        
        // Log para depuración
        System.out.println("=== LOGIN EXITOSO ===");
        System.out.println("Usuario: " + authentication.getName());
        System.out.println("Roles: " + roles);

        // ADMIN
        if (roles.stream().anyMatch(r -> r.getAuthority().equals("ROLE_ADMIN"))) {
            System.out.println("Redirigiendo a: /admin/dashboard");
            response.sendRedirect(request.getContextPath() + "/admin/dashboard");
            return;
        }

        // CUSTOMER
        if (roles.stream().anyMatch(r -> r.getAuthority().equals("ROLE_CUSTOMER"))) {
            System.out.println("Redirigiendo a: /customers");
            response.sendRedirect(request.getContextPath() + "/customers");
            return;
        }

        // Si no trae rol válido
        System.out.println("Sin rol válido, redirigiendo a login con error");
        response.sendRedirect(request.getContextPath() + "/login?error");
    }
}
