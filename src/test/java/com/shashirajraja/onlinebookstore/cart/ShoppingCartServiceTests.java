package com.shashirajraja.onlinebookstore.cart;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import com.shashirajraja.onlinebookstore.dao.CustomerRepository;
import com.shashirajraja.onlinebookstore.dao.ShoppingCartRepository;
import com.shashirajraja.onlinebookstore.dao.UserRepository;
import com.shashirajraja.onlinebookstore.dao.BookRepository;
import com.shashirajraja.onlinebookstore.entity.Book;
import com.shashirajraja.onlinebookstore.entity.Customer;
import com.shashirajraja.onlinebookstore.entity.User;
import com.shashirajraja.onlinebookstore.entity.ShoppingCart;
import com.shashirajraja.onlinebookstore.service.ShoppingCartService;

@SpringBootTest
public class ShoppingCartServiceTests {

    @Autowired private ShoppingCartService shoppingCartService;
    @Autowired private ShoppingCartRepository shoppingCartRepository;
    @Autowired private CustomerRepository customerRepository;
    @Autowired private UserRepository userRepository;
    @Autowired private BookRepository bookRepository;

    @Test
    void addIncreaseDecrease_flow() {
        String username = "cart_flow";
        if (!userRepository.existsById(username)) {
            userRepository.save(new User(username, "{noop}x", true));
        }
        if (!customerRepository.existsById(username)) {
            customerRepository.save(new Customer(username, "Flow", "User", "flow@example.com", 1111111111L, "Addr"));
        }
        Customer customer = customerRepository.findById(username).orElseThrow();
        Book book = bookRepository.findById(1).orElseThrow();

        // add 1
        shoppingCartService.addItem(customer, book);
        ShoppingCart sc1 = shoppingCartRepository.findByIds(username, 1);
        assertNotNull(sc1);
        assertEquals(1, sc1.getQuantity());

        // increase by 2 -> 3
        shoppingCartService.increaseItem(customer, book, 2);
        ShoppingCart sc2 = shoppingCartRepository.findByIds(username, 1);
        assertEquals(3, sc2.getQuantity());

        // decrease by 1 -> 2
        shoppingCartService.decreaseItem(customer, book, 1);
        ShoppingCart sc3 = shoppingCartRepository.findByIds(username, 1);
        assertEquals(2, sc3.getQuantity());

        // decrease by 2 -> remove
        shoppingCartService.decreaseItem(customer, book, 2);
        ShoppingCart sc4 = shoppingCartRepository.findByIds(username, 1);
        assertEquals(null, sc4);
    }
}
