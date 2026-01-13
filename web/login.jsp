<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/includes/common_css_js.jsp" %>
<%
    String loginType = request.getParameter("type");
    boolean isAdminMode = "admin".equals(loginType);
%>

<% if ("logout_success".equals(request.getParameter("message"))) { %>
<p class="success-msg" style="color: #10b981; font-size: 0.85rem; margin-bottom: 10px;">
    <i class="fa-solid fa-circle-check"></i> You have been logged out successfully.
</p>
<% } %>
<!DOCTYPE html>
<html>
<head>
    <title><%= isAdminMode ? "Staff Login" : "User Login" %> - PawPawMall</title>
    <link rel="stylesheet" href="<%= ctx %>/css/main.css">
</head>

<body class="auth-body">
<a href="javascript:history.back()" class="back-to-prev">
    <i class="fa-solid fa-chevron-left"></i> Back
</a>

<body class="auth-body">

<div class="auth-container">
    <div class="auth-card">
        <a href="<%= ctx %>/index" class="auth-logo">
            <i class="fa-solid fa-paw"></i>
            <span>PawPawMall</span>
        </a>

        <h2><%= isAdminMode ? "Staff Portal" : "Welcome Back!" %></h2>
        <p><%= isAdminMode ? "Internal Management Access Only." : "Log in to manage your pets' favorite treats." %></p>

        <form action="<%= ctx %>/LoginServlet" method="post" class="auth-form">
            <div class="form-group">
                <label>Username</label>
                <input type="text" name="username" placeholder="Enter username" required>
            </div>
            <div class="form-group">
                <label>Password</label>
                <input type="password" name="password" placeholder="Enter password" required>
            </div>

            <% if (request.getAttribute("errorMessage") != null) { %>
            <p class="error-msg"><i class="fa-solid fa-circle-exclamation"></i> <%= request.getAttribute("errorMessage") %></p>
            <% } %>

            <button type="submit" class="btn-filled auth-btn">
                <%= isAdminMode ? "Admin Login" : "Log In" %>
            </button>
        </form>

        <p class="auth-footer">
            Don't have an account? <a href="<%= ctx %>/register.jsp">Register here</a>
        </p>

        <%-- Hidden entrance for adminc --%>
        <div class="admin-entrance">
            <a href="<%= ctx %>/login.jsp?type=admin">Admin Portal</a>
        </div>
    </div>
</div>

</body>
</html>