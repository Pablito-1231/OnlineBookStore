# 🔐 CREDENCIALES DE ACCESO - LIBRERÍA ONLINE

## 📋 Información de Acceso

### 🛡️ ADMINISTRADOR (ADMIN)
```
Usuario: admin
Contraseña: admin123
Rol: ROLE_ADMIN
URL de acceso: http://localhost:8080/login
```

**Redireccionamiento tras login:** `/admin/dashboard`

**Permisos:**
- Gestión completa de libros (agregar, editar, eliminar)
- Visualización de usuarios registrados
- Acceso a estadísticas del sistema
- Panel de control administrativo

---

### 👤 CLIENTE (CUSTOMER)
```
Usuario: customer
Contraseña: customer123
Rol: ROLE_CUSTOMER
URL de acceso: http://localhost:8080/login
```

**Redireccionamiento tras login:** `/customers`

**Permisos:**
- Ver catálogo de libros
- Agregar libros al carrito
- Realizar compras
- Ver historial de transacciones
- Actualizar perfil personal

---

## 🚀 Pasos para Iniciar Sesión

### Opción 1: Desde la aplicación
1. Ejecuta la aplicación Spring Boot
2. Abre tu navegador en: `http://localhost:8080`
3. Serás redirigido automáticamente a `/login`
4. Ingresa las credenciales según tu rol
5. Click en "Ingresar"

### Opción 2: Acceso directo
1. Navega a: `http://localhost:8080/login`
2. Ingresa usuario y contraseña
3. Click en "Ingresar"

---

## 🔧 Solución de Problemas

### ❌ No puedo iniciar sesión con admin

**Posibles causas y soluciones:**

1. **La base de datos no está inicializada**
   ```bash
   # Verifica que MySQL esté corriendo
   # La aplicación creará automáticamente las tablas y datos
   ```

2. **Las credenciales están mal escritas**
   ```
   ✅ Correcto: admin / admin123
   ❌ Incorrecto: Admin / admin123 (username es case-sensitive)
   ```

3. **La base de datos 'onlinebookstore' no existe**
   ```sql
   -- Crear la base de datos manualmente en MySQL:
   CREATE DATABASE IF NOT EXISTS onlinebookstore;
   ```

4. **Verificar que el data.sql se haya ejecutado**
   - Revisa los logs de la aplicación al iniciar
   - Debería mostrar: "Executing SQL script from file [data.sql]"
   - Verifica en MySQL:
   ```sql
   USE onlinebookstore;
   SELECT * FROM users;
   SELECT * FROM authorities;
   ```

5. **Password encoder no coincide**
   - El sistema usa bcrypt con el prefijo `{bcrypt}`
   - Si modificaste el password, asegúrate de usar el formato correcto
   - Hash actual de 'admin123': `{bcrypt}$2a$10$QtyKIBGFIv.fg1/TRsG6jeKOxyBo3thuRbp0WVYC0tBq3sytHoMV.`

---

## 🔍 Verificación Manual en MySQL

```sql
-- Conectar a MySQL
mysql -u root -p

-- Seleccionar base de datos
USE onlinebookstore;

-- Ver usuarios
SELECT * FROM users;

-- Ver autoridades (roles)
SELECT * FROM authorities;

-- Resultado esperado:
-- users:
-- | username | password                                           | enabled |
-- | admin    | {bcrypt}$2a$10$QtyKIBGFIv.fg1/TRsG6jeKOx... | 1       |
-- | customer | {bcrypt}$2a$10$QtyKIBGFIv.fg1/TRsG6jeKOx... | 1       |

-- authorities:
-- | username | authority      |
-- | admin    | ROLE_ADMIN     |
-- | customer | ROLE_CUSTOMER  |
```

---

## 📝 Datos de Configuración

### Base de Datos (application.properties)
```properties
spring.datasource.url=jdbc:mysql://localhost:3306/onlinebookstore
spring.datasource.username=root
spring.datasource.password=
spring.datasource.driver-class-name=com.mysql.cj.jdbc.Driver
```

### Puerto del Servidor
```properties
server.port=8080
```

### URLs Importantes
- **Login:** http://localhost:8080/login
- **Registro:** http://localhost:8080/register
- **Dashboard Admin:** http://localhost:8080/admin/dashboard
- **Home Cliente:** http://localhost:8080/customers
- **Catálogo:** http://localhost:8080/books
- **Carrito:** http://localhost:8080/customers/cart

---

## 🔒 Seguridad

### Roles y Permisos
```java
// Configuración en SecurityConfig.java
.antMatchers("/admin/**").hasRole("ADMIN")
.antMatchers("/customers/**").hasRole("CUSTOMER")
```

### Password Encoder
```java
// Usa DelegatingPasswordEncoder
// Soporta múltiples algoritmos con prefijos:
// {bcrypt}, {noop}, {pbkdf2}, etc.
```

---

## 📞 Contacto y Soporte

Si sigues teniendo problemas para acceder:

1. Revisa los logs de la aplicación en la consola
2. Verifica que MySQL esté corriendo en el puerto 3306
3. Confirma que la base de datos `onlinebookstore` existe
4. Verifica que las tablas `users` y `authorities` tengan datos
5. Comprueba que el archivo `data.sql` se haya ejecutado correctamente

---

## 🎯 Acceso Rápido de Prueba

### Login como Admin:
1. Navega a: http://localhost:8080/login
2. Usuario: `admin`
3. Contraseña: `admin123`
4. **Resultado:** Serás redirigido a `/admin/dashboard` con panel de control completo

### Login como Cliente:
1. Navega a: http://localhost:8080/login
2. Usuario: `customer`
3. Contraseña: `customer123`
4. **Resultado:** Serás redirigido a `/customers` con dashboard de cliente

---

**Última actualización:** 25 de noviembre de 2025
**Versión de la aplicación:** Spring Boot 2.7.18
**Java:** 21
