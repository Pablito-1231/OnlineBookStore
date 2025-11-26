package com.shashirajraja.onlinebookstore.controller;

import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.shashirajraja.onlinebookstore.entity.Book;
import com.shashirajraja.onlinebookstore.entity.CurrentSession;
import com.shashirajraja.onlinebookstore.entity.Customer;
import com.shashirajraja.onlinebookstore.entity.ShoppingCart;
import com.shashirajraja.onlinebookstore.service.BookService;
import com.shashirajraja.onlinebookstore.service.ShoppingCartService;

@Controller
@RequestMapping("/books")
public class BookController {
	
	private static final int DEFAULT_PAGE_SIZE = 12;
	
	@Autowired
	BookService theBookService;
	
	@Autowired
	ShoppingCartService theCartService;
	
	@Autowired
	CurrentSession currentSession;
	
	@GetMapping({"","/"})
	public String viewBooks(
		@RequestParam(defaultValue = "0") int page,
		@RequestParam(defaultValue = DEFAULT_PAGE_SIZE + "") int size,
		@RequestParam(defaultValue = "") String search,
		@RequestParam(defaultValue = "0") double minPrice,
		@RequestParam(defaultValue = "10000") double maxPrice,
		Model theModel) {
		
		Pageable pageable = PageRequest.of(page, size);
		
		Customer customer = currentSession.getUser().getCustomer();
		Set<ShoppingCart> shoppingItems = theCartService.getByUsername(customer);
		
		Page<Book> booksPage;
		
		// Buscar con filtros avanzados si hay búsqueda o rango de precio personalizado
		if (!search.isEmpty() || minPrice > 0 || maxPrice < 10000) {
			booksPage = theBookService.searchBooksAdvanced(search.isEmpty() ? "%" : search, minPrice, maxPrice, pageable);
		} else {
			// Si no hay filtros, mostrar solo libros disponibles
			booksPage = theBookService.findAvailableBooksWithPagination(pageable);
		}
		
		theModel.addAttribute("books", booksPage.getContent());
		theModel.addAttribute("currentPage", page);
		theModel.addAttribute("totalPages", booksPage.getTotalPages());
		theModel.addAttribute("totalItems", booksPage.getTotalElements());
		theModel.addAttribute("pageSize", size);
		theModel.addAttribute("search", search);
		theModel.addAttribute("minPrice", minPrice);
		theModel.addAttribute("maxPrice", maxPrice);
		theModel.addAttribute("shoppingItems", shoppingItems);
		
		return "customer-books-list";
	}
	
}
