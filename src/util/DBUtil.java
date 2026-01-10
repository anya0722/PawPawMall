package util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

//to connect mySQL

public class DBUtil {

    private static final String URL = "jdbc:mysql://localhost:3306/pawpawmall?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true";
    private static final String USER = "root";
    private static final String PASSWORD = "PawPawMall";

    private static final String DRIVER = "com.mysql.cj.jdbc.Driver";

    static {
        try {
            Class.forName(DRIVER);
            System.out.println("Database Driver Loaded！");
        } catch (ClassNotFoundException e) {
            System.err.println("Database Driver Not Loaded!");
            e.printStackTrace();
        }
    }


    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }

    //Close resources
    public static void close(AutoCloseable... resources) {
        for (AutoCloseable res : resources) {
            if (res != null) {
                try {
                    res.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        }
    }
}
