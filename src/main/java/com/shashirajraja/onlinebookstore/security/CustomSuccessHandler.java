package com.shashirajraja.onlinebookstore.security;

import java.io.IOException;
import java.util.Collection;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.stereotype.Component;

@Component
public class CustomSuccessHandler implements AuthenticationSuccessHandler {

    private static final Logger log = LoggerFactory.getLogger(CustomSuccessHandler.class);

    @Override
    public void onAuthenticationSuccess(
            HttpServletRequest request,
            HttpServletResponse response,
            Authentication authentication)
            throws IOException, ServletException {

        Collection<? extends GrantedAuthority> roles = authentication.getAuthorities();
        
        log.info("Login exitoso - Usuario: {}, Roles: {}", authentication.getName(), roles);

        // ADMIN
        if (roles.stream().anyMatch(r -> r.getAuthority().equals("ROLE_ADMIN"))) {
            log.debug("Redirigiendo usuario '{}' a /admin/dashboard", authentication.getName());
            response.sendRedirect(request.getContextPath() + "/admin/dashboard");
            return;
        }

        // CUSTOMER
        if (roles.stream().anyMatch(r -> r.getAuthority().equals("ROLE_CUSTOMER"))) {
            log.debug("Redirigiendo usuario '{}' a /customers", authentication.getName());
            response.sendRedirect(request.getContextPath() + "/customers");
            return;
        }

        // Si no trae rol válido
        log.warn("Usuario '{}' sin rol válido. Roles: {}", authentication.getName(), roles);
        response.sendRedirect(request.getContextPath() + "/login?error");
    }
}
