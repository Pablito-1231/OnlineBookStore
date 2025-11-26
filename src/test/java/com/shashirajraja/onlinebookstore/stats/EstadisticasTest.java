package com.shashirajraja.onlinebookstore.stats;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import com.shashirajraja.onlinebookstore.entity.Book;
import com.shashirajraja.onlinebookstore.service.BookService;

import java.util.Set;

/**
 * Test para verificar los cálculos de estadísticas
 */
@SpringBootTest
public class EstadisticasTest {

    @Autowired
    private BookService bookService;

    @Test
    public void testEstadisticasLibros() {
        System.out.println("\n=== TEST DE ESTADÍSTICAS ===");
        
        Set<Book> allBooks = bookService.getAllBooks();
        
        long totalLibros = allBooks.size();
        long librosDisponibles = allBooks.stream().filter(b -> b.getQuantity() > 0).count();
        long librosAgotados = allBooks.stream().filter(b -> b.getQuantity() == 0).count();
        
        System.out.println("Total de libros: " + totalLibros);
        System.out.println("Libros disponibles (qty > 0): " + librosDisponibles);
        System.out.println("Libros agotados (qty == 0): " + librosAgotados);
        System.out.println("\nDetalle de libros:");
        
        allBooks.forEach(book -> {
            System.out.println("  - " + book.getName() + 
                             " | Cantidad: " + book.getQuantity() + 
                             " | Estado: " + (book.getQuantity() > 0 ? "Disponible" : "Agotado"));
        });
        
        System.out.println("\n=== FIN TEST ===\n");
    }
}
