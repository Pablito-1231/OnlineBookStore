-- V2: insertar datos maestros idempotentes
INSERT IGNORE INTO roles (id, name) VALUES (1, 'ROLE_ADMIN');
INSERT IGNORE INTO roles (id, name) VALUES (2, 'ROLE_CUSTOMER');
INSERT IGNORE INTO roles (id, name) VALUES (3, 'ROLE_PROVIDER');

-- Insertar admin con hash bcrypt por defecto (idempotente):
-- Nota: este hash es un valor por defecto para despliegues de desarrollo.
-- En entorno de producción, establezca `ADMIN_PASSWORD` como secreto y DataInitializer
-- actualizará la contraseña en tiempo de arranque si es necesario.
INSERT INTO users (username, password, enabled)
VALUES ('admin', '{bcrypt}$2a$10$KbQi9s8e1aZ0u8u0f9Lqne6H9jF7XyZ1qvK0a0b0c0d0e0f0g0h0i', 1)
ON DUPLICATE KEY UPDATE password = VALUES(password), enabled = VALUES(enabled);

INSERT INTO authorities (username, authority)
VALUES ('admin', 'ROLE_ADMIN')
ON DUPLICATE KEY UPDATE authority = VALUES(authority);

-- Nota: la creación/actualización del usuario `admin` y su contraseña la gestiona
-- `DataInitializer` en tiempo de arranque (usa el PasswordEncoder y actualiza
-- la fila si ya existe). Dejar la gestión de la contraseña en código evita
-- inconsistencias entre el formato del hash y la configuración de Spring Security.
