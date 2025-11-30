package com.shashirajraja.onlinebookstore.controller.rest;

import com.shashirajraja.onlinebookstore.dto.ApiResponse;
import com.shashirajraja.onlinebookstore.dto.ReviewRequestDto;
import com.shashirajraja.onlinebookstore.dto.ReviewResponseDto;
import com.shashirajraja.onlinebookstore.entity.Book;
import com.shashirajraja.onlinebookstore.entity.Customer;
import com.shashirajraja.onlinebookstore.entity.Review;
import com.shashirajraja.onlinebookstore.service.BookService;
import com.shashirajraja.onlinebookstore.service.CustomerService;
import com.shashirajraja.onlinebookstore.service.ReviewService;
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
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

/**
 * REST API Controller for Review management
 * Base path: /api/v1/reviews
 */
@RestController
@RequestMapping("/api/v1/reviews")
public class ReviewRestController {

    private static final Logger log = LoggerFactory.getLogger(ReviewRestController.class);

    @Autowired
    private ReviewService reviewService;

    @Autowired
    private BookService bookService;

    @Autowired
    private CustomerService customerService;

    /**
     * Create a new review
     * POST /api/v1/reviews
     */
    @PostMapping
    public ResponseEntity<ApiResponse<ReviewResponseDto>> createReview(
            @Valid @RequestBody ReviewRequestDto request) {

        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        String username = auth.getName();

        log.info("POST /api/v1/reviews - Creating review for book {} by {}",
                request.getBookId(), username);

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

        try {
            Review review = reviewService.createReview(
                    customer, book, request.getRating(), request.getComment());

            ReviewResponseDto dto = convertToDto(review);
            return ResponseEntity
                    .status(HttpStatus.CREATED)
                    .body(ApiResponse.success("Review created successfully", dto));

        } catch (IllegalStateException e) {
            return ResponseEntity
                    .badRequest()
                    .body(ApiResponse.error(e.getMessage()));
        }
    }

