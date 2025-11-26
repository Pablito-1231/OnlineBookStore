package com.shashirajraja.onlinebookstore.controller;

import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.validation.BindingResult;
import javax.validation.Valid;

import com.shashirajraja.onlinebookstore.entity.Book;
import com.shashirajraja.onlinebookstore.entity.BookDetail;
import com.shashirajraja.onlinebookstore.entity.User;
import com.shashirajraja.onlinebookstore.dto.BookSummaryDto;
import com.shashirajraja.onlinebookstore.dto.UserSummaryDto;
import com.shashirajraja.onlinebookstore.dto.StatsDto;
import com.shashirajraja.onlinebookstore.service.BookService;
import com.shashirajraja.onlinebookstore.service.UserService;
import com.shashirajraja.onlinebookstore.utility.ValidationUtil;
import com.shashirajraja.onlinebookstore.dao.ShoppingCartRepository;

@Controller
@RequestMapping("/admin")
public class AdminController {
    
    @Autowired
    private com.shashirajraja.onlinebookstore.dao.AuthorityRepository authorityRepository;

    @Autowired
    private com.shashirajraja.onlinebookstore.dao.RoleRepository roleRepository;
    // ========== ROLES - LISTAR Y CREAR ==========
    @GetMapping("/roles")
    @PreAuthorize("hasRole('ADMIN')")
    public String listarRoles(Model model) {
        // Roles definidos (tabla roles)
        java.util.List<com.shashirajraja.onlinebookstore.entity.Role> definedRoles = roleRepository.findAll();
        // Authorities asignadas a usuarios
        java.util.List<com.shashirajraja.onlinebookstore.entity.Authority> allAuthorities = authorityRepository.findAll();
        java.util.Map<String, Long> counts = allAuthorities.stream()
                .collect(java.util.stream.Collectors.groupingBy(com.shashirajraja.onlinebookstore.entity.Authority::getRole, java.util.stream.Collectors.counting()));

        java.util.List<java.util.Map<String, Object>> rolesForView = new java.util.ArrayList<>();
        for (com.shashirajraja.onlinebookstore.entity.Role r : definedRoles) {
            java.util.Map<String, Object> map = new java.util.HashMap<>();
            map.put("name", r.getName());
            map.put("count", counts.getOrDefault(r.getName(), 0L));
            rolesForView.add(map);
        }
        rolesForView.sort(java.util.Comparator.comparing(m -> m.get("name").toString()));
        model.addAttribute("roles", rolesForView);
        return "admin/roles";
    }

    @PostMapping("/roles/add")
    @PreAuthorize("hasRole('ADMIN')")
    public String crearRol(@RequestParam("roleName") String roleName, Model model) {
        if (roleName == null || roleName.trim().isEmpty()) {
            model.addAttribute("message", "El nombre del rol no puede estar vacío.");
            return listarRoles(model);
        }
        boolean exists = roleRepository.findByNameIgnoreCase(roleName.trim()).isPresent();
        if (exists) {
            model.addAttribute("message", "El rol ya existe.");
            return listarRoles(model);
        }
        com.shashirajraja.onlinebookstore.entity.Role nuevo = new com.shashirajraja.onlinebookstore.entity.Role(roleName.trim());
        roleRepository.save(nuevo);
        model.addAttribute("message", "Rol creado exitosamente.");
        return listarRoles(model);
    }

    @Autowired
    private UserService userService;
    
    @Autowired
    private BookService bookService;

    @Autowired
    private ShoppingCartRepository shoppingCartRepository;

    // ========== DASHBOARD ==========
    @GetMapping("/dashboard")
    @PreAuthorize("hasRole('ADMIN')")
    public String adminDashboard(Model model) {
        Set<Book> allBooks = bookService.getAllBooks();
        long totalUsuarios = userService.getAllUsers().stream().count();
        long librosDisponibles = allBooks.stream().filter(b -> b.getQuantity() > 0).count();
        
        model.addAttribute("users", userService.getAllUsers());
        model.addAttribute("totalUsuarios", totalUsuarios);
        model.addAttribute("librosDisponibles", librosDisponibles);
        model.addAttribute("comprasTotales", 0); // Se puede implementar después con reportes
        return "admin/dashboard";
    }

