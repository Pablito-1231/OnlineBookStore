package com.shashirajraja.onlinebookstore.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

import com.shashirajraja.onlinebookstore.entity.Customer;
import com.shashirajraja.onlinebookstore.entity.PurchaseDetail;
import com.shashirajraja.onlinebookstore.entity.PurchaseHistory;

@Service
public class EmailServiceImpl implements EmailService {

	@Autowired(required = false)
	private JavaMailSender mailSender;

	@Value("${app.email.from:noreply@libreriavirtual.com}")
	private String fromEmail;

	@Value("${app.email.enabled:false}")
	private boolean emailEnabled;

	@Override
	public boolean isEmailEnabled() {
		return emailEnabled && mailSender != null;
	}

	@Override
	public void sendRegistrationConfirmation(Customer customer) {
		if (!isEmailEnabled()) {
			return;
		}

		try {
			SimpleMailMessage message = new SimpleMailMessage();
			message.setFrom(fromEmail);
			message.setTo(customer.getEmail());
			message.setSubject("¡Bienvenido a Librería Virtual!");
			
			String body = String.format(
				"Hola %s %s,\n\n" +
				"¡Gracias por registrarte en Librería Virtual!\n\n" +
				"Tu cuenta ha sido creada exitosamente.\n" +
				"Usuario: %s\n\n" +
				"Ahora puedes explorar nuestro catálogo y realizar compras.\n\n" +
				"Saludos,\n" +
				"Equipo de Librería Virtual",
				customer.getFirstName(),
				customer.getLastName(),
				customer.getUsername()
			);
			
			message.setText(body);
			mailSender.send(message);
		} catch (Exception e) {
			// Log error pero no fallar el registro
			System.err.println("Error enviando email de registro: " + e.getMessage());
		}
	}

	@Override
	public void sendPurchaseConfirmation(Customer customer, PurchaseHistory purchaseHistory) {
		if (!isEmailEnabled()) {
			return;
		}

		try {
			SimpleMailMessage message = new SimpleMailMessage();
			message.setFrom(fromEmail);
			message.setTo(customer.getEmail());
			message.setSubject("Confirmación de Compra - Librería Virtual");
			
			StringBuilder body = new StringBuilder();
			body.append(String.format("Hola %s %s,\n\n", customer.getFirstName(), customer.getLastName()));
			body.append("¡Gracias por tu compra!\n\n");
			body.append("Detalles de tu pedido:\n");
			body.append(String.format("ID de Transacción: %s\n", purchaseHistory.getId()));
			body.append(String.format("Fecha: %s\n\n", purchaseHistory.getDate()));
			body.append("Libros comprados:\n");
			body.append("----------------------------------------\n");
			
			double total = 0;
			int itemNumber = 1;
			for (PurchaseDetail detail : purchaseHistory.getPurchaseDetails()) {
				body.append(String.format("%d. %s\n", itemNumber++, detail.getBook().getName()));
				body.append(String.format("   Cantidad: %d\n", detail.getQuantity()));
				body.append(String.format("   Precio unitario: $%.2f\n", detail.getPrice()));
				double subtotal = detail.getPrice() * detail.getQuantity();
				body.append(String.format("   Subtotal: $%.2f\n\n", subtotal));
				total += subtotal;
			}
			
			body.append("----------------------------------------\n");
			body.append(String.format("TOTAL: $%.2f\n\n", total));
			body.append("Puedes revisar el detalle completo en tu historial de transacciones.\n\n");
			body.append("Saludos,\n");
			body.append("Equipo de Librería Virtual");
			
			message.setText(body.toString());
			mailSender.send(message);
		} catch (Exception e) {
			// Log error pero no fallar la compra
			System.err.println("Error enviando email de confirmación de compra: " + e.getMessage());
		}
	}
}
