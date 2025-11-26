package com.shashirajraja.onlinebookstore.dao;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.shashirajraja.onlinebookstore.entity.Book;

@Repository
public interface BookRepository extends JpaRepository<Book, Integer> {

	// Búsqueda simple por nombre
	@Query("from Book where lower(name) like :search")
	List<Book> searchBooks(@Param("search") String search);

	// Búsqueda con paginación
	@Query(value = "from Book where lower(name) like :search",
		   countQuery = "select count(b) from Book b where lower(b.name) like :search")
	Page<Book> searchBooksWithPagination(@Param("search") String search, Pageable pageable);

	// Búsqueda por rango de precio
	@Query("from Book where price >= :minPrice and price <= :maxPrice")
	List<Book> findByPriceRange(@Param("minPrice") double minPrice, @Param("maxPrice") double maxPrice);

	// Búsqueda por rango de precio con paginación
	@Query(value = "from Book where price >= :minPrice and price <= :maxPrice",
		   countQuery = "select count(b) from Book b where b.price >= :minPrice and b.price <= :maxPrice")
	Page<Book> findByPriceRangeWithPagination(@Param("minPrice") double minPrice, 
											  @Param("maxPrice") double maxPrice, 
											  Pageable pageable);

	// Libros disponibles (cantidad > 0)
	@Query("from Book where quantity > 0")
	List<Book> findAvailableBooks();

	// Libros disponibles con paginación
	@Query(value = "from Book where quantity > 0",
		   countQuery = "select count(b) from Book b where b.quantity > 0")
	Page<Book> findAvailableBooksWithPagination(Pageable pageable);

	// Búsqueda combinada: nombre + rango de precio + disponibilidad
	@Query(value = "from Book where lower(name) like :search and price >= :minPrice and price <= :maxPrice and quantity > 0",
		   countQuery = "select count(b) from Book b where lower(b.name) like :search and b.price >= :minPrice and b.price <= :maxPrice and b.quantity > 0")
	Page<Book> searchBooksAdvanced(@Param("search") String search,
								   @Param("minPrice") double minPrice,
								   @Param("maxPrice") double maxPrice,
								   Pageable pageable);

}

