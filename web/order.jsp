<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List, model.Order, model.OrderItem" %>
<!DOCTYPE html>
<html>
<head>
    <title>My Orders - PawPawMall</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/main.css">
    <style>
        .order-container { max-width: 1000px; margin: 40px auto; padding: 0 20px; }
        .order-card { background: white; border-radius: 15px; box-shadow: 0 4px 15px rgba(0,0,0,0.05); margin-bottom: 30px; overflow: hidden; border: 1px solid #eee; }
        .order-header { background: #f8fafc; padding: 15px 25px; display: flex; justify-content: space-between; align-items: center; border-bottom: 1px solid #eee; }
        .order-id { font-weight: bold; color: var(--primary-orange); }
        .order-status { padding: 5px 12px; border-radius: 20px; font-size: 0.85rem; background: #e0f2fe; color: #0369a1; }
        .items-table { width: 100%; border-collapse: collapse; }
        .items-table th { text-align: left; padding: 15px 25px; background: #fff; color: #64748b; font-weight: 500; border-bottom: 1px solid #f1f5f9; }
        .items-table td { padding: 15px 25px; border-bottom: 1px solid #f8fafc; }
        .product-info { display: flex; align-items: center; gap: 15px; }
        .product-img { width: 50px; height: 50px; object-fit: cover; border-radius: 8px; }
        .order-footer { padding: 20px 25px; text-align: right; background: #fff; }
        .total-label { color: #64748b; margin-right: 10px; }
        .total-amount { font-size: 1.25rem; font-weight: 800; color: #1e293b; }
    </style>
</head>
<body>

<%@ include file="/includes/header.jsp" %>

<div class="order-container">
    <h2 class="section-title">Order History</h2>

    <%
        List<Order> orderList = (List<Order>) request.getAttribute("orderList");
        if (orderList == null || orderList.isEmpty()) {
    %>
    <div class="auth-card" style="max-width: 100%; margin-top: 20px;">
        <i class="fa-solid fa-box-open" style="font-size: 3rem; color: #cbd5e1;"></i>
        <p style="margin-top: 15px;">You haven't placed any orders yet.</p>
        <a href="<%= ctx %>/ShopServlet" class="btn-filled" style="margin-top: 15px;">Go Shopping</a>
    </div>
    <%
    } else {
        for (Order order : orderList) {
    %>
    <div class="order-card">
        <div class="order-header">
            <div>
                <span class="order-id">Order #<%= order.getId() %></span>
                <span style="margin-left: 15px; color: #94a3b8; font-size: 0.9rem;">
                        Placed on: <%= order.getCreatedAt() %>
                    </span>
            </div>
            <span class="order-status"><%= order.getStatus() %></span>
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
                <td>$<%= item.getPriceAtPurchase() %></td>
                <td>x<%= item.getQuantity() %></td>
                <td>$<%= item.getPriceAtPurchase() * item.getQuantity() %></td>
            </tr>
            <%
                    }
                }
            %>
            </tbody>
        </table>

        <div class="order-footer">
            <span class="total-label">Order Total:</span>
            <span class="total-amount">$<%= order.getTotalPrice() %></span>
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
