import java.sql.*;
public class CreateDb {
    public static void main(String[] args) {
        String url = "jdbc:mysql://localhost:3306/?useSSL=false&serverTimezone=UTC";
        String user = "root";
        String pass = "";
        String sql = "CREATE DATABASE IF NOT EXISTS onlinebookstore CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci";
        try (Connection c = DriverManager.getConnection(url, user, pass);
             Statement s = c.createStatement()) {
            s.executeUpdate(sql);
            System.out.println("Database created or already exists: onlinebookstore");
        } catch (SQLException e) {
            System.err.println("ERROR creating database: " + e.getMessage());
            e.printStackTrace();
            System.exit(1);
        }
    }
}
