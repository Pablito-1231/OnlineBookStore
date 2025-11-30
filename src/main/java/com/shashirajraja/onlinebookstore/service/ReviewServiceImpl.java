package com.shashirajraja.onlinebookstore.service;

import com.shashirajraja.onlinebookstore.entity.Book;
import com.shashirajraja.onlinebookstore.entity.Customer;
import com.shashirajraja.onlinebookstore.entity.Review;
import com.shashirajraja.onlinebookstore.repository.ReviewRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@Service
public class ReviewServiceImpl implements ReviewService {

    private final ReviewRepository reviewRepository;

    @Autowired
    public ReviewServiceImpl(ReviewRepository reviewRepository) {
        this.reviewRepository = reviewRepository;
    }

    @Override
    @Transactional
    public Review createReview(Customer customer, Book book, int rating, String comment) {
        // Check if customer already reviewed this book
        Optional<Review> existingReview = reviewRepository.findByCustomerAndBook(customer, book);
        if (existingReview.isPresent()) {
            throw new IllegalStateException("You have already reviewed this book");
        }

        Review review = new Review(book, customer, rating, comment);
        return reviewRepository.save(review);
    }

    @Override
    public Page<Review> getReviewsByBook(Book book, Pageable pageable) {
        return reviewRepository.findByBook(book, pageable);
    }

    @Override
    public List<Review> getReviewsByCustomer(Customer customer) {
        return reviewRepository.findByCustomer(customer);
    }

    @Override
    @Transactional
    public Review updateReview(int reviewId, Customer customer, int rating, String comment) {
        Review review = reviewRepository.findById(reviewId)
                .orElseThrow(() -> new IllegalArgumentException("Review not found"));

        if (!review.getCustomer().getUsername().equals(customer.getUsername())) {
            throw new IllegalStateException("You can only update your own reviews");
        }

        review.setRating(rating);
        review.setComment(comment);
        return reviewRepository.save(review);
    }

    @Override
    @Transactional
    public void deleteReview(int reviewId, Customer customer) {
        Review review = reviewRepository.findById(reviewId)
                .orElseThrow(() -> new IllegalArgumentException("Review not found"));

        if (!review.getCustomer().getUsername().equals(customer.getUsername())) {
            throw new IllegalStateException("You can only delete your own reviews");
        }

        reviewRepository.delete(review);
    }

    @Override
    public Double getAverageRating(Book book) {
        Double avg = reviewRepository.getAverageRatingByBook(book);
        return avg != null ? avg : 0.0;
    }

    @Override
    public long countReviewsByBook(Book book) {
        return reviewRepository.countByBook(book);
    }
}