    // ========== USUARIOS ==========
    @GetMapping("/usuarios")
    @PreAuthorize("hasRole('ADMIN')")
    public String adminUsuarios(Model model) {
        model.addAttribute("users", userService.getAllUsers());
        return "admin/usuarios";
    }

    // ========== LIBROS - LISTAR ==========
    @GetMapping("/libros")
    @PreAuthorize("hasRole('ADMIN')")
    public String listarLibros(
            @RequestParam(name = "stock", required = false) String stock,
            @RequestParam(name = "sort", required = false, defaultValue = "id") String sort,
            @RequestParam(name = "order", required = false, defaultValue = "asc") String order,
            @RequestParam(name = "page", required = false, defaultValue = "0") int page,
            @RequestParam(name = "size", required = false, defaultValue = "10") int size,
            Model model) {
        Set<Book> books = bookService.getAllBooks();
        List<Book> filtered = new ArrayList<>(books);

        if (stock != null) {
            String s = stock.toLowerCase();
            if ("available".equals(s) || "disponible".equals(s)) {
                filtered = filtered.stream().filter(b -> b.getQuantity() > 0).collect(Collectors.toList());
            } else if ("out".equals(s) || "agotado".equals(s)) {
                filtered = filtered.stream().filter(b -> b.getQuantity() == 0).collect(Collectors.toList());
            }
        }

        Comparator<Book> comparator;
        switch (sort.toLowerCase()) {
            case "name":
                comparator = Comparator.comparing(Book::getName, Comparator.nullsLast(String::compareToIgnoreCase));
                break;
            case "price":
                comparator = Comparator.comparing(Book::getPrice, Comparator.nullsLast(Double::compare));
                break;
            case "stock":
            case "quantity":
                comparator = Comparator.comparing(Book::getQuantity);
                break;
            case "type":
                comparator = Comparator.comparing(b -> b.getBookDetail() != null ? b.getBookDetail().getType() : "", String.CASE_INSENSITIVE_ORDER);
                break;
            case "id":
            default:
                comparator = Comparator.comparing(Book::getId);
        }
        if ("desc".equalsIgnoreCase(order)) {
            comparator = comparator.reversed();
        }
        filtered = filtered.stream().sorted(comparator).collect(Collectors.toList());

        int total = filtered.size();
        if (size <= 0) size = 10;
        int pageCount = (int) Math.ceil((double) total / size);
        if (page < 0) page = 0;
        if (page >= pageCount && pageCount > 0) page = pageCount - 1;
        int fromIndex = Math.min(page * size, total);
        int toIndex = Math.min(fromIndex + size, total);
        List<Book> pageItems = filtered.subList(fromIndex, toIndex);

        model.addAttribute("books", pageItems);
        model.addAttribute("totalLibros", total);
        // Contadores globales para tarjetas superiores
        long librosDisponibles = books.stream().filter(b -> b.getQuantity() > 0).count();
        long librosAgotados = books.stream().filter(b -> b.getQuantity() == 0).count();
        model.addAttribute("librosDisponibles", librosDisponibles);
        model.addAttribute("librosAgotados", librosAgotados);
        model.addAttribute("stockFilter", stock == null ? "all" : stock);
        model.addAttribute("sort", sort);
        model.addAttribute("order", order);
        model.addAttribute("page", page);
        model.addAttribute("size", size);
        model.addAttribute("pageCount", pageCount);
        return "admin/libros";
    }

