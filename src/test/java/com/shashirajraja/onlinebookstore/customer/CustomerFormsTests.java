package com.shashirajraja.onlinebookstore.customer;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.view;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.model;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.security.test.context.support.WithMockUser;
import org.springframework.test.web.servlet.MockMvc;
import static org.springframework.security.test.web.servlet.request.SecurityMockMvcRequestPostProcessors.csrf;

@SpringBootTest
@AutoConfigureMockMvc
public class CustomerFormsTests {
    @Autowired
    private com.shashirajraja.onlinebookstore.dao.UserRepository userRepository;
    @Autowired
    private com.shashirajraja.onlinebookstore.dao.CustomerRepository customerRepository;
    @Autowired
    private com.shashirajraja.onlinebookstore.entity.CurrentSession currentSession;
    @Autowired
    private org.springframework.security.crypto.password.PasswordEncoder passwordEncoder;

    private void prepararUsuarioSesion() {
        String username = "cliente1";
        String rawPassword = "Password123";
        if (!userRepository.existsById(username)) {
            com.shashirajraja.onlinebookstore.entity.User u = new com.shashirajraja.onlinebookstore.entity.User(username, passwordEncoder.encode(rawPassword), true);
            userRepository.save(u);
        }
        if (!customerRepository.existsById(username)) {
            com.shashirajraja.onlinebookstore.entity.Customer c = new com.shashirajraja.onlinebookstore.entity.Customer(username, "Ana", "García", "ana@example.com", 1234567890L, "Dirección");
            customerRepository.save(c);
        }
        // Simular sesión
        com.shashirajraja.onlinebookstore.entity.User user = userRepository.findById(username).get();
        currentSession.setUser(user);
    }

    @Autowired
    private MockMvc mockMvc;

    @Test
    @WithMockUser(username = "cliente1", roles = {"CUSTOMER"})
    void actualizarPerfil_valido() throws Exception {
        prepararUsuarioSesion();
        mockMvc.perform(post("/customers/profile/update/process")
                .param("username", "cliente1")
                .param("role", "ROLE_CUSTOMER")
                .param("firstName", "Ana")
                .param("lastName", "García")
                .param("email", "ana@example.com")
                .param("password", "Password123")
                .with(csrf()))
            .andExpect(status().isOk())
            .andExpect(view().name("customer-profile-update"));
    }

    @Test
    @WithMockUser(username = "cliente1", roles = {"CUSTOMER"})
    void actualizarPerfil_invalido_email() throws Exception {
        prepararUsuarioSesion();
        mockMvc.perform(post("/customers/profile/update/process")
                .param("username", "cliente1")
                .param("role", "ROLE_CUSTOMER")
                .param("firstName", "Ana")
                .param("lastName", "García")
                .param("email", "noemail")
                .param("password", "Password123")
                .with(csrf()))
            .andExpect(status().isOk())
            .andExpect(view().name("customer-profile-update"))
            .andExpect(model().attributeExists("message"));
    }

    @Test
    @WithMockUser(username = "cliente1", roles = {"CUSTOMER"})
    void procesarPago_valido() throws Exception {
        prepararUsuarioSesion();
        mockMvc.perform(post("/customers/payment/success")
                .param("upi", "usuario@banco")
                .param("otp", "1234")
                .with(csrf()))
            .andExpect(status().isOk())
            .andExpect(view().name("customer-transaction-detail"));
    }

    @Test
    @WithMockUser(username = "cliente1", roles = {"CUSTOMER"})
    void procesarPago_invalido_otp() throws Exception {
        prepararUsuarioSesion();
        mockMvc.perform(post("/customers/payment/success")
                .param("upi", "usuario@banco")
                .param("otp", "")
                .with(csrf()))
            .andExpect(status().isOk())
            .andExpect(view().name("customer-payment-form"))
            .andExpect(model().attributeExists("message"));
    }
}
