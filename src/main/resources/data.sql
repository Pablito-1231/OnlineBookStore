-- Seed de datos para la app de librería
-- Detalles de libros
INSERT IGNORE INTO book_detail (id, type, detail, sold) VALUES (1,'Fiction','Mystery novel',0);
INSERT IGNORE INTO book_detail (id, type, detail, sold) VALUES (2,'Fiction','Sci-Fi adventure',0);
INSERT IGNORE INTO book_detail (id, type, detail, sold) VALUES (3,'Non-Fiction','History overview',0);
INSERT IGNORE INTO book_detail (id, type, detail, sold) VALUES (4,'Non-Fiction','Science essays',0);
INSERT IGNORE INTO book_detail (id, type, detail, sold) VALUES (5,'Children','Fairy tales',0);
INSERT IGNORE INTO book_detail (id, type, detail, sold) VALUES (6,'Fiction','Romance drama',0);
INSERT IGNORE INTO book_detail (id, type, detail, sold) VALUES (7,'Fiction','Detective stories',0);
INSERT IGNORE INTO book_detail (id, type, detail, sold) VALUES (8,'Non-Fiction','Tech handbook',0);
INSERT IGNORE INTO book_detail (id, type, detail, sold) VALUES (9,'Non-Fiction','Cooking recipes',0);
INSERT IGNORE INTO book_detail (id, type, detail, sold) VALUES (10,'Fiction','Fantasy epic',0);
INSERT IGNORE INTO book_detail (id, type, detail, sold) VALUES (11,'Fiction','Short stories',0);
INSERT IGNORE INTO book_detail (id, type, detail, sold) VALUES (12,'Non-Fiction','Business strategy',0);
-- Detalles adicionales para ampliar el catálogo
INSERT IGNORE INTO book_detail (id, type, detail, sold) VALUES (13,'Fiction','Urban tales',0);
INSERT IGNORE INTO book_detail (id, type, detail, sold) VALUES (14,'Non-Fiction','Art design',0);
INSERT IGNORE INTO book_detail (id, type, detail, sold) VALUES (15,'Fiction','Space opera',0);
INSERT IGNORE INTO book_detail (id, type, detail, sold) VALUES (16,'Fiction','Noir classic',0);
INSERT IGNORE INTO book_detail (id, type, detail, sold) VALUES (17,'Non-Fiction','Health & wellness',0);
INSERT IGNORE INTO book_detail (id, type, detail, sold) VALUES (18,'Fiction','Comedy sketches',0);
INSERT IGNORE INTO book_detail (id, type, detail, sold) VALUES (19,'Children','Learning ABC',0);
INSERT IGNORE INTO book_detail (id, type, detail, sold) VALUES (20,'Non-Fiction','Finance basics',0);
INSERT IGNORE INTO book_detail (id, type, detail, sold) VALUES (21,'Fiction','Mythology retold',0);
INSERT IGNORE INTO book_detail (id, type, detail, sold) VALUES (22,'Fiction','Dystopian saga',0);
INSERT IGNORE INTO book_detail (id, type, detail, sold) VALUES (23,'Non-Fiction','Photography guide',0);
INSERT IGNORE INTO book_detail (id, type, detail, sold) VALUES (24,'Fiction','Cozy mystery',0);
INSERT IGNORE INTO book_detail (id, type, detail, sold) VALUES (25,'Non-Fiction','Gardening tips',0);
INSERT IGNORE INTO book_detail (id, type, detail, sold) VALUES (26,'Fiction','Historical drama',0);
INSERT IGNORE INTO book_detail (id, type, detail, sold) VALUES (27,'Non-Fiction','DIY handbook',0);
INSERT IGNORE INTO book_detail (id, type, detail, sold) VALUES (28,'Fiction','Superhero chronicles',0);
INSERT IGNORE INTO book_detail (id, type, detail, sold) VALUES (29,'Non-Fiction','Language learning',0);
INSERT IGNORE INTO book_detail (id, type, detail, sold) VALUES (30,'Fiction','Cyberpunk tales',0);

