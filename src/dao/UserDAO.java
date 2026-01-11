package dao;

import model.User;
import util.DBUtil;
import util.PasswordUtil;

import java.sql.*;

public class UserDAO {

//The method for user to registration
    public boolean register(User user) {
        String sql = "INSERT INTO users (username, password, role) VALUES (?, ?, ?)";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            // Prevent SQL injection by using placeholders
            pstmt.setString(1, user.getUsername());
            String hashedPassword = PasswordUtil.hashPassword(user.getPassword());
            pstmt.setString(2, hashedPassword);
            pstmt.setString(3, user.getRole());

            int rowsAffected = pstmt.executeUpdate();
            return rowsAffected > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

//The method for user to log in
    public User login(String username, String password) {
        String sql = "SELECT * FROM users WHERE username = ? AND password = ?";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, username);
            String hashedPassword = PasswordUtil.hashPassword(password);

            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    // return if searched user
                    User user = new User();
                    user.setId(rs.getInt("id"));
                    user.setUsername(rs.getString("username"));
                    user.setPassword(rs.getString("password"));
                    user.setRole(rs.getString("role"));
                    return user;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null; // log in unsuccessfully
    }
}
