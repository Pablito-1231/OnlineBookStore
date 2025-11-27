-- Seed de datos mínimo para pruebas
-- Detalles de libros (OneToOne: cada book_detail debe ser único por book)
INSERT IGNORE INTO book_detail (id, type, detail, sold) VALUES (1,'Fiction','Mystery novel',0);
INSERT IGNORE INTO book_detail (id, type, detail, sold) VALUES (2,'Fiction','Sci-Fi adventure',0);
INSERT IGNORE INTO book_detail (id, type, detail, sold) VALUES (3,'Non-Fiction','History overview',0);
INSERT IGNORE INTO book_detail (id, type, detail, sold) VALUES (4,'Fiction','Classic literature',0);
INSERT IGNORE INTO book_detail (id, type, detail, sold) VALUES (5,'Fiction','Latin American classic',0);
INSERT IGNORE INTO book_detail (id, type, detail, sold) VALUES (6,'Fiction','Romance drama',0);
INSERT IGNORE INTO book_detail (id, type, detail, sold) VALUES (7,'Fiction','Detective stories',0);
INSERT IGNORE INTO book_detail (id, type, detail, sold) VALUES (8,'Fiction','Fantasy epic',0);
INSERT IGNORE INTO book_detail (id, type, detail, sold) VALUES (9,'Fiction','Thriller mystery',0);

-- Libros (cada uno con su propio book_detail_id único)
INSERT IGNORE INTO book (id, name, quantity, price, book_detail_id) VALUES (1,'Cien años de soledad', 12, 69000, 1);
INSERT IGNORE INTO book (id, name, quantity, price, book_detail_id) VALUES (2,'El amor en los tiempos del cólera', 10, 62000, 2);
INSERT IGNORE INTO book (id, name, quantity, price, book_detail_id) VALUES (3,'La sombra del viento', 8, 58000, 3);
INSERT IGNORE INTO book (id, name, quantity, price, book_detail_id) VALUES (4,'Don Quijote de la Mancha', 6, 85000, 4);
INSERT IGNORE INTO book (id, name, quantity, price, book_detail_id) VALUES (5,'Rayuela', 9, 54000, 5);
INSERT IGNORE INTO book (id, name, quantity, price, book_detail_id) VALUES (6,'El alquimista', 14, 52000, 6);
INSERT IGNORE INTO book (id, name, quantity, price, book_detail_id) VALUES (7,'1984', 7, 49000, 7);
INSERT IGNORE INTO book (id, name, quantity, price, book_detail_id) VALUES (8,'Harry Potter y la piedra filosofal', 18, 75000, 8);
INSERT IGNORE INTO book (id, name, quantity, price, book_detail_id) VALUES (20,'El código Da Vinci', 0, 49000, 9);

-- Usuarios en BD
INSERT IGNORE INTO users (username, password, enabled) VALUES ('admin', '$2a$10$KSXQZ0Q5r9Q9Q9Q9Q9Q9Q9Q9Q9Q9Q9Q9Q9Q9Q9Q9Q9Q9Q9Q9Q', 1);
INSERT IGNORE INTO authorities (username, authority) VALUES ('admin', 'ROLE_ADMIN');

INSERT IGNORE INTO users (username, password, enabled) VALUES ('customer', '$2a$10$KSXQZ0Q5r9Q9Q9Q9Q9Q9Q9Q9Q9Q9Q9Q9Q9Q9Q9Q9Q9Q9Q9Q9Q9Q9Q', 1);
INSERT IGNORE INTO authorities (username, authority) VALUES ('customer', 'ROLE_CUSTOMER');

-- Datos del customer
INSERT IGNORE INTO customer (id, first_name, last_name, email, mob, address) VALUES ('customer', 'Juan', 'Pérez', 'customer@test.com', 123456789, 'Calle Principal 123');

-- Roles básicos
INSERT IGNORE INTO roles (id, name) VALUES (1, 'ROLE_ADMIN');
INSERT IGNORE INTO roles (id, name) VALUES (2, 'ROLE_CUSTOMER');

-- Shopping cart de ejemplo
INSERT IGNORE INTO shopping_cart (customer_id, book_id, count) VALUES ('customer', 1, 2);
INSERT IGNORE INTO shopping_cart (customer_id, book_id, count) VALUES ('customer', 2, 1);

-- Relación book_user (libros comprados por el usuario)
INSERT IGNORE INTO book_user (book_id, customer_id) VALUES (1, 'customer');
INSERT IGNORE INTO book_user (book_id, customer_id) VALUES (2, 'customer');

-- Historial de compras de ejemplo
INSERT IGNORE INTO purchase_history (id, customer_id, date) VALUES ('ph1', 'customer', '2025-11-26');

-- Detalle de compra de ejemplo
INSERT IGNORE INTO purchase_detail (purchase_history_id, book_id, price, quanitity) VALUES ('ph1', 1, 69000, 1);
INSERT IGNORE INTO purchase_detail (purchase_history_id, book_id, price, quanitity) VALUES ('ph1', 2, 62000, 1);
