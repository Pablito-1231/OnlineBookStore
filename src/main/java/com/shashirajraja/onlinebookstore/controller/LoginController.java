package com.shashirajraja.onlinebookstore.controller;

import jakarta.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.shashirajraja.onlinebookstore.entity.CurrentSession;
import com.shashirajraja.onlinebookstore.service.UserService;

@Controller
public class LoginController {

	private static final Logger logger = LoggerFactory.getLogger(LoginController.class);

	@Autowired
	UserService theUserService;
	
	@Autowired
	CurrentSession currentSession;
	
	@GetMapping("/login")
	public String showLoginForm(HttpSession session) {
 		session.setAttribute("var", "My Variable");
 		logger.debug("Mostrando formulario de login");
		return "login-form";
	}
	
	
	
	
	//load user to the session after getting logged in
	
	/*@After("execution(* * showHome(..))")
	public void loadUserAfterLoggedIn(HttpSession session) {
		// logger.info("Cargando los datos del usuario desde la base de datos");
		Authentication loggedInUser = SecurityContextHolder.getContext().getAuthentication();
		String username = loggedInUser.getName();
		User theUser = theUserService.getUserByUsername(username);
		session.setAttribute("activeUser", theUser);
	}*/
}
