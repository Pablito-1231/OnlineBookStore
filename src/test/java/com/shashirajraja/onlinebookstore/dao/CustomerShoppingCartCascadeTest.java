package com.shashirajraja.onlinebookstore.dao;

import static org.junit.jupiter.api.Assertions.assertEquals;

import java.util.List;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.orm.jpa.DataJpaTest;
import org.springframework.boot.test.autoconfigure.jdbc.AutoConfigureTestDatabase;
import org.springframework.test.context.ActiveProfiles;
import org.springframework.transaction.annotation.Transactional;

import com.shashirajraja.onlinebookstore.entity.Book;
import com.shashirajraja.onlinebookstore.entity.BookDetail;
import com.shashirajraja.onlinebookstore.entity.Customer;
import com.shashirajraja.onlinebookstore.entity.ShoppingCart;

@DataJpaTest
@AutoConfigureTestDatabase(replace = AutoConfigureTestDatabase.Replace.NONE)
@ActiveProfiles("test-mysql")
public class CustomerShoppingCartCascadeTest {

    @Autowired
    private CustomerRepository customerRepository;

    @Autowired
    private BookRepository bookRepository;

    @Autowired
    private ShoppingCartRepository shoppingCartRepository;

    @Test
    @Transactional
    public void deleteCustomerShouldRemoveShoppingCartItems() {
        String username = "test_customer_cascade";

        // Clean previous test data
        try { shoppingCartRepository.removeByIds(username, 9999); } catch(Exception e) {}
        customerRepository.deleteById(username);

        // Create book and book detail
        BookDetail bd = new BookDetail("paperback", "detail", 0);
        Book book = new Book("Test Book", 10, 9.99, bd);
        book = bookRepository.saveAndFlush(book);

        Customer customer = new Customer(username, "First", "Last", "test@example.com", 1234567890L, "addr");
        customer = customerRepository.saveAndFlush(customer);

        // Add shopping cart entry and maintain both sides of the relationship
        ShoppingCart sc = new ShoppingCart(customer, book, 2);
        // ensure the customer's collection is updated so JPA cascade/orphanRemoval can work
        customer.addShoppingCart(sc);
        customer = customerRepository.saveAndFlush(customer);

        List<ShoppingCart> before = shoppingCartRepository.getItemsByCustomer(customer);
        assertEquals(1, before.size(), "Shopping cart should have one item after insert");

        // Delete customer
        customerRepository.delete(customer);
        customerRepository.flush();

        List<ShoppingCart> after = shoppingCartRepository.getItemsByCustomer(customer);
        assertEquals(0, after.size(), "Shopping cart items should be removed after deleting customer");
    }
}
