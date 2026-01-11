package util;

import model.User;
import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

/* To make sure that unlogged in user can't access private page like cart page or others
 And normal user (Customer) can't access the amdmin pages. */
@WebFilter("/*") // Reject all requests
public class AuthFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // Initialization logic
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        HttpSession session = httpRequest.getSession(false);

        String uri = httpRequest.getRequestURI();
        User currentUser = (session != null) ? (User) session.getAttribute("currentUser") : null;

        // Define those pages that can be accessed by unlogged in user as public pages
        boolean isPublicPage = uri.endsWith("login.jsp") ||
                uri.endsWith("register.jsp") ||
                uri.endsWith("index.jsp") ||
                uri.endsWith("LoginServlet") ||
                uri.endsWith("RegisterServlet") ||
                uri.contains("/assets/") || // The place storing images
                uri.endsWith("HomePageDesignDraft.jpg") ||
                uri.contains("/uploads/") ||
                uri.endsWith("/index");

        boolean isAdminPage = uri.contains("admin_") || uri.endsWith("AdminServlet");
        //Check for admin only pages
        if (isAdminPage) {
            if (currentUser != null && "admin".equals(currentUser.getRole())) {
                chain.doFilter(request, response);
            } else {
                httpResponse.sendError(HttpServletResponse.SC_FORBIDDEN, "Access Denied: Admin only.");
            }
            return;
        }

        // Check for log in needed pages
        boolean isUserPage = uri.contains("cart.jsp") ||
                uri.contains("order.jsp") ||
                uri.endsWith("OrderServlet") ||
                uri.endsWith("CheckoutServlet");

        if (isUserPage) {
            if (currentUser != null) {
                chain.doFilter(request, response);
            } else {
                httpResponse.sendRedirect("login.jsp?error=please_login");
            }
            return;
        }

        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {
    }
}
