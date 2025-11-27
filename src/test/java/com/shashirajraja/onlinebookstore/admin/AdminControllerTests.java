package com.shashirajraja.onlinebookstore.admin;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.view;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.model;
import static org.hamcrest.Matchers.hasSize;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.security.test.context.support.WithMockUser;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.context.jdbc.Sql;
import static org.springframework.security.test.web.servlet.request.SecurityMockMvcRequestPostProcessors.csrf;

@SpringBootTest
@AutoConfigureMockMvc
@Sql(scripts = {"/cleanup.sql", "/data.sql"}, executionPhase = Sql.ExecutionPhase.BEFORE_TEST_METHOD)
public class AdminControllerTests {

    @Autowired
    private MockMvc mockMvc;

    @Test
    @WithMockUser(username = "admin", roles = {"ADMIN"})
    void librosJson_sortedPaged_available_size5() throws Exception {
        mockMvc.perform(get("/admin/libros.json")
                .param("stock", "available")
                .param("sort", "price")
                .param("order", "desc")
                .param("page", "0")
                .param("size", "5"))
            .andExpect(status().isOk())
            .andExpect(jsonPath("$", hasSize(5)));
    }

    @Test
    @WithMockUser(username = "admin", roles = {"ADMIN"})
    void libros_view_outofstock_ok() throws Exception {
        mockMvc.perform(get("/admin/libros")
                .param("stock", "out")
                .param("sort", "stock")
                .param("order", "asc")
                .param("page", "0")
                .param("size", "5"))
            .andExpect(status().isOk());
    }

    @Test
    @WithMockUser(username = "admin", roles = {"ADMIN"})
    void agregarLibro_validacion_nombre_obligatorio() throws Exception {
        mockMvc.perform(post("/admin/libros/add/process")
                .param("name", "")
                .param("price", "10.0")
                .param("quantity", "5")
                .param("bookDetail.type", "EBOOK")
                .with(csrf()))
            .andExpect(status().isOk())
            .andExpect(view().name("admin/libro-form"))
            .andExpect(model().attributeHasFieldErrors("book", "name"));
    }
}
