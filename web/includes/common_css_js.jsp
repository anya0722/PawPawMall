<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%

    String ctx = request.getContextPath();

    request.setAttribute("ctx", ctx);
%>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">


<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&amp;display=swap" rel="stylesheet">

<link rel="stylesheet" href="<%= ctx %>/css/main.css">

<style>
    :root {
        --primary-orange: #f97316;
        --primary-hover: #ea580c;
        --dark-navy: #0b1121;
        --bg-warm: #FFF9F2;
        --text-gray: #4b5563;
    }
    body {
        margin: 0;
        font-family: 'Inter', Arial, sans-serif;
        color: #111827;
        line-height: 1.5;
    }
</style>

<script src="<%= ctx %>/js/main.js" defer></script>