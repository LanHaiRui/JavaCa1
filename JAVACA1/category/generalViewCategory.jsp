<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Our Categories</title>
    <style>
        body {
            font-family: Arial, sans-serif;
        }
        .category-container, .service-container {
            display: flex;
            flex-wrap: wrap;
            gap: 15px;
            padding: 20px;
        }
        .category, .service {
            border: 1px solid #ddd;
            border-radius: 5px;
            padding: 15px;
            text-align: center;
            width: 200px;
            cursor: pointer;
            transition: 0.3s;
        }
        .category:hover, .service:hover {
            background-color: #f5f5f5;
            transform: scale(1.05);
        }
        .back-arrow {
            position: fixed;
            top: 20px;
            left: 20px;
            cursor: pointer;
            font-size: 20px;
            text-decoration: none;
        }
    </style>
    <script>
        function fetchServices(categoryId) {
            // Fetch services for the selected category via AJAX
            fetch(`ourCategories?categoryId=${categoryId}`)
                .then(response => response.text())
                .then(html => {
                    document.getElementById('services').innerHTML = html;
                });
        }

        function goBack() {
            location.reload();
        }
    </script>
</head>
<body>
<%@ include file="../navbar.jsp" %>
<h1>Our Categories</h1>
<div id="categories" class="category-container">
    <%
        // Display categories dynamically
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            String connURL = "jdbc:mysql://localhost/javaca1?user=root&password=passwordLHRH3nry570&serverTimezone=UTC";
            try (Connection conn = DriverManager.getConnection(connURL);
                 Statement stmt = conn.createStatement();
                 ResultSet rs = stmt.executeQuery("SELECT id, name FROM category")) {
                while (rs.next()) {
                    int id = rs.getInt("id");
                    String name = rs.getString("name");
    %>
        <div class="category" onclick="fetchServices(<%= id %>)"><%= name %></div>
    <%
                }
            }
        } catch (Exception e) {
            out.println("<p style='color:red;'>Error loading categories.</p>");
        }
    %>
</div>

<div id="services" class="service-container"></div>

<a class="back-arrow" onclick="goBack()">&#8592; Back</a>
</body>
</html>
