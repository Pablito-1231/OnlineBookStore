package com.shashirajraja.onlinebookstore.web;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;
import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.HandlerInterceptor;

/**
 * Interceptor de diagnóstico que registra el handler (clase y método) responsable
 * de atender cada petición HTTP. Temporal — usar solo para depuración.
 */
@Component
public class RequestLoggingInterceptor implements HandlerInterceptor {

    private static final Logger logger = LoggerFactory.getLogger(RequestLoggingInterceptor.class);

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        try {
            if (handler instanceof HandlerMethod) {
                HandlerMethod hm = (HandlerMethod) handler;
                String className = hm.getBeanType().getName();
                String methodName = hm.getMethod().getName();
                logger.info("[RequestLoggingInterceptor] {} {} -> handler: {}#{}", request.getMethod(), request.getRequestURI(), className, methodName);
            } else if (handler != null) {
                logger.info("[RequestLoggingInterceptor] {} {} -> handler: {}", request.getMethod(), request.getRequestURI(), handler.getClass().getName());
            } else {
                logger.info("[RequestLoggingInterceptor] {} {} -> handler: null", request.getMethod(), request.getRequestURI());
            }
        } catch (Exception e) {
            logger.warn("[RequestLoggingInterceptor] fallo al registrar handler: {}", e.getMessage());
        }
        return true;
    }
}
