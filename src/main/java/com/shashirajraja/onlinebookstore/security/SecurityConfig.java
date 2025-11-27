package com.shashirajraja.onlinebookstore.security;

import javax.sql.DataSource;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;

import org.springframework.security.config.annotation.method.configuration.EnableMethodSecurity;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.config.annotation.authentication.configuration.AuthenticationConfiguration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.crypto.factory.PasswordEncoderFactories;
import org.springframework.security.provisioning.JdbcUserDetailsManager;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.util.matcher.AntPathRequestMatcher;

@Configuration
@EnableWebSecurity
@EnableMethodSecurity(prePostEnabled = true)
public class SecurityConfig {

    @Autowired
    private DataSource dataSource;

    @Autowired
    private CustomSuccessHandler customSuccessHandler;
    
    @Autowired
    private CustomAuthenticationFailureHandler customAuthenticationFailureHandler;

    @Bean
    UserDetailsService userDetailsService() {
        JdbcUserDetailsManager manager = new JdbcUserDetailsManager(dataSource);
        manager.setUsersByUsernameQuery("SELECT username, password, enabled FROM users WHERE username = ?");
        manager.setAuthoritiesByUsernameQuery("SELECT username, authority FROM authorities WHERE username = ?");
        return manager;
    }

    @Bean
    SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
        http
            // Habilitar CSRF (por defecto) para formularios JSP
            .csrf(csrf -> {})
            .authorizeHttpRequests(authz -> authz
                // Recursos estáticos y páginas públicas
                .requestMatchers(
                    "/",
                        "/home",
                        "/login",
                        "/register",
                        "/register-customer",
                        "/register-provider",
                        "/register/**",
                        "/register/customer",
                        "/register/provider",
                        "/authenticateTheUser",
                    "/error",
                    "/WEB-INF/view/**",
                    "/css/**",
                    "/js/**",
                    "/img/**",
                    "/static/**",
                    "/vendor/**",
                    "/internal/**"
                ).permitAll()
                // Zonas administrativas
                .requestMatchers("/admin/**").hasRole("ADMIN")
                // Zonas de cliente autenticado
                .requestMatchers("/customers/**", "/cart/**", "/books/**").hasAnyRole("CUSTOMER", "ADMIN")
                // Cualquier otra solicitud requiere autenticación
                .anyRequest().authenticated()
            )
            .formLogin(form -> form
                .loginPage("/login")
                .loginProcessingUrl("/authenticateTheUser")
                .successHandler(customSuccessHandler)
                .failureHandler(customAuthenticationFailureHandler)
                .permitAll()
            )
            .logout(logout -> logout
                .logoutRequestMatcher(new AntPathRequestMatcher("/logout"))
                .logoutSuccessUrl("/login?logout")
                .invalidateHttpSession(true)
                .deleteCookies("JSESSIONID")
                .permitAll()
            );
        
        return http.build();
    }

    @Bean
    PasswordEncoder passwordEncoder() {
        // DelegatingPasswordEncoder soporta prefijos como {bcrypt}, {noop}, etc.
        return PasswordEncoderFactories.createDelegatingPasswordEncoder();
    }

    @Bean
    public AuthenticationManager authenticationManager(AuthenticationConfiguration authConfig) throws Exception {
        // Expose AuthenticationManager para permitir re-autenticación y evitar advertencias
        return authConfig.getAuthenticationManager();
    }
}
