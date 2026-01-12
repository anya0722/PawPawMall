<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List, model.Order, model.OrderItem" %>
<%@ include file="/includes/header.jsp" %>
<%
    boolean isAdmin = currentUser != null && "admin".equalsIgnoreCase(currentUser.getRole());
%>
<!DOCTYPE html>
<html>
<head>
    <title><%= isAdmin ? "Manage Customer Orders" : "My Orders" %> - PawPawMall</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/main.css">
    <style>
        .order-container { max-width: 1000px; margin: 40px auto; padding: 0 20px; }
        .order-card { background: white; border-radius: 15px; box-shadow: 0 4px 15px rgba(0,0,0,0.05); margin-bottom: 30px; overflow: hidden; border: 1px solid #eee; }
        .order-header { background: #f8fafc; padding: 15px 25px; display: flex; justify-content: space-between; align-items: center; border-bottom: 1px solid #eee; }
        .order-id { font-weight: bold; color: var(--primary-orange); }

        .order-status { padding: 5px 12px; border-radius: 20px; font-size: 0.85rem; font-weight: 600; }
        .status-pending { background: #fef3c7; color: #92400e; }
        .status-shipped { background: #e0f2fe; color: #0369a1; }
        .status-completed { background: #dcfce7; color: #166534; }
        .status-cancelled { background: #fee2e2; color: #991b1b; }

        .items-table { width: 100%; border-collapse: collapse; }
        .items-table th { text-align: left; padding: 15px 25px; background: #fff; color: #64748b; font-weight: 500; border-bottom: 1px solid #f1f5f9; }
        .items-table td { padding: 15px 25px; border-bottom: 1px solid #f8fafc; }
        .product-info { display: flex; align-items: center; gap: 15px; }
        .product-img { width: 50px; height: 50px; object-fit: cover; border-radius: 8px; }

        .order-footer { padding: 20px 25px; display: flex; justify-content: space-between; align-items: center; background: #fff; }
        .total-amount { font-size: 1.25rem; font-weight: 800; color: #1e293b; }

        .admin-controls { display: flex; align-items: center; gap: 10px; }
        .status-select { padding: 5px 10px; border-radius: 8px; border: 1px solid #ddd; font-size: 0.9rem; }
        .update-btn { background: #334155; color: white; border: none; padding: 6px 12px; border-radius: 8px; cursor: pointer; font-size: 0.85rem; }
        .update-btn:hover { background: #000; }
    </style>
</head>
<body>

<div class="order-container">
    <%-- Title switch depends on current usr's role --%>
    <h2 class="section-title">
        <%= isAdmin ? "Customer Order Management" : "My Order History" %>
    </h2>

    <%
        List<Order> orderList = (List<Order>) request.getAttribute("orderList");
        if (orderList == null || orderList.isEmpty()) {
    %>
    <div class="auth-card" style="max-width: 100%; margin-top: 20px; text-align: center; padding: 50px;">
        <i class="fa-solid fa-box-open" style="font-size: 4rem; color: #cbd5e1;"></i>

        <p style="margin-top: 20px; font-size: 1.1rem; color: #64748b;">
            <%= isAdmin ? "There are currently no customer orders in the system." : "You haven't placed any orders yet." %>
        </p>

        <a href="<%= ctx %><%= isAdmin ? "/AdminDashboard" : "/ShopServlet" %>" class="btn-filled" style="margin-top: 20px; display: inline-block;">
            <%= isAdmin ? "Back to Dashboard" : "Go Shopping Now" %>
        </a>
    </div>
    <%
    } else {
        for (Order order : orderList) {
            String statusClass = "status-pending";
            if("Shipped".equalsIgnoreCase(order.getStatus())) statusClass = "status-shipped";
            else if("Completed".equalsIgnoreCase(order.getStatus())) statusClass = "status-completed";
            else if("Cancelled".equalsIgnoreCase(order.getStatus())) statusClass = "status-cancelled";
    %>
    <div class="order-card">
        <div class="order-header">
            <div>
                <span class="order-id">Order #<%= order.getId() %></span>
                <% if(isAdmin) { %>
                <span style="margin-left: 10px; font-weight: 500; color: #64748b;">(User ID: <%= order.getUserId() %>)</span>
                <% } %>
                <span style="margin-left: 15px; color: #94a3b8; font-size: 0.9rem;">
                    Placed on: <%= order.getCreatedAt() %>
                </span>
            </div>
            <span class="order-status <%= statusClass %>"><%= order.getStatus() %></span>
        </div>

        <table class="items-table">
            <thead>
            <tr>
                <th>Product</th>
                <th>Price</th>
                <th>Quantity</th>
                <th>Subtotal</th>
            </tr>
            </thead>
            <tbody>
            <%
                if (order.getItems() != null) {
                    for (OrderItem item : order.getItems()) {
            %>
            <tr>
                <td>
                    <div class="product-info">
                        <img src="<%= ctx %>/<%= item.getProduct().getImagePath() %>" class="product-img">
                        <span><%= item.getProduct().getName() %></span>
                    </div>
                </td>
                <td>$<%= String.format("%.2f", item.getPriceAtPurchase()) %></td>
                <td>x<%= item.getQuantity() %></td>
                <td>$<%= String.format("%.2f", item.getPriceAtPurchase() * item.getQuantity()) %></td>
            </tr>
            <%
                    }
                }
            %>
            </tbody>
        </table>

        <div class="order-footer">
            <div class="footer-left">
                <% if (isAdmin) { %>
                <form action="<%= ctx %>/OrderServlet" method="post" class="admin-controls">
                    <input type="hidden" name="orderId" value="<%= order.getId() %>">
                    <select name="status" class="status-select">
                        <option value="Pending" <%= "Pending".equals(order.getStatus()) ? "selected" : "" %>>Pending</option>
                        <option value="Shipped" <%= "Shipped".equals(order.getStatus()) ? "selected" : "" %>>Shipped</option>
                        <option value="Completed" <%= "Completed".equals(order.getStatus()) ? "selected" : "" %>>Completed</option>
                        <option value="Cancelled" <%= "Cancelled".equals(order.getStatus()) ? "selected" : "" %>>Cancelled</option>
                    </select>
                    <button type="submit" class="update-btn">Update Status</button>
                </form>
                <% } %>
            </div>
            <div class="footer-right">
                <span style="color: #64748b; margin-right: 10px;">Total Amount:</span>
                <span class="total-amount">$<%= String.format("%.2f", order.getTotalPrice()) %></span>
            </div>
        </div>
    </div>
    <%
            }
        }
    %>
</div>

<%@ include file="/includes/footer.jsp" %>

</body>
</html>
