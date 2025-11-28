-- Semilla de datos para la aplicación de librería
-- Detalles de libros (120 entradas) con metadatos y sinopsis en español

INSERT IGNORE INTO book_detail (id, type, detail, sold) VALUES (1,'Ficción','Autor: Gabriel García Márquez; ISBN: 9780307474728; Género: Realismo mágico; Sinopsis: Una saga familiar multigeneracional ambientada en un pueblo mítico, llena de amor, pérdida y destino.',0);
INSERT IGNORE INTO book_detail (id, type, detail, sold) VALUES (2,'Ficción','Autor: Gabriel García Márquez; ISBN: 9780307474729; Género: Romance; Sinopsis: Una historia de amor que abarca décadas, explorando la memoria y la añoranza.',0);
INSERT IGNORE INTO book_detail (id, type, detail, sold) VALUES (3,'Ficción','Autor: Carlos Ruiz Zafón; ISBN: 9780143126393; Género: Misterio; Sinopsis: Un joven librero descubre secretos detrás de la vida de un autor en una ciudad laberíntica.',0);
INSERT IGNORE INTO book_detail (id, type, detail, sold) VALUES (4,'Clásico','Autor: Miguel de Cervantes; ISBN: 9780142437230; Género: Clásico; Sinopsis: Una sátira perdurable de la caballería y la locura humana contada a través de un caballero errante y su escudero.',0);
INSERT IGNORE INTO book_detail (id, type, detail, sold) VALUES (5,'Clásico','Autor: Julio Cortázar; ISBN: 9780141185051; Género: Ficción experimental; Sinopsis: Narraciones lúdicas y surrealistas que exploran la conciencia y la vida urbana.',0);
INSERT IGNORE INTO book_detail (id, type, detail, sold) VALUES (6,'Ficción','Autor: Paulo Coelho; ISBN: 9780061122415; Género: Inspiracional; Sinopsis: El viaje de un pastor en busca de un tesoro que se convierte en una búsqueda de sentido.',0);
INSERT IGNORE INTO book_detail (id, type, detail, sold) VALUES (7,'Distopía','Autor: George Orwell; ISBN: 9780451524935; Género: Distopía; Sinopsis: Una visión escalofriante del control totalitario, la vigilancia y la pérdida de la verdad.',0);
INSERT IGNORE INTO book_detail (id, type, detail, sold) VALUES (8,'Fantasía','Autor: J.K. Rowling; ISBN: 9780747532743; Género: Fantasía; Sinopsis: Un joven mago descubre su destino en una escuela de magia y enfrenta fuerzas oscuras.',0);
INSERT IGNORE INTO book_detail (id, type, detail, sold) VALUES (9,'Suspenso','Autor: Dan Brown; ISBN: 9780307474274; Género: Suspenso; Sinopsis: Un simbologista desentraña conspiraciones que abarcan el arte, la religión y sociedades secretas.',0);
INSERT IGNORE INTO book_detail (id, type, detail, sold) VALUES (10,'Infantil','Autor: Antoine de Saint-Exupéry; ISBN: 9780156012195; Género: Infantil; Sinopsis: Una fábula poética sobre la amistad, la imaginación y el sentido de la vida.',0);

-- Añadimos una lista amplia (hasta 120) con sinopsis y metadatos en español
INSERT IGNORE INTO book_detail (id, type, detail, sold) VALUES (11,'Ficción','Autor: Jorge Luis Borges; ISBN: 9780143105985; Género: Cuentos; Sinopsis: Relatos laberínticos que cuestionan la realidad, la literatura y la identidad.',0);
INSERT IGNORE INTO book_detail (id, type, detail, sold) VALUES (12,'No ficción','Autor: Yuval Noah Harari; ISBN: 9780062316110; Género: Historia; Sinopsis: Un recorrido amplio sobre el desarrollo de la humanidad, sus ideas y transformaciones.',0);
INSERT IGNORE INTO book_detail (id, type, detail, sold) VALUES (13,'Ficción','Autor: Isabel Allende; ISBN: 9780060973960; Género: Ficción histórica; Sinopsis: Saga generacional que combina elementos mágicos con historia política.',0);
INSERT IGNORE INTO book_detail (id, type, detail, sold) VALUES (14,'No ficción','Autor: Malcolm Gladwell; ISBN: 9780316017930; Género: Psicología; Sinopsis: Narrativas que exploran la toma de decisiones y las tendencias sociales.',0);
INSERT IGNORE INTO book_detail (id, type, detail, sold) VALUES (15,'Ficción','Autor: Frank Herbert; ISBN: 9780441013593; Género: Ciencia ficción; Sinopsis: Épica de ciencia ficción sobre política, ecología y destino en un planeta desértico.',0);
INSERT IGNORE INTO book_detail (id, type, detail, sold) VALUES (16,'Ficción','Autor: Agatha Christie; ISBN: 9780062073488; Género: Misterio; Sinopsis: Clásicos detectivescos con tramas ingeniosas y giros inolvidables.',0);
INSERT IGNORE INTO book_detail (id, type, detail, sold) VALUES (17,'No ficción','Autor: Stephen Hawking; ISBN: 9780553380163; Género: Ciencia; Sinopsis: Introducción accesible a la cosmología, los agujeros negros y los orígenes del universo.',0);
INSERT IGNORE INTO book_detail (id, type, detail, sold) VALUES (18,'Ficción','Autor: León Tolstói; ISBN: 9780199232765; Género: Histórico; Sinopsis: Una novela monumental que explora el amor, la guerra y la sociedad en tiempos turbulentos.',0);
INSERT IGNORE INTO book_detail (id, type, detail, sold) VALUES (19,'Infantil','Autor: Dr. Seuss; ISBN: 9780394800011; Género: Infantil; Sinopsis: Historias rítmicas e imaginativas para los primeros lectores.',0);
INSERT IGNORE INTO book_detail (id, type, detail, sold) VALUES (20,'No ficción','Autor: Robert C. Martin; ISBN: 9780132350884; Género: Programación; Sinopsis: Principios y prácticas para escribir código limpio y mantenible.',0);

-- Generar entradas 21..120 con sinopsis y metadatos incrementales

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
-- Nota: este archivo ahora sólo siembra `book_detail` y `book`.
-- Usuarios, roles y otros datos maestros los gestiona `DataInitializer` y el runner seguro para el admin.


