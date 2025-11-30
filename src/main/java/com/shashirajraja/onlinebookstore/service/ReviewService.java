package com.shashirajraja.onlinebookstore.service;

import com.shashirajraja.onlinebookstore.entity.Book;
import com.shashirajraja.onlinebookstore.entity.Customer;
import com.shashirajraja.onlinebookstore.entity.Review;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.List;

/**
 * Service interface for Review management
 */
public interface ReviewService {

    /**
     * Create a new review
     * Validates that customer has purchased the book
     */
    Review createReview(Customer customer, Book book, int rating, String comment);

    /**
     * Update an existing review
     */
    Review updateReview(int reviewId, Customer customer, int rating, String comment);

    /**
     * Delete a review
     */
    void deleteReview(int reviewId, Customer customer);

    /**
     * Get all reviews for a book
     */
    List<Review> getReviewsByBook(Book book);

    /**
     * Get all reviews for a book with pagination
     */
    Page<Review> getReviewsByBook(Book book, Pageable pageable);

    /**
     * Get all reviews by a customer
     */
    List<Review> getReviewsByCustomer(Customer customer);

    /**
     * Get a specific review by ID
     */
    Review getReviewById(int reviewId);

    /**
     * Calculate average rating for a book
     */
    Double getAverageRating(Book book);

    /**
     * Count total reviews for a book
     */
    long countReviewsByBook(Book book);

    /**
     * Check if customer has already reviewed a book
     */
    boolean hasCustomerReviewedBook(Customer customer, Book book);

    /**
     * Check if customer has purchased a book
     */
    boolean hasCustomerPurchasedBook(Customer customer, Book book);
}
