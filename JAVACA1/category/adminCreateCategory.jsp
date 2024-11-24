<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Create Category</title>
<style>
    body {
        font-family: 'Arial', sans-serif;
        margin: 0;
        padding: 0;
        background-color: #f4f4f9;
    }

    h1 {
        text-align: center;
        color: #2E7D32; /* Dark Green */
        margin-top: 20px;
    }

    .container {
        max-width: 600px;
        margin: 40px auto;
        padding: 20px;
        background: #fff;
        border-radius: 8px;
        box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
    }

    .btn-view {
        display: block;
        margin: 0 auto 20px;
        padding: 10px 20px;
        font-size: 16px;
        background-color: #2E7D32; /* Dark Green */
        color: #fff;
        border: none;
        border-radius: 5px;
        cursor: pointer;
        text-decoration: none;
        text-align: center;
        transition: background 0.3s;
    }

    .btn-view:hover {
        background-color: #1B5E20; /* Darker Green */
    }

    form {
        display: flex;
        flex-direction: column;
        gap: 15px;
    }

    label {
        font-size: 14px;
        color: #555;
    }

    input[type="text"] {
        width: 100%;
        padding: 10px;
        font-size: 14px;
        border: 1px solid #ddd;
        border-radius: 5px;
    }

    input[type="submit"], input[type="reset"] {
        padding: 10px 15px;
        font-size: 16px;
        border: none;
        border-radius: 5px;
        cursor: pointer;
        transition: background 0.3s;
    }

    input[type="submit"] {
        background-color: #28a745; /* Green for Submit */
        color: white;
    }

    input[type="submit"]:hover {
        background-color: #218838;
    }

    input[type="reset"] {
        background-color: #dc3545; /* Red for Reset */
        color: white;
    }

    input[type="reset"]:hover {
        background-color: #c82333;
    }

    .error-message {
        color: red;
        text-align: center;
        margin-bottom: 20px;
    }
</style>
</head>
<body>
<%@ include file="../navbar.jsp" %>
<%
    //////////////////SESSION HANDLING//////////////////////////////////////////////////////////////////
    String userRole = (String) session.getAttribute("sessUserRole"); // getting attribute in session
    if (userRole == null || userRole.equals("member")) { // if not Admin
        response.sendRedirect("generalViewCategory.jsp");
    }
    //////////////////SESSION HANDLING//////////////////////////////////////////////////////////////////

    // Error handling logic
    String errCode = request.getParameter("errCode");
    String message = null;
    if ("categoryAlreadyExists".equals(errCode)) {
        message = "This category already exists!";
    } else if ("invalidCategory".equals(errCode)) {
        message = "This category is invalid!";
    } else if ("serverError".equals(errCode)) {
        message = "A server error has occurred!";
    }
%>
<div class="container">
    <h1>Category Creation</h1>
    <%
        if (message != null) {
    %>
    <p class="error-message"><%= message %></p>
    <%
        }
    %>
    <a href="adminViewUpdateDeleteCategory.jsp" class="btn-view">View All Categories</a>
    <form action="${pageContext.request.contextPath}/category" method="post">
        <input type="hidden" name="action" value="create">
        <label for="categoryName">Category Name:</label>
        <input type="text" id="categoryName" name="categoryName" required>
        <input type="submit" value="Create">
        <input type="reset" value="Reset">
    </form>
</div>
</body>
</html>
