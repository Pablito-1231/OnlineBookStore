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
        assertNotNull(response.getTimestamp());
        assertNull(response.getError());
    }

    @Test
    void testApiResponseError() {
        String errorMessage = "Error occurred";
        ApiResponse<Void> response = ApiResponse.error(errorMessage);

        assertFalse(response.isSuccess());
        assertEquals(errorMessage, response.getMessage());
        assertEquals(errorMessage, response.getError());
        assertNull(response.getData());
        assertNotNull(response.getTimestamp());
    }

    @Test
    void testBookResponseDto() {
        BookResponseDto dto = new BookResponseDto(
                1, "Clean Code", 10, 29.99,
                "Paperback", "A great book", 5,
                4.5, 10); // averageRating, totalReviews

        assertEquals(1, dto.getId());
        assertEquals("Clean Code", dto.getName());
        assertEquals(10, dto.getQuantity());
        assertEquals(29.99, dto.getPrice());
        assertEquals("Paperback", dto.getType());
        assertEquals("A great book", dto.getDetail());
        assertEquals(5, dto.getSold());
        assertTrue(dto.getAvailable());
        assertEquals(4.5, dto.getAverageRating());
        assertEquals(10, dto.getTotalReviews());
    }

    @Test
    void testBookResponseDtoAvailability() {
        BookResponseDto dto = new BookResponseDto();

        // Test with stock
        dto.setQuantity(5);
        assertTrue(dto.getAvailable());

        // Test without stock
        dto.setQuantity(0);
        assertFalse(dto.getAvailable());
    }

    @Test
    void testBookRequestDto() {
        BookRequestDto dto = new BookRequestDto(
                "New Book", 15, 39.99, "Hardcover", "Great book");

        assertEquals("New Book", dto.getName());
        assertEquals(15, dto.getQuantity());
        assertEquals(39.99, dto.getPrice());
        assertEquals("Hardcover", dto.getType());
        assertEquals("Great book", dto.getDetail());
    }

    @Test
    void testPageResponse() {
        java.util.List<String> content = java.util.Arrays.asList("Item1", "Item2", "Item3");
        PageResponse<String> pageResponse = new PageResponse<>(
                content, 0, 10, 25, 3);

        assertEquals(content, pageResponse.getContent());
        assertEquals(0, pageResponse.getPage());
        assertEquals(10, pageResponse.getSize());
        assertEquals(25, pageResponse.getTotalElements());
        assertEquals(3, pageResponse.getTotalPages());
        assertTrue(pageResponse.isFirst());
        assertFalse(pageResponse.isLast());
        assertFalse(pageResponse.isEmpty());
    }

    @Test
    void testPageResponseEmpty() {
        PageResponse<String> pageResponse = new PageResponse<>(
                java.util.Collections.emptyList(), 0, 10, 0, 0);

        assertTrue(pageResponse.isEmpty());
        assertTrue(pageResponse.isFirst());
        assertTrue(pageResponse.isLast());
    }

    @Test
    void testUserResponseDto() {
        UserResponseDto dto = new UserResponseDto(
                "testuser", "test@email.com", "John", "Doe",
                "1234567890", "123 Main St", "ROLE_CUSTOMER");

        assertEquals("testuser", dto.getUsername());
        assertEquals("test@email.com", dto.getEmail());
        assertEquals("John", dto.getFirstName());
        assertEquals("Doe", dto.getLastName());
        assertEquals("1234567890", dto.getPhone());
        assertEquals("123 Main St", dto.getAddress());
        assertEquals("ROLE_CUSTOMER", dto.getRole());
    }

    @Test
    void testCartItemResponseDto() {
        CartItemResponseDto dto = new CartItemResponseDto(
                1, "Test Book", 29.99, 2, true);

        assertEquals(1, dto.getBookId());
        assertEquals("Test Book", dto.getBookName());
        assertEquals(29.99, dto.getBookPrice());
        assertEquals(2, dto.getQuantity());
        assertEquals(59.98, dto.getSubtotal(), 0.01);
        assertTrue(dto.getAvailable());
    }

    @Test
    void testCartItemResponseDtoSubtotalCalculation() {
        CartItemResponseDto dto = new CartItemResponseDto();
        dto.setBookPrice(25.00);
        dto.setQuantity(3);

        assertEquals(75.00, dto.getSubtotal(), 0.01);

        // Update price
        dto.setBookPrice(30.00);
        assertEquals(90.00, dto.getSubtotal(), 0.01);

        // Update quantity
        dto.setQuantity(2);
        assertEquals(60.00, dto.getSubtotal(), 0.01);
    }
}
