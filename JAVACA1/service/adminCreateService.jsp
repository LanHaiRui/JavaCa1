<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Create Service</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f9f9f9;
            margin: 0;
            padding: 0;
        }

        .container {
            max-width: 800px;
            margin: 50px auto;
            background: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }

        h1 {
            text-align: center;
            color: #333;
        }

        .button-container {
            text-align: center;
            margin-bottom: 20px;
        }

        button {
            background-color: #007BFF;
            color: white;
            border: none;
            padding: 10px 20px;
            font-size: 16px;
            border-radius: 5px;
            cursor: pointer;
        }

        button:hover {
            background-color: #0056b3;
        }

        form label {
            display: block;
            font-weight: bold;
            margin-bottom: 5px;
            color: #555;
        }

        form input[type="text"],
        form textarea,
        form select {
            width: 100%;
            padding: 10px;
            margin-bottom: 15px;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 14px;
        }

        form input[type="submit"],
        form input[type="reset"] {
            background-color: #28a745;
            color: white;
            border: none;
            padding: 10px 15px;
            font-size: 14px;
            border-radius: 5px;
            cursor: pointer;
            margin-right: 10px;
        }

        form input[type="reset"] {
            background-color: #dc3545;
        }

        form input[type="submit"]:disabled {
            background-color: #ccc;
            cursor: not-allowed;
        }

        a {
            color: #007BFF;
            text-decoration: none;
        }

        a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
<%@ include file="../navbar.jsp" %>
<%
    String userRole = (String) session.getAttribute("sessUserRole");
    if (userRole == null || userRole.equals("member")) {
        response.sendRedirect("generalViewService.jsp");
    }

    String errCode = request.getParameter("errCode");
    String message = null;
    if ("serviceAlreadyExists".equals(errCode)) {
        message = "This service already exists!";
    } else if ("imageLinkAlreadyExists".equals(errCode)) {
        message = "The image link already exists! Please use a unique link.";
    } else if ("invalidService".equals(errCode)) {
        message = "This service is invalid!";
    } else if ("serverError".equals(errCode)) {
        message = "A server error has occurred!";
    } else if ("noCategories".equals(errCode)) {
        message = "No categories exist! Please create a category first.";
    }

    if (message != null) {
%>
    <script>
        alert("<%= message %>");
    </script>
<%
    }

    boolean allowSubmit = false;
    Connection conn = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        String connURL = "jdbc:mysql://localhost/javaca1?user=root&password=passwordLHRH3nry570&serverTimezone=UTC";
        conn = DriverManager.getConnection(connURL);

        String sqlStr = "SELECT id, name FROM category";
        PreparedStatement pstmt = conn.prepareStatement(sqlStr);
        rs = pstmt.executeQuery();

        if (rs.isBeforeFirst()) {
            allowSubmit = true;
        }
%>
<div class="container">
    <h1>Create a New Service</h1>
    <div class="button-container">
        <button onclick="window.location.href='adminViewUpdateDeleteService.jsp';">View All Services</button>
    </div>
    <form action="${pageContext.request.contextPath}/service" method="post" id="createServiceForm">
        <input type="hidden" name="action" value="create">

        <label for="serviceName">New Service Name:</label>
        <input type="text" id="serviceName" name="serviceName" required>

        <label for="image_link">Image Link:</label>
        <input type="text" id="image_link" name="image_link" required>

        <label for="category">Category:</label>
        <select id="category" name="category" required>
            <option value="">Select Category</option>
<%
            while (rs.next()) {
                int id = rs.getInt("id");
                String categoryName = rs.getString("name");
%>
            <option value="<%= id %>"><%= categoryName %></option>
<%
            }
%>
        </select>

        <label for="description">Description:</label>
        <textarea id="description" name="description" rows="4" required></textarea>

        <input type="submit" id="submitButton" value="Create" disabled>
        <input type="reset" value="Reset">
    </form>
</div>
<%
    } catch (Exception e) {
        out.println("<p style='color:red;'>Error loading categories. Please try again later.</p>");
    } finally {
        try { if (rs != null) rs.close(); } catch (SQLException ignore) {}
        try { if (conn != null) conn.close(); } catch (SQLException ignore) {}
    }

    if (!allowSubmit) {
        response.sendRedirect("adminCreateService.jsp?errCode=noCategories");
%>
    <p class="container"><a href="../category/adminCreateCategory.jsp">Click here to add categories</a></p>
<%
    }
%>

<script>
    const form = document.getElementById('createServiceForm');
    const submitButton = document.getElementById('submitButton');

    function validateForm() {
        const serviceName = document.getElementById('serviceName').value.trim();
        const imageLink = document.getElementById('image_link').value.trim();
        const category = document.getElementById('category').value;
        const description = document.getElementById('description').value.trim();

        submitButton.disabled = !(serviceName && imageLink && category && description);
    }

    form.addEventListener('input', validateForm);
    form.addEventListener('change', validateForm);
</script>
</body>
</html>
