package com.shashirajraja.onlinebookstore.dto;

import com.fasterxml.jackson.annotation.JsonInclude;

/**
 * DTO for Shopping Cart Item responses in REST API
 */
@JsonInclude(JsonInclude.Include.NON_NULL)
public class CartItemResponseDto {

    private Integer bookId;
    private String bookName;
    private Double bookPrice;
    private Integer quantity;
    private Double subtotal;
    private Boolean available;

    public CartItemResponseDto() {
    }

    public CartItemResponseDto(Integer bookId, String bookName, Double bookPrice,
            Integer quantity, Boolean available) {
        this.bookId = bookId;
        this.bookName = bookName;
        this.bookPrice = bookPrice;
        this.quantity = quantity;
        this.available = available;
        this.subtotal = bookPrice * quantity;
    }

    // Getters and Setters
    public Integer getBookId() {
        return bookId;
    }

    public void setBookId(Integer bookId) {
        this.bookId = bookId;
    }

    public String getBookName() {
        return bookName;
    }

    public void setBookName(String bookName) {
        this.bookName = bookName;
    }

    public Double getBookPrice() {
        return bookPrice;
    }

    public void setBookPrice(Double bookPrice) {
        this.bookPrice = bookPrice;
        calculateSubtotal();
    }

    public Integer getQuantity() {
        return quantity;
    }

    public void setQuantity(Integer quantity) {
        this.quantity = quantity;
        calculateSubtotal();
    }

    public Double getSubtotal() {
        return subtotal;
    }

    public void setSubtotal(Double subtotal) {
        this.subtotal = subtotal;
    }

    public Boolean getAvailable() {
        return available;
    }

    public void setAvailable(Boolean available) {
        this.available = available;
    }

    private void calculateSubtotal() {
        if (bookPrice != null && quantity != null) {
            this.subtotal = bookPrice * quantity;
        }
    }
}
