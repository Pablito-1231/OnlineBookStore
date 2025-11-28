package com.shashirajraja.onlinebookstore;

import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.context.properties.ConfigurationPropertiesScan;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;

@SpringBootApplication
@ConfigurationPropertiesScan
public class OnlineBookStoreApplication extends SpringBootServletInitializer{

    public static void main(String[] args) {
        org.springframework.boot.SpringApplication app = new org.springframework.boot.SpringApplication(OnlineBookStoreApplication.class);
        app.addInitializers(new com.shashirajraja.onlinebookstore.bootstrap.DatabaseCreationInitializer());
        app.run(args);
    }

    @Override
    protected SpringApplicationBuilder configure(SpringApplicationBuilder application) {
        return application.sources(OnlineBookStoreApplication.class);
    }
}
