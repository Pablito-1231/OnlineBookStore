package com.shashirajraja.onlinebookstore.security;

import javax.sql.DataSource;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.crypto.factory.PasswordEncoderFactories;
import org.springframework.security.web.util.matcher.AntPathRequestMatcher;

@Configuration
@EnableWebSecurity
@EnableGlobalMethodSecurity(prePostEnabled = true)
public class SecurityConfig extends WebSecurityConfigurerAdapter {

    @Autowired
    private DataSource dataSource;

    @Autowired
    private CustomSuccessHandler customSuccessHandler;
    
    @Autowired
    private CustomAuthenticationFailureHandler customAuthenticationFailureHandler;
    

    @Override
    protected void configure(AuthenticationManagerBuilder auth) throws Exception {
        auth.jdbcAuthentication()
            .dataSource(dataSource)
            .usersByUsernameQuery("SELECT username, password, enabled FROM users WHERE username = ?")
            .authoritiesByUsernameQuery("SELECT username, authority FROM authorities WHERE username = ?")
            .passwordEncoder(passwordEncoder());
    }
    

@Override
protected void configure(HttpSecurity http) throws Exception {

    http
        .authorizeRequests()
            .antMatchers(
                "/css/**",
                "/js/**",
                "/images/**",
                "/vendor/**",
                "/static/**",
                "/login",
                "/register",
                "/register/customer",
                "/register/provider"
            ).permitAll()
            .antMatchers("/admin/**").hasRole("ADMIN")
            .antMatchers("/customers/**").hasRole("CUSTOMER")
            .antMatchers("/books").authenticated()
            .anyRequest().authenticated()
        .and()
        .formLogin()
            .loginPage("/login")
            .loginProcessingUrl("/authenticateTheUser")
            .successHandler(customSuccessHandler)
            .failureHandler(customAuthenticationFailureHandler)
            .permitAll()
        .and()
        .logout()
            .logoutRequestMatcher(new AntPathRequestMatcher("/logout", "GET"))
            .logoutSuccessUrl("/login?logout")
            .invalidateHttpSession(true)
            .clearAuthentication(true)
            .deleteCookies("JSESSIONID")
            .permitAll()
        .and()
        .exceptionHandling()
            .accessDeniedPage("/access-denied");
}

    @Bean
    public PasswordEncoder passwordEncoder() {
        // DelegatingPasswordEncoder soporta prefijos como {bcrypt}, {noop}, etc.
        return PasswordEncoderFactories.createDelegatingPasswordEncoder();
    }
}
