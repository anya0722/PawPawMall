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


@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get the parameters from front-end side
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        // Verify user using "login" in UserDAO
        UserDAO userDAO = new UserDAO();
        User user = userDAO.login(username, password);

        if (user != null) {
            // Save object user
            HttpSession session = request.getSession();
            session.setAttribute("currentUser", user);

            // Jump to different pages depends on the role of user (normal user or admin）
            if ("admin".equalsIgnoreCase(user.getRole())) {
                response.sendRedirect("AdminDashboard"); // Going to admin dashboard
            } else {
                response.sendRedirect("index"); // Back to homepage
            }
        } else {
            // fail in logging in
            request.setAttribute("errorMessage", "Invalid username or password!");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}