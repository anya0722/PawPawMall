<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.User" %>
<%@ include file="/includes/common_css_js.jsp" %>
<%
    User currentUser = (User) session.getAttribute("currentUser");
%>

<header class="navbar">
    <div class="nav-container">
        <a href="<%= ctx %>/index" class="brand-group">
            <div class="logo"><i class="fa-solid fa-paw"></i></div>
            <div class="brand-name">PawPawMall</div>
        </a>

        <nav class="nav-links">
            <a href="<%= ctx %>/index">Home</a>
            <a href="<%= ctx %>/ShopServlet">Shop</a>
            <a href="<%= ctx %>/index#about-us">About</a>
            <% if (currentUser != null && "admin".equals(currentUser.getRole())) { %>
            <a href="<%= ctx %>/AdminDashboard" class="admin-link">Dashboard</a>
            <% } %>
        </nav>

        <div class="nav-right-group">
            <div class="nav-search">
                <form action="<%= ctx %>/SearchServlet" method="get" class="search-form">
                    <input type="text" name="query" placeholder="Search..." required>
                    <button type="submit"><i class="fa-solid fa-magnifying-glass"></i></button>
                </form>
            </div>

            <div class="nav-right">
                <% if (currentUser == null) { %>
                <a href="<%= ctx %>/login.jsp" class="icon-btn">
                    <i class="fa-solid fa-user"></i>
                    <span class="nav-label">Log In</span>
                </a>
                <% } else { %>
                <div class="user-greeting">
                    <i class="fa-solid fa-circle-user"></i>
                    <span>Hi, <%= currentUser.getUsername() %></span>
                </div>
                <% } %>
                <a href="<%= ctx %>/CartServlet" class="icon-btn">
                    <i class="fa-solid fa-cart-shopping"></i>
                </a>
            </div>
        </div>
    </div>
</header>