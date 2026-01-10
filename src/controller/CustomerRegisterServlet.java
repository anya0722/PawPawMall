package controller;

import dao.UserDAO;
import model.User;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/RegisterServlet")
public class CustomerRegisterServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        // Default register as customer
        String role = "customer";

        if (password == null || !password.equals(confirmPassword)) {
            request.setAttribute("errorMessage", "Your passwords do not match.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        User newUser = new User();
        newUser.setUsername(username);
        newUser.setPassword(password);
        newUser.setRole(role);

        UserDAO userDAO = new UserDAO();

        // Check if the username is already existed
        boolean isRegistered = userDAO.register(newUser);

        if (isRegistered) {
            request.getSession().setAttribute("successMessage", "Your registration has been success. Please login again.");
            response.sendRedirect("login.jsp");
        } else {
            request.setAttribute("errorMessage", "Your registration has failed. Please change a username.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect("register.jsp");
    }
}
