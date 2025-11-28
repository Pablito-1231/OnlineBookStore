package com.shashirajraja.onlinebookstore.config;

import jakarta.annotation.PostConstruct;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Component;

import java.util.Arrays;
import java.util.List;
import java.security.SecureRandom;

@Component
public class DataInitializer {

    private static final Logger log = LoggerFactory.getLogger(DataInitializer.class);

    @Autowired
    private JdbcTemplate jdbc;

    @Autowired
    private PasswordEncoder passwordEncoder;

    @PostConstruct
    public void init() {
        try {
            // Insertar roles si no existen
            jdbc.update("INSERT IGNORE INTO roles (id, name) VALUES (?, ?)", 1, "ROLE_ADMIN");
            jdbc.update("INSERT IGNORE INTO roles (id, name) VALUES (?, ?)", 2, "ROLE_CUSTOMER");
            jdbc.update("INSERT IGNORE INTO roles (id, name) VALUES (?, ?)", 3, "ROLE_PROVIDER");

            // Preparar contraseña del admin desde variable de entorno o generar una segura
            String adminPass = System.getenv("ADMIN_PASSWORD");
            boolean generated = false;
            if (adminPass == null || adminPass.isBlank()) {
                adminPass = generateRandomPassword(16);
                generated = true;
            }

            String encoded = passwordEncoder.encode(adminPass);

            // Insertar o actualizar usuario admin de forma idempotente
            jdbc.update("INSERT INTO users (username, password, enabled) VALUES (?, ?, ?) ON DUPLICATE KEY UPDATE password=VALUES(password), enabled=VALUES(enabled)", "admin", encoded, 1);
            jdbc.update("INSERT IGNORE INTO authorities (username, authority) VALUES (?, ?)", "admin", "ROLE_ADMIN");

            if (generated) {
                // No imprimir la contraseña en consola por seguridad.
                log.debug("DataInitializer: se generó una contraseña ADMIN (no mostrada). Establece ADMIN_PASSWORD en el entorno para controlarla.");
            }

            // Sembrar catálogo de libros (idempotente)
            seedBooksIfNeeded(120);

            // Si se solicita, añadir más libros reales sin borrar los existentes.
            String addCountStr = System.getenv("SEED_ADD_COUNT");
            if (addCountStr != null) {
                try {
                    int addCount = Integer.parseInt(addCountStr);
                    if (addCount > 0) {
                        seedAdditionalBooks(addCount);
                    }
                } catch (NumberFormatException ex) {
                    log.warn("SEED_ADD_COUNT no es un entero válido: {}", addCountStr);
                }
            }
        } catch (Exception e) {
            // Si las tablas no existen aún, no detener el arranque
            log.warn("DataInitializer: no fue posible insertar datos maestros ahora: {}", e.getMessage());
        }
    }

