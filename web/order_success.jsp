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
