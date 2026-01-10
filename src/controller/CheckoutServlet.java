package controller;

import dao.CartDAO;
import dao.OrderDAO;
import model.CartItem;
import model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;


@WebServlet("/CheckoutServlet")
public class CheckoutServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("currentUser") : null;

        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        CartDAO cartDAO = new CartDAO();
        OrderDAO orderDAO = new OrderDAO();

        List<CartItem> cartItems = cartDAO.getCartByUser(user.getId());

        if (cartItems == null || cartItems.isEmpty()) {
            request.setAttribute("errorMessage", "Your cart is empty!");
            request.getRequestDispatcher("cart.jsp").forward(request, response);
            return;
        }


        double totalPrice = 0;
        for (CartItem item : cartItems) {
            if (item.getProduct() != null) {
                totalPrice += item.getProduct().getPrice() * item.getQuantity();
            }
        }


        boolean isSuccess = orderDAO.checkout(user.getId(), totalPrice, cartItems);

        if (isSuccess) {

            response.sendRedirect("order_success.jsp");
        } else {

            request.setAttribute("errorMessage", "Checkout failed! One or more items might be out of stock.");
            request.getRequestDispatcher("cart.jsp").forward(request, response);
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect("CartServlet");
    }
}
