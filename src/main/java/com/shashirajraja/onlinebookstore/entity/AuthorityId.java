package com.shashirajraja.onlinebookstore.entity;

import java.io.Serializable;
import java.util.Objects;

/**
 * IdClass para la entidad Authority.
 * Use los tipos de PK: user -> String (username), role -> String
 */
public class AuthorityId implements Serializable {

    private static final long serialVersionUID = 1L;

    // nombre debe coincidir con la propiedad @Id en Authority (user)
    private String user;
    private String role;

    public AuthorityId() {
    }

    public AuthorityId(String user, String role) {
        this.user = user;
        this.role = role;
    }

    public String getUser() {
        return user;
    }

    public void setUser(String user) {
        this.user = user;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        AuthorityId that = (AuthorityId) o;
        return Objects.equals(user, that.user) && Objects.equals(role, that.role);
    }

    @Override
    public int hashCode() {
        return Objects.hash(user, role);
    }

    @Override
    public String toString() {
        return "AuthorityId{" +
                "user='" + user + '\'' +
                ", role='" + role + '\'' +
                '}';
    }
}
