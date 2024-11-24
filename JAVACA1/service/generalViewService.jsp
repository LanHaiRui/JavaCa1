<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Our Services</title>
    <style>
        body {
            font-family: 'Roboto', Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f4f9;
            display: flex;
            flex-direction: column;
            align-items: center;
        }

        h1 {
            text-align: center;
            margin-top: 20px;
            font-size: 2.5rem;
            color: #333;
        }

        .service-container {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 20px;
            padding: 20px;
            width: 90%;
            max-width: 1200px;
            overflow-y: auto;
        }

        .service-card {
            background-color: #fff;
            border: 1px solid #ddd;
            border-radius: 12px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            padding: 20px;
            text-align: center;
            display: flex;
            flex-direction: column;
            gap: 15px;
            transition: transform 0.3s, box-shadow 0.3s;
        }

        .service-card:hover {
            transform: scale(1.05);
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
        }

        .service-card h3 {
            font-size: 18px;
            margin: 0;
            font-weight: bold;
            color: #333;
        }

        .service-card p {
            font-size: 14px;
            color: #666;
            margin: 5px 0;
            line-height: 1.5;
        }

        .service-card button {
            background: linear-gradient(90deg, #4caf50, #43a047);
            color: white;
            border: none;
            padding: 10px;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
            font-weight: bold;
            transition: background 0.3s;
        }

        .service-card button:hover {
            background: linear-gradient(90deg, #43a047, #388e3c);
        }

        .no-services {
            text-align: center;
            font-size: 18px;
            color: #555;
            margin-top: 50px;
        }
    </style>
</head>
<body>
    <h1>Our Services</h1>
    <div class="service-container">
        <%
            // Database connection and query execution
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                String connURL = "jdbc:mysql://localhost/javaca1?user=root&password=passwordLHRH3nry570&serverTimezone=UTC";
                try (Connection conn = DriverManager.getConnection(connURL);
                     Statement stmt = conn.createStatement();
                     ResultSet rs = stmt.executeQuery(
                         "SELECT s.name, s.description, c.name AS category_name FROM service s JOIN category c ON s.category_id = c.id")) {

                    boolean hasServices = false;
                    while (rs.next()) {
                        hasServices = true;
                        String serviceName = rs.getString("name");
                        String category = rs.getString("category_name");
                        String description = rs.getString("description");
        %>
        <div class="service-card">
            <h3><%= serviceName %></h3>
            <p><strong>Category:</strong> <%= category %></p>
            <p><%= description %></p>
            <button>Book</button>
        </div>
        <%
                    }

                    if (!hasServices) {
        %>
        <p class="no-services">No services available at the moment. Please check back later!</p>
        <%
                    }
                }
            } catch (Exception e) {
                out.println("<p style='color:red; text-align: center;'>Error loading services. Please try again later.</p>");
            }
        %>
    </div>
</body>
</html>
