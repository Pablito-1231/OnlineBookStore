package com.shashirajraja.onlinebookstore.dto;

public class BookResponseDto {
    private int id;
    private String name;
    private int quantity;
    private double price;
    private String type;
    private String detail;

    public BookResponseDto() {
    }

    public BookResponseDto(int id, String name, int quantity, double price, String type, String detail) {
        this.id = id;
        this.name = name;
        this.quantity = quantity;
        this.price = price;
        this.type = type;
        this.detail = detail;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
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
