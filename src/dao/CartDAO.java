package dao;

import model.CartItem;
import model.Product;
import util.DBUtil;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CartDAO {

    // Add to cart method. If product exists, increase the number. Otherwise insert new record.
    public boolean addToCart(int userId, int productId, int quantity) {
        String checkSql = "SELECT id, quantity FROM cart WHERE user_id = ? AND product_id = ?";
        String updateSql = "UPDATE cart SET quantity = quantity + ? WHERE id = ?";
        String insertSql = "INSERT INTO cart (user_id, product_id, quantity) VALUES (?, ?, ?)";

        try (Connection conn = DBUtil.getConnection()) {
            // Check if the product exist in the cart
            try (PreparedStatement psCheck = conn.prepareStatement(checkSql)) {
                psCheck.setInt(1, userId);
                psCheck.setInt(2, productId);
                try (ResultSet rs = psCheck.executeQuery()) {
                    if (rs.next()) {
                        //Increase the number
                        try (PreparedStatement psUpdate = conn.prepareStatement(updateSql)) {
                            psUpdate.setInt(1, quantity);
                            psUpdate.setInt(2, rs.getInt("id"));
                            return psUpdate.executeUpdate() > 0;
                        }
                    } else {
                        // Insert the new record
                        try (PreparedStatement psInsert = conn.prepareStatement(insertSql)) {
                            psInsert.setInt(1, userId);
                            psInsert.setInt(2, productId);
                            psInsert.setInt(3, quantity);
                            return psInsert.executeUpdate() > 0;
                        }
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }


    public List<CartItem> getCartByUser(int userId) {
        List<CartItem> list = new ArrayList<>();

        String sql = "SELECT c.*, p.name, p.price, p.image_path, p.description, p.stock " +
                "FROM cart c JOIN products p ON c.product_id = p.id " +
                "WHERE c.user_id = ?";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, userId);
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    CartItem item = new CartItem();
                    item.setId(rs.getInt("id"));
                    item.setUserId(rs.getInt("user_id"));
                    item.setProductId(rs.getInt("product_id"));
                    item.setQuantity(rs.getInt("quantity"));

                    Product p = new Product();
                    p.setId(rs.getInt("product_id"));
                    p.setName(rs.getString("name"));
                    p.setPrice(rs.getDouble("price"));
                    p.setImagePath(rs.getString("image_path"));
                    p.setDescription(rs.getString("description"));
                    p.setStock(rs.getInt("stock"));
                    item.setProduct(p);

                    list.add(item);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean updateQuantity(int cartId, int newQuantity) {
        String sql = "UPDATE cart SET quantity = ? WHERE id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, newQuantity);
            pstmt.setInt(2, cartId);
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    public boolean deleteItem(int cartId) {
        String sql = "DELETE FROM cart WHERE id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, cartId);
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}
