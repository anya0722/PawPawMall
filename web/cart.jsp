<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List, model.CartItem, model.Cart" %>
<%
    List<CartItem> cartItems = (List<CartItem>) request.getAttribute("cartItems");

    // User cart to calculate price
    Cart cart = new Cart();
    if (cartItems != null) {
        cart.setItems(cartItems);
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Your Cart - PawPawMall</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/main.css">
</head>
<body class="cart-body">

<%@ include file="/includes/header.jsp" %>

<main class="cart-page">
    <div class="cart-container">
        <h1 class="page-title"><i class="fa-solid fa-cart-shopping"></i> Shopping Cart</h1>

        <% if (cartItems == null || cartItems.isEmpty()) { %>
        <div class="empty-cart">
            <i class="fa-solid fa-basket-shopping"></i>
            <p>Your cart is currently empty.</p>
            <a href="<%= ctx %>/ShopServlet" class="btn-filled">Go Shopping</a>
        </div>
        <% } else { %>
        <div class="cart-content">
            <div class="cart-items-list">
                <% for (CartItem item : cartItems) { %>
                <div class="cart-item-card">
                    <div class="item-img">
                        <img src="<%= ctx %>/<%= item.getProduct().getImagePath() %>" alt="<%= item.getProduct().getName() %>">
                    </div>

                    <div class="item-details">
                        <h3><%= item.getProduct().getName() %></h3>
                        <p class="unit-price">$<%= String.format("%.2f", item.getProduct().getPrice()) %></p>
                    </div>

                    <div class="item-controls">
                        <form action="<%= ctx %>/CartServlet" method="post">
                            <input type="hidden" name="action" value="minus">
                            <input type="hidden" name="cartId" value="<%= item.getId() %>">
                            <input type="hidden" name="currentQty" value="<%= item.getQuantity() %>">
                            <button type="submit" class="qty-btn" <%= item.getQuantity() <= 1 ? "disabled" : "" %>>
                                <i class="fa-solid fa-minus"></i>
                            </button>
                        </form>

                        <span class="qty-number"><%= item.getQuantity() %></span>

                        <form action="<%= ctx %>/CartServlet" method="post">
                            <input type="hidden" name="action" value="add">
                            <input type="hidden" name="productId" value="<%= item.getProductId() %>">
                            <button type="submit" class="qty-btn">
                                <i class="fa-solid fa-plus"></i>
                            </button>
                        </form>
                    </div>

                    <div class="item-subtotal">
                        <p>$<%= String.format("%.2f", item.getProduct().getPrice() * item.getQuantity()) %></p>
                    </div>

                    <form action="<%= ctx %>/CartServlet" method="post" class="delete-form">
                        <input type="hidden" name="action" value="delete">
                        <input type="hidden" name="cartId" value="<%= item.getId() %>">
                        <button type="submit" class="delete-btn" onclick="return confirm('Remove this item?')">
                            <i class="fa-solid fa-trash-can"></i>
                        </button>
                    </form>
                </div>
                <% } %>
            </div>

            <aside class="cart-summary">
                <h3>Order Summary</h3>
                <div class="summary-row">
                    <span>Total Items:</span>
                    <span><%= cart.getTotalQuantity() %></span>
                </div>
                <div class="summary-row total">
                    <span>Total Price:</span>
                    <span>$<%= String.format("%.2f", cart.getTotalPrice()) %></span>
                </div>

                <form action="<%= ctx %>/CheckoutServlet" method="post">
                    <button type="submit" class="btn-filled checkout-btn">Proceed to Checkout</button>
                </form>

                <a href="<%= ctx %>/ShopServlet" class="continue-shopping">
                    <i class="fa-solid fa-arrow-left"></i> Continue Shopping
                </a>
            </aside>
        </div>
        <% } %>
    </div>
</main>

<%@ include file="/includes/footer.jsp" %>

</body>
</html>