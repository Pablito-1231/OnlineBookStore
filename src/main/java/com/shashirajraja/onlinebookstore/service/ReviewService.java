package com.shashirajraja.onlinebookstore.service;

import com.shashirajraja.onlinebookstore.entity.Book;
import com.shashirajraja.onlinebookstore.entity.Customer;
import com.shashirajraja.onlinebookstore.entity.Review;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.List;

public interface ReviewService {

    Review createReview(Customer customer, Book book, int rating, String comment);

    Page<Review> getReviewsByBook(Book book, Pageable pageable);

    List<Review> getReviewsByCustomer(Customer customer);

    Review updateReview(int reviewId, Customer customer, int rating, String comment);

    void deleteReview(int reviewId, Customer customer);

    Double getAverageRating(Book book);

    long countReviewsByBook(Book book);
}
