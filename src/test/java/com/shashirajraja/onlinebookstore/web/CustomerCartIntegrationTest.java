package com.shashirajraja.onlinebookstore.web;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.model;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.view;

import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.BeforeEach;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.jdbc.AutoConfigureTestDatabase;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.security.test.context.support.WithMockUser;
import org.springframework.test.context.ActiveProfiles;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;

import com.shashirajraja.onlinebookstore.dao.BookRepository;
import com.shashirajraja.onlinebookstore.dao.CustomerRepository;
import com.shashirajraja.onlinebookstore.dao.ShoppingCartRepository;
import com.shashirajraja.onlinebookstore.dao.UserRepository;
import com.shashirajraja.onlinebookstore.entity.Book;
import com.shashirajraja.onlinebookstore.entity.BookDetail;
import com.shashirajraja.onlinebookstore.entity.Customer;
import com.shashirajraja.onlinebookstore.entity.ShoppingCart;
import com.shashirajraja.onlinebookstore.entity.User;

@SpringBootTest
@AutoConfigureMockMvc
@AutoConfigureTestDatabase(replace = AutoConfigureTestDatabase.Replace.NONE)
@ActiveProfiles("test-mysql")
public class CustomerCartIntegrationTest {

    @Autowired
    private MockMvc mockMvc;

    @Autowired
    private BookRepository bookRepository;

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private CustomerRepository customerRepository;

    @Autowired
    private ShoppingCartRepository shoppingCartRepository;

    @BeforeEach
    public void setup() {
        // clean existing test artifacts if any
        String username = "test_customer_integ";
        try { shoppingCartRepository.removeByIds(username, 99999); } catch (Exception e) {}
        try { customerRepository.deleteById(username); } catch (Exception e) {}

        // create book
        BookDetail bd = new BookDetail("paperback","detail",0);
        Book book = new Book("Prueba Integracion Libro", 5, 12.5, bd);
        book = bookRepository.saveAndFlush(book);

        // create user + customer
        Customer customer = new Customer("test_customer_integ", "Fn", "Ln", "t@e.com", 1234567890L, "addr");
        User user = new User();
        user.setUsername("test_customer_integ");
        user.setPassword("noop");
        user.setEnabled(true);
        user.setCustomer(customer);
        customer.setUser(user);
        userRepository.saveAndFlush(user);
        customerRepository.saveAndFlush(customer);

        // add shopping cart
        ShoppingCart sc = new ShoppingCart(customer, book, 1);
        customer.addShoppingCart(sc);
        customerRepository.saveAndFlush(customer);
    }

    @Test
    @WithMockUser(username = "test_customer_integ", roles = {"CUSTOMER"})
    public void cartPageRendersForAuthenticatedCustomer() throws Exception {
        mockMvc.perform(get("/customers/cart"))
            .andExpect(status().isOk())
            .andExpect(view().name("customer-cart"))
            .andExpect(model().attributeExists("shoppingItems"));
    }
}
