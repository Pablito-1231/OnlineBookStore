package com.shashirajraja.onlinebookstore.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/internal")
public class InternalAdminController {

    @Autowired
    private JdbcTemplate jdbc;

    // Endpoint temporal para ejecutar la limpieza de usuarios de prueba.
    @PostMapping("/cleanup-test-users")
    public Map<String, Object> cleanupTestUsers() {
        String[] users = new String[] {"prueba_auto","prueba1","testuser1"};
        Map<String, Object> result = new HashMap<>();
        try {
            // Reportar conteos antes
            result.put("users_before", jdbc.queryForObject(
                    "select count(*) from users where username in ('prueba_auto','prueba1','testuser1')", Integer.class));

            // Borrar purchase_detail por purchase_history
            jdbc.update("DELETE pd FROM purchase_detail pd JOIN purchase_history ph ON pd.purchase_history_id = ph.id WHERE ph.customer_id IN ('prueba_auto','prueba1','testuser1')");
            jdbc.update("DELETE FROM purchase_history WHERE customer_id IN ('prueba_auto','prueba1','testuser1')");

            jdbc.update("DELETE FROM shopping_cart WHERE customer_id IN ('prueba_auto','prueba1','testuser1')");
            jdbc.update("DELETE FROM book_user WHERE customer_id IN ('prueba_auto','prueba1','testuser1')");

            jdbc.update("DELETE FROM authorities WHERE username IN ('prueba_auto','prueba1','testuser1')");
            jdbc.update("DELETE FROM users WHERE username IN ('prueba_auto','prueba1','testuser1')");
            jdbc.update("DELETE FROM customer WHERE id IN ('prueba_auto','prueba1','testuser1')");

            result.put("users_after", jdbc.queryForObject(
                    "select count(*) from users where username in ('prueba_auto','prueba1','testuser1')", Integer.class));
            result.put("status", "ok");
        } catch (Exception e) {
            result.put("status", "error");
            result.put("message", e.getMessage());
        }
        return result;
    }
}
