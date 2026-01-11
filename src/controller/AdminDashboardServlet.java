package controller;

import dao.OrderDAO;
import dao.ProductDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

    @WebServlet("/AdminDashboard")
    public class AdminDashboardServlet extends HttpServlet {
        private OrderDAO orderDAO = new OrderDAO();
        private ProductDAO productDAO = new ProductDAO();

        protected void doGet(HttpServletRequest request, HttpServletResponse response)
                throws ServletException, IOException {

            double totalRevenue = orderDAO.getTotalRevenue();
            int totalOrders = orderDAO.getTotalOrderCount();
            int lowStock = productDAO.getLowStockCount();

            request.setAttribute("totalRevenue", totalRevenue);
            request.setAttribute("totalOrders", totalOrders);
            request.setAttribute("lowStock", lowStock);
            
            request.getRequestDispatcher("admin_dashboard.jsp").forward(request, response);
        }
    }

