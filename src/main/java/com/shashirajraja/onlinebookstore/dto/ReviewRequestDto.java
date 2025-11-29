package com.shashirajraja.onlinebookstore.dto;

import jakarta.validation.constraints.*;

/**
 * DTO for creating/updating a review
 */
public class ReviewRequestDto {

    @NotNull(message = "Book ID is required")
    @Positive(message = "Book ID must be positive")
    private Integer bookId;

    @NotNull(message = "Rating is required")
    @Min(value = 1, message = "Rating must be at least 1")
    @Max(value = 5, message = "Rating must be at most 5")
    private Integer rating;

    @Size(max = 1000, message = "Comment must not exceed 1000 characters")
    private String comment;

    // Constructors
    public ReviewRequestDto() {
    }

    public ReviewRequestDto(Integer bookId, Integer rating, String comment) {
        this.bookId = bookId;
        this.rating = rating;
        this.comment = comment;
    }

    // Getters and Setters
    public Integer getBookId() {
        return bookId;
    }

    public void setBookId(Integer bookId) {
        this.bookId = bookId;
    }

    public Integer getRating() {
        return rating;
    }

    public void setRating(Integer rating) {
        this.rating = rating;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }
}
