package com.shashirajraja.onlinebookstore.controller.rest;

import com.shashirajraja.onlinebookstore.dto.ApiResponse;
import com.shashirajraja.onlinebookstore.dto.CartItemResponseDto;
import com.shashirajraja.onlinebookstore.entity.Book;
import com.shashirajraja.onlinebookstore.entity.Customer;
import com.shashirajraja.onlinebookstore.entity.ShoppingCart;
import com.shashirajraja.onlinebookstore.service.BookService;
import com.shashirajraja.onlinebookstore.service.CustomerService;
import com.shashirajraja.onlinebookstore.service.ShoppingCartService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

/**
 * REST API Controller for Shopping Cart management
 * Base path: /api/v1/cart
 */
@RestController
@RequestMapping("/api/v1/cart")
public class ShoppingCartRestController {

    private static final Logger log = LoggerFactory.getLogger(ShoppingCartRestController.class);

    @Autowired
    private ShoppingCartService cartService;

    @Autowired
    private CustomerService customerService;

    @Autowired
    private BookService bookService;

    /**
     * Get current user's shopping cart
     * GET /api/v1/cart
     */
    @GetMapping
    public ResponseEntity<ApiResponse<List<CartItemResponseDto>>> getCart() {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        String username = auth.getName();

        log.debug("GET /api/v1/cart - username: {}", username);

        Customer customer = customerService.getCustomer(username);
        if (customer == null) {
            return ResponseEntity
                    .status(HttpStatus.NOT_FOUND)
                    .body(ApiResponse.error("Customer not found"));
        }

        Set<ShoppingCart> cartItems = cartService.getByUsername(customer);
        List<CartItemResponseDto> cartDtos = cartItems.stream()
                .map(this::convertToDto)
                .collect(Collectors.toList());

        return ResponseEntity.ok(ApiResponse.success(cartDtos));
    }

    /**
     * Add item to cart
     * POST /api/v1/cart/items
     * Body: { "bookId": 1, "quantity": 2 }
     */
    @PostMapping("/items")
    public ResponseEntity<ApiResponse<String>> addToCart(
            @RequestBody AddToCartRequest request) {

        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        String username = auth.getName();

        log.info("POST /api/v1/cart/items - username: {}, bookId: {}, quantity: {}",
                username, request.getBookId(), request.getQuantity());

        Customer customer = customerService.getCustomer(username);
        if (customer == null) {
            return ResponseEntity
                    .status(HttpStatus.NOT_FOUND)
                    .body(ApiResponse.error("Customer not found"));
        }

        Book book = bookService.getBookById(request.getBookId());
        if (book == null) {
            return ResponseEntity
                    .status(HttpStatus.NOT_FOUND)
                    .body(ApiResponse.error("Book not found"));
        }

        if (book.getQuantity() < request.getQuantity()) {
            return ResponseEntity
                    .badRequest()
                    .body(ApiResponse.error("Insufficient stock. Available: " + book.getQuantity()));
        }

        String result;
        if (request.getQuantity() == 1) {
            result = cartService.addItem(customer, book);
        } else {
            result = cartService.increaseItem(customer, book, request.getQuantity());
        }

        if (result.contains("successfully") || result.contains("exitosamente")) {
            return ResponseEntity
                    .status(HttpStatus.CREATED)
                    .body(ApiResponse.success(result, result));
        } else {
            return ResponseEntity
                    .badRequest()
                    .body(ApiResponse.error(result));
        }
    }

    /**
     * Update cart item quantity
     * PUT /api/v1/cart/items/{bookId}
     * Body: { "quantity": 3 }
     */
    @PutMapping("/items/{bookId}")
    public ResponseEntity<ApiResponse<String>> updateCartItem(
            @PathVariable int bookId,
            @RequestBody UpdateCartRequest request) {

        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        String username = auth.getName();

        log.info("PUT /api/v1/cart/items/{} - username: {}, quantity: {}",
                bookId, username, request.getQuantity());

        Customer customer = customerService.getCustomer(username);
        Book book = bookService.getBookById(bookId);

        if (customer == null || book == null) {
            return ResponseEntity
                    .status(HttpStatus.NOT_FOUND)
                    .body(ApiResponse.error("Customer or book not found"));
        }

        if (book.getQuantity() < request.getQuantity()) {
            return ResponseEntity
                    .badRequest()
                    .body(ApiResponse.error("Insufficient stock. Available: " + book.getQuantity()));
        }

        String result = cartService.increaseItem(customer, book, request.getQuantity());

        if (result.contains("successfully") || result.contains("exitosamente")) {
            return ResponseEntity.ok(ApiResponse.success(result, result));
        } else {
            return ResponseEntity
                    .badRequest()
                    .body(ApiResponse.error(result));
        }
    }

