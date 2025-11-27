package com.shashirajraja.onlinebookstore.dao;

import static org.junit.jupiter.api.Assertions.assertEquals;

import java.util.List;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.orm.jpa.DataJpaTest;
import org.springframework.boot.test.autoconfigure.jdbc.AutoConfigureTestDatabase;
import org.springframework.test.context.ActiveProfiles;
import org.springframework.transaction.annotation.Transactional;

import com.shashirajraja.onlinebookstore.entity.Authority;
import com.shashirajraja.onlinebookstore.entity.User;

@DataJpaTest
@AutoConfigureTestDatabase(replace = AutoConfigureTestDatabase.Replace.NONE)
@ActiveProfiles("test-mysql")
public class UserAuthorityCascadeTest {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private AuthorityRepository authorityRepository;

    @Test
    @Transactional
    public void deleteUserShouldRemoveAuthorities() {
        String username = "test_cascade_user";

        // Clean up any previous
        authorityRepository.deleteByUsername(username);
        userRepository.deleteById(username);

        User user = new User(username, "password");
        Authority auth = new Authority(user, "ROLE_CUSTOMER");
        user.addAuthority(auth);

        userRepository.saveAndFlush(user);

        List<Authority> before = authorityRepository.findByUser(user);
        assertEquals(1, before.size(), "Authorities should exist after save");

        // Delete user via JPA
        userRepository.delete(user);
        userRepository.flush();

        List<Authority> after = authorityRepository.findByUser(user);
        assertEquals(0, after.size(), "Authorities should be removed after deleting user");
    }
}
