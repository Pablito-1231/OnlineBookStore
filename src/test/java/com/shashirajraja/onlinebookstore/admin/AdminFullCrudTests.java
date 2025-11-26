package com.shashirajraja.onlinebookstore.admin;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.view;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.model;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;
import static org.hamcrest.Matchers.hasSize;
import static org.hamcrest.Matchers.containsString;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.security.test.context.support.WithMockUser;
import org.springframework.test.web.servlet.MockMvc;
import static org.springframework.security.test.web.servlet.request.SecurityMockMvcRequestPostProcessors.csrf;

@SpringBootTest
@AutoConfigureMockMvc
public class AdminFullCrudTests {

    @Autowired
    private MockMvc mockMvc;

    // --- Libros ---
    @Test
    @WithMockUser(username = "admin", roles = {"ADMIN"})
    void agregarLibro_valido() throws Exception {
        mockMvc.perform(post("/admin/libros/add/process")
                .param("name", "Nuevo Libro")
                .param("price", "25.0")
                .param("quantity", "10")
                .param("bookDetail.type", "EBOOK")
                .param("bookDetail.detail", "Prueba")
                .with(csrf()))
            .andExpect(status().isOk())
            .andExpect(view().name("admin/libros"));
    }

    @Test
    @WithMockUser(username = "admin", roles = {"ADMIN"})
    void editarLibro_valido() throws Exception {
        mockMvc.perform(post("/admin/libros/edit/process")
                .param("id", "1")
                .param("name", "Libro Editado")
                .param("price", "30.0")
                .param("quantity", "5")
                .param("bookDetail.type", "EBOOK")
                .param("bookDetail.detail", "Editado")
                .with(csrf()))
            .andExpect(status().isOk())
            .andExpect(view().name("admin/libros"));
    }

    @Test
    @WithMockUser(username = "admin", roles = {"ADMIN"})
    void eliminarLibro_permitido() throws Exception {
        mockMvc.perform(get("/admin/libros/delete").param("id", "2"))
            .andExpect(status().isOk())
            .andExpect(view().name("admin/libros"));
    }

    // --- Usuarios ---
    @Test
    @WithMockUser(username = "admin", roles = {"ADMIN"})
    void listarUsuarios() throws Exception {
        mockMvc.perform(get("/admin/usuarios"))
            .andExpect(status().isOk())
            .andExpect(view().name("admin/usuarios"));
    }

    @Test
    @WithMockUser(username = "admin", roles = {"ADMIN"})
    void editarUsuario_valido() throws Exception {
        int status = mockMvc.perform(post("/admin/usuarios/edit/process")
                .param("username", "cliente1")
                .param("enabled", "true")
                .param("role", "ROLE_CUSTOMER")
                .param("firstName", "Juan")
                .param("lastName", "Pérez")
                .param("email", "juan@example.com")
                .with(csrf()))
            .andReturn().getResponse().getStatus();
        // Acepta 200 OK o 302 redirect
        org.junit.jupiter.api.Assertions.assertTrue(status == 200 || status == 302);
    }

    @Test
    @WithMockUser(username = "admin", roles = {"ADMIN"})
    void eliminarUsuario() throws Exception {
        mockMvc.perform(get("/admin/usuarios/delete").param("username", "cliente2"))
            .andExpect(status().isOk())
            .andExpect(view().name("admin/usuarios"));
    }

    @Test
    @WithMockUser(username = "admin", roles = {"ADMIN"})
    void toggleUsuario() throws Exception {
        mockMvc.perform(get("/admin/usuarios/toggle").param("username", "cliente3"))
            .andExpect(status().isOk())
            .andExpect(view().name("admin/usuarios"));
    }

    // --- Roles ---
    @Test
    @WithMockUser(username = "admin", roles = {"ADMIN"})
    void crearRol_valido() throws Exception {
        mockMvc.perform(post("/admin/roles/add")
                .param("roleName", "ROLE_TEST")
                .with(csrf()))
            .andExpect(status().isOk())
            .andExpect(view().name("admin/roles"));
    }

    @Test
    @WithMockUser(username = "admin", roles = {"ADMIN"})
    void crearRol_duplicado() throws Exception {
        mockMvc.perform(post("/admin/roles/add")
                .param("roleName", "ROLE_ADMIN")
                .with(csrf()))
            .andExpect(status().isOk())
            .andExpect(view().name("admin/roles"))
            .andExpect(model().attributeExists("message"));
    }

    @Test
    @WithMockUser(username = "admin", roles = {"ADMIN"})
    void crearRol_vacio() throws Exception {
        mockMvc.perform(post("/admin/roles/add")
                .param("roleName", "")
                .with(csrf()))
            .andExpect(status().isOk())
            .andExpect(view().name("admin/roles"))
            .andExpect(model().attributeExists("message"));
    }

    @Test
    @WithMockUser(username = "admin", roles = {"ADMIN"})
    void listarRoles() throws Exception {
        mockMvc.perform(get("/admin/roles"))
            .andExpect(status().isOk())
            .andExpect(view().name("admin/roles"));
    }
}
