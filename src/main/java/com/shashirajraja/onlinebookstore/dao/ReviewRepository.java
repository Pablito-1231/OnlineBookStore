package com.shashirajraja.onlinebookstore.dao;

import com.shashirajraja.onlinebookstore.entity.Book;
import com.shashirajraja.onlinebookstore.entity.Customer;
import com.shashirajraja.onlinebookstore.entity.Review;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

/**
 * Repository for Review entity
 */
@Repository
public interface ReviewRepository extends JpaRepository<Review, Integer> {

    /**
     * Find all reviews for a specific book
     */
    List<Review> findByBook(Book book);

    /**
     * Find all reviews for a specific book with pagination
     */
    Page<Review> findByBook(Book book, Pageable pageable);

    /**
     * Find all reviews by a specific customer
     */
    List<Review> findByCustomer(Customer customer);

    /**
     * Find review by customer and book (a customer can only review a book once)
     */
    Optional<Review> findByCustomerAndBook(Customer customer, Book book);

    /**
     * Calculate average rating for a book
     */
    @Query("SELECT AVG(r.rating) FROM Review r WHERE r.book = :book")
    Double calculateAverageRating(@Param("book") Book book);

    /**
     * Count total reviews for a book
     */
    long countByBook(Book book);

    /**
     * Find reviews by rating
     */
    List<Review> findByBookAndRating(Book book, int rating);

    /**
     * Check if customer has reviewed a book
     */
    boolean existsByCustomerAndBook(Customer customer, Book book);
}
