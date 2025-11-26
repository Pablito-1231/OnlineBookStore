package com.shashirajraja.onlinebookstore.dao;

import com.shashirajraja.onlinebookstore.entity.Role;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface RoleRepository extends JpaRepository<Role, Long> {
    Optional<Role> findByNameIgnoreCase(String name);
}
