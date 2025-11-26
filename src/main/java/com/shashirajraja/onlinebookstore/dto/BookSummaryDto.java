package com.shashirajraja.onlinebookstore.dto;

public class BookSummaryDto {
    private int id;
    private String name;
    private double price;
    private int quantity;
    private String type;

    public BookSummaryDto(int id, String name, double price, int quantity, String type) {
        this.id = id;
        this.name = name;
        this.price = price;
        this.quantity = quantity;
        this.type = type;
    }

    public int getId() { return id; }
    public String getName() { return name; }
    public double getPrice() { return price; }
    public int getQuantity() { return quantity; }
    public String getType() { return type; }
}
