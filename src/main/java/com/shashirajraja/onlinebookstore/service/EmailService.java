package com.shashirajraja.onlinebookstore.service;

import com.shashirajraja.onlinebookstore.entity.Customer;
import com.shashirajraja.onlinebookstore.entity.PurchaseHistory;

public interface EmailService {
	
	/**
	 * Envía email de confirmación de registro
	 */
	void sendRegistrationConfirmation(Customer customer);
	
	/**
	 * Envía email de confirmación de compra
	 */
	void sendPurchaseConfirmation(Customer customer, PurchaseHistory purchaseHistory);
	
	/**
	 * Verifica si el servicio de email está habilitado
	 */
	boolean isEmailEnabled();
}
