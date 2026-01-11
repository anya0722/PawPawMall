package controller;

import dao.ProductDAO;
import model.Product;
import model.User;
import util.FileUploadUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;
import javax.servlet.annotation.MultipartConfig;

// Product management method for Admins
@WebServlet("/ProductManagementServlet")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 2,  // 2MB
        maxFileSize = 1024 * 1024 * 10,      // 10MB
        maxRequestSize = 1024 * 1024 * 50    // 50MB
)
public class ProductManagementServlet extends HttpServlet {

    private final ProductDAO productDAO = new ProductDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // authority check
        if (!isAdmin(request)) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Access Denied.");
            return;
        }

        // Fetch product list
        List<Product> allProducts = productDAO.getAllProducts();
        request.setAttribute("productList", allProducts);
        request.getRequestDispatcher("admin_products.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        if (!isAdmin(request)) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Access Denied.");
            return;
        }

        String action = request.getParameter("action");

        try {
            if ("add".equals(action)) {
                processAdd(request, response);
            } else if ("update".equals(action)) {
                processUpdate(request, response);
            } else if ("delete".equals(action)) {
                processDelete(request, response);
            } else {
                response.sendRedirect("ProductManagementServlet");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("ProductManagementServlet?msg=system_error");
        }
    }


    private void processAdd(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        Product p = extractProduct(request);

        String uploadPath = getServletContext().getRealPath("/") + "uploads";

        String savedPath = FileUploadUtil.saveFile(request.getPart("imageFile"), uploadPath);
        p.setImagePath(savedPath);

        if (productDAO.addProduct(p)) {
            response.sendRedirect("ProductManagementServlet?msg=add_success");
        } else {
            response.sendRedirect("ProductManagementServlet?msg=error");
        }
    }

    private void processUpdate(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {

        Product p = extractProduct(request);
        p.setId(Integer.parseInt(request.getParameter("id")));

        String uploadPath = getServletContext().getRealPath("/") + "uploads";
        String newPath = FileUploadUtil.saveFile(request.getPart("imageFile"), uploadPath);

        if (newPath != null) {
            p.setImagePath(newPath);
        } else {
            p.setImagePath(request.getParameter("existingImagePath"));
        }

        if (productDAO.updateProduct(p)) {
            response.sendRedirect("ProductManagementServlet?msg=update_success");
        } else {
            response.sendRedirect("ProductManagementServlet?msg=error");
        }
    }

    private void processDelete(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        if (productDAO.deleteProduct(id)) {
            response.sendRedirect("ProductManagementServlet?msg=delete_success");
        } else {
            response.sendRedirect("ProductManagementServlet?msg=error");
        }
    }

    private Product extractProduct(HttpServletRequest request) {
        Product p = new Product();
        p.setName(request.getParameter("name"));
        p.setDescription(request.getParameter("description"));
        p.setPrice(Double.parseDouble(request.getParameter("price")));
        p.setCategory(request.getParameter("category"));
        p.setStock(Integer.parseInt(request.getParameter("stock")));
        return p;
    }

    private boolean isAdmin(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("currentUser") : null;
        return user != null && "Admin".equals(user.getRole());
    }
}