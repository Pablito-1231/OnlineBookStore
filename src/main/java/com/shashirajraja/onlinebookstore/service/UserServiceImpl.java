package com.shashirajraja.onlinebookstore.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.shashirajraja.onlinebookstore.dao.UserRepository;
import com.shashirajraja.onlinebookstore.entity.User;

@Service
public class UserServiceImpl implements UserService {

	@Autowired
	private UserRepository theUserRepository;
	
	@Override
	@Transactional
	public List<User> getAllUsers() {
		List<User> users = new ArrayList<User>();
		users.addAll(theUserRepository.findAll());
		return users;
	}

	@Override
	@Transactional
	public User getUserByUsername(String username) {
		
		Optional<User> userOpt = theUserRepository.findById(username);
		
		User theUser = null;
		
		if(userOpt.isPresent())
			theUser = userOpt.get();
		
		return theUser;
	}

	@Override
	@Transactional
	public String updateUser(User user) {
		if (user == null || user.getUsername() == null) {
			return "Error: Usuario inválido";
		}
		
		Optional<User> existingUserOpt = theUserRepository.findById(user.getUsername());
		if (!existingUserOpt.isPresent()) {
			return "Error: Usuario no encontrado";
		}
		
		theUserRepository.save(user);
		return "Usuario actualizado exitosamente";
	}

	@Override
	@Transactional
	public String deleteUser(String username) {
		if (username == null || username.trim().isEmpty()) {
			return "Error: Username inválido";
		}
		
		Optional<User> userOpt = theUserRepository.findById(username);
		if (!userOpt.isPresent()) {
			return "Error: Usuario no encontrado";
		}
		
		// Prevenir eliminar el admin principal
		if ("admin".equals(username)) {
			return "Error: No se puede eliminar el usuario admin principal";
		}
		
		theUserRepository.deleteById(username);
		return "Usuario eliminado exitosamente";
	}

	@Override
	@Transactional
	public String toggleUserEnabled(String username) {
		if (username == null || username.trim().isEmpty()) {
			return "Error: Username inválido";
		}
		
		Optional<User> userOpt = theUserRepository.findById(username);
		if (!userOpt.isPresent()) {
			return "Error: Usuario no encontrado";
		}
		
		// Prevenir deshabilitar el admin principal
		if ("admin".equals(username)) {
			return "Error: No se puede deshabilitar el usuario admin principal";
		}
		
		User user = userOpt.get();
		user.setEnabled(!user.isEnabled());
		theUserRepository.save(user);
		
		return user.isEnabled() ? "Usuario habilitado" : "Usuario deshabilitado";
	}
}