    // ========== LIBROS - JSON LISTAR ==========
    @GetMapping("/libros.json")
    @ResponseBody
    public List<BookSummaryDto> listarLibrosJson(
            @RequestParam(name = "stock", required = false) String stock,
            @RequestParam(name = "sort", required = false, defaultValue = "id") String sort,
            @RequestParam(name = "order", required = false, defaultValue = "asc") String order,
            @RequestParam(name = "page", required = false, defaultValue = "0") int page,
            @RequestParam(name = "size", required = false, defaultValue = "10") int size) {
        Set<Book> books = bookService.getAllBooks();
        List<Book> filtered = new ArrayList<>(books);

        if (stock != null) {
            String s = stock.toLowerCase();
            if ("available".equals(s) || "disponible".equals(s)) {
                filtered = filtered.stream().filter(b -> b.getQuantity() > 0).collect(Collectors.toList());
            } else if ("out".equals(s) || "agotado".equals(s)) {
                filtered = filtered.stream().filter(b -> b.getQuantity() == 0).collect(Collectors.toList());
            }
        }

        Comparator<Book> comparator;
        switch (sort.toLowerCase()) {
            case "name":
                comparator = Comparator.comparing(Book::getName, Comparator.nullsLast(String::compareToIgnoreCase));
                break;
            case "price":
                comparator = Comparator.comparing(Book::getPrice, Comparator.nullsLast(Double::compare));
                break;
            case "stock":
            case "quantity":
                comparator = Comparator.comparing(Book::getQuantity);
                break;
            case "type":
                comparator = Comparator.comparing(b -> b.getBookDetail() != null ? b.getBookDetail().getType() : "", String.CASE_INSENSITIVE_ORDER);
                break;
            case "id":
            default:
                comparator = Comparator.comparing(Book::getId);
        }
        if ("desc".equalsIgnoreCase(order)) {
            comparator = comparator.reversed();
        }
        filtered = filtered.stream().sorted(comparator).collect(Collectors.toList());

        int total = filtered.size();
        if (size <= 0) size = 10;
        int pageCount = (int) Math.ceil((double) total / size);
        if (page < 0) page = 0;
        if (page >= pageCount && pageCount > 0) page = pageCount - 1;
        int fromIndex = Math.min(page * size, total);
        int toIndex = Math.min(fromIndex + size, total);
        List<Book> pageItems = filtered.subList(fromIndex, toIndex);

        return pageItems.stream()
                .map(b -> new BookSummaryDto(
                        b.getId(),
                        b.getName(),
                        b.getPrice(),
                        b.getQuantity(),
                        b.getBookDetail() != null ? b.getBookDetail().getType() : null))
                .collect(Collectors.toList());
    }

    // ========== LIBROS - FORMULARIO AGREGAR ==========
    @GetMapping("/libros/add")
    @PreAuthorize("hasRole('ADMIN')")
    public String formularioAgregarLibro(Model model) {
        model.addAttribute("book", new Book());
        model.addAttribute("bookDetail", new BookDetail());
        model.addAttribute("action", "add");
        return "admin/libro-form";
    }

