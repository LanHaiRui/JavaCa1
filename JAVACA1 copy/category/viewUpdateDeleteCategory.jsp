<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>View, Update, Delete Category</title>
    <style>
        table {
            width: 100%;
            border-collapse: collapse;
            overflow-x: auto;
        }
        table, th, td {
            border: 1px solid black;
        }
        th, td {
            padding: 8px;
            text-align: left;
        }
        tbody {
            display: block;
            overflow-y: scroll;
            height: 300px;
        }
        thead, tbody tr {
            display: table;
            width: 100%;
            table-layout: fixed;
        }
    </style>
    <script>
        function confirmUpdate(button) {
            let textBox = button.previousElementSibling;
            if (textBox.value.trim() === "") {
                alert("Please enter a category name.");
                return false;
            }
            return confirm("Are you sure you want to change the name of this category?");
        }

        function confirmDelete() {
            return confirm("Are you sure you want to delete this category? All services under this category will be removed.");
        }

        function toggleUpdateButton(textBox, button) {
            button.disabled = textBox.value.trim() === "";
        }
    </script>
</head>
<body>
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
                <td><%= name %></td>
                <td>
                    <form action="${pageContext.request.contextPath}/category" method="post" style="display:inline;">
                        <input type="hidden" name="categoryId" value="<%= id %>">
                        <input type="text" name="categoryName" onkeyup="toggleUpdateButton(this, this.nextElementSibling)" placeholder="New name">
                        <button type="submit" name="action" value="update" disabled onclick="return confirmUpdate(this)">Update</button>
                    </form>
                    <form action="${pageContext.request.contextPath}/category" method="post" style="display:inline;">
                        <input type="hidden" name="categoryId" value="<%= id %>">
                        <button type="submit" name="action" value="delete" onclick="return confirmDelete()">Delete</button>
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