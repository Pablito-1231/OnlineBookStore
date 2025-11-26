package com.shashirajraja.onlinebookstore.config;

import org.springframework.boot.web.embedded.tomcat.TomcatServletWebServerFactory;
import org.springframework.boot.web.servlet.server.ConfigurableServletWebServerFactory;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.ViewResolver;
import org.springframework.web.servlet.view.InternalResourceViewResolver;
import org.springframework.web.servlet.view.JstlView;

import java.io.File;

@Configuration
public class WebConfig {

    @Bean
    public ConfigurableServletWebServerFactory servletContainer() {
        TomcatServletWebServerFactory factory = new TomcatServletWebServerFactory();
        
        // Configurar document root para desarrollo
        File webappDir = new File("src/main/webapp");
        if (webappDir.exists() && webappDir.isDirectory()) {
            factory.setDocumentRoot(webappDir);
            System.out.println("✓ Document root configurado: " + webappDir.getAbsolutePath());
        } else {
            System.out.println("⚠ Document root no existe, usando classpath");
        }
        
        return factory;
    }
    
    @Bean
    public ViewResolver viewResolver() {
        InternalResourceViewResolver resolver = new InternalResourceViewResolver();
        resolver.setViewClass(JstlView.class);
        resolver.setPrefix("/WEB-INF/view/");
        resolver.setSuffix(".jsp");
        resolver.setOrder(1);
        System.out.println("✓ ViewResolver configurado: /WEB-INF/view/*.jsp");
        return resolver;
    }
}
