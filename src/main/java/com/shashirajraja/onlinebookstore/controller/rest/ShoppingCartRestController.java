package com.shashirajraja.onlinebookstore.controller.rest;

import com.shashirajraja.onlinebookstore.dto.ApiResponse;
import com.shashirajraja.onlinebookstore.entity.Book;
import com.shashirajraja.onlinebookstore.entity.Customer;
import com.shashirajraja.onlinebookstore.entity.ShoppingCart;
import com.shashirajraja.onlinebookstore.service.BookService;
import com.shashirajraja.onlinebookstore.service.CustomerService;
import com.shashirajraja.onlinebookstore.service.ShoppingCartService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/cart")
public class ShoppingCartRestController {

    private final ShoppingCartService shoppingCartService;
    private final CustomerService customerService;
    private final BookService bookService;

    @Autowired
    public ShoppingCartRestController(ShoppingCartService shoppingCartService, CustomerService customerService,
            BookService bookService) {
        this.shoppingCartService = shoppingCartService;
        this.customerService = customerService;
        this.bookService = bookService;
    }

    @GetMapping
    public ResponseEntity<ApiResponse<List<Map<String, Object>>>> getCart() {
        Customer customer = getAuthenticatedCustomer();
        if (customer == null) {
            return ResponseEntity.status(401)
                    .body(new ApiResponse<>(false, "User not authenticated or not a customer", null));
        }

        java.util.Set<ShoppingCart> items = shoppingCartService.getAllItems(customer);
        List<Map<String, Object>> response = new ArrayList<>();

        for (ShoppingCart item : items) {
            Map<String, Object> itemData = new HashMap<>();
            itemData.put("bookId", item.getBook().getId());
            itemData.put("bookName", item.getBook().getName());
            itemData.put("price", item.getBook().getPrice());
            itemData.put("quantity", item.getQuantity());
            response.add(itemData);
        }

        return ResponseEntity.ok(new ApiResponse<>(true, "Cart items retrieved", response));
    }

    @PostMapping("/add")
    public ResponseEntity<ApiResponse<String>> addToCart(@RequestParam int bookId) {
        Customer customer = getAuthenticatedCustomer();
        if (customer == null) {
            return ResponseEntity.status(401).body(new ApiResponse<>(false, "User not authenticated", null));
        }

        Book book = bookService.getBookById(bookId);
        if (book == null) {
            return ResponseEntity.status(404).body(new ApiResponse<>(false, "Book not found", null));
        }

        shoppingCartService.addItem(customer, book);
        return ResponseEntity.ok(new ApiResponse<>(true, "Item added to cart", null));
    }

    @PostMapping("/remove")
    public ResponseEntity<ApiResponse<String>> removeFromCart(@RequestParam int bookId) {
        Customer customer = getAuthenticatedCustomer();
        if (customer == null) {
            return ResponseEntity.status(401).body(new ApiResponse<>(false, "User not authenticated", null));
        }

        Book book = bookService.getBookById(bookId);
        if (book == null) {
            return ResponseEntity.status(404).body(new ApiResponse<>(false, "Book not found", null));
        }

        shoppingCartService.removeItem(customer, book);
        return ResponseEntity.ok(new ApiResponse<>(true, "Item removed from cart", null));
    }

    private Customer getAuthenticatedCustomer() {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        if (auth == null || !auth.isAuthenticated()) {
            return null;
        }
        return customerService.getCustomer(auth.getName());
    }
}
