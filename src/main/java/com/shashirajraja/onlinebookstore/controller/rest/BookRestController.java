package com.shashirajraja.onlinebookstore.controller.rest;

import com.shashirajraja.onlinebookstore.dto.ApiResponse;
import com.shashirajraja.onlinebookstore.dto.BookResponseDto;
import com.shashirajraja.onlinebookstore.entity.Book;
import com.shashirajraja.onlinebookstore.service.BookService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/api/books")
public class BookRestController {

    private final BookService bookService;

    @Autowired
    public BookRestController(BookService bookService) {
        this.bookService = bookService;
    }

    @GetMapping
    public ResponseEntity<ApiResponse<List<BookResponseDto>>> getAllBooks() {
        // Using getAllBooks() and streaming to list
        List<BookResponseDto> dtos = bookService.getAllBooks().stream()
                .map(this::convertToDto)
                .collect(Collectors.toList());

        return ResponseEntity.ok(new ApiResponse<>(true, "Books retrieved successfully", dtos));
    }

    @GetMapping("/{id}")
    public ResponseEntity<ApiResponse<BookResponseDto>> getBookById(@PathVariable int id) {
        Book book = bookService.getBookById(id);
        if (book == null) {
            return ResponseEntity.status(404).body(new ApiResponse<>(false, "Book not found", null));
        }
        return ResponseEntity.ok(new ApiResponse<>(true, "Book found", convertToDto(book)));
    }

    @GetMapping("/search")
    public ResponseEntity<ApiResponse<List<BookResponseDto>>> searchBooks(@RequestParam String query) {
        List<BookResponseDto> dtos = bookService.searchBooks(query).stream()
                .map(this::convertToDto)
                .collect(Collectors.toList());
        return ResponseEntity.ok(new ApiResponse<>(true, "Search results", dtos));
    }

    private BookResponseDto convertToDto(Book book) {
        return new BookResponseDto(
                book.getId(),
                book.getName(),
                book.getQuantity(),
                book.getPrice(),
                book.getBookDetail() != null ? book.getBookDetail().getType() : null,
                book.getBookDetail() != null ? book.getBookDetail().getDetail() : null);
    }
}
