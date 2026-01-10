package util;

import java.sql.Connection;

public class TestConnection {
    public static void main(String[] args) {
        try {
            Connection conn = DBUtil.getConnection();
            if (conn != null) {
                System.out.println("Connected to database.");
                conn.close();
            }
        } catch (Exception e) {
            System.err.println("Unable to connect to database.");
            e.printStackTrace();
        }
    }
}