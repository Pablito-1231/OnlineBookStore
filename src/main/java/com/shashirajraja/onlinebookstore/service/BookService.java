package com.shashirajraja.onlinebookstore.service;

import java.util.List;
import java.util.Set;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import com.shashirajraja.onlinebookstore.entity.Book;


public interface BookService {

	public Set<Book> getAllBooks();
	
	public Book getBookById(int bookId);
	
	public String updateBook(Book book);
	
	public String removeBookById(int bookId);

	public String removeBook(Book book);
	
	public String addBook(Book book);
	
	public Set<Book> searchBooks(String search);
	
	// Nuevos métodos para paginación y filtros
	public Page<Book> searchBooksWithPagination(String search, Pageable pageable);
	
	public List<Book> findByPriceRange(double minPrice, double maxPrice);
	
	public Page<Book> findByPriceRangeWithPagination(double minPrice, double maxPrice, Pageable pageable);
	
	public List<Book> findAvailableBooks();
	
	public Page<Book> findAvailableBooksWithPagination(Pageable pageable);
	
	public Page<Book> searchBooksAdvanced(String search, double minPrice, double maxPrice, Pageable pageable);
}

