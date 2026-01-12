<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.User" %>


<%@ include file="/includes/common_css_js.jsp" %>

<%
    User currentUser = (User) session.getAttribute("currentUser");
%>

<header class="navbar">
    <div class="nav-left-container">
        <a href="<%= ctx %>/index" class="brand-group">
            <div class="logo"><i class="fa-solid fa-paw"></i></div>
            <div class="brand-name">PawPawMall</div>
        </a>

        <nav class="nav-links">
            <a href="<%= ctx %>/index">Home</a>
            <a href="<%= ctx %>/ShopServlet">Shop</a>
            <a href="<%= ctx %>/index#about-us">About</a>
            <% if (currentUser != null && "admin".equals(currentUser.getRole())) { %>
            <a href="<%= ctx %>/AdminDashboard" style="color: var(--primary-orange);">Dashboard</a>
            <% } %>
        </nav>
    </div>

    <div class="nav-search">
        <form action="<%= ctx %>/SearchServlet" method="get" class="search-form">
            <input type="text" name="query" placeholder="Search cat food, toys..." required>
            <button type="submit"><i class="fa-solid fa-magnifying-glass"></i></button>
        </form>
    </div>

    <div class="nav-right">
        <% if (currentUser == null) { %>
        <a href="<%= ctx %>/login.jsp" class="icon-btn" title="Log In">
            <i class="fa-solid fa-user"></i>
            <span class="nav-label">Log In</span>
        </a>
        <% } else { %>
        <div class="user-greeting">
            <i class="fa-solid fa-circle-user"></i>
            <span>Welcome, <%= currentUser.getUsername() %></span>
            <div class="user-dropdown">
                <a href="<%= ctx %>/OrderServlet">My Orders</a>
                <a href="<%= ctx %>/LogoutServlet" style="color: #ef4444;">Logout</a>
            </div>
        </div>
        <% } %>

        <a href="<%= ctx %>/CartServlet" class="icon-btn" title="Shopping Cart">
            <i class="fa-solid fa-cart-shopping"></i>
        </a>
    </div>
</header>