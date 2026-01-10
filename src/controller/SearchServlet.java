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

@WebServlet("/SearchServlet")
public class SearchServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get parameters for searching.
        // Corresponding to ProductDAO.searchProductsComplex function
        String name = request.getParameter("query");
        String category = request.getParameter("category");

        String minPriceStr = request.getParameter("minPrice");
        String maxPriceStr = request.getParameter("maxPrice");

        Double minPrice = null;
        Double maxPrice = null;

        // Transfer the prices' format
        try {
            if (minPriceStr != null && !minPriceStr.isEmpty()) {
                minPrice = Double.parseDouble(minPriceStr);
            }
            if (maxPriceStr != null && !maxPriceStr.isEmpty()) {
                maxPrice = Double.parseDouble(maxPriceStr);
            }
        } catch (NumberFormatException e) {
        }

        ProductDAO productDAO = new ProductDAO();
        List<Product> searchResults = productDAO.searchProductsComplex(name, category, minPrice, maxPrice);

        request.setAttribute("productList", searchResults);
        request.setAttribute("searchQuery", name); // Return the keyword for showing "Here is the results about...".

        // Forward the result to the page that shows the searching results.
        request.getRequestDispatcher("index.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}