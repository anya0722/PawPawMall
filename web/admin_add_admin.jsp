<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/includes/common_css_js.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title>Add New Administrator - PawPawMall</title>
    <link rel="stylesheet" href="<%= ctx %>/css/main.css">
</head>
<body class="admin-body">

<%@ include file="/includes/header.jsp" %>

<div class="admin-page-container">
    <div class="auth-card" style="margin-top: 50px;">
        <div class="auth-logo">
            <i class="fa-solid fa-user-shield"></i>
            <span>Admin Portal</span>
        </div>

        <h2>Create Staff Account</h2>
        <p>Register a new administrator with full system access.</p>

        <form action="<%= ctx %>/AdminRegisterServlet" method="post" class="auth-form">
            <div class="form-group">
                <label>Admin Username</label>
                <input type="text" name="username" placeholder="Enter admin username" required>
            </div>

            <div class="form-group">
                <label>Temporary Password</label>
                <input type="password" name="password" placeholder="Create a secure password" required>
            </div>

            <% if (request.getAttribute("errorMessage") != null) { %>
            <p class="error-msg"><%= request.getAttribute("errorMessage") %></p>
            <% } %>

            <% if (request.getAttribute("successMessage") != null) { %>
            <p class="success-msg" style="color: #10b981;"><%= request.getAttribute("successMessage") %></p>
            <% } %>

            <button type="submit" class="btn-filled auth-btn">Create Admin Account</button>
        </form>

        <div style="margin-top: 20px;">
            <a href="<%= ctx %>/AdminDashboard" class="btn-outline" style="display: block; text-align: center;">
                <i class="fa-solid fa-arrow-left"></i> Back to Dashboard
            </a>
        </div>
    </div>
</div>

<%@ include file="/includes/footer.jsp" %>
</body>
</html>
