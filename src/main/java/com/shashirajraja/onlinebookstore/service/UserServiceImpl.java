package com.shashirajraja.onlinebookstore.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.shashirajraja.onlinebookstore.dao.UserRepository;
import com.shashirajraja.onlinebookstore.dao.AuthorityRepository;
import com.shashirajraja.onlinebookstore.dao.CustomerRepository;
import com.shashirajraja.onlinebookstore.entity.User;
import com.shashirajraja.onlinebookstore.entity.Customer;
import com.shashirajraja.onlinebookstore.entity.Authority;

@Service
public class UserServiceImpl implements UserService {

	@Autowired
	private UserRepository theUserRepository;
	
	@Autowired
	private AuthorityRepository authorityRepository;
	
	@Autowired
	private CustomerRepository customerRepository;
	
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
		
		try {
			System.out.println("=== ELIMINANDO USUARIO: " + username + " ===");
			
			// 1. Eliminar authorities primero usando query nativa
			int authDeleted = authorityRepository.deleteByUsername(username);
			System.out.println("Authorities eliminadas: " + authDeleted);
			
			// 2. Verificar si tiene customer y eliminarlo (cascada eliminará: shopping_cart, purchase_history, book_user)
			Optional<Customer> customerOpt = customerRepository.findById(username);
			if (customerOpt.isPresent()) {
				customerRepository.deleteById(username);
				System.out.println("Customer eliminado (con cascada)");
			}
			
			// 3. Finalmente eliminar el usuario
			theUserRepository.deleteById(username);
			System.out.println("Usuario eliminado exitosamente");
			
			return "Usuario eliminado exitosamente";
		} catch (Exception e) {
			System.err.println("Error al eliminar usuario " + username + ": " + e.getMessage());
			e.printStackTrace();
			return "Error: No se pudo eliminar el usuario. " + e.getMessage();
		}
	}

	@Override
	@Transactional
	public String toggleUserEnabled(String username) {
		System.out.println("=== TOGGLE USER ENABLED ===");
		System.out.println("Username recibido: " + username);
		
		if (username == null || username.trim().isEmpty()) {
			return "Error: Username inválido";
		}
		
		Optional<User> userOpt = theUserRepository.findById(username);
		if (!userOpt.isPresent()) {
			System.out.println("Usuario NO encontrado en BD");
			return "Error: Usuario no encontrado";
		}
		
		// Prevenir deshabilitar el admin principal
		if ("admin".equals(username)) {
			return "Error: No se puede deshabilitar el usuario admin principal";
		}
		
		User user = userOpt.get();
		boolean estadoAnterior = user.isEnabled();
		boolean nuevoEstado = !estadoAnterior;
		
		System.out.println("Estado anterior: " + estadoAnterior);
		System.out.println("Nuevo estado: " + nuevoEstado);
		
		user.setEnabled(nuevoEstado);
		User savedUser = theUserRepository.save(user);
		
		System.out.println("Estado guardado en BD: " + savedUser.isEnabled());
		System.out.println("===========================");
		
		return savedUser.isEnabled() ? "Usuario habilitado" : "Usuario deshabilitado";
	}
}
