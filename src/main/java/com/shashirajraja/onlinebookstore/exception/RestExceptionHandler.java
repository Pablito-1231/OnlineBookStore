package com.shashirajraja.onlinebookstore.exception;

import com.shashirajraja.onlinebookstore.dto.ApiResponse;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestController;

@ControllerAdvice(annotations = RestController.class)
public class RestExceptionHandler {

    @ExceptionHandler(Exception.class)
    public ResponseEntity<ApiResponse<String>> handleException(Exception exc) {
        return new ResponseEntity<>(new ApiResponse<>(false, exc.getMessage(), null), HttpStatus.BAD_REQUEST);
    }
}
