package com.shashirajraja.onlinebookstore.entity;

import java.io.Serializable;
import java.util.Objects;

/**
 * Id class for ShoppingCart composite primary key.
 * Uses the PK types of referenced entities: customer -> String (username), book -> Integer (id).
 */
public class ShoppingCartId implements Serializable {

	private static final long serialVersionUID = 1L;

	private String customer; // corresponds to Customer.id (username)

	private Integer book; // corresponds to Book.id

	public ShoppingCartId() {
	}

	public ShoppingCartId(String customer, Integer book) {
		this.customer = customer;
		this.book = book;
	}

	public String getCustomer() {
		return customer;
	}

	public void setCustomer(String customer) {
		this.customer = customer;
	}

	public Integer getBook() {
		return book;
	}

	public void setBook(Integer book) {
		this.book = book;
	}

	@Override
	public int hashCode() {
		return Objects.hash(customer, book);
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null || getClass() != obj.getClass())
			return false;
		ShoppingCartId other = (ShoppingCartId) obj;
		return Objects.equals(this.customer, other.customer) && Objects.equals(this.book, other.book);
	}

}