-- Libros (títulos reales en COP)
INSERT IGNORE INTO book (id, name, quantity, price, book_detail_id) VALUES (1,'Cien años de soledad', 12, 69000, 1);
INSERT IGNORE INTO book (id, name, quantity, price, book_detail_id) VALUES (2,'El amor en los tiempos del cólera', 10, 62000, 6);
INSERT IGNORE INTO book (id, name, quantity, price, book_detail_id) VALUES (3,'La sombra del viento', 8, 58000, 26);
INSERT IGNORE INTO book (id, name, quantity, price, book_detail_id) VALUES (4,'Don Quijote de la Mancha', 6, 85000, 11);
INSERT IGNORE INTO book (id, name, quantity, price, book_detail_id) VALUES (5,'Rayuela', 9, 54000, 15);
INSERT IGNORE INTO book (id, name, quantity, price, book_detail_id) VALUES (6,'El alquimista', 14, 52000, 1);
INSERT IGNORE INTO book (id, name, quantity, price, book_detail_id) VALUES (7,'1984', 7, 49000, 22);
INSERT IGNORE INTO book (id, name, quantity, price, book_detail_id) VALUES (8,'El señor de los anillos: La comunidad del anillo', 5, 99000, 10);
INSERT IGNORE INTO book (id, name, quantity, price, book_detail_id) VALUES (9,'Harry Potter y la piedra filosofal', 18, 75000, 10);
INSERT IGNORE INTO book (id, name, quantity, price, book_detail_id) VALUES (10,'El principito', 20, 35000, 5);
INSERT IGNORE INTO book (id, name, quantity, price, book_detail_id) VALUES (11,'Pedro Páramo', 11, 42000, 26);
INSERT IGNORE INTO book (id, name, quantity, price, book_detail_id) VALUES (12,'Ficciones', 10, 48000, 11);
-- Libros adicionales en COP
INSERT IGNORE INTO book (id, name, quantity, price, book_detail_id) VALUES (13,'Crónica de una muerte anunciada', 16, 43000, 24);
INSERT IGNORE INTO book (id, name, quantity, price, book_detail_id) VALUES (14,'Sapiens: De animales a dioses', 9, 89000, 12);
INSERT IGNORE INTO book (id, name, quantity, price, book_detail_id) VALUES (15,'Homo Deus', 7, 88000, 12);
INSERT IGNORE INTO book (id, name, quantity, price, book_detail_id) VALUES (16,'Breves respuestas a las grandes preguntas', 6, 67000, 4);
INSERT IGNORE INTO book (id, name, quantity, price, book_detail_id) VALUES (17,'Clean Code', 4, 150000, 8);
INSERT IGNORE INTO book (id, name, quantity, price, book_detail_id) VALUES (18,'El poder del hábito', 13, 68000, 20);
INSERT IGNORE INTO book (id, name, quantity, price, book_detail_id) VALUES (19,'Cocina colombiana tradicional', 15, 56000, 9);
INSERT IGNORE INTO book (id, name, quantity, price, book_detail_id) VALUES (20,'El código Da Vinci', 0, 49000, 7);
INSERT IGNORE INTO book (id, name, quantity, price, book_detail_id) VALUES (21,'El psicoanalista', 8, 52000, 7);
INSERT IGNORE INTO book (id, name, quantity, price, book_detail_id) VALUES (22,'Dune', 9, 99000, 2);
INSERT IGNORE INTO book (id, name, quantity, price, book_detail_id) VALUES (23,'El juego de Ender', 10, 59000, 2);
INSERT IGNORE INTO book (id, name, quantity, price, book_detail_id) VALUES (24,'Fundación', 12, 62000, 2);
INSERT IGNORE INTO book (id, name, quantity, price, book_detail_id) VALUES (25,'El nombre del viento', 5, 88000, 10);
INSERT IGNORE INTO book (id, name, quantity, price, book_detail_id) VALUES (26,'El temor de un hombre sabio', 3, 99000, 10);
INSERT IGNORE INTO book (id, name, quantity, price, book_detail_id) VALUES (27,'La chica del tren', 14, 45000, 24);
INSERT IGNORE INTO book (id, name, quantity, price, book_detail_id) VALUES (28,'Orgullo y prejuicio', 10, 38000, 26);
INSERT IGNORE INTO book (id, name, quantity, price, book_detail_id) VALUES (29,'Los pilares de la Tierra', 6, 78000, 26);
INSERT IGNORE INTO book (id, name, quantity, price, book_detail_id) VALUES (30,'El arte de la guerra', 22, 36000, 20);

-- Usuarios en BD (para login JDBC)
-- Admin user: admin / admin
INSERT IGNORE INTO users (username, password, enabled) VALUES ('admin', '{noop}admin', 1);
INSERT IGNORE INTO authorities (username, authority) VALUES ('admin', 'ROLE_ADMIN');

-- Customer user: customer / customer
INSERT IGNORE INTO users (username, password, enabled) VALUES ('customer', '{noop}customer', 1);
INSERT IGNORE INTO authorities (username, authority) VALUES ('customer', 'ROLE_CUSTOMER');

INSERT IGNORE INTO customer (id, first_name, last_name, email, mob, address) 
VALUES ('customer', 'Juan', 'Pérez', 'customer@test.com', 123456789, 'Calle Principal 123');

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

-- Asegurar que las contraseñas existentes tengan un prefijo de encoder.
-- Si la contraseña ya tiene formato {id}... no se modifica.


