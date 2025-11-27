package com.shashirajraja.onlinebookstore.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.shashirajraja.onlinebookstore.entity.Customer;
import com.shashirajraja.onlinebookstore.entity.PurchaseDetail;
import com.shashirajraja.onlinebookstore.entity.PurchaseHistory;

@Service
public class EmailServiceImpl implements EmailService {

	private static final Logger logger = LoggerFactory.getLogger(EmailServiceImpl.class);

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
			
			String body = (
                    """
                    Hola %s %s,
                    
                    ¡Gracias por registrarte en Librería Virtual!
                    
                    Tu cuenta ha sido creada exitosamente.
                    Usuario: %s
                    
                    Ahora puedes explorar nuestro catálogo y realizar compras.
                    
                    Saludos,
                    Equipo de Librería Virtual""").formatted(
                    customer.getFirstName(),
                    customer.getLastName(),
                    customer.getUsername()
            );
			
			message.setText(body);
			mailSender.send(message);
		} catch (Exception e) {
			// Log error pero no fallar el registro
			logger.warn("Error enviando email de registro: {}", e.getMessage(), e);
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
			body.append("Hola %s %s,\n\n".formatted(customer.getFirstName(), customer.getLastName()));
			body.append("¡Gracias por tu compra!\n\n");
			body.append("Detalles de tu pedido:\n");
			body.append("ID de Transacción: %s\n".formatted(purchaseHistory.getId()));
			body.append("Fecha: %s\n\n".formatted(purchaseHistory.getDate()));
			body.append("Libros comprados:\n");
			body.append("----------------------------------------\n");
			
			double total = 0;
			int itemNumber = 1;
			for (PurchaseDetail detail : purchaseHistory.getPurchaseDetails()) {
				body.append("%d. %s\n".formatted(itemNumber++, detail.getBook().getName()));
				body.append("   Cantidad: %d\n".formatted(detail.getQuantity()));
				body.append("   Precio unitario: $%.2f\n".formatted(detail.getPrice()));
				double subtotal = detail.getPrice() * detail.getQuantity();
				body.append("   Subtotal: $%.2f\n\n".formatted(subtotal));
				total += subtotal;
			}
			
			body.append("----------------------------------------\n");
			body.append("TOTAL: $%.2f\n\n".formatted(total));
			body.append("Puedes revisar el detalle completo en tu historial de transacciones.\n\n");
			body.append("Saludos,\n");
			body.append("Equipo de Librería Virtual");
			
			message.setText(body.toString());
			mailSender.send(message);
		} catch (Exception e) {
			// Log error pero no fallar la compra
			logger.warn("Error enviando email de confirmación de compra: {}", e.getMessage(), e);
		}
	}
}
