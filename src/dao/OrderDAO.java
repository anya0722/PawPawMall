package dao;

import model.Order;
import model.OrderItem;
import model.CartItem;
import util.DBUtil;
import java.sql.*;
import java.util.List;

public class OrderDAO {

    //**Create order, Decrease stock, Clear cart
    public boolean checkout(int userId, double totalPrice, List<CartItem> cartItems) {
        String insertOrderSql = "INSERT INTO orders (user_id, total_price, status) VALUES (?, ?, 'Pending')";
        String insertItemSql = "INSERT INTO order_items (order_id, product_id, quantity, price_at_purchase) VALUES (?, ?, ?, ?)";
        String updateStockSql = "UPDATE products SET stock = stock - ? WHERE id = ? AND stock >= ?";
        String clearCartSql = "DELETE FROM cart WHERE user_id = ?";

        Connection conn = null;
        try {
            conn = DBUtil.getConnection();
            conn.setAutoCommit(false); // Prevent autumated save of single SQL statements

            // Insert order and get orderID
            int orderId = -1;
            try (PreparedStatement psOrder = conn.prepareStatement(insertOrderSql, Statement.RETURN_GENERATED_KEYS)) {
                psOrder.setInt(1, userId);
                psOrder.setDouble(2, totalPrice);
                psOrder.executeUpdate();

                try (ResultSet rs = psOrder.getGeneratedKeys()) {
                    if (rs.next()) {
                        orderId = rs.getInt(1);
                    }
                }
            }

            if (orderId == -1) throw new SQLException("Order created failed.");

            // Decrease stock and rollback method
            try (PreparedStatement psStock = conn.prepareStatement(updateStockSql);
                 PreparedStatement psItem = conn.prepareStatement(insertItemSql)) {

                for (CartItem item : cartItems) {

                    psStock.setInt(1, item.getQuantity());
                    psStock.setInt(2, item.getProductId());
                    psStock.setInt(3, item.getQuantity()); 

                    int affectedRows = psStock.executeUpdate();
                    if (affectedRows == 0) {
                        throw new SQLException("Not enough stocks. Product ID: " + item.getProductId());
                    }

                    psItem.setInt(1, orderId);
                    psItem.setInt(2, item.getProductId());
                    psItem.setInt(3, item.getQuantity());
                    psItem.setDouble(4, item.getProduct().getPrice());
                    psItem.addBatch();
                }
                psItem.executeBatch();
            }

            // Clear the cart of user
            try (PreparedStatement psClear = conn.prepareStatement(clearCartSql)) {
                psClear.setInt(1, userId);
                psClear.executeUpdate();
            }

            conn.commit();
            return true;
        } catch (SQLException e) {
            // Rollback if exception happened
            if (conn != null) {
                try {
                    conn.rollback();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
            e.printStackTrace();
            return false;
        } finally {
            DBUtil.close(conn);
        }
    }
}
