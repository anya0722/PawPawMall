<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Order Successful - PawPawMall</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/main.css">
</head>
<body class="success-page-body">

<%@ include file="/includes/header.jsp" %>

<main class="success-container">
    <div class="success-card">
        <div class="success-icon">
            <i class="fa-solid fa-circle-check"></i>
        </div>

        <h1 class="success-title">Payment Successful!</h1>

        <div class="order-details-mini" style="background: #f8fafc; padding: 20px; border-radius: 12px; margin: 20px 0; text-align: left; border: 1px solid #e2e8f0;">
            <h4 style="margin-bottom: 10px; color: #1e293b;">Delivery Information Summary</h4>
            <p style="margin-bottom: 5px;"><strong>Receiver: </strong> <%= session.getAttribute("lastReceiver") %></p>
            <p style="margin-bottom: 5px;"><strong>Address: </strong> <%= session.getAttribute("lastAddress") %></p>
            <p style="color: #64748b; font-size: 0.85rem; margin-top: 10px; border-top: 1px dashed #cbd5e1; padding-top: 10px;">
                <i class="fa-solid fa-clock"></i> We will deliver your order in 3-5 days!
            </p>
        </div>


        <p class="success-message">
            Thank you for your purchase. Your order has been placed successfully and is being processed by our team.
        </p>

        <div class="order-details-mini">
            <p>A confirmation email will be sent to you shortly.</p>
        </div>

        <div class="success-actions">
            <a href="<%= ctx %>/OrderServlet" class="btn-filled">
                <i class="fa-solid fa-list-ul"></i> View My Orders
            </a>

            <a href="<%= ctx %>/index" class="btn-outline">
                <i class="fa-solid fa-house"></i> Back to Home
            </a>
        </div>
    </div>
</main>

<%@ include file="/includes/footer.jsp" %>

</body>
</html>
