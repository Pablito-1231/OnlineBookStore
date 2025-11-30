package com.shashirajraja.onlinebookstore.dto;

import com.fasterxml.jackson.annotation.JsonInclude;

/**
 * DTO for Book responses in REST API
 * Optimized for API consumption with calculated fields
 */
@JsonInclude(JsonInclude.Include.NON_NULL)
public class BookResponseDto {

    private Integer id;
    private String name;
    private Integer quantity;
    private Double price;
    private String type;
    private String detail;
    private Integer sold;
    private Boolean available;
    private Double averageRating; // Average rating from reviews
    private Integer totalReviews; // Total number of reviews

    public BookResponseDto() {
    }

    public BookResponseDto(Integer id, String name, Integer quantity, Double price,
            String type, String detail, Integer sold, Double averageRating, Integer totalReviews) {
        this.id = id;
        this.name = name;
        this.quantity = quantity;
        this.price = price;
        this.type = type;
        this.detail = detail;
        this.sold = sold;
        this.available = quantity != null && quantity > 0;
        this.averageRating = averageRating != null ? averageRating : 0.0;
        this.totalReviews = totalReviews != null ? totalReviews : 0;
    }

    // Getters and Setters
    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

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
        this.available = quantity != null && quantity > 0;
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

    public Integer getSold() {
        return sold;
    }

    public void setSold(Integer sold) {
        this.sold = sold;
    }

    public Boolean getAvailable() {
        return available;
    }

    public void setAvailable(Boolean available) {
        this.available = available;
    }

    public Double getAverageRating() {
        return averageRating;
    }

    public void setAverageRating(Double averageRating) {
        this.averageRating = averageRating;
    }

    public Integer getTotalReviews() {
        return totalReviews;
    }

    public void setTotalReviews(Integer totalReviews) {
        this.totalReviews = totalReviews;
    }
}
