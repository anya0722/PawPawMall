package controller;

import dao.ProductDAO;
import model.Product;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/ShopServlet")
public class ShopServlet extends HttpServlet {

    private ProductDAO productDAO = new ProductDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get the category as parameter
        String category = request.getParameter("category");
        List<Product> productList;

        if (category == null || category.isEmpty() || "all".equals(category)) {
            productList = productDAO.getAllProducts();
            request.setAttribute("currentCategory", "All Products");
        } else {
            productList = productDAO.getProductsByCategory(category);
            request.setAttribute("currentCategory", category);
        }

        request.setAttribute("productList", productList);
        request.getRequestDispatcher("shop.jsp").forward(request, response);
    }
}
