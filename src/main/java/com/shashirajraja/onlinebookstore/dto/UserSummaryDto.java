package com.shashirajraja.onlinebookstore.dto;

public class UserSummaryDto {
    private String username;
    private String role;
    private boolean enabled;

    public UserSummaryDto(String username, String role, boolean enabled) {
        this.username = username;
        this.role = role;
        this.enabled = enabled;
    }

    public String getUsername() { return username; }
    public String getRole() { return role; }
    public boolean isEnabled() { return enabled; }
}
