package com.shashirajraja.onlinebookstore.service;

import java.util.HashSet;
import java.util.List;
import java.util.Optional;
import java.util.Set;

import jakarta.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import com.shashirajraja.onlinebookstore.config.CacheConfig;
import com.shashirajraja.onlinebookstore.dao.BookRepository;
import com.shashirajraja.onlinebookstore.entity.Book;

@Service
public class BookServiceImpl implements BookService {

	@Autowired
	private BookRepository theBook;

	@Override
	@Transactional
	public Set<Book> getAllBooks() {

		Set<Book> books = new HashSet<Book>();

		books.addAll(theBook.findAll());

		return books;
	}

	@Override
	@Transactional
	@Cacheable(value = CacheConfig.BOOK_BY_ID_CACHE, key = "#bookId")
	public Book getBookById(int bookId) {

		Optional<Book> bookOpt = theBook.findById(bookId);

		if (bookOpt.isPresent())
			return bookOpt.get();

		return null;
	}

	@Override
	@Transactional
	@CacheEvict(value = { CacheConfig.BOOK_BY_ID_CACHE, CacheConfig.BOOKS_CACHE,
			CacheConfig.AVAILABLE_BOOKS_CACHE }, allEntries = true)
	public String updateBook(Book book) {
		if (book == null) {
			return "Error: Libro inválido";
		}
		theBook.save(book);
		return "¡Libro actualizado exitosamente!";
	}

	@Override
	@Transactional
	public String removeBookById(int bookId) {
		Optional<Book> bookOpt = theBook.findById(bookId);

		if (bookOpt.isEmpty())
			return "ID de libro inválido";

		Book book = bookOpt.get();
		theBook.save(book);

		return "¡Libro eliminado exitosamente!";
	}

	@Override
	@Transactional
	@CacheEvict(value = { CacheConfig.BOOK_BY_ID_CACHE, CacheConfig.BOOKS_CACHE,
			CacheConfig.AVAILABLE_BOOKS_CACHE }, allEntries = true)
	public String addBook(Book book) {
		if (book == null) {
			return "Error: Libro inválido";
		}
		theBook.save(book);

		return "¡Libro agregado exitosamente!";
	}

	@Override
	@Transactional
	public Set<Book> searchBooks(String search) {
		Set<Book> books = new HashSet<Book>(theBook.searchBooks("%" + search.toLowerCase() + "%"));
		return books;
	}

	@Override
	public String removeBook(Book book) {
		if (book == null) {
			return "Error: Libro inválido";
		}
		Optional<Book> optBook = theBook.findById(book.getId());

		if (optBook.isPresent()) {
			Book bookToDelete = optBook.get();
			theBook.delete(bookToDelete);
		} else {
			return "¡Libro no disponible en la base de datos!";
		}

		return "¡Libro eliminado exitosamente!";
	}

	// ========== NUEVOS MÉTODOS PARA PAGINACIÓN Y FILTROS ==========

	@Override
	@Transactional
	public Page<Book> searchBooksWithPagination(String search, Pageable pageable) {
		return theBook.searchBooksWithPagination("%" + search.toLowerCase() + "%", pageable);
	}

	@Override
	@Transactional
	public List<Book> findByPriceRange(double minPrice, double maxPrice) {
		return theBook.findByPriceRange(minPrice, maxPrice);
	}

	@Override
	@Transactional
	public Page<Book> findByPriceRangeWithPagination(double minPrice, double maxPrice, Pageable pageable) {
		return theBook.findByPriceRangeWithPagination(minPrice, maxPrice, pageable);
	}

	@Override
	@Transactional
	public List<Book> findAvailableBooks() {
		return theBook.findAvailableBooks();
	}

	@Override
	@Transactional
	@Cacheable(value = CacheConfig.AVAILABLE_BOOKS_CACHE, key = "#pageable.pageNumber + '-' + #pageable.pageSize")
	public Page<Book> findAvailableBooksWithPagination(Pageable pageable) {
		return theBook.findAvailableBooksWithPagination(pageable);
	}

	@Override
	@Transactional
	public Page<Book> searchBooksAdvanced(String search, double minPrice, double maxPrice, Pageable pageable) {
		return theBook.searchBooksAdvanced("%" + search.toLowerCase() + "%", minPrice, maxPrice, pageable);
	}

}
