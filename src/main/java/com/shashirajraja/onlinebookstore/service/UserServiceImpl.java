package com.shashirajraja.onlinebookstore.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import jakarta.transaction.Transactional;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.shashirajraja.onlinebookstore.dao.UserRepository;
import com.shashirajraja.onlinebookstore.dao.AuthorityRepository;
import com.shashirajraja.onlinebookstore.dao.CustomerRepository;
import com.shashirajraja.onlinebookstore.entity.User;
import com.shashirajraja.onlinebookstore.entity.Customer;

@Service
public class UserServiceImpl implements UserService {

	private static final Logger log = LoggerFactory.getLogger(UserServiceImpl.class);

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
		if (username == null || username.trim().isEmpty()) {
			return null;
		}
		
		Optional<User> userOpt = theUserRepository.findById(username);
		
		User theUser = null;
		
		if(userOpt.isPresent())
			theUser = userOpt.get();

		// Initialize customer collections to avoid LazyInitializationException later
		// when the User/Customer is stored in session and accessed outside a TX.
		try {
			if (theUser != null && theUser.getCustomer() != null) {
				// touch collections while inside transaction
				if (theUser.getCustomer().getShoppingCart() != null)
					theUser.getCustomer().getShoppingCart().size();
				if (theUser.getCustomer().getBooks() != null)
					theUser.getCustomer().getBooks().size();
				if (theUser.getCustomer().getPurchaseHistories() != null)
					theUser.getCustomer().getPurchaseHistories().size();
			}
		} catch (Exception ex) {
			log.debug("No se pudieron inicializar colecciones del customer: {}", ex.getMessage());
		}
		
		return theUser;
	}

	@Override
	@Transactional
	public String updateUser(User user) {
		if (user == null || user.getUsername() == null) {
			return "Error: Usuario inválido";
		}
		
		Optional<User> existingUserOpt = theUserRepository.findById(user.getUsername());
		if (existingUserOpt.isEmpty()) {
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
		if (userOpt.isEmpty()) {
			return "Error: Usuario no encontrado";
		}
		
		// Prevenir eliminar el admin principal
		if ("admin".equals(username)) {
			return "Error: No se puede eliminar el usuario admin principal";
		}
		
		try {
			log.info("Eliminando usuario: {}", username);
			
			// 1. Eliminar authorities primero usando query nativa
			int authDeleted = authorityRepository.deleteByUsername(username);
			log.debug("Authorities eliminadas: {}", authDeleted);
			
			// 2. Verificar si tiene customer y eliminarlo (cascada eliminará: shopping_cart, purchase_history, book_user)
			Optional<Customer> customerOpt = customerRepository.findById(username);
			if (customerOpt.isPresent()) {
				customerRepository.deleteById(username);
				log.debug("Customer eliminado (con cascada)");
			}
			
			// 3. Finalmente eliminar el usuario
			theUserRepository.deleteById(username);
			log.info("Usuario eliminado exitosamente: {}", username);
			
			return "Usuario eliminado exitosamente";
		} catch (Exception e) {
			log.error("Error al eliminar usuario {}: {}", username, e.getMessage(), e);
			return "Error: No se pudo eliminar el usuario. " + e.getMessage();
		}
	}

	@Override
	@Transactional
	public String toggleUserEnabled(String username) {
		log.debug("Toggle user enabled - Username: {}", username);
		
		if (username == null || username.trim().isEmpty()) {
			return "Error: Username inválido";
		}
		
		Optional<User> userOpt = theUserRepository.findById(username);
		if (userOpt.isEmpty()) {
			log.warn("Usuario no encontrado: {}", username);
			return "Error: Usuario no encontrado";
		}
		
		// Prevenir deshabilitar el admin principal
		if ("admin".equals(username)) {
			return "Error: No se puede deshabilitar el usuario admin principal";
		}
		
		User user = userOpt.get();
		boolean estadoAnterior = user.isEnabled();
		boolean nuevoEstado = !estadoAnterior;
		
		log.debug("Cambiando estado de usuario {} de {} a {}", username, estadoAnterior, nuevoEstado);
		
		user.setEnabled(nuevoEstado);
		User savedUser = theUserRepository.save(user);
		
		log.info("Usuario {} {}", username, savedUser.isEnabled() ? "habilitado" : "deshabilitado");
		
		return savedUser.isEnabled() ? "Usuario habilitado" : "Usuario deshabilitado";
	}
}