    // ========== LIBROS - PROCESAR AGREGAR ==========
    @PostMapping("/libros/add/process")
    @PreAuthorize("hasRole('ADMIN')")
    public String procesarAgregarLibro(@Valid @ModelAttribute("book") Book book,
                                        BindingResult bookBindingResult,
                                        @RequestParam(value = "bookDetail.type", required = false) String type,
                                        @RequestParam(value = "bookDetail.detail", required = false) String detail,
                                        Model model) {
        try {
            // Validación Bean Validation
            if (bookBindingResult != null && bookBindingResult.hasErrors()) {
                model.addAttribute("message", "❌ Error: Revisa los campos del libro");
                model.addAttribute("messageType", "error");
                model.addAttribute("book", book);
                model.addAttribute("bookDetail", new BookDetail(type, detail, 0));
                model.addAttribute("action", "add");
                return "admin/libro-form";
            }
            // ========== VALIDACIONES ==========
            if (book.getName() == null || book.getName().trim().isEmpty()) {
                model.addAttribute("message", "❌ Error: El nombre del libro es obligatorio");
                model.addAttribute("messageType", "error");
                model.addAttribute("book", book);
                model.addAttribute("bookDetail", new BookDetail(type, detail, 0));
                model.addAttribute("action", "add");
                return "admin/libro-form";
            }
            
            if (!ValidationUtil.isValidPrice(book.getPrice())) {
                model.addAttribute("message", "❌ Error: El precio debe ser mayor a 0");
                model.addAttribute("messageType", "error");
                model.addAttribute("book", book);
                model.addAttribute("bookDetail", new BookDetail(type, detail, 0));
                model.addAttribute("action", "add");
                return "admin/libro-form";
            }
            
            if (!ValidationUtil.isValidQuantity(book.getQuantity())) {
                model.addAttribute("message", "❌ Error: La cantidad debe ser mayor o igual a 0");
                model.addAttribute("messageType", "error");
                model.addAttribute("book", book);
                model.addAttribute("bookDetail", new BookDetail(type, detail, 0));
                model.addAttribute("action", "add");
                return "admin/libro-form";
            }
            
            if (type == null || type.trim().isEmpty()) {
                type = "EBOOK";
            }
            if (detail == null) {
                detail = "No especificado";
            }
            
            BookDetail bookDetail = new BookDetail(type, detail, 0);
            book.setBookDetail(bookDetail);
            String message = bookService.addBook(book);
            model.addAttribute("message", "✅ " + message);
            model.addAttribute("messageType", "success");
        } catch (Exception e) {
            model.addAttribute("message", "❌ Error al agregar libro: " + e.getMessage());
            model.addAttribute("messageType", "error");
            model.addAttribute("book", book);
            model.addAttribute("bookDetail", new BookDetail(type, detail, 0));
            model.addAttribute("action", "add");
            return "admin/libro-form";
        }
        
        Set<Book> books = bookService.getAllBooks();
        model.addAttribute("books", books);
        model.addAttribute("totalLibros", books.size());
        long librosDisponibles = books.stream().filter(b -> b.getQuantity() > 0).count();
        long librosAgotados = books.stream().filter(b -> b.getQuantity() == 0).count();
        model.addAttribute("librosDisponibles", librosDisponibles);
        model.addAttribute("librosAgotados", librosAgotados);
        return "admin/libros";
    }

    // ========== LIBROS - FORMULARIO EDITAR ==========
    @GetMapping("/libros/edit")
    @PreAuthorize("hasRole('ADMIN')")
    public String formularioEditarLibro(@RequestParam("id") int bookId, Model model) {
        Book book = bookService.getBookById(bookId);
        if (book == null) {
            model.addAttribute("message", "Libro no encontrado");
            model.addAttribute("messageType", "error");
            return "redirect:/admin/libros";
        }
        model.addAttribute("book", book);
        model.addAttribute("bookDetail", book.getBookDetail() != null ? book.getBookDetail() : new BookDetail());
        model.addAttribute("action", "edit");
        return "admin/libro-form";
    }

