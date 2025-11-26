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

-- Libros (variedad de precios y cantidades)
INSERT IGNORE INTO book (id, name, quantity, price, book_detail_id) VALUES (1,'Mystery of Time', 10, 19.99, 1);
INSERT IGNORE INTO book (id, name, quantity, price, book_detail_id) VALUES (2,'Galaxy Riders', 15, 29.99, 2);
INSERT IGNORE INTO book (id, name, quantity, price, book_detail_id) VALUES (3,'World History 101', 5, 24.50, 3);
INSERT IGNORE INTO book (id, name, quantity, price, book_detail_id) VALUES (4,'Science Sparks', 8, 14.99, 4);
INSERT IGNORE INTO book (id, name, quantity, price, book_detail_id) VALUES (5,'Bedtime Tales', 20, 9.99, 5);
INSERT IGNORE INTO book (id, name, quantity, price, book_detail_id) VALUES (6,'Autumn Romance', 12, 12.49, 6);
INSERT IGNORE INTO book (id, name, quantity, price, book_detail_id) VALUES (7,'Detective Diaries', 0, 7.50, 7);
INSERT IGNORE INTO book (id, name, quantity, price, book_detail_id) VALUES (8,'Coding in Practice', 6, 49.99, 8);
INSERT IGNORE INTO book (id, name, quantity, price, book_detail_id) VALUES (9,'Chef Secrets', 0, 21.00, 9);
INSERT IGNORE INTO book (id, name, quantity, price, book_detail_id) VALUES (10,'Dragon Realms', 30, 39.90, 10);
INSERT IGNORE INTO book (id, name, quantity, price, book_detail_id) VALUES (11,'Midnight Shorts', 18, 5.99, 11);
INSERT IGNORE INTO book (id, name, quantity, price, book_detail_id) VALUES (12,'Winning Moves', 3, 99.99, 12);
-- Libros adicionales
INSERT IGNORE INTO book (id, name, quantity, price, book_detail_id) VALUES (13,'City Lights', 11, 15.99, 13);
INSERT IGNORE INTO book (id, name, quantity, price, book_detail_id) VALUES (14,'Design Thinking', 7, 27.50, 14);
INSERT IGNORE INTO book (id, name, quantity, price, book_detail_id) VALUES (15,'Starbound Fleet', 22, 34.99, 15);
INSERT IGNORE INTO book (id, name, quantity, price, book_detail_id) VALUES (16,'Shadows & Smoke', 0, 8.49, 16);
INSERT IGNORE INTO book (id, name, quantity, price, book_detail_id) VALUES (17,'Healthy Habits', 9, 18.00, 17);
INSERT IGNORE INTO book (id, name, quantity, price, book_detail_id) VALUES (18,'Laugh Out Loud', 5, 6.99, 18);
INSERT IGNORE INTO book (id, name, quantity, price, book_detail_id) VALUES (19,'ABC Starter', 25, 4.99, 19);
INSERT IGNORE INTO book (id, name, quantity, price, book_detail_id) VALUES (20,'Money Matters', 10, 12.00, 20);
INSERT IGNORE INTO book (id, name, quantity, price, book_detail_id) VALUES (21,'Gods Among Us', 13, 21.99, 21);
INSERT IGNORE INTO book (id, name, quantity, price, book_detail_id) VALUES (22,'Broken World', 14, 16.75, 22);
INSERT IGNORE INTO book (id, name, quantity, price, book_detail_id) VALUES (23,'Capturing Light', 6, 32.00, 23);
INSERT IGNORE INTO book (id, name, quantity, price, book_detail_id) VALUES (24,'Tea & Treachery', 12, 11.49, 24);
INSERT IGNORE INTO book (id, name, quantity, price, book_detail_id) VALUES (25,'Garden Paths', 8, 13.25, 25);
INSERT IGNORE INTO book (id, name, quantity, price, book_detail_id) VALUES (26,'Empire Rising', 3, 22.99, 26);
INSERT IGNORE INTO book (id, name, quantity, price, book_detail_id) VALUES (27,'Fix-It Manual', 15, 17.90, 27);
INSERT IGNORE INTO book (id, name, quantity, price, book_detail_id) VALUES (28,'Heroic Tales', 20, 19.49, 28);
INSERT IGNORE INTO book (id, name, quantity, price, book_detail_id) VALUES (29,'Speak Easy', 16, 14.00, 29);
INSERT IGNORE INTO book (id, name, quantity, price, book_detail_id) VALUES (30,'Neon Nights', 4, 23.75, 30);

-- Usuarios en BD (para login JDBC)
-- Admin user: admin / admin123
INSERT IGNORE INTO users (username, password, enabled) VALUES ('admin', '{bcrypt}$2a$10$QtyKIBGFIv.fg1/TRsG6jeKOxyBo3thuRbp0WVYC0tBq3sytHoMV.', 1);
INSERT IGNORE INTO authorities (username, authority) VALUES ('admin', 'ROLE_ADMIN');

-- Customer user: customer / customer123
INSERT IGNORE INTO users (username, password, enabled) VALUES ('customer', '{bcrypt}$2a$10$QtyKIBGFIv.fg1/TRsG6jeKOxyBo3thuRbp0WVYC0tBq3sytHoMV.', 1);
INSERT IGNORE INTO authorities (username, authority) VALUES ('customer', 'ROLE_CUSTOMER');

-- Datos del customer en tabla customer
INSERT IGNORE INTO customer (id, first_name, last_name, email, mob, address) 
VALUES ('customer', 'Juan', 'Pérez', 'customer@test.com', 123456789, 'Calle Principal 123');
