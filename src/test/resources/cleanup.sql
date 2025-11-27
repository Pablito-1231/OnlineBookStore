-- Limpieza de datos antes de cada prueba para evitar duplicados
SET FOREIGN_KEY_CHECKS=0;
TRUNCATE TABLE shopping_cart;
TRUNCATE TABLE book_user;
TRUNCATE TABLE purchase_detail;
TRUNCATE TABLE purchase_history;
TRUNCATE TABLE authorities;
TRUNCATE TABLE customer;
TRUNCATE TABLE users;
TRUNCATE TABLE book;
TRUNCATE TABLE book_detail;
-- Si existe la tabla roles, también se limpia (inofensivo si está vacía)
TRUNCATE TABLE roles;
SET FOREIGN_KEY_CHECKS=1;
