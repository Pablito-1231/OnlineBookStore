package com.shashirajraja.onlinebookstore.service;

import java.util.List;
import java.util.Optional;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.shashirajraja.onlinebookstore.dao.CustomerRepository;
import com.shashirajraja.onlinebookstore.entity.Authority;
import com.shashirajraja.onlinebookstore.entity.CurrentSession;
import com.shashirajraja.onlinebookstore.entity.Customer;
import com.shashirajraja.onlinebookstore.entity.User;
import com.shashirajraja.onlinebookstore.forms.entity.ChangePassword;
import com.shashirajraja.onlinebookstore.forms.entity.CustomerData;

@Service
public class CustomerServiceImpl implements CustomerService {

	@Autowired
	CurrentSession currentSession;
	
	@Autowired
	CustomerRepository theCustomerRepository;
	
	@Autowired
	PasswordEncoder thePasswordEncoder;
	
	@Override
	@Transactional
	public List<Customer> getAllCustomers() {
		
		return theCustomerRepository.findAll();
	}

	@Override
	@Transactional
	public Customer getCustomer(String username) {
		
		Optional<Customer> custOpt = theCustomerRepository.findById(username);
		
		Customer theCustomer = null;
		
		if(custOpt.isPresent())
			theCustomer = custOpt.get();
		
		return theCustomer;
	}

	@Override
	@Transactional
	public String saveCustomer(Customer theCustomer) {
		
		theCustomerRepository.save(theCustomer);
		
		return "¡Datos guardados exitosamente!";
	}

	@Override
	public String updateCustomer(Customer theCustomer) {
		
		saveCustomer(theCustomer);
		
		return "¡Datos actualizados exitosamente!";
	}

	@Override
	@Transactional
	public String removeCustomer(Customer theCustomer) {
		
		theCustomerRepository.delete(theCustomer);
		
		return "¡Datos del cliente eliminados exitosamente!";
	}
	@Override
	@Transactional
	public String registerCustomer(CustomerData data) {
	
		// Validar password
		if(!data.getPassword().equals(data.getConfirmPassword())) 
			return "¡La contraseña y la confirmación no coinciden!";
	
		// Encriptar contraseña
		data.setPassword(thePasswordEncoder.encode(data.getPassword()));
		data.setConfirmPassword(data.getPassword());
	
		// Validar móvil
		long mobile = data.getMobile();
		String mobStr = mobile + "";
		if(mobStr.length() < 10 || mobStr.length() > 12)
			return "¡Número móvil inválido!";
	
		if(mobStr.length() == 11 && mobStr.charAt(0) == '0') {
			mobStr = mobStr.substring(1);
			mobile = Long.parseLong(mobStr);
		} else if(mobStr.length() == 12 && mobStr.startsWith("91")) {
			mobStr = mobStr.substring(2);
			mobile = Long.parseLong(mobStr);
		} else if(mobStr.length() != 10 || mobStr.charAt(0) == '0') {
			return "¡Por favor ingresa un número móvil válido!";
		}
	
		data.setMobile(mobile);
	
	// Validar username existente
	Optional<Customer> theCust = theCustomerRepository.findById(data.getUsername());
	if(theCust.isPresent()) {
		return "¡El nombre de usuario ya está registrado, prueba con uno nuevo!";
	}

	// Validar email existente
	List<Customer> emailUsers = theCustomerRepository.findByEmail(data.getEmail());
	if(emailUsers != null && !emailUsers.isEmpty()) {
		return "¡El correo electrónico ya está registrado!";
	}		// Crear User
		User theUsers = new User(data.getUsername(), data.getPassword());
		theUsers.addAuthority(new Authority(theUsers, data.getRole()));
	
		// Crear Customer
		Customer customer = new Customer(
			data.getUsername(),
			data.getFirstName(),
			data.getLastName(),
			data.getEmail(),
			data.getMobile(),
			data.getAddress()
		);
	
		customer.setUsers(theUsers);
	

	// Guardar
	theCustomerRepository.save(customer);

	return "¡Registro exitoso, inicia sesión ahora!";
}	@Override
	@Transactional
	public CustomerData getCustomerData(String username) {
		Customer customer = getCustomer(username);
		
		CustomerData data = new CustomerData(customer);
	
		return data;
	}

	@Override
	@Transactional
	public String updateCustomer(CustomerData data) {
		
	Optional<Customer> custOpt = theCustomerRepository.findById(data.getUsername());
	Customer theCustomer = new Customer();
	
	if(custOpt.isPresent())
		theCustomer = custOpt.get();
	else
		return "¡Datos de cliente inválidos!";
	if(data.getPassword() == null) {
		
		return "¡Por favor ingresa la contraseña primero!";
	}
	
	if(!thePasswordEncoder.matches(data.getPassword(), theCustomer.getUser().getPassword())) 
	return "¡Contraseña inválida!";
	
	
	long mobile = data.getMobile();
	String mobStr = mobile + "";
	if(mobStr.length() > 12 || mobStr.length() < 10)
		return "¡Número móvil inválido!";
		if(mobStr.length() == 11 && mobStr.charAt(0) == '0') {
			mobStr = mobStr.substring(1, mobStr.length());
			mobile = Long.parseLong(mobStr);
		}else if(mobStr.length()==12 && mobStr.charAt(0)=='9' && mobStr.charAt(1) == '1'){
		mobStr = mobStr.substring(2,mobStr.length());
		mobile = Long.parseLong(mobStr);
	}
	else if(mobStr.length() != 10 || mobStr.charAt(0)=='0') {
		return "¡Por favor ingresa un número móvil válido!";
	}
	data.setMobile(mobile);		theCustomer.setFirstName(data.getFirstName());
		theCustomer.setLastName(data.getLastName());
		theCustomer.setAddress(data.getAddress());
		theCustomer.setEmail(data.getEmail());
		theCustomer.setMobile(data.getMobile());
		theCustomer.setUsername(data.getUsername());
		
		theCustomer = theCustomerRepository.save(theCustomer);
		
		User theUser = theCustomer.getUser();
		
	currentSession.setUser(theUser);
	
	return "¡Los datos de tu perfil han sido actualizados exitosamente!";
}	@Override
	@Transactional
	public String updatePassword(ChangePassword changePassword) {
		if(!changePassword.getNewPassword().equals(changePassword.getConfirmPassword()))
			return "Las nuevas contraseñas no coinciden";
		String newPassword = changePassword.getNewPassword();
		if(newPassword.length() <= 4)
			return "La longitud de la contraseña debe ser mayor a 4";
		
		Optional<Customer> theCust = theCustomerRepository.findById(changePassword.getUsername());
		Customer cust = null;
		if(theCust.isPresent())
			cust = theCust.get();
		if(!thePasswordEncoder.matches(changePassword.getOldPassword(), cust.getUser().getPassword()))
			return "¡Contraseña antigua incorrecta!";
		
		newPassword = thePasswordEncoder.encode(newPassword);
		
		cust.getUser().setPassword(newPassword);
		
		theCustomerRepository.save(cust);
		
		return "¡Contraseña actualizada exitosamente!";
	}

	
}
