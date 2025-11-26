package com.shashirajraja.onlinebookstore.config;

import org.springframework.boot.web.embedded.tomcat.TomcatServletWebServerFactory;
import org.springframework.boot.web.server.WebServerFactoryCustomizer;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

/**
 * Configuración personalizada para Tomcat embebido
 * Habilita la compilación de JSP con Jasper
 */
@Configuration
public class TomcatConfig {

    @Bean
    public WebServerFactoryCustomizer<TomcatServletWebServerFactory> tomcatCustomizer() {
        return factory -> {
            factory.addContextCustomizers(context -> {
                // Habilitar modo desarrollo para Jasper (recompilación automática)
                context.addServletContainerInitializer(
                    (set, servletContext) -> {
                        servletContext.setAttribute("org.apache.tomcat.util.scan.StandardJarScanFilter.jarsToSkip", "");
                    }, null
                );

                // Configurar parámetros de init para JspServlet
                context.addParameter("development", "true");
                context.addParameter("keepgenerated", "true");
            });
        };
    }
}
