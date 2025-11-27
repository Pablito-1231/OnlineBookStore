package com.shashirajraja.onlinebookstore.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

import com.shashirajraja.onlinebookstore.entity.Customer;
import com.shashirajraja.onlinebookstore.forms.entity.CustomerData;
import com.shashirajraja.onlinebookstore.service.CustomerService;
import com.shashirajraja.onlinebookstore.service.EmailService;

@Controller
public class RegisterController {

    private static final org.slf4j.Logger logger = org.slf4j.LoggerFactory.getLogger(RegisterController.class);
	
    @Autowired
    private CustomerService customerService;
    
    @Autowired
    private EmailService emailService;

    @GetMapping("/register")
    public String showRegisterForm(Model model) {
        model.addAttribute("customerData", new CustomerData());
        return "register-customer";
    }

    @PostMapping("/register/customer")
public String processCustomerRegistration(
        @ModelAttribute CustomerData customerData,
        Model model) {

    String message = customerService.registerCustomer(customerData);

    // Si el registro fue exitoso, enviar email y redirigir al login
    if (message.startsWith("¡Registro exitoso")) {
        try {
            // Obtener el customer recién creado para enviar el email
            Customer customer = customerService.getCustomer(customerData.getUsername());
            if (customer != null) {
                emailService.sendRegistrationConfirmation(customer);
            }
        } catch (Exception e) {
            // No fallar el registro si el email falla
            logger.warn("Error enviando correo electrónico de bienvenida: {}", e.getMessage(), e);
        }
        return "redirect:/login";
    }

    // Si hubo error, mostrar mensaje en la misma página
    model.addAttribute("message", message);
    return "register-customer";
}
}
