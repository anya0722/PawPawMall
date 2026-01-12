<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/includes/common_css_js.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Register - PawPawMall</title>
    <link rel="stylesheet" href="<%= ctx %>/css/main.css">
</head>
<body class="auth-body">

<div class="auth-container">
    <div class="auth-card">
        <a href="<%= ctx %>/index" class="auth-logo">
            <i class="fa-solid fa-paw"></i>
            <span>PawPawMall</span>
        </a>

        <h2>Create Account</h2>
        <p>Join our community of cat lovers today!</p>

        <form action="<%= ctx %>/RegisterServlet" method="post" class="auth-form">

            <div class="form-group">
                <label for="username">Username</label>
                <input type="text" id="username" name="username" placeholder="Choose a unique username" required>
            </div>

            <div class="form-group">
                <label for="password">Password</label>
                <input type="password" id="password" name="password" placeholder="Create a strong password" required>
            </div>

            <div class="form-group">
                <label for="confirmPassword">Confirm Password</label>
                <input type="password" id="confirmPassword" name="confirmPassword" placeholder="Repeat your password" required>
            </div>

            <% if (request.getAttribute("errorMessage") != null) { %>
            <p class="error-msg">
                <i class="fa-solid fa-circle-exclamation"></i>
                <%= request.getAttribute("errorMessage") %>
            </p>
            <% } %>

            <button type="submit" class="btn-filled auth-btn">Sign Up</button>
        </form>

        <p class="auth-footer">
            Already have an account? <a href="<%= ctx %>/login.jsp">Log in here</a>
        </p>
    </div>
</div>

</body>
</html>