    private void seedAdditionalBooks(int addCount) {
        try {
            Integer existing = jdbc.queryForObject("SELECT COUNT(*) FROM book", Integer.class);
            int startIndex = (existing == null) ? 0 : existing;
            int target = startIndex + addCount;
            log.info("DataInitializer: agregando {} libros (objetivo total {}).", addCount, target);

            // reuse realistic seed list
            List<String[]> seed = List.of(
                    new String[]{"Don Quixote", "Miguel de Cervantes", "Classic"},
                    new String[]{"Pride and Prejudice", "Jane Austen", "Classic"},
                    new String[]{"1984", "George Orwell", "Dystopia"},
                    new String[]{"To Kill a Mockingbird", "Harper Lee", "Fiction"},
                    new String[]{"The Great Gatsby", "F. Scott Fitzgerald", "Classic"},
                    new String[]{"Moby Dick", "Herman Melville", "Adventure"},
                    new String[]{"War and Peace", "Leo Tolstoy", "Historical"},
                    new String[]{"The Hobbit", "J.R.R. Tolkien", "Fantasy"},
                    new String[]{"Crime and Punishment", "Fyodor Dostoevsky", "Classic"},
                    new String[]{"The Catcher in the Rye", "J.D. Salinger", "Fiction"},
                    new String[]{"Brave New World", "Aldous Huxley", "Dystopia"},
                    new String[]{"Jane Eyre", "Charlotte Brontë", "Classic"},
                    new String[]{"The Odyssey", "Homer", "Epic"},
                    new String[]{"The Brothers Karamazov", "Fyodor Dostoevsky", "Philosophical"},
                    new String[]{"Anna Karenina", "Leo Tolstoy", "Classic"},
                    new String[]{"The Lord of the Rings", "J.R.R. Tolkien", "Fantasy"},
                    new String[]{"The Alchemist", "Paulo Coelho", "Fiction"},
                    new String[]{"The Little Prince", "Antoine de Saint-Exupéry", "Children"},
                    new String[]{"Frankenstein", "Mary Shelley", "Horror"},
                    new String[]{"Dracula", "Bram Stoker", "Horror"},
                    new String[]{"The Kite Runner", "Khaled Hosseini", "Fiction"},
                    new String[]{"One Hundred Years of Solitude", "Gabriel García Márquez", "Magical Realism"},
                    new String[]{"Les Misérables", "Victor Hugo", "Historical"},
                    new String[]{"The Picture of Dorian Gray", "Oscar Wilde", "Philosophical"},
                    new String[]{"Wuthering Heights", "Emily Brontë", "Classic"},
                    new String[]{"The Road", "Cormac McCarthy", "Post-Apocalyptic"},
                    new String[]{"Meditations", "Marcus Aurelius", "Philosophy"},
                    new String[]{"Siddhartha", "Hermann Hesse", "Philosophical"},
                    new String[]{"The Book Thief", "Markus Zusak", "Historical"},
                    new String[]{"The Chronicles of Narnia", "C.S. Lewis", "Fantasy"},
                    new String[]{"Beloved", "Toni Morrison", "Fiction"},
                    new String[]{"The Handmaid's Tale", "Margaret Atwood", "Dystopia"},
                    new String[]{"Life of Pi", "Yann Martel", "Fiction"},
                    new String[]{"A Tale of Two Cities", "Charles Dickens", "Historical"},
                    new String[]{"The Stranger", "Albert Camus", "Philosophical"},
                    new String[]{"Slaughterhouse-Five", "Kurt Vonnegut", "Satire"},
                    new String[]{"The Old Man and the Sea", "Ernest Hemingway", "Fiction"},
                    new String[]{"The Grapes of Wrath", "John Steinbeck", "Historical"},
                    new String[]{"The Divine Comedy", "Dante Alighieri", "Epic"}
            );

            SecureRandom rnd = new SecureRandom();
            int variety = seed.size();
            for (int i = startIndex + 1; i <= target; i++) {
                String[] info = seed.get((i - 1) % variety);
                String baseTitle = info[0];
                String author = info[1];
                String genre = info[2];

                String title = baseTitle + " - Vol " + i;
                double price = Math.round((8.0 + rnd.nextDouble() * 42.0) * 100.0) / 100.0;
                int quantity = 5 + rnd.nextInt(96);
                String isbn = String.format("978%010d", Math.abs(rnd.nextLong() % 10000000000L));
                String synopsis = String.format("%s is a %s by %s. A compelling read that explores universal themes and memorable characters.", baseTitle, genre.toLowerCase(), author);
                String detail = String.format("Author: %s; ISBN: %s; Genre: %s; Synopsis: %s", author, isbn, genre, synopsis);
                String type = (i % 3 == 0) ? "HARDCOVER" : ((i % 3 == 1) ? "PAPERBACK" : "EBOOK");

                Integer detailId = null;
                try {
                    detailId = jdbc.queryForObject("SELECT id FROM book_detail WHERE detail = ? LIMIT 1", Integer.class, detail);
                } catch (Exception e) {
                    detailId = null;
                }
                if (detailId == null) {
                    try {
                        jdbc.update("INSERT INTO book_detail (detail, sold, type) VALUES (?, ?, ?)", detail, 0, type);
                        detailId = jdbc.queryForObject("SELECT LAST_INSERT_ID()", Integer.class);
                    } catch (Exception e) {
                        log.debug("No se pudo insertar book_detail adicional para {}: {}", title, e.getMessage());
                    }
                }

                try {
                    jdbc.update(
                            "INSERT INTO book (name, price, quantity, book_detail_id) VALUES (?, ?, ?, ?)",
                            title, price, quantity, detailId);
                } catch (Exception e) {
                    log.debug("No se pudo insertar book adicional {}: {}", title, e.getMessage());
                }
            }

            log.info("DataInitializer: añadidos {} libros adicionales. Total objetivo: {}", addCount, target);
        } catch (Exception e) {
            log.warn("DataInitializer.seedAdditionalBooks: error al añadir libros: {}", e.getMessage());
        }
    }