    // ========== LIBROS - PROCESAR EDITAR ==========
    @PostMapping("/libros/edit/process")
    @PreAuthorize("hasRole('ADMIN')")
    public String procesarEditarLibro(@Valid @ModelAttribute("book") Book book,
                                       BindingResult bookBindingResult,
                                       @RequestParam(value = "bookDetail.type", required = false) String type,
                                       @RequestParam(value = "bookDetail.detail", required = false) String detail,
                                       Model model) {
        try {
            Book existingBook = bookService.getBookById(book.getId());
            if (existingBook == null) {
                model.addAttribute("message", "❌ Error: Libro no encontrado");
                model.addAttribute("messageType", "error");
                return "redirect:/admin/libros";
            }
            // Validación Bean Validation
            if (bookBindingResult != null && bookBindingResult.hasErrors()) {
                model.addAttribute("message", "❌ Error: Revisa los campos del libro");
                model.addAttribute("messageType", "error");
                model.addAttribute("book", book);
                model.addAttribute("bookDetail", new BookDetail(type, detail, 0));
                model.addAttribute("action", "edit");
                return "admin/libro-form";
            }
            
            // ========== VALIDACIONES ==========
            if (book.getName() == null || book.getName().trim().isEmpty()) {
                model.addAttribute("message", "❌ Error: El nombre del libro es obligatorio");
                model.addAttribute("messageType", "error");
                model.addAttribute("book", book);
                model.addAttribute("bookDetail", new BookDetail(type, detail, 0));
                model.addAttribute("action", "edit");
                return "admin/libro-form";
            }
            
            if (!ValidationUtil.isValidPrice(book.getPrice())) {
                model.addAttribute("message", "❌ Error: El precio debe ser mayor a 0");
                model.addAttribute("messageType", "error");
                model.addAttribute("book", book);
                model.addAttribute("bookDetail", new BookDetail(type, detail, 0));
                model.addAttribute("action", "edit");
                return "admin/libro-form";
            }
            
            if (!ValidationUtil.isValidQuantity(book.getQuantity())) {
                model.addAttribute("message", "❌ Error: La cantidad debe ser mayor o igual a 0");
                model.addAttribute("messageType", "error");
                model.addAttribute("book", book);
                model.addAttribute("bookDetail", new BookDetail(type, detail, 0));
                model.addAttribute("action", "edit");
                return "admin/libro-form";
            }
            
            existingBook.setName(book.getName());
            existingBook.setPrice(book.getPrice());
            existingBook.setQuantity(book.getQuantity());
            
            if (existingBook.getBookDetail() != null && type != null) {
                existingBook.getBookDetail().setType(type);
                existingBook.getBookDetail().setDetail(detail != null ? detail : "");
            } else if (type != null) {
                existingBook.setBookDetail(new BookDetail(type, detail != null ? detail : "", 0));
            }
            
            String message = bookService.updateBook(existingBook);
            model.addAttribute("message", "✅ " + message);
            model.addAttribute("messageType", "success");
        } catch (Exception e) {
            model.addAttribute("message", "❌ Error al editar libro: " + e.getMessage());
            model.addAttribute("messageType", "error");
            model.addAttribute("book", book);
            model.addAttribute("bookDetail", new BookDetail(type, detail, 0));
            model.addAttribute("action", "edit");
            return "admin/libro-form";
        }
        
        Set<Book> books = bookService.getAllBooks();
        model.addAttribute("books", books);
        model.addAttribute("totalLibros", books.size());
        return "admin/libros";
    }

    // ========== LIBROS - ELIMINAR ==========
    @GetMapping("/libros/delete")
    @PreAuthorize("hasRole('ADMIN')")
    public String eliminarLibro(@RequestParam("id") int bookId, Model model) {
        Book book = bookService.getBookById(bookId);
        if (book == null) {
            model.addAttribute("message", "❌ Error: Libro no encontrado");
            model.addAttribute("messageType", "error");
        } else {
            try {
                // Impedir eliminar si el libro está en algún carrito
                if (!shoppingCartRepository.getItemsByBook(book).isEmpty()) {
                    model.addAttribute("message", "❌ No se puede eliminar: el libro está presente en carritos");
                    model.addAttribute("messageType", "error");
                } else {
                    String message = bookService.removeBookById(bookId);
                    model.addAttribute("message", message);
                    model.addAttribute("messageType", "success");
                }
            } catch (Exception e) {
                model.addAttribute("message", "❌ Error al eliminar libro: " + e.getMessage());
                model.addAttribute("messageType", "error");
            }
        }

        Set<Book> books = bookService.getAllBooks();
        model.addAttribute("books", books);
        model.addAttribute("totalLibros", books.size());
        return "admin/libros";
    }

