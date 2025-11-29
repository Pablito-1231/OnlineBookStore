package com.shashirajraja.onlinebookstore.controller.rest;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.shashirajraja.onlinebookstore.dto.BookRequestDto;
import com.shashirajraja.onlinebookstore.entity.Book;
import com.shashirajraja.onlinebookstore.entity.BookDetail;
import com.shashirajraja.onlinebookstore.service.BookService;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.PageRequest;
import org.springframework.http.MediaType;
import org.springframework.security.test.context.support.WithMockUser;
import org.springframework.test.web.servlet.MockMvc;

import java.util.Arrays;
import java.util.List;

import static org.mockito.ArgumentMatchers.*;
import static org.mockito.Mockito.when;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

/**
 * Integration tests for BookRestController
 */
@SpringBootTest
@AutoConfigureMockMvc
class BookRestControllerTest {

    @Autowired
    private MockMvc mockMvc;

    @Autowired
    private ObjectMapper objectMapper;

    @MockBean
    private BookService bookService;

    @Test
    @WithMockUser(username = "testuser", roles = { "CUSTOMER" })
    void testGetAllBooks() throws Exception {
        // Prepare test data
        Book book1 = createTestBook(1, "Book 1", 10, 29.99);
        Book book2 = createTestBook(2, "Book 2", 5, 39.99);
        List<Book> books = Arrays.asList(book1, book2);
        Page<Book> booksPage = new PageImpl<>(books, PageRequest.of(0, 12), 2);

        when(bookService.findAvailableBooksWithPagination(any()))
                .thenReturn(booksPage);

        // Perform request and verify
        mockMvc.perform(get("/api/v1/books")
                .contentType(MediaType.APPLICATION_JSON))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.success").value(true))
                .andExpect(jsonPath("$.data.content").isArray())
                .andExpect(jsonPath("$.data.content.length()").value(2))
                .andExpect(jsonPath("$.data.totalElements").value(2))
                .andExpect(jsonPath("$.data.totalPages").value(1));
    }

    @Test
    @WithMockUser(username = "testuser", roles = { "CUSTOMER" })
    void testGetBookById() throws Exception {
        Book book = createTestBook(1, "Test Book", 10, 29.99);

        when(bookService.getBookById(1)).thenReturn(book);

        mockMvc.perform(get("/api/v1/books/1")
                .contentType(MediaType.APPLICATION_JSON))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.success").value(true))
                .andExpect(jsonPath("$.data.id").value(1))
                .andExpect(jsonPath("$.data.name").value("Test Book"))
                .andExpect(jsonPath("$.data.price").value(29.99))
                .andExpect(jsonPath("$.data.available").value(true));
    }

    @Test
    @WithMockUser(username = "testuser", roles = { "CUSTOMER" })
    void testGetBookByIdNotFound() throws Exception {
        when(bookService.getBookById(999)).thenReturn(null);

        mockMvc.perform(get("/api/v1/books/999")
                .contentType(MediaType.APPLICATION_JSON))
                .andExpect(status().isNotFound())
                .andExpect(jsonPath("$.success").value(false))
                .andExpect(jsonPath("$.message").value("Book not found with id: 999"));
    }

    @Test
    @WithMockUser(username = "admin", roles = { "ADMIN" })
    void testCreateBook() throws Exception {
        BookRequestDto requestDto = new BookRequestDto(
                "New Book", 15, 49.99, "Hardcover", "Great book");

        when(bookService.addBook(any(Book.class)))
                .thenReturn("Book added successfully");

        mockMvc.perform(post("/api/v1/books")
                .contentType(MediaType.APPLICATION_JSON)
                .content(objectMapper.writeValueAsString(requestDto)))
                .andExpect(status().isCreated())
                .andExpect(jsonPath("$.success").value(true))
                .andExpect(jsonPath("$.message").value("Book created successfully"))
                .andExpect(jsonPath("$.data.name").value("New Book"));
    }

    @Test
    @WithMockUser(username = "admin", roles = { "ADMIN" })
    void testCreateBookValidationError() throws Exception {
        BookRequestDto requestDto = new BookRequestDto(
                "", -5, -10.0, "", "" // Invalid data
        );

        mockMvc.perform(post("/api/v1/books")
                .contentType(MediaType.APPLICATION_JSON)
                .content(objectMapper.writeValueAsString(requestDto)))
                .andExpect(status().isBadRequest())
                .andExpect(jsonPath("$.success").value(false))
                .andExpect(jsonPath("$.message").value("Validation failed"));
    }

    @Test
    @WithMockUser(username = "admin", roles = { "ADMIN" })
    void testUpdateBook() throws Exception {
        Book existingBook = createTestBook(1, "Old Name", 10, 29.99);
        BookRequestDto updateDto = new BookRequestDto(
                "Updated Name", 20, 39.99, "E-Book", "Updated description");

        when(bookService.getBookById(1)).thenReturn(existingBook);
        when(bookService.updateBook(any(Book.class)))
                .thenReturn("Book updated successfully");

        mockMvc.perform(put("/api/v1/books/1")
                .contentType(MediaType.APPLICATION_JSON)
                .content(objectMapper.writeValueAsString(updateDto)))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.success").value(true))
                .andExpect(jsonPath("$.message").value("Book updated successfully"))
                .andExpect(jsonPath("$.data.name").value("Updated Name"));
    }

    @Test
    @WithMockUser(username = "admin", roles = { "ADMIN" })
    void testDeleteBook() throws Exception {
        Book book = createTestBook(1, "Test Book", 10, 29.99);

        when(bookService.getBookById(1)).thenReturn(book);
        when(bookService.removeBookById(1))
                .thenReturn("Book removed successfully");

        mockMvc.perform(delete("/api/v1/books/1")
                .contentType(MediaType.APPLICATION_JSON))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.success").value(true))
                .andExpect(jsonPath("$.message").value("Book deleted successfully"));
    }

    @Test
    @WithMockUser(username = "testuser", roles = { "CUSTOMER" })
    void testGetAvailableBooks() throws Exception {
        Book book1 = createTestBook(1, "Available Book 1", 10, 29.99);
        Book book2 = createTestBook(2, "Available Book 2", 5, 39.99);
        List<Book> books = Arrays.asList(book1, book2);
        Page<Book> booksPage = new PageImpl<>(books, PageRequest.of(0, 12), 2);

        when(bookService.findAvailableBooksWithPagination(any()))
                .thenReturn(booksPage);

        mockMvc.perform(get("/api/v1/books/available")
                .contentType(MediaType.APPLICATION_JSON))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.success").value(true))
                .andExpect(jsonPath("$.data.content.length()").value(2));
    }

    // Helper method
    private Book createTestBook(int id, String name, int quantity, double price) {
        BookDetail detail = new BookDetail("E-Book", "Test description", 0);
        Book book = new Book(name, quantity, price, detail);
        book.setId(id);
        return book;
    }
}
