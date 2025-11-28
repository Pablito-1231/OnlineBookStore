package com.shashirajraja.onlinebookstore.service;

import java.util.List;

import com.shashirajraja.onlinebookstore.entity.User;

public interface UserService {

	public List<User> getAllUsers();
	
	public User getUserByUsername(String username);
	
	public String updateUser(User user);
	
	public String deleteUser(String username);
	
	public String toggleUserEnabled(String username);
    String changeAdminPassword(String oldPassword, String newPassword, String confirmPassword);
}
