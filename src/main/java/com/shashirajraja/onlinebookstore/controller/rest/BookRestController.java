package com.shashirajraja.onlinebookstore.controller.rest;

import com.shashirajraja.onlinebookstore.dto.ApiResponse;
import com.shashirajraja.onlinebookstore.dto.BookRequestDto;
import com.shashirajraja.onlinebookstore.dto.BookResponseDto;
import com.shashirajraja.onlinebookstore.dto.PageResponse;
import com.shashirajraja.onlinebookstore.entity.Book;
import com.shashirajraja.onlinebookstore.entity.BookDetail;
import com.shashirajraja.onlinebookstore.service.BookService;
import jakarta.validation.Valid;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.stream.Collectors;

/**
 * REST API Controller for Book management
 * Base path: /api/v1/books
 */
@RestController
@RequestMapping("/api/v1/books")
public class BookRestController {

    private static final Logger log = LoggerFactory.getLogger(BookRestController.class);
    private static final int DEFAULT_PAGE_SIZE = 12;

    @Autowired
    private BookService bookService;

    /**
     * Get all books with pagination and filters
     * GET
     * /api/v1/books?page=0&size=12&search=java&minPrice=10&maxPrice=100&sort=name,asc
     */
    @GetMapping
    public ResponseEntity<ApiResponse<PageResponse<BookResponseDto>>> getAllBooks(
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = DEFAULT_PAGE_SIZE + "") int size,
            @RequestParam(defaultValue = "") String search,
            @RequestParam(defaultValue = "0") double minPrice,
            @RequestParam(defaultValue = "10000") double maxPrice,
            @RequestParam(defaultValue = "name") String sortBy,
            @RequestParam(defaultValue = "asc") String sortDir) {

        log.debug("GET /api/v1/books - page: {}, size: {}, search: '{}', price: {}-{}",
                page, size, search, minPrice, maxPrice);

        Sort sort = sortDir.equalsIgnoreCase("desc")
                ? Sort.by(sortBy).descending()
                : Sort.by(sortBy).ascending();
        Pageable pageable = PageRequest.of(page, size, sort);

        Page<Book> booksPage;
        if (!search.isEmpty() || minPrice > 0 || maxPrice < 10000) {
            booksPage = bookService.searchBooksAdvanced(
                    search.isEmpty() ? "%" : search, minPrice, maxPrice, pageable);
        } else {
            booksPage = bookService.findAvailableBooksWithPagination(pageable);
        }

        List<BookResponseDto> bookDtos = booksPage.getContent().stream()
                .map(this::convertToDto)
                .collect(Collectors.toList());

        PageResponse<BookResponseDto> pageResponse = new PageResponse<>(
                bookDtos,
                booksPage.getNumber(),
                booksPage.getSize(),
                booksPage.getTotalElements(),
                booksPage.getTotalPages());

        return ResponseEntity.ok(ApiResponse.success(pageResponse));
    }

    /**
     * Get book by ID
     * GET /api/v1/books/{id}
     */
    @GetMapping("/{id}")
    public ResponseEntity<ApiResponse<BookResponseDto>> getBookById(@PathVariable int id) {
        log.debug("GET /api/v1/books/{}", id);

        Book book = bookService.getBookById(id);
        if (book == null) {
            return ResponseEntity
                    .status(HttpStatus.NOT_FOUND)
                    .body(ApiResponse.error("Book not found with id: " + id));
        }

        BookResponseDto dto = convertToDto(book);
        return ResponseEntity.ok(ApiResponse.success(dto));
    }

    /**
     * Create new book
     * POST /api/v1/books
     */
    @PostMapping
    public ResponseEntity<ApiResponse<BookResponseDto>> createBook(
            @Valid @RequestBody BookRequestDto bookRequest) {

        log.info("POST /api/v1/books - Creating book: {}", bookRequest.getName());

        Book book = convertToEntity(bookRequest);
        String result = bookService.addBook(book);

        if (result.contains("successfully") || result.contains("exitosamente")) {
            BookResponseDto dto = convertToDto(book);
            return ResponseEntity
                    .status(HttpStatus.CREATED)
                    .body(ApiResponse.success("Book created successfully", dto));
        } else {
            return ResponseEntity
                    .badRequest()
                    .body(ApiResponse.error(result));
        }
    }

    /**
     * Update existing book
     * PUT /api/v1/books/{id}
     */
    @PutMapping("/{id}")
    public ResponseEntity<ApiResponse<BookResponseDto>> updateBook(
            @PathVariable int id,
            @Valid @RequestBody BookRequestDto bookRequest) {

        log.info("PUT /api/v1/books/{} - Updating book", id);

        Book existingBook = bookService.getBookById(id);
        if (existingBook == null) {
            return ResponseEntity
                    .status(HttpStatus.NOT_FOUND)
                    .body(ApiResponse.error("Book not found with id: " + id));
        }

        // Update fields
        existingBook.setName(bookRequest.getName());
        existingBook.setQuantity(bookRequest.getQuantity());
        existingBook.setPrice(bookRequest.getPrice());

        if (existingBook.getBookDetail() == null) {
            existingBook.setBookDetail(new BookDetail());
        }
        existingBook.getBookDetail().setType(bookRequest.getType());
        existingBook.getBookDetail().setDetail(bookRequest.getDetail());

        String result = bookService.updateBook(existingBook);

        if (result.contains("successfully") || result.contains("exitosamente")) {
            BookResponseDto dto = convertToDto(existingBook);
            return ResponseEntity.ok(ApiResponse.success("Book updated successfully", dto));
        } else {
            return ResponseEntity
                    .badRequest()
                    .body(ApiResponse.error(result));
        }
    }

    /**
     * Delete book
     * DELETE /api/v1/books/{id}
     */
    @DeleteMapping("/{id}")
    public ResponseEntity<ApiResponse<Void>> deleteBook(@PathVariable int id) {
        log.info("DELETE /api/v1/books/{}", id);

        Book book = bookService.getBookById(id);
        if (book == null) {
            return ResponseEntity
                    .status(HttpStatus.NOT_FOUND)
                    .body(ApiResponse.error("Book not found with id: " + id));
        }

        String result = bookService.removeBookById(id);

        if (result.contains("successfully") || result.contains("exitosamente")) {
            return ResponseEntity.ok(ApiResponse.success("Book deleted successfully", null));
        } else {
            return ResponseEntity
                    .badRequest()
                    .body(ApiResponse.error(result));
        }
    }

    /**
     * Get available books only
     * GET /api/v1/books/available
     */
    @GetMapping("/available")
    public ResponseEntity<ApiResponse<PageResponse<BookResponseDto>>> getAvailableBooks(
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = DEFAULT_PAGE_SIZE + "") int size) {

        log.debug("GET /api/v1/books/available - page: {}, size: {}", page, size);

        Pageable pageable = PageRequest.of(page, size);
        Page<Book> booksPage = bookService.findAvailableBooksWithPagination(pageable);

        List<BookResponseDto> bookDtos = booksPage.getContent().stream()
                .map(this::convertToDto)
                .collect(Collectors.toList());

        PageResponse<BookResponseDto> pageResponse = new PageResponse<>(
                bookDtos,
                booksPage.getNumber(),
                booksPage.getSize(),
                booksPage.getTotalElements(),
                booksPage.getTotalPages());

        return ResponseEntity.ok(ApiResponse.success(pageResponse));
    }

    // Helper methods

    private BookResponseDto convertToDto(Book book) {
        BookDetail detail = book.getBookDetail();
        return new BookResponseDto(
                book.getId(),
                book.getName(),
                book.getQuantity(),
                book.getPrice(),
                detail != null ? detail.getType() : null,
                detail != null ? detail.getDetail() : null,
                detail != null ? detail.getSold() : 0);
    }

    private Book convertToEntity(BookRequestDto dto) {
        BookDetail detail = new BookDetail(dto.getType(), dto.getDetail(), 0);
        return new Book(dto.getName(), dto.getQuantity(), dto.getPrice(), detail);
    }
}
