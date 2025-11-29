package com.shashirajraja.onlinebookstore.config;

import com.github.benmanes.caffeine.cache.Caffeine;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.cache.CacheManager;
import org.springframework.cache.annotation.EnableCaching;
import org.springframework.cache.caffeine.CaffeineCacheManager;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import java.util.concurrent.TimeUnit;

/**
 * Cache configuration using Caffeine
 * Provides in-memory caching for frequently accessed data
 */
@Configuration
@EnableCaching
public class CacheConfig {

    private static final Logger log = LoggerFactory.getLogger(CacheConfig.class);

    // Cache names
    public static final String BOOKS_CACHE = "books";
    public static final String BOOK_BY_ID_CACHE = "bookById";
    public static final String AVAILABLE_BOOKS_CACHE = "availableBooks";
    public static final String STATS_CACHE = "stats";
    public static final String USER_CACHE = "users";

    @Bean
    public CacheManager cacheManager() {
        log.info("Configuring Caffeine Cache Manager");

        CaffeineCacheManager cacheManager = new CaffeineCacheManager(
                BOOKS_CACHE,
                BOOK_BY_ID_CACHE,
                AVAILABLE_BOOKS_CACHE,
                STATS_CACHE,
                USER_CACHE);

        cacheManager.setCaffeine(caffeineConfig());

        return cacheManager;
    }

    private Caffeine<Object, Object> caffeineConfig() {
        return Caffeine.newBuilder()
                .initialCapacity(100)
                .maximumSize(500)
                .expireAfterWrite(10, TimeUnit.MINUTES)
                .recordStats()
                .build();
    }
}
