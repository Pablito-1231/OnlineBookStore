package com.shashirajraja.onlinebookstore.dto;

import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.*;

/**
 * Unit tests for DTO classes
 */
class DtoTests {

    @Test
    void testApiResponseSuccess() {
        String testData = "Test Data";
        ApiResponse<String> response = ApiResponse.success(testData);

        assertTrue(response.isSuccess());
        assertEquals("Success", response.getMessage());
        assertEquals(testData, response.getData());
    }

    @Test
    void testApiResponseSuccessWithMessage() {
        String testData = "Test Data";
        String message = "Operation successful";
        ApiResponse<String> response = ApiResponse.success(message, testData);

        assertTrue(response.isSuccess());
        assertEquals(message, response.getMessage());
        assertEquals(testData, response.getData());
    }

    @Test
    void testApiResponseError() {
        String errorMessage = "Error occurred";
        ApiResponse<Void> response = ApiResponse.error(errorMessage);

        assertFalse(response.isSuccess());
        assertEquals(errorMessage, response.getMessage());
        assertNull(response.getData());
    }

    @Test
    void testBookResponseDto() {
        BookResponseDto dto = new BookResponseDto(
                1, "Clean Code", 10, 29.99,
                "Paperback", "A great book");

        assertEquals(1, dto.getId());
        assertEquals("Clean Code", dto.getName());
        assertEquals(10, dto.getQuantity());
        assertEquals(29.99, dto.getPrice());
        assertEquals("Paperback", dto.getType());
        assertEquals("A great book", dto.getDetail());
    }

    @Test
    void testBookResponseDtoSetters() {
        BookResponseDto dto = new BookResponseDto();

        dto.setId(2);
        dto.setName("Effective Java");
        dto.setQuantity(5);
        dto.setPrice(45.99);
        dto.setType("Hardcover");
        dto.setDetail("Best practices");

        assertEquals(2, dto.getId());
        assertEquals("Effective Java", dto.getName());
        assertEquals(5, dto.getQuantity());
        assertEquals(45.99, dto.getPrice());
        assertEquals("Hardcover", dto.getType());
        assertEquals("Best practices", dto.getDetail());
    }

    @Test
    void testReviewRequestDto() {
        ReviewRequestDto dto = new ReviewRequestDto(1, 5, "Excellent book!");

        assertEquals(1, dto.getBookId());
        assertEquals(5, dto.getRating());
        assertEquals("Excellent book!", dto.getComment());
    }

    @Test
    void testReviewRequestDtoSetters() {
        ReviewRequestDto dto = new ReviewRequestDto();

        dto.setBookId(2);
        dto.setRating(4);
        dto.setComment("Good read");

        assertEquals(2, dto.getBookId());
        assertEquals(4, dto.getRating());
        assertEquals("Good read", dto.getComment());
    }

    @Test
    void testReviewResponseDto() {
        java.time.LocalDateTime now = java.time.LocalDateTime.now();

        ReviewResponseDto dto = new ReviewResponseDto(
                1, 10, "Clean Code", "John Doe", 5, "Great book!", now, now);

        assertEquals(1, dto.getId());
        assertEquals(10, dto.getBookId());
        assertEquals("Clean Code", dto.getBookName());
        assertEquals("John Doe", dto.getCustomerName());
        assertEquals(5, dto.getRating());
        assertEquals("Great book!", dto.getComment());
        assertEquals(now, dto.getCreatedAt());
        assertEquals(now, dto.getUpdatedAt());
    }

    @Test
    void testReviewResponseDtoSetters() {
        ReviewResponseDto dto = new ReviewResponseDto();
        java.time.LocalDateTime now = java.time.LocalDateTime.now();

        dto.setId(2);
        dto.setBookId(20);
        dto.setBookName("Effective Java");
        dto.setCustomerName("Jane Smith");
        dto.setRating(4);
        dto.setComment("Very informative");
        dto.setCreatedAt(now);
        dto.setUpdatedAt(now);

        assertEquals(2, dto.getId());
        assertEquals(20, dto.getBookId());
        assertEquals("Effective Java", dto.getBookName());
        assertEquals("Jane Smith", dto.getCustomerName());
        assertEquals(4, dto.getRating());
        assertEquals("Very informative", dto.getComment());
        assertEquals(now, dto.getCreatedAt());
        assertEquals(now, dto.getUpdatedAt());
    }
}