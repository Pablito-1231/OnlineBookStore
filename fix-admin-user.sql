-- ================================================
-- SCRIPT DE VERIFICACIÓN Y CORRECCIÓN DE ADMIN
-- Ejecuta este script en MySQL Workbench o tu cliente MySQL
-- ================================================

-- 1. Seleccionar la base de datos
USE onlinebookstore;

-- 2. Verificar si existe el usuario admin
SELECT 'Verificando usuario admin...' as Status;
SELECT * FROM users WHERE username = 'admin';

-- 3. Verificar roles del admin
SELECT 'Verificando roles del admin...' as Status;
SELECT * FROM authorities WHERE username = 'admin';

-- 4. ELIMINAR usuario admin existente (por si está corrupto)
DELETE FROM authorities WHERE username = 'admin';
DELETE FROM users WHERE username = 'admin';

-- 5. RECREAR el usuario admin con las credenciales correctas
-- Contraseña: admin123 (hasheada con bcrypt)
INSERT INTO users (username, password, enabled) 
VALUES ('admin', '{bcrypt}$2a$10$QtyKIBGFIv.fg1/TRsG6jeKOxyBo3thuRbp0WVYC0tBq3sytHoMV.', 1);

-- 6. Asignar el rol ROLE_ADMIN
INSERT INTO authorities (username, authority) 
VALUES ('admin', 'ROLE_ADMIN');

-- 7. Verificar que se creó correctamente
SELECT 'Usuario admin recreado:' as Status;
SELECT * FROM users WHERE username = 'admin';
SELECT * FROM authorities WHERE username = 'admin';

-- 8. Verificar todas las tablas necesarias existen
SELECT 'Verificando estructura de tablas...' as Status;
SHOW TABLES;

-- 9. Mostrar todos los usuarios del sistema
SELECT 'Todos los usuarios del sistema:' as Status;
SELECT u.username, u.enabled, a.authority 
FROM users u 
LEFT JOIN authorities a ON u.username = a.username;

SELECT '¡Script completado! Ahora intenta iniciar sesión con admin/admin123' as Status;