    // ========== ESTADÍSTICAS ==========
    @GetMapping("/estadisticas")
    @PreAuthorize("hasRole('ADMIN')")
    public String estadisticas(Model model, javax.servlet.http.HttpServletResponse response) {
        // Desactivar cache
        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
        response.setHeader("Pragma", "no-cache");
        response.setHeader("Expires", "0");
        
        Set<Book> allBooks = bookService.getAllBooks();
        
        long totalLibros = allBooks.size();
        long librosDisponibles = allBooks.stream().filter(b -> b.getQuantity() > 0).count();
        long librosAgotados = allBooks.stream().filter(b -> b.getQuantity() == 0).count();
        long totalUsuarios = userService.getAllUsers().stream().count();
        
        // Debug: imprimir valores
        System.out.println("=== ESTADÍSTICAS DEBUG ===");
        System.out.println("Total libros: " + totalLibros);
        System.out.println("Disponibles: " + librosDisponibles);
        System.out.println("Agotados: " + librosAgotados);
        
        model.addAttribute("totalLibros", totalLibros);
        model.addAttribute("librosDisponibles", librosDisponibles);
        model.addAttribute("librosAgotados", librosAgotados);
        model.addAttribute("totalUsuarios", totalUsuarios);
        
        return "admin/estadisticas";
    }

    // ========== USUARIOS - FORMULARIO EDITAR ==========
    @GetMapping("/usuarios/edit")
    @PreAuthorize("hasRole('ADMIN')")
    public String formularioEditarUsuario(@RequestParam("username") String username, Model model) {
        User user = userService.getUserByUsername(username);
        if (user == null) {
            model.addAttribute("message", "❌ Usuario no encontrado");
            model.addAttribute("messageType", "error");
            return "redirect:/admin/usuarios";
        }
        model.addAttribute("user", user);
        model.addAttribute("action", "edit");
        return "admin/usuario-form";
    }

    // ========== USUARIOS - PROCESAR EDITAR ==========
    @PostMapping("/usuarios/edit/process")
    @PreAuthorize("hasRole('ADMIN')")
    public String procesarEditarUsuario(
            @RequestParam("username") String username,
            @RequestParam(value = "newUsername", required = false) String newUsername,
            @RequestParam(value = "enabled", required = false, defaultValue = "false") boolean enabled,
            @RequestParam(value = "role", required = false) String role,
            @RequestParam(value = "firstName", required = false) String firstName,
            @RequestParam(value = "lastName", required = false) String lastName,
            @RequestParam(value = "email", required = false) String email,
            Model model) {
        try {
            User user = userService.getUserByUsername(username);
            if (user == null) {
                model.addAttribute("message", "❌ Error: Usuario no encontrado");
                model.addAttribute("messageType", "error");
                return "redirect:/admin/usuarios";
            }
            if ("admin".equals(username)) {
                model.addAttribute("message", "No se permite modificar el usuario administrador principal.");
                model.addAttribute("messageType", "error");
            } else {
                // Actualizar campos editables (NO el username que es PK)
                user.setEnabled(enabled);
                if (user.getCustomer() != null) {
                    if (firstName != null) user.getCustomer().setFirstName(firstName);
                    if (lastName != null) user.getCustomer().setLastName(lastName);
                    if (email != null) user.getCustomer().setEmail(email);
                }
                // Actualizar solo campos básicos (sin authorities)
                String message = userService.updateUser(user);
                
                // Cambiar rol principal después de actualizar el usuario (operación separada)
                if (role != null && !role.isEmpty()) {
                    // Recargar user desde BD para tener estado fresco
                    User freshUser = userService.getUserByUsername(username);
                    java.util.List<com.shashirajraja.onlinebookstore.entity.Authority> currentAuthorities = 
                        authorityRepository.findByUser(freshUser);
                    
                    if (!currentAuthorities.isEmpty()) {
                        String currentRole = currentAuthorities.get(0).getRole();
                        if (!currentRole.equals(role)) {
                            // Eliminar authority actual
                            authorityRepository.deleteAll(currentAuthorities);
                            authorityRepository.flush();
                            // Crear nueva authority con el nuevo rol
                            com.shashirajraja.onlinebookstore.entity.Authority newAuth =
                                    new com.shashirajraja.onlinebookstore.entity.Authority(freshUser, role);
                            authorityRepository.save(newAuth);
                        }
                    } else {
                        // Crear primera authority si no existe ninguna
                        com.shashirajraja.onlinebookstore.entity.Authority newAuth =
                                new com.shashirajraja.onlinebookstore.entity.Authority(freshUser, role);
                        authorityRepository.save(newAuth);
                    }
                }
                if (message.startsWith("Error")) {
                    model.addAttribute("message", "❌ " + message);
                    model.addAttribute("messageType", "error");
                } else {
                    model.addAttribute("message", message);
                    model.addAttribute("messageType", "success");
                }
            }
        } catch (Exception e) {
            model.addAttribute("message", "❌ Error al editar usuario: " + e.getMessage());
            model.addAttribute("messageType", "error");
        }
        model.addAttribute("users", userService.getAllUsers());
        return "admin/usuarios";
    }

