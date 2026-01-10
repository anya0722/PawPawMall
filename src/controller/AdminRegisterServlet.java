 package controller;

import dao.UserDAO;
import model.User;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/AdminServlet")
public class AdminRegisterServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Security check: If the one who try to add an admin is an admin.
        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("currentUser");

        if (currentUser == null || !"0".equals(currentUser.getRole())) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Sorry. You are not allowed to perform this action.");
            return;
        }

        // Get parameters
        String action = request.getParameter("action");

        if ("addAdmin".equals(action)) {
            String username = request.getParameter("username");
            String password = request.getParameter("password");
            String confirmPassword = request.getParameter("confirmPassword");

            if (password == null || !password.equals(confirmPassword)) {
                request.setAttribute("errorMessage", "Your passwords do not match.");
                request.getRequestDispatcher("admin_add_admin.jsp").forward(request, response);
                return;
            }

            User newAdmin = new User();
            newAdmin.setUsername(username);
            newAdmin.setPassword(password);
            newAdmin.setRole("Admin");

            UserDAO userDAO = new UserDAO();
            if (userDAO.register(newAdmin)) {
                request.setAttribute("successMessage", "Admin account " + username + "is signed up！");
            } else {
                request.setAttribute("errorMessage", "Signed up failed. Please change your username and try again.");
            }
            request.getRequestDispatcher("admin_add_admin.jsp").forward(request, response);
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect("admin_dashboard.jsp");
    }
}