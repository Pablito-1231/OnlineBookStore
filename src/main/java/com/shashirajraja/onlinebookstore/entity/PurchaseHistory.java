package com.shashirajraja.onlinebookstore.entity;

import java.util.Date;
import java.util.Set;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;

@Entity
@Table(name="purchase_history")
public class PurchaseHistory {

	@Id
	@Column(name="id")
	private String id;
	
	@JoinColumn(name="customer_id")
	@ManyToOne
	private Customer customer;
	
	@Column(name="date")
	private Date date;

	@OneToMany(mappedBy ="purchaseHistory", fetch = FetchType.LAZY, cascade = CascadeType.ALL)
	Set<PurchaseDetail> purchaseDetails;
	
	public PurchaseHistory() {
	}
	
	public PurchaseHistory(String id, Date date) {
		this.id = id;
		this.date = date;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public Date getDate() {
		return date;
	}

	public void setDate(Date date) {
		this.date = date;
	}

	public Customer getCustomer() {
		return customer;
	}

	public void setCustomer(Customer customer) {
		this.customer = customer;
	}

	public Set<PurchaseDetail> getPurchaseDetails() {
		return purchaseDetails;
	}

	public void setPurchaseDetails(Set<PurchaseDetail> purchaseDetails) {
		this.purchaseDetails = purchaseDetails;
	}

	@Override
	public String toString() {
		return "PurchaseHistory [id=" + id + ", date=" + date + "]";
	}
	
	
	
}
