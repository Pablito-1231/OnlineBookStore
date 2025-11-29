package com.shashirajraja.onlinebookstore.controller.rest;

import com.shashirajraja.onlinebookstore.dto.ApiResponse;
import com.shashirajraja.onlinebookstore.dto.UserResponseDto;
import com.shashirajraja.onlinebookstore.entity.Authority;
import com.shashirajraja.onlinebookstore.entity.Customer;
import com.shashirajraja.onlinebookstore.entity.User;
import com.shashirajraja.onlinebookstore.service.CustomerService;
import com.shashirajraja.onlinebookstore.service.UserService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.stream.Collectors;

/**
 * REST API Controller for User management
 * Base path: /api/v1/users
 */
@RestController
@RequestMapping("/api/v1/users")
public class UserRestController {

    private static final Logger log = LoggerFactory.getLogger(UserRestController.class);

    @Autowired
    private UserService userService;

    @Autowired
    private CustomerService customerService;

    /**
     * Get current authenticated user profile
     * GET /api/v1/users/me
     */
    @GetMapping("/me")
    public ResponseEntity<ApiResponse<UserResponseDto>> getCurrentUser() {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        String username = auth.getName();

        log.debug("GET /api/v1/users/me - username: {}", username);

        User user = userService.getUserByUsername(username);
        if (user == null) {
            return ResponseEntity
                    .status(HttpStatus.NOT_FOUND)
                    .body(ApiResponse.error("User not found"));
        }

        UserResponseDto dto = convertToDto(user);
        return ResponseEntity.ok(ApiResponse.success(dto));
    }

    /**
     * Get user by username (admin only)
     * GET /api/v1/users/{username}
     */
    @GetMapping("/{username}")
    public ResponseEntity<ApiResponse<UserResponseDto>> getUserByUsername(
            @PathVariable String username) {

        log.debug("GET /api/v1/users/{}", username);

        User user = userService.getUserByUsername(username);
        if (user == null) {
            return ResponseEntity
                    .status(HttpStatus.NOT_FOUND)
                    .body(ApiResponse.error("User not found: " + username));
        }

        UserResponseDto dto = convertToDto(user);
        return ResponseEntity.ok(ApiResponse.success(dto));
    }

    /**
     * Get all users (admin only)
     * GET /api/v1/users
     */
    @GetMapping
    public ResponseEntity<ApiResponse<List<UserResponseDto>>> getAllUsers() {
        log.debug("GET /api/v1/users - Getting all users");

        List<User> users = userService.getAllUsers();
        List<UserResponseDto> userDtos = users.stream()
                .map(this::convertToDto)
                .collect(Collectors.toList());

        return ResponseEntity.ok(ApiResponse.success(userDtos));
    }

    /**
     * Update current user profile
     * PUT /api/v1/users/me
     */
    @PutMapping("/me")
    public ResponseEntity<ApiResponse<UserResponseDto>> updateCurrentUser(
            @RequestBody UserResponseDto updateDto) {

        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        String username = auth.getName();

        log.info("PUT /api/v1/users/me - Updating profile for: {}", username);

        Customer customer = customerService.getCustomer(username);
        if (customer == null) {
            return ResponseEntity
                    .status(HttpStatus.NOT_FOUND)
                    .body(ApiResponse.error("Customer profile not found"));
        }

        // Update customer fields
        if (updateDto.getFirstName() != null) {
            customer.setFirstName(updateDto.getFirstName());
        }
        if (updateDto.getLastName() != null) {
            customer.setLastName(updateDto.getLastName());
        }
        if (updateDto.getEmail() != null) {
            customer.setEmail(updateDto.getEmail());
        }
        if (updateDto.getPhone() != null) {
            try {
                customer.setMobile(Long.parseLong(updateDto.getPhone()));
            } catch (NumberFormatException e) {
                return ResponseEntity
                        .badRequest()
                        .body(ApiResponse.error("Invalid phone number format"));
            }
        }
        if (updateDto.getAddress() != null) {
            customer.setAddress(updateDto.getAddress());
        }

        customerService.updateCustomer(customer);

        User user = customer.getUser();
        UserResponseDto dto = convertToDto(user);

        return ResponseEntity.ok(ApiResponse.success("Profile updated successfully", dto));
    }

    /**
     * Delete user (admin only)
     * DELETE /api/v1/users/{username}
     */
    @DeleteMapping("/{username}")
    public ResponseEntity<ApiResponse<Void>> deleteUser(@PathVariable String username) {
        log.info("DELETE /api/v1/users/{}", username);

        User user = userService.getUserByUsername(username);
        if (user == null) {
            return ResponseEntity
                    .status(HttpStatus.NOT_FOUND)
                    .body(ApiResponse.error("User not found: " + username));
        }

        // Prevent deleting yourself
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        if (auth.getName().equals(username)) {
            return ResponseEntity
                    .badRequest()
                    .body(ApiResponse.error("Cannot delete your own account"));
        }

        userService.deleteUser(username);

        return ResponseEntity.ok(ApiResponse.success("User deleted successfully", null));
    }

    // Helper methods

    private UserResponseDto convertToDto(User user) {
        UserResponseDto dto = new UserResponseDto();
        dto.setUsername(user.getUsername());
        dto.setEnabled(user.isEnabled());

        // Get role from authorities
        if (user.getAuthorities() != null && !user.getAuthorities().isEmpty()) {
            Authority firstAuth = user.getAuthorities().get(0);
            dto.setRole(firstAuth.getRole());
        }

        // Get customer details if available
        Customer customer = user.getCustomer();
        if (customer != null) {
            dto.setFirstName(customer.getFirstName());
            dto.setLastName(customer.getLastName());
            dto.setEmail(customer.getEmail());
            dto.setPhone(String.valueOf(customer.getMobile()));
            dto.setAddress(customer.getAddress());
        }

        return dto;
    }
}
