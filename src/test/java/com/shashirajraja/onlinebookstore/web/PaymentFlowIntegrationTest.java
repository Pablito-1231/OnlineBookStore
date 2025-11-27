package com.shashirajraja.onlinebookstore.web;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.model;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.view;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.jdbc.AutoConfigureTestDatabase;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.security.test.context.support.WithMockUser;
import static org.springframework.security.test.web.servlet.request.SecurityMockMvcRequestPostProcessors.csrf;
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
import com.shashirajraja.onlinebookstore.service.EmailService;

@SpringBootTest
@AutoConfigureMockMvc
@AutoConfigureTestDatabase(replace = AutoConfigureTestDatabase.Replace.NONE)
@ActiveProfiles("test-mysql")
public class PaymentFlowIntegrationTest {

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

    @MockBean
    private EmailService emailService; // evitar envío real de correos

    @BeforeEach
    public void setup() {
        String username = "test_customer_pay";
        try { shoppingCartRepository.removeByIds(username, 99999); } catch (Exception e) {}
        try { customerRepository.deleteById(username); } catch (Exception e) {}
        try { userRepository.deleteById(username); } catch (Exception e) {}

        BookDetail bd = new BookDetail("paperback","detail",0);
        Book book = new Book("Libro Pago Test", 5, 20.0, bd);
        book = bookRepository.saveAndFlush(book);

        Customer customer = new Customer(username, "Fn", "Ln", "t@e.com", 1234567890L, "addr");
        User user = new User();
        user.setUsername(username);
        user.setPassword("noop");
        user.setEnabled(true);
        user.setCustomer(customer);
        customer.setUser(user);
        userRepository.saveAndFlush(user);
        customerRepository.saveAndFlush(customer);

        ShoppingCart sc = new ShoppingCart(customer, book, 1);
        customer.addShoppingCart(sc);
        customerRepository.saveAndFlush(customer);
    }

    @Test
    @WithMockUser(username = "test_customer_pay", roles = {"CUSTOMER"})
    public void paymentSuccessCreatesTransaction() throws Exception {
        mockMvc.perform(post("/customers/payment/success")
            .with(csrf())
            .param("upi", "usuario@banco")
            .param("otp", "1234"))
                .andExpect(status().isOk())
                .andExpect(view().name("customer-transaction-detail"))
                .andExpect(model().attributeExists("message"))
                .andExpect(model().attributeExists("purchaseHistory"));
    }
}
