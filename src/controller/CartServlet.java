package controller;

import dao.CartDAO;
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

@WebServlet("/CartServlet")
public class CartServlet extends HttpServlet {

    private CartDAO cartDAO = new CartDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Show cart page
        User user = getLoggedInUser(request);
        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        List<CartItem> cartItems = cartDAO.getCartByUser(user.getId());
        request.setAttribute("cartItems", cartItems);
        request.getRequestDispatcher("cart.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        User user = getLoggedInUser(request);
        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String action = request.getParameter("action");

        // add product into cart
        if ("add".equals(action)) {
            int productId = Integer.parseInt(request.getParameter("productId"));
            cartDAO.addToCart(user.getId(), productId, 1);
        }

        // decrease product from cart
        else if ("minus".equals(action)) {
            int cartId = Integer.parseInt(request.getParameter("cartId"));
            int currentQty = Integer.parseInt(request.getParameter("currentQty"));

            if (currentQty > 1) {
                cartDAO.updateQuantity(cartId, currentQty - 1);
            } else {
                // Delete if quantity = 1 because it would be 0 then
                cartDAO.deleteItem(cartId);
            }
        }

        //D elete
        else if ("delete".equals(action)) {
            int cartId = Integer.parseInt(request.getParameter("cartId"));
            cartDAO.deleteItem(cartId);
        }

        // Refresh
        response.sendRedirect("CartServlet");
    }

    private User getLoggedInUser(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        return (session != null) ? (User) session.getAttribute("currentUser") : null;
    }
}