    private void seedBooksIfNeeded(int count) {
        try {
            // Check if there are already books
            Integer existing = jdbc.queryForObject("SELECT COUNT(*) FROM book", Integer.class);
            if (existing != null && existing >= count) {
                log.info("DataInitializer: ya existen {} libros, no se sembrará catálogo.", existing);
                return;
            }

            // Ensure unique index on book.name to allow ON DUPLICATE KEY UPDATE
            Integer idx = jdbc.queryForObject(
                    "SELECT COUNT(1) FROM INFORMATION_SCHEMA.STATISTICS WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME='book' AND INDEX_NAME='uk_book_name'",
                    Integer.class);
            if (idx == null || idx == 0) {
                try {
                    jdbc.execute("CREATE UNIQUE INDEX uk_book_name ON book (name)");
                } catch (Exception e) {
                    log.debug("No se pudo crear índice único uk_book_name: {}", e.getMessage());
                }
            }

            // Ensure unique index on book_detail.detail
            Integer idxDetail = jdbc.queryForObject(
                    "SELECT COUNT(1) FROM INFORMATION_SCHEMA.STATISTICS WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME='book_detail' AND INDEX_NAME='uk_book_detail_detail'",
                    Integer.class);
            if (idxDetail == null || idxDetail == 0) {
                try {
                    jdbc.execute("CREATE UNIQUE INDEX uk_book_detail_detail ON book_detail (detail)");
                } catch (Exception e) {
                    log.debug("No se pudo crear índice único uk_book_detail_detail: {}", e.getMessage());
                }
            }

            // Seed realistic book data: titles, authors, genres
            List<String[]> seed = List.of(
                    new String[]{"Don Quixote", "Miguel de Cervantes", "Classic"},
                    new String[]{"Pride and Prejudice", "Jane Austen", "Classic"},
                    new String[]{"1984", "George Orwell", "Dystopia"},
                    new String[]{"To Kill a Mockingbird", "Harper Lee", "Fiction"},
                    new String[]{"The Great Gatsby", "F. Scott Fitzgerald", "Classic"},
                    new String[]{"Moby Dick", "Herman Melville", "Adventure"},
                    new String[]{"War and Peace", "Leo Tolstoy", "Historical"},
                    new String[]{"The Hobbit", "J.R.R. Tolkien", "Fantasy"},
                    new String[]{"Crime and Punishment", "Fyodor Dostoevsky", "Classic"},
                    new String[]{"The Catcher in the Rye", "J.D. Salinger", "Fiction"},
                    new String[]{"Brave New World", "Aldous Huxley", "Dystopia"},
                    new String[]{"Jane Eyre", "Charlotte Brontë", "Classic"},
                    new String[]{"The Odyssey", "Homer", "Epic"},
                    new String[]{"The Brothers Karamazov", "Fyodor Dostoevsky", "Philosophical"},
                    new String[]{"Anna Karenina", "Leo Tolstoy", "Classic"},
                    new String[]{"The Lord of the Rings", "J.R.R. Tolkien", "Fantasy"},
                    new String[]{"The Alchemist", "Paulo Coelho", "Fiction"},
                    new String[]{"The Little Prince", "Antoine de Saint-Exupéry", "Children"},
                    new String[]{"Frankenstein", "Mary Shelley", "Horror"},
                    new String[]{"Dracula", "Bram Stoker", "Horror"},
                    new String[]{"The Kite Runner", "Khaled Hosseini", "Fiction"},
                    new String[]{"One Hundred Years of Solitude", "Gabriel García Márquez", "Magical Realism"},
                    new String[]{"Les Misérables", "Victor Hugo", "Historical"},
                    new String[]{"The Picture of Dorian Gray", "Oscar Wilde", "Philosophical"},
                    new String[]{"Wuthering Heights", "Emily Brontë", "Classic"},
                    new String[]{"The Road", "Cormac McCarthy", "Post-Apocalyptic"},
                    new String[]{"Meditations", "Marcus Aurelius", "Philosophy"},
                    new String[]{"Siddhartha", "Hermann Hesse", "Philosophical"},
                    new String[]{"The Book Thief", "Markus Zusak", "Historical"},
                    new String[]{"The Chronicles of Narnia", "C.S. Lewis", "Fantasy"},
                    new String[]{"Beloved", "Toni Morrison", "Fiction"},
                    new String[]{"The Handmaid's Tale", "Margaret Atwood", "Dystopia"},
                    new String[]{"Life of Pi", "Yann Martel", "Fiction"},
                    new String[]{"A Tale of Two Cities", "Charles Dickens", "Historical"},
                    new String[]{"The Stranger", "Albert Camus", "Philosophical"},
                    new String[]{"Slaughterhouse-Five", "Kurt Vonnegut", "Satire"},
                    new String[]{"The Old Man and the Sea", "Ernest Hemingway", "Fiction"},
                    new String[]{"The Grapes of Wrath", "John Steinbeck", "Historical"},
                    new String[]{"The Divine Comedy", "Dante Alighieri", "Epic"}
            );

            SecureRandom rnd = new SecureRandom();
            int variety = seed.size();
            for (int i = 1; i <= count; i++) {
                String[] info = seed.get((i - 1) % variety);
                String baseTitle = info[0];
                String author = info[1];
                String genre = info[2];

                // Ensure unique title by appending edition number when necessary
                String title = baseTitle;
                int suffix = 1;
                while (true) {
                    Integer exists = null;
                    try {
                        exists = jdbc.queryForObject("SELECT COUNT(1) FROM book WHERE name = ?", Integer.class, title);
                    } catch (Exception e) {
                        exists = 0;
                    }
                    if (exists == null || exists == 0) break;
                    suffix++;
                    title = baseTitle + " (Edition " + suffix + ")";
                }

                double price = Math.round((8.0 + rnd.nextDouble() * 42.0) * 100.0) / 100.0; // 8.00 - 50.00
                int quantity = 5 + rnd.nextInt(96); // 5 - 100

                String isbn = String.format("978%010d", Math.abs(rnd.nextLong() % 10000000000L));
                String synopsis = String.format("%s is a %s by %s. A compelling read that explores universal themes and memorable characters.", baseTitle, genre.toLowerCase(), author);
                String detail = String.format("Author: %s; ISBN: %s; Genre: %s; Synopsis: %s", author, isbn, genre, synopsis);
                String type = (i % 3 == 0) ? "HARDCOVER" : ((i % 3 == 1) ? "PAPERBACK" : "EBOOK");

                // Upsert book_detail
                Integer detailId = null;
                try {
                    detailId = jdbc.queryForObject("SELECT id FROM book_detail WHERE detail = ? LIMIT 1", Integer.class, detail);
                } catch (Exception e) {
                    detailId = null;
                }
                if (detailId == null) {
                    try {
                        jdbc.update("INSERT INTO book_detail (detail, sold, type) VALUES (?, ?, ?)", detail, 0, type);
                        detailId = jdbc.queryForObject("SELECT LAST_INSERT_ID()", Integer.class);
                    } catch (Exception e) {
                        log.debug("No se pudo insertar book_detail para {}: {}", title, e.getMessage());
                    }
                }

                // Upsert book
                try {
                    jdbc.update(
                            "INSERT INTO book (name, price, quantity, book_detail_id) VALUES (?, ?, ?, ?) ON DUPLICATE KEY UPDATE price=VALUES(price), quantity=VALUES(quantity), book_detail_id=VALUES(book_detail_id)",
                            title, price, quantity, detailId);
                } catch (Exception e) {
                    try {
                        String sql = "INSERT INTO book (name, price, quantity, book_detail_id) SELECT ?, ?, ?, ? FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM book WHERE name = ?)";
                        jdbc.update(sql, title, price, quantity, detailId, title);
                    } catch (Exception ex) {
                        log.debug("No se pudo insertar/actualizar book {}: {}", title, ex.getMessage());
                    }
                }
            }

            log.info("DataInitializer: sembrado catálogo realista de {} libros.", count);
        } catch (Exception e) {
            log.warn("DataInitializer.seedBooksIfNeeded: no se pudo sembrar libros: {}", e.getMessage());
        }
    }

    private String generateRandomPassword(int length) {
        final String chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!@#$%&*()-_=+";
        SecureRandom rnd = new SecureRandom();
        StringBuilder sb = new StringBuilder(length);
        for (int i = 0; i < length; i++) {
            sb.append(chars.charAt(rnd.nextInt(chars.length())));
        }
        return sb.toString();
    }
}
