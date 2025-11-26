package com.shashirajraja.onlinebookstore.entity;

import java.io.Serial;
import java.io.Serializable;
import java.util.Objects;

/**
 * IdClass para la entidad Authority.
 * Debe coincidir en nombres y tipos con los campos @Id de Authority
 * y proveer equals/hashCode consistentes.
 */
public class AuthorityId implements Serializable {

    @Serial
    private static final long serialVersionUID = 1L;

	// Deben llamarse exactamente como en la entidad y con el mismo tipo
	private User user;
	private String role;

	public AuthorityId() {
	}

	public AuthorityId(User user, String role) {
		this.user = user;
		this.role = role;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
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
		String thisUsername = this.user != null ? this.user.getUsername() : null;
		String thatUsername = that.user != null ? that.user.getUsername() : null;
		return Objects.equals(thisUsername, thatUsername) && Objects.equals(role, that.role);
	}

	@Override
	public int hashCode() {
		String username = this.user != null ? this.user.getUsername() : null;
		return Objects.hash(username, role);
	}

	@Override
	public String toString() {
		String username = this.user != null ? this.user.getUsername() : null;
		return "AuthorityId{" +
				"user=" + username +
				", role='" + role + '\'' +
				'}';
	}
}
