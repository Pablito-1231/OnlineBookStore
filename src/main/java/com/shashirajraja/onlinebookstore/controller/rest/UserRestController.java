package com.shashirajraja.onlinebookstore.controller.rest;

import com.shashirajraja.onlinebookstore.dto.ApiResponse;
import com.shashirajraja.onlinebookstore.entity.Customer;
import com.shashirajraja.onlinebookstore.entity.User;
import com.shashirajraja.onlinebookstore.service.CustomerService;
import com.shashirajraja.onlinebookstore.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("/api/users")
public class UserRestController {

    private final UserService userService;
    private final CustomerService customerService;

    @Autowired
    public UserRestController(UserService userService, CustomerService customerService) {
        this.userService = userService;
        this.customerService = customerService;
    }

    @GetMapping("/me")
    public ResponseEntity<ApiResponse<Map<String, Object>>> getCurrentUser() {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        if (auth == null || !auth.isAuthenticated()) {
            return ResponseEntity.status(401).body(new ApiResponse<>(false, "Not authenticated", null));
        }

        String username = auth.getName();
        User user = userService.getUserByUsername(username);

        if (user == null) {
            return ResponseEntity.status(404).body(new ApiResponse<>(false, "User not found", null));
        }

        Map<String, Object> userData = new HashMap<>();
        userData.put("username", user.getUsername());
        userData.put("enabled", user.isEnabled());

        if (user.getCustomer() != null) {
            Customer customer = user.getCustomer();
            userData.put("firstName", customer.getFirstName());
            userData.put("lastName", customer.getLastName());
            userData.put("email", customer.getEmail());
            userData.put("mobile", customer.getMobile());
            userData.put("address", customer.getAddress());
        }

        return ResponseEntity.ok(new ApiResponse<>(true, "User profile retrieved", userData));
    }
}