    /**
     * Get reviews for a specific book
     * GET /api/v1/reviews/book/{bookId}
     */
    @GetMapping("/book/{bookId}")
    public ResponseEntity<ApiResponse<List<ReviewResponseDto>>> getReviewsByBook(
            @PathVariable int bookId,
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "10") int size,
            @RequestParam(defaultValue = "createdAt") String sortBy,
            @RequestParam(defaultValue = "DESC") String sortDir) {

        log.debug("GET /api/v1/reviews/book/{} - page: {}, size: {}", bookId, page, size);

        Book book = bookService.getBookById(bookId);
        if (book == null) {
            return ResponseEntity
                    .status(HttpStatus.NOT_FOUND)
                    .body(ApiResponse.error("Book not found"));
        }

        Sort.Direction direction = sortDir.equalsIgnoreCase("ASC") ? Sort.Direction.ASC : Sort.Direction.DESC;
        Pageable pageable = PageRequest.of(page, size, Sort.by(direction, sortBy));

        Page<Review> reviewsPage = reviewService.getReviewsByBook(book, pageable);
        List<ReviewResponseDto> reviewDtos = reviewsPage.getContent().stream()
                .map(this::convertToDto)
                .collect(Collectors.toList());

        return ResponseEntity.ok(ApiResponse.success(reviewDtos));
    }

    /**
     * Get book rating statistics
     * GET /api/v1/reviews/book/{bookId}/stats
     */
    @GetMapping("/book/{bookId}/stats")
    public ResponseEntity<ApiResponse<Map<String, Object>>> getBookRatingStats(
            @PathVariable int bookId) {

        log.debug("GET /api/v1/reviews/book/{}/stats", bookId);

        Book book = bookService.getBookById(bookId);
        if (book == null) {
            return ResponseEntity
                    .status(HttpStatus.NOT_FOUND)
                    .body(ApiResponse.error("Book not found"));
        }

        Double averageRating = reviewService.getAverageRating(book);
        long totalReviews = reviewService.countReviewsByBook(book);

        Map<String, Object> stats = new HashMap<>();
        stats.put("averageRating", averageRating);
        stats.put("totalReviews", totalReviews);
        stats.put("bookId", bookId);
        stats.put("bookName", book.getName());

        return ResponseEntity.ok(ApiResponse.success(stats));
    }

    /**
     * Get current user's reviews
     * GET /api/v1/reviews/my-reviews
     */
    @GetMapping("/my-reviews")
    public ResponseEntity<ApiResponse<List<ReviewResponseDto>>> getMyReviews() {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        String username = auth.getName();

        log.debug("GET /api/v1/reviews/my-reviews - username: {}", username);

        Customer customer = customerService.getCustomer(username);
        if (customer == null) {
            return ResponseEntity
                    .status(HttpStatus.NOT_FOUND)
                    .body(ApiResponse.error("Customer not found"));
        }

        List<Review> reviews = reviewService.getReviewsByCustomer(customer);
        List<ReviewResponseDto> reviewDtos = reviews.stream()
                .map(this::convertToDto)
                .collect(Collectors.toList());

        return ResponseEntity.ok(ApiResponse.success(reviewDtos));
    }

    /**
     * Update a review
     * PUT /api/v1/reviews/{id}
     */
    @PutMapping("/{id}")
    public ResponseEntity<ApiResponse<ReviewResponseDto>> updateReview(
            @PathVariable int id,
            @Valid @RequestBody ReviewRequestDto request) {

        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        String username = auth.getName();

        log.info("PUT /api/v1/reviews/{} - Updating review by {}", id, username);

        Customer customer = customerService.getCustomer(username);
        if (customer == null) {
            return ResponseEntity
                    .status(HttpStatus.NOT_FOUND)
                    .body(ApiResponse.error("Customer not found"));
        }

        try {
            Review review = reviewService.updateReview(
                    id, customer, request.getRating(), request.getComment());

            ReviewResponseDto dto = convertToDto(review);
            return ResponseEntity.ok(ApiResponse.success("Review updated successfully", dto));

        } catch (IllegalArgumentException e) {
            return ResponseEntity
                    .status(HttpStatus.NOT_FOUND)
                    .body(ApiResponse.error(e.getMessage()));
        } catch (IllegalStateException e) {
            return ResponseEntity
                    .status(HttpStatus.FORBIDDEN)
                    .body(ApiResponse.error(e.getMessage()));
        }
    }

    /**
     * Delete a review
     * DELETE /api/v1/reviews/{id}
     */
    @DeleteMapping("/{id}")
    public ResponseEntity<ApiResponse<Void>> deleteReview(@PathVariable int id) {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        String username = auth.getName();

        log.info("DELETE /api/v1/reviews/{} - Deleting review by {}", id, username);

        Customer customer = customerService.getCustomer(username);
        if (customer == null) {
            return ResponseEntity
                    .status(HttpStatus.NOT_FOUND)
                    .body(ApiResponse.error("Customer not found"));
        }

        try {
            reviewService.deleteReview(id, customer);
            return ResponseEntity.ok(ApiResponse.success("Review deleted successfully", null));

        } catch (IllegalArgumentException e) {
            return ResponseEntity
                    .status(HttpStatus.NOT_FOUND)
                    .body(ApiResponse.error(e.getMessage()));
        } catch (IllegalStateException e) {
            return ResponseEntity
                    .status(HttpStatus.FORBIDDEN)
                    .body(ApiResponse.error(e.getMessage()));
        }
    }

    // Helper method to convert Review to DTO
    private ReviewResponseDto convertToDto(Review review) {
        return new ReviewResponseDto(
                review.getId(),
                review.getBook().getId(),
                review.getBook().getName(),
                review.getCustomer().getFirstName() + " " + review.getCustomer().getLastName(),
                review.getRating(),
                review.getComment(),
                review.getCreatedAt(),
                review.getUpdatedAt());
    }
}
