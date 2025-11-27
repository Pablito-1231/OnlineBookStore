package com.shashirajraja.onlinebookstore.controller;

import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Controller;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

import com.shashirajraja.onlinebookstore.entity.CurrentSession;
import com.shashirajraja.onlinebookstore.entity.Customer;
import com.shashirajraja.onlinebookstore.entity.PurchaseHistory;
import com.shashirajraja.onlinebookstore.service.EmailService;
import com.shashirajraja.onlinebookstore.service.PaymentService;
import com.shashirajraja.onlinebookstore.utility.ValidationUtil;

@Controller
public class PaymentController {

	private static final Logger logger = LoggerFactory.getLogger(PaymentController.class);

	@Autowired
	private PaymentService paymentService;
	
	@Autowired
	private CurrentSession currentSession;
	
	@Autowired
	private EmailService emailService;
	
	@GetMapping("customers/cart/pay")
	public String showPaymentForm() {
		
		return "customer-payment-form";
	}
	
	@PostMapping("customers/payment/success")
	public String paymentSuccess(@Param("upi") String upi,@Param("otp") String otp, Model theModel) {
		
		// ========== VALIDACIONES ==========
		if (upi == null || upi.trim().isEmpty()) {
			theModel.addAttribute("message", "❌ Error: El UPI no puede estar vacío");
			theModel.addAttribute("messageType", "error");
			return "customer-payment-form";
		}
		
		if (!ValidationUtil.isValidUPI(upi)) {
			theModel.addAttribute("message", "❌ Error: Formato de UPI inválido (Ej: usuario@banco)");
			theModel.addAttribute("messageType", "error");
			return "customer-payment-form";
		}
		
		if (otp == null || otp.trim().isEmpty()) {
			theModel.addAttribute("message", "❌ Error: El OTP no puede estar vacío");
			theModel.addAttribute("messageType", "error");
			return "customer-payment-form";
		}
		
		if (!ValidationUtil.isValidOTP(otp)) {
			theModel.addAttribute("message", "❌ Error: OTP inválido (debe contener 4-6 dígitos)");
			theModel.addAttribute("messageType", "error");
			return "customer-payment-form";
		}
		
		// ========== PROCESAR PAGO ==========
		try {
			Customer customer = currentSession.getUser().getCustomer();
			
			//load the purchase history
			paymentService.getPurchaseHistories(customer);
			
			//create purchase History
			String transId = paymentService.createTransaction(customer);
			
			// Enviar email de confirmación de compra
			try {
				PurchaseHistory purchaseHistory = paymentService.getPurchaseHistory(customer, transId);
				emailService.sendPurchaseConfirmation(customer, purchaseHistory);
			} catch (Exception emailEx) {
				// Log el error pero no interrumpir el flujo
				logger.warn("Error al enviar email de confirmación: {}", emailEx.getMessage(), emailEx);
			}
			
			theModel.addAttribute("message", "✅ ¡Pago exitoso! ID de transacción: "+ transId);
			theModel.addAttribute("messageType", "success");
			theModel.addAttribute("purchaseHistory", paymentService.getPurchaseHistory(customer, transId));
			
			return "customer-transaction-detail";
		} catch (Exception e) {
			logger.error("ERROR en paymentSuccess: {}", e.getMessage(), e);
			theModel.addAttribute("message", "❌ Error al procesar el pago: " + e.getMessage());
			theModel.addAttribute("messageType", "error");
			return "customer-payment-form";
		}
	}
	
	@GetMapping("customers/transactions")
	public String showTransactions(Model theModel) {
		Customer customer = currentSession.getUser().getCustomer();
		//load the purchaseHistories
		Set<PurchaseHistory> purchaseHistories = paymentService.getPurchaseHistories(customer);
		theModel.addAttribute("purchaseHistories", purchaseHistories);
		theModel.addAttribute("purchaseHistory", new PurchaseHistory());
		return "customer-transactions";
	}
	
	@PostMapping("customers/transactions/detail")
	public String getTransactionDetail(@ModelAttribute String transId, Model theModel) {
		
		if (transId == null || transId.trim().isEmpty()) {
			theModel.addAttribute("message", "❌ Error: ID de transacción no válido");
			theModel.addAttribute("messageType", "error");
			return "customer-transactions";
		}
		
		try {
			theModel.addAttribute("message", "Detalles para ID de transacción: "+ transId);
			Customer customer = currentSession.getUser().getCustomer();
			theModel.addAttribute("purchaseHistory", paymentService.getPurchaseHistory(customer, transId));
			return "customer-transaction-detail";
		} catch (Exception e) {
			theModel.addAttribute("message", "❌ Error al obtener detalles: " + e.getMessage());
			theModel.addAttribute("messageType", "error");
			return "customer-transactions";
		}
	}
}
