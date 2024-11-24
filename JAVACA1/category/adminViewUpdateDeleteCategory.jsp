<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>View, Update, Delete Categories</title>
    <style>
        table {
            width: 100%;
            border-collapse: collapse;
        }
        table, th, td {
            border: 1px solid black;
        }
        th, td {
            padding: 8px;
            text-align: left;
        }
    </style>
    <script>
        function confirmUpdate(button) {
            const row = button.closest('tr');
            const categoryName = row.querySelector('.categoryName').value.trim();

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
<%
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
    }

    if (message != null) {
%>
    <script>
        alert("<%= message %>");
    </script>
<%
    }
%>

<h1>Category Management</h1>
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
                    <button type="submit" onclick="return confirmUpdate(this)">Update</button>
                </form>
            </td>
            <td>
                <form action="${pageContext.request.contextPath}/category" method="post" style="display:inline;">
                    <input type="hidden" name="categoryId" value="<%= id %>">
                    <input type="hidden" name="action" value="delete">
                    <button type="submit" onclick="return confirmDelete()">Delete</button>
                </form>
            </td>
        </tr>
        <%
                    }
                }
            } catch (Exception e) {
                out.println("<p style='color:red;'>Error loading categories.</p>");
            }
        %>
    </tbody>
</table>
</body>
</html>