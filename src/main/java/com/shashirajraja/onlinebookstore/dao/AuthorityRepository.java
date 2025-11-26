package com.shashirajraja.onlinebookstore.dao;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.shashirajraja.onlinebookstore.entity.Authority;
import com.shashirajraja.onlinebookstore.entity.AuthorityId;

@Repository
public interface AuthorityRepository extends JpaRepository<Authority, AuthorityId> {
    java.util.List<Authority> findByUser(com.shashirajraja.onlinebookstore.entity.User user);
    
    @Modifying
    @Query(value = "DELETE FROM authorities WHERE username = :username", nativeQuery = true)
    int deleteByUsername(@Param("username") String username);
}
