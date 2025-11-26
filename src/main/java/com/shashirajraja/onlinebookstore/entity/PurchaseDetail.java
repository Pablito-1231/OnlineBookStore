package com.shashirajraja.onlinebookstore.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.IdClass;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToOne;
import jakarta.persistence.Table;

@Entity
@Table(name="purchase_detail")
@IdClass(PurchaseDetailId.class)
public class PurchaseDetail{

	@Id
	@JoinColumn(name="purchase_history_id")
	@ManyToOne
	PurchaseHistory purchaseHistory;
	
	@Id
	@JoinColumn(name="book_id")
	@OneToOne
	Book book;
	
	
	@Column(name = "price")
	double price;
	
	@Column(name = "quanitity")
	int quantity;
	
	public PurchaseDetail() {
		
	}

	public PurchaseDetail(PurchaseHistory purchaseHistory,Book book, double price, int quantity) {
		this.purchaseHistory = purchaseHistory;
		this.price = price;
		this.book = book;
		this.quantity = quantity;
	}

	public PurchaseDetail(double price, int quantity) {
		this.price = price;
		this.quantity = quantity;
	}

	public PurchaseHistory getPurchaseHistory() {
		return purchaseHistory;
	}

	public void setPurchaseHistory(PurchaseHistory purchaseHistory) {
		this.purchaseHistory = purchaseHistory;
	}

	public double getPrice() {
		return price;
	}

	public void setPrice(double price) {
		this.price = price;
	}

	public int getQuantity() {
		return quantity;
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}

	public Book getBook() {
		return book;
	}

	public void setBook(Book book) {
		this.book = book;
	}

	@Override
	public String toString() {
		return "PurchaseDetail [price=" + price + ", quantity=" + quantity + "]";
	}
	
}