    /**
     * Remove item from cart
     * DELETE /api/v1/cart/items/{bookId}
     */
    @DeleteMapping("/items/{bookId}")
    public ResponseEntity<ApiResponse<Void>> removeFromCart(@PathVariable int bookId) {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        String username = auth.getName();

        log.info("DELETE /api/v1/cart/items/{} - username: {}", bookId, username);

        Customer customer = customerService.getCustomer(username);
        Book book = bookService.getBookById(bookId);

        if (customer == null || book == null) {
            return ResponseEntity
                    .status(HttpStatus.NOT_FOUND)
                    .body(ApiResponse.error("Customer or book not found"));
        }

        String result = cartService.removeItem(customer, book);

        if (result.contains("successfully") || result.contains("exitosamente")) {
            return ResponseEntity.ok(ApiResponse.success(result, null));
        } else {
            return ResponseEntity
                    .badRequest()
                    .body(ApiResponse.error(result));
        }
    }

    /**
     * Clear entire cart
     * DELETE /api/v1/cart
     */
    @DeleteMapping
    public ResponseEntity<ApiResponse<Void>> clearCart() {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        String username = auth.getName();

        log.info("DELETE /api/v1/cart - username: {}", username);

        Customer customer = customerService.getCustomer(username);
        if (customer == null) {
            return ResponseEntity
                    .status(HttpStatus.NOT_FOUND)
                    .body(ApiResponse.error("Customer not found"));
        }

        Set<ShoppingCart> cartItems = cartService.getByUsername(customer);
        for (ShoppingCart item : cartItems) {
            cartService.removeItem(customer, item.getBook());
        }

        return ResponseEntity.ok(ApiResponse.success("Cart cleared successfully", null));
    }

    /**
     * Get cart total
     * GET /api/v1/cart/total
     */
    @GetMapping("/total")
    public ResponseEntity<ApiResponse<CartTotalResponse>> getCartTotal() {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        String username = auth.getName();

        log.debug("GET /api/v1/cart/total - username: {}", username);

        Customer customer = customerService.getCustomer(username);
        if (customer == null) {
            return ResponseEntity
                    .status(HttpStatus.NOT_FOUND)
                    .body(ApiResponse.error("Customer not found"));
        }

        Set<ShoppingCart> cartItems = cartService.getByUsername(customer);

        double total = cartItems.stream()
                .mapToDouble(item -> item.getBook().getPrice() * item.getQuantity())
                .sum();

        int itemCount = cartItems.size();
        int totalQuantity = cartItems.stream()
                .mapToInt(ShoppingCart::getQuantity)
                .sum();

        CartTotalResponse response = new CartTotalResponse(total, itemCount, totalQuantity);
        return ResponseEntity.ok(ApiResponse.success(response));
    }

    // Helper methods and DTOs

    private CartItemResponseDto convertToDto(ShoppingCart cartItem) {
        Book book = cartItem.getBook();
        return new CartItemResponseDto(
                book.getId(),
                book.getName(),
                book.getPrice(),
                cartItem.getQuantity(),
                book.getQuantity() > 0);
    }

    // Inner classes for request/response

    public static class AddToCartRequest {
        private int bookId;
        private int quantity = 1;

        public int getBookId() {
            return bookId;
        }

        public void setBookId(int bookId) {
            this.bookId = bookId;
        }

        public int getQuantity() {
            return quantity;
        }

        public void setQuantity(int quantity) {
            this.quantity = quantity;
        }
    }

    public static class UpdateCartRequest {
        private int quantity;

        public int getQuantity() {
            return quantity;
        }

        public void setQuantity(int quantity) {
            this.quantity = quantity;
        }
    }

    public static class CartTotalResponse {
        private double total;
        private int itemCount;
        private int totalQuantity;

        public CartTotalResponse(double total, int itemCount, int totalQuantity) {
            this.total = total;
            this.itemCount = itemCount;
            this.totalQuantity = totalQuantity;
        }

        public double getTotal() {
            return total;
        }

        public void setTotal(double total) {
            this.total = total;
        }

        public int getItemCount() {
            return itemCount;
        }

        public void setItemCount(int itemCount) {
            this.itemCount = itemCount;
        }

        public int getTotalQuantity() {
            return totalQuantity;
        }

        public void setTotalQuantity(int totalQuantity) {
            this.totalQuantity = totalQuantity;
        }
    }
}
