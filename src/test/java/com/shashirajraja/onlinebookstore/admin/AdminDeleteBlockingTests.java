package com.shashirajraja.onlinebookstore.admin;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.view;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.model;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.security.test.context.support.WithMockUser;
import org.springframework.test.web.servlet.MockMvc;

import com.shashirajraja.onlinebookstore.dao.CustomerRepository;
import com.shashirajraja.onlinebookstore.dao.ShoppingCartRepository;
import com.shashirajraja.onlinebookstore.dao.UserRepository;
import com.shashirajraja.onlinebookstore.entity.Customer;
import com.shashirajraja.onlinebookstore.entity.User;

@SpringBootTest
@AutoConfigureMockMvc
public class AdminDeleteBlockingTests {

    @Autowired
    private MockMvc mockMvc;

    @Autowired
    private ShoppingCartRepository shoppingCartRepository;

    @Autowired
    private CustomerRepository customerRepository;

    @Autowired
    private UserRepository userRepository;

    @Test
    @WithMockUser(username = "admin", roles = {"ADMIN"})
    void noEliminarSiLibroEnCarrito() throws Exception {
        // Preparar un usuario/cliente de prueba y agregar libro id=1 al carrito
        String username = "cart_tester";
        if (!userRepository.existsById(username)) {
            User u = new User(username, "{noop}x", true);
            userRepository.save(u);
        }
        if (!customerRepository.existsById(username)) {
            Customer c = new Customer(username, "Test", "User", "test@example.com", 1234567890L, "Addr");
            customerRepository.save(c);
        }
        // addByIds(customer_id, book_id, count) – evitar duplicado
        if (shoppingCartRepository.findByIds(username, 1) == null) {
            shoppingCartRepository.addByIds(username, 1, 1);
        }

        // Intentar eliminar el libro id=1
        mockMvc.perform(get("/admin/libros/delete").param("id", "1"))
            .andExpect(status().isOk())
            .andExpect(view().name("admin/libros"))
            .andExpect(model().attribute("messageType", "error"));
    }
}
