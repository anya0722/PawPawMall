<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List, model.Product" %>
<%
    // Get product list for servlet
    List<Product> productList = (List<Product>) request.getAttribute("productList");

    String query = request.getParameter("query") != null ? request.getParameter("query") : "";
    String category = request.getParameter("category") != null ? request.getParameter("category") : "";
    String minPrice = request.getParameter("minPrice") != null ? request.getParameter("minPrice") : "";
    String maxPrice = request.getParameter("maxPrice") != null ? request.getParameter("maxPrice") : "";
%>

<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>Shop - PawPawMall</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/main.css">
</head>
<body>

<%@ include file="/includes/header.jsp" %>

<main class="shop-page">
    <div class="shop-container">

        <section class="search-filter-section">
            <form action="<%= ctx %>/SearchServlet" method="get" class="combo-search-form">
                <div class="filter-group">
                    <label>Product Name</label>
                    <input type="text" name="query" value="<%= query %>" placeholder="Search by name...">
                </div>

                <div class="filter-group">
                    <label>Category</label>
                    <select name="category">
                        <option value="">All Categories</option>
                        <option value="Food" <%= "Food".equals(category) ? "selected" : "" %>>Food</option>
                        <option value="Toys" <%= "Toys".equals(category) ? "selected" : "" %>>Toys</option>
                        <option value="Accessories" <%= "Accessories".equals(category) ? "selected" : "" %>>Accessories</option>
                    </select>
                </div>

                <div class="filter-group">
                    <label>Min Price ($)</label>
                    <input type="number" name="minPrice" value="<%= minPrice %>" placeholder="0" step="0.01">
                </div>

                <div class="filter-group">
                    <label>Max Price ($)</label>
                    <input type="number" name="maxPrice" value="<%= maxPrice %>" placeholder="999" step="0.01">
                </div>

                <button type="submit" class="search-btn">
                    <i class="fa-solid fa-magnifying-glass"></i> Filter
                </button>

                <a href="<%= ctx %>/ShopServlet" class="reset-btn">Reset</a>

                <%-- In case user want to see all products again after filter --%>
                <a href="<%= ctx %>/ShopServlet" class="view-all-btn">
                    <i class="fa-solid fa-border-all"></i> View All
                </a>


            </form>
        </section>

        <section class="shop-content">
            <div class="product-grid">
                <% if (productList != null && !productList.isEmpty()) {
                    for (Product p : productList) { %>
                <div class="item-card">
                    <div class="item-img">
                        <img src="<%= ctx %>/<%= p.getImagePath() %>" alt="<%= p.getName() %>">
                    </div>
                    <div class="item-info">
                        <p class="category-label"><%= p.getCategory() %></p>
                        <h3><%= p.getName() %></h3>
                        <div class="item-footer">
                            <span class="price">$<%= String.format("%.2f", p.getPrice()) %></span>
                            <a href="<%= ctx %>/CartServlet?action=add&productId=<%= p.getId() %>" class="add-to-cart">
                                <i class="fa-solid fa-cart-plus"></i>
                            </a>
                        </div>
                    </div>
                </div>
                <% } } else { %>
                <div class="no-results">
                    <i class="fa-solid fa-face-frown"></i>
                    <p>No products found matching your search.</p>
                </div>
                <% } %>
            </div>
        </section>
    </div>
</main>

<%@ include file="/includes/footer.jsp" %>

</body>
</html>
