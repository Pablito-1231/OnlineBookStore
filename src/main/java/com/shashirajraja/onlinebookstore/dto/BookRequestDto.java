package com.shashirajraja.onlinebookstore.dto;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Positive;
import jakarta.validation.constraints.PositiveOrZero;
import jakarta.validation.constraints.Size;

/**
 * DTO for creating/updating books via REST API
 */
public class BookRequestDto {

    @NotBlank(message = "El nombre del libro es obligatorio")
    @Size(max = 255, message = "El nombre no puede exceder 255 caracteres")
    private String name;

    @PositiveOrZero(message = "La cantidad debe ser mayor o igual a 0")
    private Integer quantity;

    @Positive(message = "El precio debe ser mayor a 0")
    private Double price;

    @NotBlank(message = "El tipo es obligatorio")
    @Size(max = 20, message = "El tipo debe tener como máximo 20 caracteres")
    private String type;

    @Size(max = 500, message = "La descripción no puede exceder 500 caracteres")
    private String detail;

    public BookRequestDto() {
    }

    public BookRequestDto(String name, Integer quantity, Double price, String type, String detail) {
        this.name = name;
        this.quantity = quantity;
        this.price = price;
        this.type = type;
        this.detail = detail;
    }

    // Getters and Setters
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Integer getQuantity() {
        return quantity;
    }

    public void setQuantity(Integer quantity) {
        this.quantity = quantity;
    }

    public Double getPrice() {
        return price;
    }

    public void setPrice(Double price) {
        this.price = price;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getDetail() {
        return detail;
    }

    public void setDetail(String detail) {
        this.detail = detail;
    }
}
