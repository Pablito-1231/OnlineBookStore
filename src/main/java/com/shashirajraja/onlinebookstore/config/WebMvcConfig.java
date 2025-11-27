package com.shashirajraja.onlinebookstore.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import com.shashirajraja.onlinebookstore.web.RequestLoggingInterceptor;

@Configuration
public class WebMvcConfig implements WebMvcConfigurer {

    @Autowired
    private RequestLoggingInterceptor requestLoggingInterceptor;

    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        // Registrar en todas las rutas para depuración temporal
        registry.addInterceptor(requestLoggingInterceptor).addPathPatterns("/**");
    }
}
