<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    Double totalRevenue = (Double) request.getAttribute("totalRevenue");
    Integer totalOrders = (Integer) request.getAttribute("totalOrders");
    Integer lowStock = (Integer) request.getAttribute("lowStock");

    totalRevenue = (totalRevenue != null) ? totalRevenue : 0.0;
    totalOrders = (totalOrders != null) ? totalOrders : 0;
    lowStock = (lowStock != null) ? lowStock : 0;
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard - PawPawMall</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/main.css">
</head>
<body class="admin-body">

<%@ include file="/includes/header.jsp" %>

<main class="admin-container">
    <header class="admin-header">
        <h1><i class="fa-solid fa-gauge-high"></i> Management Dashboard</h1>
        <p>Welcome back, Administrator. Here's what's happening today.</p>
    </header>

    <div class="stats-grid">
        <div class="stat-card revenue">
            <div class="stat-icon"><i class="fa-solid fa-sack-dollar"></i></div>
            <div class="stat-info">
                <h3>Total Revenue</h3>
                <p class="stat-value">$<%= String.format("%.2f", totalRevenue) %></p>
            </div>
        </div>

        <div class="stat-card orders">
            <div class="stat-icon"><i class="fa-solid fa-box-open"></i></div>
            <div class="stat-info">
                <h3>Total Orders</h3>
                <p class="stat-value text-blue"><%= totalOrders %></p>
            </div>
        </div>

        <div class="stat-card stock <%= lowStock > 0 ? "warning" : "" %>">
            <div class="stat-icon"><i class="fa-solid fa-triangle-exclamation"></i></div>
            <div class="stat-info">
                <h3>Low Stock Items</h3>
                <p class="stat-value <%= lowStock > 0 ? "text-red" : "" %>"><%= lowStock %></p>
                <% if (lowStock > 0) { %>
                <span class="warning-tag">Action Needed</span>
                <% } %>
            </div>
        </div>
    </div>

    <section class="admin-actions">
        <h2>Quick Actions</h2>
        <div class="action-btns">
            <a href="<%= ctx %>/ProductManagementServlet" class="action-card">
                <i class="fa-solid fa-file-invoice-dollar"></i>
                <span>Manage Products</span>
            </a>
            <a href="<%= ctx %>/OrderServlet" class="action-card">
                <i class="fa-solid fa-truck-fast"></i>
                <span>Review Orders</span>
            </a>
        </div>
    </section>
</main>

<%@ include file="/includes/footer.jsp" %>

</body>
</html>