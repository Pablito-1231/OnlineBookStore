-- Script para resetear usuarios con contraseñas simples
USE onlinebookstore;

-- Eliminar usuarios existentes
DELETE FROM authorities WHERE username IN ('admin', 'customer');
DELETE FROM customer WHERE id = 'customer';
DELETE FROM users WHERE username IN ('admin', 'customer');

-- Crear usuarios con contraseñas simples (sin bcrypt)
-- Admin: admin / admin
INSERT INTO users (username, password, enabled) VALUES ('admin', '{noop}admin', 1);
INSERT INTO authorities (username, authority) VALUES ('admin', 'ROLE_ADMIN');

-- Customer: customer / customer
INSERT INTO users (username, password, enabled) VALUES ('customer', '{noop}customer', 1);
INSERT INTO authorities (username, authority) VALUES ('customer', 'ROLE_CUSTOMER');

-- Datos del customer
INSERT INTO customer (id, first_name, last_name, email, mob, address) 
VALUES ('customer', 'Juan', 'Pérez', 'customer@test.com', 123456789, 'Calle Principal 123');

SELECT 'Usuarios actualizados correctamente' AS resultado;
