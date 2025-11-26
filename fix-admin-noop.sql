-- ================================================
-- SCRIPT ALTERNATIVO: Contraseña sin encriptar (SOLO PARA TESTING)
-- USA ESTO SI EL SCRIPT ANTERIOR NO FUNCIONA
-- ================================================

USE onlinebookstore;

-- Eliminar admin existente
DELETE FROM authorities WHERE username = 'admin';
DELETE FROM users WHERE username = 'admin';

-- Crear admin con contraseña SIN encriptar (usando {noop})
-- Esto es SOLO para verificar que el login funcione
INSERT INTO users (username, password, enabled) 
VALUES ('admin', '{noop}admin123', 1);

INSERT INTO authorities (username, authority) 
VALUES ('admin', 'ROLE_ADMIN');

-- Verificar
SELECT * FROM users WHERE username = 'admin';
SELECT * FROM authorities WHERE username = 'admin';

SELECT '¡Usuario admin creado con contraseña sin encriptar!' as Status;
SELECT 'Intenta iniciar sesión con: admin / admin123' as Credenciales;
