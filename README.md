# 📚 OnlineBookStore - Tienda de Libros Online

Sistema completo de comercio electrónico para la venta de libros en línea, desarrollado con Spring Boot y tecnologías modernas.

## 🚀 Características Principales

### Para Clientes
- 📖 Catálogo de libros con múltiples formatos (E-Book, Tapa Blanda, Tapa Dura, Audiolibro)
- 🛒 Carrito de compras interactivo
- 💳 Sistema de pagos integrado
- 📧 Notificaciones por email
- 👤 Gestión de perfil y contraseñas
- 📜 Historial de compras y transacciones

### Para Administradores
- 📊 Dashboard con estadísticas en tiempo real
- 📚 Gestión completa de libros (CRUD)
- 👥 Administración de usuarios
- 📈 Reportes y análisis de ventas
- 🎨 Interfaz moderna y responsive
- 📋 Filtros y ordenamiento avanzado

## 🛠️ Tecnologías

### Backend
- **Java 21**
- **Spring Boot 2.7.18**
  - Spring MVC
  - Spring Security
  - Spring Data JPA
  - Spring Mail
- **MySQL 8.0.33**
- **Maven** - Gestión de dependencias

### Frontend
- **JSP** con JSTL
- **Bootstrap 5.3.0**
- **Font Awesome 6.0.0**
- **CSS3** personalizado
- **JavaScript** vanilla

### Seguridad
- Autenticación basada en roles (ADMIN, CUSTOMER, PROVIDER)
- Protección CSRF
- Encriptación de contraseñas con BCrypt
- Variables de entorno para credenciales sensibles

## 📋 Requisitos Previos

- Java JDK 21+
- MySQL 8.0+
- Maven 3.6+
- Servidor SMTP (Gmail configurado)

## ⚙️ Instalación

### 1. Clonar el repositorio
```bash
git clone https://github.com/Pablito-1231/OnlineBookStore.git
cd OnlineBookStore
```

### 2. Configurar la base de datos
```sql
CREATE DATABASE onlinebookstore;
```

### 3. Configurar variables de entorno
Copia el archivo `.env.example` y crea tu propio `.env`:
```bash
cp .env.example .env
```

Edita `.env` con tus credenciales:
```properties
DB_URL=jdbc:mysql://localhost:3306/onlinebookstore
DB_USERNAME=root
DB_PASSWORD=tu_password

MAIL_USERNAME=tu_email@gmail.com
MAIL_PASSWORD=tu_app_password
```

### 4. Compilar y ejecutar
```bash
mvn clean install
mvn spring-boot:run
```

La aplicación estará disponible en: `http://localhost:8080/OnlineBookStore`

## 📁 Estructura del Proyecto

```
OnlineBookStore/
├── src/main/
│   ├── java/com/shashirajraja/onlinebookstore/
│   │   ├── controller/      # Controladores MVC
│   │   ├── service/         # Lógica de negocio
│   │   ├── dao/             # Repositorios JPA
│   │   ├── entity/          # Entidades JPA
│   │   ├── security/        # Configuración de seguridad
│   │   ├── dto/             # Data Transfer Objects
│   │   └── exception/       # Manejo de excepciones
│   ├── resources/
│   │   ├── application.properties
│   │   ├── data.sql         # Datos iniciales
│   │   └── static/          # CSS, JS, imágenes
│   └── webapp/WEB-INF/view/ # Vistas JSP
│       ├── admin/           # Panel de administración
│       └── customer/        # Vistas de cliente
└── src/test/                # Tests unitarios e integración
```

## 👥 Roles y Permisos

### ADMIN
- Acceso completo al panel de administración
- Gestión de libros, usuarios y estadísticas
- Acceso a reportes y análisis

### CUSTOMER
- Navegación del catálogo
- Compra de libros
- Gestión de perfil personal

### PROVIDER
- Acceso básico al sistema
- Gestión de inventario (futuro)

## 🔐 Seguridad

- Las credenciales sensibles están en variables de entorno
- Contraseñas hasheadas con BCrypt
- Protección CSRF en todos los formularios
- Sesiones seguras con Spring Security
- Validación de datos en frontend y backend

## 📧 Configuración de Email

El sistema utiliza Gmail SMTP para notificaciones. Necesitas:

1. Cuenta de Gmail
2. Contraseña de aplicación (App Password)
3. Configurar en `.env`:
   ```
   MAIL_USERNAME=tu_email@gmail.com
   MAIL_PASSWORD=xxxx xxxx xxxx xxxx
   ```

## 🎨 Características de UI

- Diseño moderno y responsive
- Animaciones suaves (optimizadas para UX)
- Sidebar unificado en panel admin
- Cards interactivas para libros
- Badges informativos de estado
- Filtros y ordenamiento en tiempo real
- Mensajes de confirmación con emojis

## 📊 Base de Datos

### Tablas Principales
- `users` - Usuarios del sistema
- `authorities` - Roles y permisos
- `customer` - Información de clientes
- `book` - Catálogo de libros
- `book_detail` - Detalles adicionales
- `shopping_cart` - Carritos de compra
- `purchase_history` - Historial de compras
- `purchase_detail` - Detalles de transacciones

## 🚀 Despliegue

### Producción
1. Compilar el proyecto:
   ```bash
   mvn clean package
   ```

2. El archivo WAR estará en: `target/OnlineBookStore-0.0.1-SNAPSHOT.war`

3. Desplegar en servidor Tomcat o similar

### Túnel de desarrollo (ngrok)
```bash
ngrok http 8080
```

## 🧪 Testing

Ejecutar todos los tests:
```bash
mvn test
```

Tests incluidos:
- Tests unitarios de servicios
- Tests de integración de repositorios
- Tests de email
- Tests de estadísticas

## 📝 Notas de Desarrollo

- Spring Boot 2.7.18 (EOL pero funcional)
- Java 21 como target de compilación
- MySQL sin contraseña en desarrollo (cambiar en producción)
- Puerto por defecto: 8080
- Context path: /OnlineBookStore

## 🔄 Estado del Proyecto

**Versión**: 0.0.1-SNAPSHOT  
**Última actualización**: Noviembre 2025  
**Estado**: ✅ Desarrollo Activo

### Completado
- ✅ Sistema de autenticación y autorización
- ✅ CRUD completo de libros
- ✅ Gestión de usuarios
- ✅ Carrito de compras funcional
- ✅ Sistema de pagos
- ✅ Notificaciones por email
- ✅ Panel administrativo moderno
- ✅ Base de datos optimizada

### En Desarrollo
- 🔨 Reportes avanzados
- 🔨 Sistema de reseñas
- 🔨 Recomendaciones personalizadas
- 🔨 API REST completa

## 📄 Licencia

Este proyecto es parte de un proyecto educativo/empresarial.

## 👨‍💻 Autor

**Pablo Barrera**
- GitHub: [@Pablito-1231](https://github.com/Pablito-1231)

## 🤝 Contribuciones

Las contribuciones son bienvenidas. Por favor:
1. Fork el proyecto
2. Crea una rama para tu feature (`git checkout -b feature/AmazingFeature`)
3. Commit tus cambios (`git commit -m 'Add some AmazingFeature'`)
4. Push a la rama (`git push origin feature/AmazingFeature`)
5. Abre un Pull Request

## 📞 Soporte

Para reportar problemas o sugerencias:
- 📧 Email: libreriarefugioliterario8@gmail.com
- 🐛 Issues: [GitHub Issues](https://github.com/Pablito-1231/OnlineBookStore/issues)

---

⭐ Si este proyecto te fue útil, no olvides darle una estrella en GitHub!
