package com.shashirajraja.onlinebookstore.service;

import com.shashirajraja.onlinebookstore.dao.ReviewRepository;
import com.shashirajraja.onlinebookstore.entity.Book;
import com.shashirajraja.onlinebookstore.entity.Customer;
import com.shashirajraja.onlinebookstore.entity.Review;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

/**
 * Service implementation for Review management
 */
@Service
public class ReviewServiceImpl implements ReviewService {

    private static final Logger log = LoggerFactory.getLogger(ReviewServiceImpl.class);

    @Autowired
    private ReviewRepository reviewRepository;

    @Override
    @Transactional
    public Review createReview(Customer customer, Book book, int rating, String comment) {
        log.info("Creating review for book {} by customer {}", book.getId(), customer.getUsername());

        // Validate that customer hasn't already reviewed this book
        if (hasCustomerReviewedBook(customer, book)) {
            throw new IllegalStateException("Ya has reseñado este libro. Puedes editar tu reseña existente.");
        }

        // Validate that customer has purchased the book
        if (!hasCustomerPurchasedBook(customer, book)) {
            throw new IllegalStateException("Solo puedes reseñar libros que hayas comprado.");
        }

        // Create and save review
        Review review = new Review(book, customer, rating, comment);
        return reviewRepository.save(review);
    }

    @Override
    @Transactional
    public Review updateReview(int reviewId, Customer customer, int rating, String comment) {
        log.info("Updating review {} by customer {}", reviewId, customer.getUsername());

        Review review = getReviewById(reviewId);

        // Validate ownership
        if (!review.getCustomer().getUsername().equals(customer.getUsername())) {
            throw new IllegalStateException("Solo puedes editar tus propias reseñas.");
        }

        review.setRating(rating);
        review.setComment(comment);

        return reviewRepository.save(review);
    }

    @Override
    @Transactional
    public void deleteReview(int reviewId, Customer customer) {
        log.info("Deleting review {} by customer {}", reviewId, customer.getUsername());

        Review review = getReviewById(reviewId);

        // Validate ownership
        if (!review.getCustomer().getUsername().equals(customer.getUsername())) {
            throw new IllegalStateException("Solo puedes eliminar tus propias reseñas.");
        }

        reviewRepository.delete(review);
    }

    @Override
    @Transactional(readOnly = true)
    public List<Review> getReviewsByBook(Book book) {
        return reviewRepository.findByBook(book);
    }

    @Override
    @Transactional(readOnly = true)
    public Page<Review> getReviewsByBook(Book book, Pageable pageable) {
        return reviewRepository.findByBook(book, pageable);
    }

    @Override
    @Transactional(readOnly = true)
    public List<Review> getReviewsByCustomer(Customer customer) {
        return reviewRepository.findByCustomer(customer);
    }

    @Override
    @Transactional(readOnly = true)
    public Review getReviewById(int reviewId) {
        Optional<Review> reviewOpt = reviewRepository.findById(reviewId);
        if (reviewOpt.isEmpty()) {
            throw new IllegalArgumentException("Reseña no encontrada con ID: " + reviewId);
        }
        return reviewOpt.get();
    }

    @Override
    @Transactional(readOnly = true)
    public Double getAverageRating(Book book) {
        Double average = reviewRepository.calculateAverageRating(book);
        return average != null ? average : 0.0;
    }

    @Override
    @Transactional(readOnly = true)
    public long countReviewsByBook(Book book) {
        return reviewRepository.countByBook(book);
    }

    @Override
    @Transactional(readOnly = true)
    public boolean hasCustomerReviewedBook(Customer customer, Book book) {
        return reviewRepository.existsByCustomerAndBook(customer, book);
    }

    @Override
    @Transactional(readOnly = true)
    public boolean hasCustomerPurchasedBook(Customer customer, Book book) {
        // Check if the book is in the customer's purchased books
        return customer.getBooks() != null && customer.getBooks().contains(book);
    }
}
