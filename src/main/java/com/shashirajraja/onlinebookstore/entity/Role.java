package com.shashirajraja.onlinebookstore.entity;

import jakarta.persistence.*;
import java.util.Objects;

@Entity
@Table(name = "roles")
public class Role {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "name", unique = true, nullable = false, length = 100)
    private String name;

    public Role() {}

    public Role(String name) { this.name = name; }

    public Long getId() { return id; }

    public String getName() { return name; }

    public void setName(String name) { this.name = name; }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (!(o instanceof Role)) return false;
        Role role = (Role) o;
        return Objects.equals(name.toLowerCase(), role.name.toLowerCase());
    }

    @Override
    public int hashCode() { return Objects.hash(name.toLowerCase()); }
}
