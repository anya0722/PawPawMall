package controller;

import dao.OrderDAO;
import model.Order;
import model.User;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/OrderServlet")
public class OrderServlet extends HttpServlet {

    private OrderDAO orderDAO = new OrderDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Fetch the current user
        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("currentUser") : null;

        // Double check to ensure security
        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // Fetch the orders depends on role. For admin, can get all orders. But for customer only show their own orders
        List<Order> orderList;
        if ("admin".equals(user.getRole())) {
            // For Admin
            orderList = orderDAO.getAllOrders();
        } else {
            // For Customer
            orderList = orderDAO.getOrdersByUser(user.getId());
        }

        // Save to request and send to jsp
        request.setAttribute("orderList", orderList);
        request.getRequestDispatcher("order.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get current session and user
        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("currentUser") : null;

        // Chek authority
        if (user == null || !"admin".equalsIgnoreCase(user.getRole())) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Access Denied: Admin only.");
            return;
        }

        String orderIdStr = request.getParameter("orderId");
        String newStatus = request.getParameter("status");

        if (orderIdStr != null && newStatus != null) {
            try {
                int orderId = Integer.parseInt(orderIdStr);

                // Update the status
                boolean success = orderDAO.updateOrderStatus(orderId, newStatus);

                if (success) {
                    response.sendRedirect("OrderServlet?msg=update_success");
                } else {
                    response.sendRedirect("OrderServlet?msg=update_failed");
                }
            } catch (NumberFormatException e) {
                response.sendRedirect("OrderServlet?msg=invalid_id");
            }
        }
    }


}
