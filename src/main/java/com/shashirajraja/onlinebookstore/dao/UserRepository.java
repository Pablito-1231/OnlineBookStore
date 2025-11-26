package com.shashirajraja.onlinebookstore.dao;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.shashirajraja.onlinebookstore.entity.User;

@Repository
public interface UserRepository extends JpaRepository<User, String> {

}
