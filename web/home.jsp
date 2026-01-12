<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List, model.Product" %>
<%
    // Fetch data from request
    List<Product> productList = (List<Product>) request.getAttribute("productList");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>PawPawMall - Your Pet, Our Priority</title>
</head>
<body>

<%@ include file="/includes/header.jsp" %>


<%-- Hero Section--%>
<section class="hero-section">
    <div class="hero-container">
        <div class="hero-content">
            <h1 class="hero-main-title">Your Cat, <br><span class="orange-text">Our Priority</span></h1>
            <p class="hero-subtitle">Expertly selected cat food and toys to fuel their zoomies and purrs. Only the best for your paw-some friends.</p>

            <div class="hero-buttons">
                <a href="<%= ctx %>/ShopServlet" class="btn-filled">Discover More</a>
                <% if (currentUser == null) { %>
                <a href="<%= ctx %>/login.jsp" class="btn-outline">Log in</a>
                <% } %>
            </div>
        </div>
    </div>

    <div class="custom-shape-divider-bottom">
        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1440 320" preserveAspectRatio="none">
            <path class="shape-fill" d="M0,224L48,213.3C96,203,192,181,288,192C384,203,480,245,576,234.7C672,224,768,160,864,149.3C960,139,1056,181,1152,186.7C1248,192,1344,160,1392,144L1440,128L1440,320L1392,320C1344,320,1248,320,1152,320C1056,320,960,320,864,320C768,320,672,320,576,320C480,320,384,320,288,320C192,320,96,320,48,320L0,320Z"></path>
        </svg>
    </div>

</section>

<%--Shop by Category--%>
<section class="category-section">
    <h2 class="section-title">Shop by Category</h2>
    <div class="category-grid">
        <div class="cat-card"><img src="<%= ctx %>/images/cat-new.jpg"><span>New Arrivals</span></div>
        <div class="cat-card"><img src="<%= ctx %>/images/cat-toys.jpg"><span>Cat Toys</span></div>
        <div class="cat-card"><img src="<%= ctx %>/images/cat-food.jpg"><span>Cat Food</span></div>
        <div class="cat-card"><img src="<%= ctx %>/images/cat-sale.jpg"><span>On Sale</span></div>
    </div>
</section>

<%-- New Arrivals --%>
<section class="products-section" id="new-arrivals">
    <h2 class="section-title">New Arrivals</h2>
    <div class="product-grid">
        <% if (productList != null) {
            for (Product p : productList) { %>
        <div class="item-card">
            <img src="<%= ctx %>/<%= p.getImagePath() %>" alt="<%= p.getName() %>">
            <div class="item-info">
                <h3><%= p.getName() %></h3>
                <p class="price">$<%= p.getPrice() %></p>
                <a href="<%= ctx %>/CartServlet?action=add&productId=<%= p.getId() %>" class="add-to-cart">
                    <i class="fa-solid fa-plus"></i>
                </a>
            </div>
        </div>
        <% } } else { %>
        <p>No products found. Please check HomeServlet logic.</p>
        <% } %>
    </div>
</section>

<%--About Us & Team --%>
<section class="about-team" id="about-us">
    <div class="about-box">
        <h2>About PawPawMall</h2>
        <p>We are a team of USM students passionate about pets and software development.</p>
    </div>
    <div class="team-box">
        <h2>Our Team</h2>
        <ul>
            <li>Team</li>
            <%-- Wait to insert team introduction --%>
        </ul>
    </div>
</section>

<%@include file="/includes/footer.jsp"%>
</body>
</html>
