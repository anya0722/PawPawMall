<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.Product" %>
<%@ include file="/includes/header.jsp" %>
<%
    Product p = (Product) request.getAttribute("product");
%>
<!DOCTYPE html>
<html>
<head>
    <title><%= p.getName() %> - PawPawMall</title>
    <link rel="stylesheet" href="<%= ctx %>/css/main.css">
</head>
<body>
<main class="product-detail-page">
    <div class="shop-container" style="display: flex; gap: 40px; margin-top: 50px;">
        <div class="detail-img-box" style="flex: 1;">
            <img src="<%= ctx %>/<%= p.getImagePath() %>" style="width: 100%; border-radius: 20px; box-shadow: 0 10px 30px rgba(0,0,0,0.1);">
        </div>

        <div class="detail-info-box" style="flex: 1;">
            <span class="category-tag"><%= p.getCategory() %></span>
            <h1 style="font-size: 2.5rem; margin: 15px 0;"><%= p.getName() %></h1>
            <p class="price" style="font-size: 1.8rem; color: var(--primary-orange); font-weight: 800;">$<%= String.format("%.2f", p.getPrice()) %></p>

            <div class="stock-info" style="margin: 20px 0;">
                <span class="stock-badge <%= p.getStock() < 5 ? "stock-low" : "stock-normal" %>">
                    Stock: <%= p.getStock() %>
                </span>
            </div>

            <p class="description" style="color: #64748b; line-height: 1.8; margin: 30px 0;">
                <%= p.getDescription() != null ? p.getDescription() : "No details yet." %>
            </p>

            <form action="<%= ctx %>/CartServlet" method="post">
                <input type="hidden" name="action" value="add">
                <input type="hidden" name="productId" value="<%= p.getId() %>">
                <button type="submit" class="btn-filled" style="padding: 15px 40px; font-size: 1.1rem;">
                    <i class="fa-solid fa-cart-plus"></i> Add to cart
                </button>
            </form>
        </div>
    </div>
</main>
<%@ include file="/includes/footer.jsp" %>
</body>
</html>