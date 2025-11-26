package com.shashirajraja.onlinebookstore.exception;

import jakarta.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.NoHandlerFoundException;

/**
 * Manejador global de excepciones para la aplicación.
 * Captura y procesa todas las excepciones no manejadas.
 */
@ControllerAdvice
public class GlobalExceptionHandler {

    private static final Logger log = LoggerFactory.getLogger(GlobalExceptionHandler.class);

    /**
     * Maneja excepciones generales del sistema
     */
    @ExceptionHandler(Exception.class)
    public ModelAndView handleException(Exception ex, HttpServletRequest request) {
        log.error("Error no manejado en {}: {}", request.getRequestURI(), ex.getMessage(), ex);
        
        ModelAndView mav = new ModelAndView("error");
        mav.addObject("errorMessage", "Ha ocurrido un error inesperado");
        mav.addObject("errorDetails", ex.getMessage());
        mav.addObject("url", request.getRequestURI());
        mav.setStatus(HttpStatus.INTERNAL_SERVER_ERROR);
        
        return mav;
    }

    /**
     * Maneja RuntimeExceptions (errores de lógica de negocio)
     */
    @ExceptionHandler(RuntimeException.class)
    public ModelAndView handleRuntimeException(RuntimeException ex, HttpServletRequest request) {
        log.error("RuntimeException en {}: {}", request.getRequestURI(), ex.getMessage(), ex);
        
        ModelAndView mav = new ModelAndView("error");
        mav.addObject("errorMessage", "Error al procesar la solicitud");
        mav.addObject("errorDetails", ex.getMessage());
        mav.addObject("url", request.getRequestURI());
        mav.setStatus(HttpStatus.BAD_REQUEST);
        
        return mav;
    }

    /**
     * Maneja errores 404 (página no encontrada)
     */
    @ExceptionHandler(NoHandlerFoundException.class)
    public ModelAndView handleNotFound(NoHandlerFoundException ex, HttpServletRequest request) {
        log.warn("Página no encontrada: {}", request.getRequestURI());
        
        ModelAndView mav = new ModelAndView("error");
        mav.addObject("errorMessage", "Página no encontrada");
        mav.addObject("errorDetails", "La página que buscas no existe");
        mav.addObject("url", request.getRequestURI());
        mav.setStatus(HttpStatus.NOT_FOUND);
        
        return mav;
    }

    /**
     * Maneja errores de acceso denegado
     */
    @ExceptionHandler(org.springframework.security.access.AccessDeniedException.class)
    public ModelAndView handleAccessDenied(
            org.springframework.security.access.AccessDeniedException ex,
            HttpServletRequest request) {
        log.warn("Acceso denegado para {} en {}", request.getUserPrincipal().getName(), request.getRequestURI());
        
        ModelAndView mav = new ModelAndView("access-denied");
        mav.setStatus(HttpStatus.FORBIDDEN);
        
        return mav;
    }
}
