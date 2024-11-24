<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>View, Update, Delete Categories</title>
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
            max-width: 1200px;
            margin: 20px auto;
            padding: 20px;
            background: #fff;
            border-radius: 8px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }

        .btn-create {
            display: inline-block;
            margin-bottom: 20px;
            padding: 10px 20px;
            font-size: 16px;
            background-color: #2E7D32; /* Dark Green */
            color: #fff;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            text-decoration: none;
            transition: background 0.3s;
        }

        .btn-create:hover {
            background-color: #1B5E20; /* Darker Green */
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 10px;
            background: #fff;
        }

        table th {
            background-color: #2E7D32; /* Dark Green */
            color: white;
            padding: 12px;
            text-align: left;
            border: 1px solid #ddd;
        }

        table td {
            padding: 12px;
            border: 1px solid #ddd;
            text-align: left;
        }

        table td input[type="text"] {
            width: calc(100% - 10px);
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 4px;
        }

        button {
            padding: 8px 12px;
            font-size: 14px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background 0.3s;
        }

        .btn-update {
            background-color: #43A047; /* Green for Update */
            color: white;
        }

        .btn-update:hover {
            background-color: #388E3C;
        }

        .btn-delete {
            background-color: #C62828; /* Red for Delete */
            color: white;
        }

        .btn-delete:hover {
            background-color: #B71C1C;
        }

        p.error-message {
            color: red;
            text-align: center;
            font-weight: bold;
        }
    </style>
    <script>
        function confirmUpdate(button) {
            const row = button.closest('tr');
            const categoryName = row.querySelector('input[name="categoryName"]').value.trim();

            if (!categoryName) {
                alert("Please ensure all fields are filled.");
                return false;
            }

            return confirm("Are you sure you want to update this category?");
        }

        function confirmDelete() {
            return confirm("Are you sure you want to delete this category?");
        }
    </script>
</head>
<body>
<%@ include file="../navbar.jsp" %>
<%
    // Session Handling
    String userRole = (String) session.getAttribute("sessUserRole");
    if (userRole == null || userRole.equals("member")) {
        response.sendRedirect("generalViewCategory.jsp");
    }

    // Error Handling
    String errCode = request.getParameter("errCode");
    String message = null;
    if ("categoryNotFound".equals(errCode)) {
        message = "The specified category could not be found!";
    } else if ("updateFailed".equals(errCode)) {
        message = "Failed to update the category. Please try again.";
    } else if ("deleteFailed".equals(errCode)) {
        message = "Failed to delete the category. Please try again.";
    } else if ("categoryAlreadyExists".equals(errCode)) {
        message = "The category already exists!";
    } else if ("serverError".equals(errCode)) {
        message = "A server error has occurred!";
    } else if ("loadingCategoryError".equals(errCode)) {
        message = "Error Loading Category!";
    }
%>
<div class="container">
    <h1>Category Management</h1>
    <%
        if (message != null) {
    %>
    <p class="error-message"><%= message %></p>
    <%
        }
    %>
    <a href="adminCreateCategory.jsp" class="btn-create">Create New Category</a>
    <table>
        <thead>
            <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <%
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
            <tr>
                <td><%= id %></td>
                <td>
                    <form action="${pageContext.request.contextPath}/category" method="post" style="display:inline;">
                        <input type="hidden" name="categoryId" value="<%= id %>">
                        <input type="hidden" name="action" value="update">
                        <input type="text" name="categoryName" value="<%= name %>" required>
                        <button type="submit" class="btn-update" onclick="return confirmUpdate(this)">Update</button>
                    </form>
                </td>
                <td>
                    <form action="${pageContext.request.contextPath}/category" method="post" style="display:inline;">
                        <input type="hidden" name="categoryId" value="<%= id %>">
                        <input type="hidden" name="action" value="delete">
                        <button type="submit" class="btn-delete" onclick="return confirmDelete()">Delete</button>
                    </form>
                </td>
            </tr>
            <%
                        }
                    }
                } catch (Exception e) {
                    out.println("<p class='error-message'>Error loading categories.</p>");
                }
            %>
        </tbody>
    </table>
</div>
</body>
</html>
