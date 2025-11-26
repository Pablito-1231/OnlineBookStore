# 🚨 SOLUCIÓN: Usuario o contraseña incorrectos

## 📋 Diagnóstico del Problema

Estás recibiendo el error "Usuario o contraseña incorrectos" al intentar iniciar sesión con admin.

### Posibles causas:
1. ❌ El usuario admin no existe en la base de datos
2. ❌ El hash de la contraseña está corrupto
3. ❌ La base de datos no se inicializó correctamente
4. ❌ El archivo data.sql no se ejecutó

---

## ✅ SOLUCIÓN RÁPIDA (3 pasos)

### Paso 1: Abrir MySQL Workbench o Cliente MySQL
1. Abre **MySQL Workbench**
2. Conecta a tu servidor local (localhost:3306)
3. Usuario: `root`, Contraseña: (la tuya o vacía)

### Paso 2: Ejecutar Script de Corrección
Abre el archivo `fix-admin-user.sql` que está en la raíz del proyecto y ejecútalo completo.

**O copia y pega esto directamente:**

```sql
USE onlinebookstore;

-- Eliminar admin existente (por si está corrupto)
DELETE FROM authorities WHERE username = 'admin';
DELETE FROM users WHERE username = 'admin';

-- Recrear admin con credenciales correctas
INSERT INTO users (username, password, enabled) 
VALUES ('admin', '{bcrypt}$2a$10$QtyKIBGFIv.fg1/TRsG6jeKOxyBo3thuRbp0WVYC0tBq3sytHoMV.', 1);

INSERT INTO authorities (username, authority) 
VALUES ('admin', 'ROLE_ADMIN');

-- Verificar que se creó
SELECT * FROM users WHERE username = 'admin';
SELECT * FROM authorities WHERE username = 'admin';
```

### Paso 3: Reiniciar la Aplicación
1. Detén la aplicación Spring Boot (Ctrl+C en la terminal)
2. Inicia nuevamente la aplicación
3. Ve a http://localhost:8080/login
4. Ingresa:
   - Usuario: `admin`
   - Contraseña: `admin123`

---

## 🔧 SOLUCIÓN ALTERNATIVA (Si la anterior no funciona)

Usa contraseña sin encriptar (solo para testing):

```sql
USE onlinebookstore;

DELETE FROM authorities WHERE username = 'admin';
DELETE FROM users WHERE username = 'admin';

-- Contraseña SIN encriptar (más fácil para depurar)
INSERT INTO users (username, password, enabled) 
VALUES ('admin', '{noop}admin123', 1);

INSERT INTO authorities (username, authority) 
VALUES ('admin', 'ROLE_ADMIN');
```

Reinicia la app e intenta nuevamente con `admin` / `admin123`.

---

## 🔍 VERIFICACIÓN

### Verificar que el usuario existe:
```sql
USE onlinebookstore;
SELECT u.username, u.password, u.enabled, a.authority 
FROM users u 
LEFT JOIN authorities a ON u.username = a.username
WHERE u.username = 'admin';
```

**Resultado esperado:**
```
username | password                                          | enabled | authority
admin    | {bcrypt}$2a$10$QtyKIBGFIv.fg1/TRsG6jeKOx...      | 1       | ROLE_ADMIN
```

### Verificar tablas existen:
```sql
USE onlinebookstore;
SHOW TABLES;
```

**Debe mostrar:**
- users
- authorities
- book
- book_detail
- customer
- shopping_cart
- payment
- etc.

---

## 🐛 DEBUGGING ADICIONAL

### 1. Revisar logs de la aplicación
Cuando intentas hacer login, revisa la consola de la aplicación. Debería mostrar:
```
=== LOGIN EXITOSO ===
Usuario: admin
Roles: [ROLE_ADMIN]
Redirigiendo a: /admin/dashboard
```

O si falla:
```
Sin rol válido, redirigiendo a login con error
```

### 2. Verificar que la base de datos existe
```sql
SHOW DATABASES LIKE 'onlinebookstore';
```

Si no existe, créala:
```sql
CREATE DATABASE onlinebookstore;
```

### 3. Verificar configuración en application.properties
```properties
spring.datasource.url=jdbc:mysql://localhost:3306/onlinebookstore
spring.datasource.username=root
spring.datasource.password=
```

Asegúrate que:
- MySQL esté corriendo en puerto 3306
- El usuario root tenga acceso
- La contraseña sea correcta (vacía en tu caso)

### 4. Generar nuevo hash de contraseña
Si quieres generar un hash nuevo, ejecuta:
```bash
# En la raíz del proyecto
cd src/test/java/com/shashirajraja/onlinebookstore/security
javac -cp ".:../../../../../../../../../lib/*" PasswordHashGenerator.java
java -cp ".:../../../../../../../../../lib/*" PasswordHashGenerator
```

O ejecuta el test desde tu IDE:
`PasswordHashGenerator.java` → Run

---

## 📝 Checklist de Verificación

- [ ] MySQL está corriendo
- [ ] Base de datos `onlinebookstore` existe
- [ ] Tablas `users` y `authorities` existen
- [ ] Usuario `admin` existe en tabla `users`
- [ ] Rol `ROLE_ADMIN` existe en tabla `authorities` para `admin`
- [ ] Password tiene el formato correcto: `{bcrypt}$2a$10$...`
- [ ] Campo `enabled` está en `1`
- [ ] La aplicación está corriendo en puerto 8080
- [ ] Accediendo a http://localhost:8080/login

---

## 🎯 PRUEBA FINAL

Una vez completados los pasos:

1. **Detén** la aplicación (Ctrl+C)
2. **Reinicia** la aplicación
3. **Navega** a: http://localhost:8080/login
4. **Ingresa:**
   - Usuario: `admin`
   - Contraseña: `admin123`
5. **Resultado esperado:** Serás redirigido a `/admin/dashboard`

---

## 💡 CONSEJO PRO

Si nada funciona, elimina COMPLETAMENTE la base de datos y déjala recrear:

```sql
DROP DATABASE IF EXISTS onlinebookstore;
CREATE DATABASE onlinebookstore;
```

Luego reinicia la aplicación. Spring Boot creará automáticamente todas las tablas y ejecutará `data.sql`.

---

## 📞 ¿Aún no funciona?

Si después de todos estos pasos sigues sin poder acceder:

1. Copia el mensaje de error EXACTO de la consola
2. Copia el resultado de:
   ```sql
   SELECT * FROM users WHERE username = 'admin';
   SELECT * FROM authorities WHERE username = 'admin';
   ```
3. Comparte esa información para un diagnóstico más específico

---

**Última actualización:** 25 de noviembre de 2025
