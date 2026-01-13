<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List, model.CartItem, model.Cart" %>
<%
    // Get cart data
    List<CartItem> cartItems = (List<CartItem>) request.getAttribute("cartItems");
    Cart cart = new Cart();
    if (cartItems != null) {
        cart.setItems(cartItems);
    }
%>

<!DOCTYPE html>
<head>
    <meta charset="UTF-8">
    <title>Checkout - PawPawMall</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/main.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body class="cart-body">

<%@ include file="/includes/header.jsp" %>

<main class="cart-page">
    <div class="cart-container">
        <h1 class="page-title"><i class="fa-solid fa-credit-card"></i> Order Checkout</h1>

        <div class="cart-content">
            <div class="cart-items-list">
                <form action="<%= ctx %>/CheckoutServlet" method="post" id="checkoutForm">
                    <section class="checkout-section">
                        <h3 class="section-subtitle"><i class="fa-solid fa-location-dot"></i> Receiver Information</h3>
                        <div class="form-group">
                            <label for="fullName">Name </label>
                            <input type="text" id="fullName" name="fullName" placeholder="Please enter your name" required>
                        </div>
                        <div class="form-group">
                            <label for="phone">Contact Number</label>
                            <input type="tel" id="phone" name="phone" placeholder="Please enter your contact number" required>
                        </div>
                        <div class="form-group">
                            <label for="address">Delivery Address</label>
                            <textarea id="address" name="address" rows="3" placeholder="Please enter your address in details" required></textarea>
                        </div>
                    </section>

                    <section class="checkout-section" style="margin-top: 30px;">
                        <h3 class="section-subtitle"><i class="fa-solid fa-wallet"></i> Payment Method</h3>
                        <div class="payment-methods">
                            <label class="payment-option">
                                <input type="radio" name="paymentMethod" value="CreditCard" checked>
                                <span class="method-box">
                                    <i class="fa-solid fa-credit-card"></i> Credit Cards
                                </span>
                            </label>
                            <label class="payment-option">
                                <input type="radio" name="paymentMethod" value="BankTransfer">
                                <span class="method-box">
                                    <i class="fa-solid fa-building-columns"></i> Bank Transfer
                                </span>
                            </label>
                            <label class="payment-option">
                                <input type="radio" name="paymentMethod" value="EWallet">
                                <span class="method-box">
                                    <i class="fa-solid fa-mobile-screen"></i> E-Wallet
                                </span>
                            </label>
                        </div>

                        <div class="bank-selection">
                            <p>Choose your payment method</p>
                            <div class="bank-grid">
                                <label class="bank-item">
                                    <input type="radio" name="bank" value="PBB" required>
                                    <div class="bank-box">
                                        <i class="fa-solid fa-building-columns bank-logo-mock"></i>
                                        <span>PBB</span>
                                    </div>
                                </label>
                                <label class="bank-item">
                                    <input type="radio" name="bank" value="MBB">
                                    <div class="bank-box">
                                        <i class="fa-solid fa-building-columns bank-logo-mock" style="color: #ffcc00;"></i>
                                        <span>MBB</span>
                                    </div>
                                </label>
                                <label class="bank-item">
                                    <input type="radio" name="bank" value="CIMB">
                                    <div class="bank-box">
                                        <i class="fa-solid fa-building-columns bank-logo-mock" style="color: #cc0000;"></i>
                                        <span>CIMB</span>
                                    </div>
                                </label>
                                <label class="bank-item">
                                    <input type="radio" name="bank" value="HLB">
                                    <div class="bank-box">
                                        <i class="fa-solid fa-building-columns bank-logo-mock" style="color: #003399;"></i>
                                        <span>HLB</span>
                                    </div>
                                </label>

                                <label class="bank-item">
                                    <input type="radio" name="bank" value="TNG">
                                    <div class="bank-box">
                                        <i class="fa-solid fa-wallet bank-logo-mock" style="color: #0055CC;"></i>
                                        <span>TNG</span>
                                    </div>
                                </label>
                                <label class="bank-item">
                                    <input type="radio" name="bank" value="Alipay">
                                    <div class="bank-box">
                                        <i class="fa-brands fa-alipay bank-logo-mock" style="color: #00A3EE;"></i>
                                        <span>Alipay</span>
                                    </div>
                                </label>
                                <label class="bank-item">
                                    <input type="radio" name="bank" value="WeChat">
                                    <div class="bank-box">
                                        <i class="fa-brands fa-weixin bank-logo-mock" style="color: #07C160;"></i>
                                        <span>WeChat</span>
                                    </div>
                                </label>
                                <label class="bank-item">
                                    <input type="radio" name="bank" value="GrabPay">
                                    <div class="bank-box">
                                        <i class="fa-solid fa-coins bank-logo-mock" style="color: #00B14F;"></i>
                                        <span>GrabPay</span>
                                    </div>
                                </label>
                            </div>
                        </div>
                    </section>
                </form>
            </div>

            <aside class="cart-summary">
                <h3>Order Summary</h3>
                <div class="summary-items-preview">
                    <% if (cartItems != null) {
                        for (CartItem item : cartItems) { %>
                    <div class="summary-row">
                        <span class="item-name-preview"><%= item.getProduct().getName() %> x<%= item.getQuantity() %></span>
                        <span>$<%= String.format("%.2f", item.getProduct().getPrice() * item.getQuantity()) %></span>
                    </div>
                    <% } } %>
                </div>
                <hr>
                <div class="summary-row">
                    <span>Total Amount</span>
                    <span><%= cart.getTotalQuantity() %></span>
                </div>
                <div class="summary-row total">
                    <span>Total Price</span>
                    <span>$<%= String.format("%.2f", cart.getTotalPrice()) %></span>
                </div>

                <button type="submit" form="checkoutForm" class="btn-filled checkout-btn">
                    Confirm Payment
                </button>

                <a href="<%= ctx %>/CartServlet" class="continue-shopping">
                    <i class="fa-solid fa-arrow-left"></i> Back to shopping cart
                </a>
            </aside>
        </div>
    </div>
</main>

<%@ include file="/includes/footer.jsp" %>

</body>
</html>
