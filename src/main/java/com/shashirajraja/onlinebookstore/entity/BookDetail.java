package com.shashirajraja.onlinebookstore.entity;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.PositiveOrZero;
import jakarta.validation.constraints.Size;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name="book_detail")
public class BookDetail {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name="id")
	private int id;
	
	@Column(name="type")
	@NotBlank(message = "El tipo es obligatorio")
	@Size(max = 20, message = "El tipo debe tener como máximo 20 caracteres")
	private String type;
	
	@Column(name="detail")
	@Size(max = 500, message = "La descripción no puede exceder 500 caracteres")
	private String detail;
	
	@Column(name="sold")
	@PositiveOrZero(message = "Vendidos debe ser 0 o mayor")
	private int sold;
	
	public BookDetail() {}

	public BookDetail(String type, String detail, int sold) {
		this.type = type;
		this.detail = detail;
		this.sold = sold;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
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

	public int getSold() {
		return sold;
	}

	public void setSold(int sold) {
		this.sold = sold;
	}

	@Override
	public String toString() {
		return "BookDetail [id=" + id + ", type=" + type + ", detail=" + detail + ", sold=" + sold + "]";
	}
	
}