    // ========== USUARIOS - TOGGLE ENABLED ==========
    @GetMapping("/usuarios/toggle")
    @PreAuthorize("hasRole('ADMIN')")
    public String toggleUsuario(@RequestParam("username") String username, Model model) {
        try {
            String message = userService.toggleUserEnabled(username);
            
            if (message.startsWith("Error")) {
                model.addAttribute("message", "❌ " + message);
                model.addAttribute("messageType", "error");
            } else {
                model.addAttribute("message", message);
                model.addAttribute("messageType", "success");
            }
        } catch (Exception e) {
            model.addAttribute("message", "❌ Error al cambiar estado: " + e.getMessage());
            model.addAttribute("messageType", "error");
        }
        
        model.addAttribute("users", userService.getAllUsers());
        return "admin/usuarios";
    }

    // ========== USUARIOS - ELIMINAR ==========
    @GetMapping("/usuarios/delete")
    @PreAuthorize("hasRole('ADMIN')")
    public String eliminarUsuario(@RequestParam("username") String username, Model model) {
        try {
            String message = userService.deleteUser(username);
            
            if (message.startsWith("Error")) {
                model.addAttribute("message", "❌ " + message);
                model.addAttribute("messageType", "error");
            } else {
                model.addAttribute("message", message);
                model.addAttribute("messageType", "success");
            }
        } catch (Exception e) {
            model.addAttribute("message", "❌ Error al eliminar usuario: " + e.getMessage());
            model.addAttribute("messageType", "error");
        }
        
        model.addAttribute("users", userService.getAllUsers());
        return "admin/usuarios";
    }

    // ========== USUARIOS - JSON ==========
    @GetMapping("/usuarios.json")
    @ResponseBody
    @PreAuthorize("hasRole('ADMIN')")
        public List<UserSummaryDto> usuariosJson() {
        return userService.getAllUsers().stream()
            .map(u -> new UserSummaryDto(
                u.getUsername(),
                (u.getAuthorities() != null && !u.getAuthorities().isEmpty()) ? u.getAuthorities().get(0).getRole() : null,
                u.isEnabled()))
            .collect(Collectors.toList());
        }

    // ========== ESTADÍSTICAS - JSON ==========
    @GetMapping("/stats.json")
    @ResponseBody
    @PreAuthorize("hasRole('ADMIN')")
    public StatsDto estadisticasJson() {
        Set<Book> allBooks = bookService.getAllBooks();
        long totalLibros = allBooks.size();
        long librosDisponibles = allBooks.stream().filter(b -> b.getQuantity() > 0).count();
        long librosAgotados = allBooks.stream().filter(b -> b.getQuantity() == 0).count();
        long totalUsuarios = userService.getAllUsers().stream().count();
        return new StatsDto(totalLibros, librosDisponibles, librosAgotados, totalUsuarios);
    }
}