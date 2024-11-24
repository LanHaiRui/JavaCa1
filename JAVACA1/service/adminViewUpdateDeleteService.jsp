<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Service Management</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f9f9f9;
            margin: 0;
            padding: 20px;
        }

        h1 {
            text-align: center;
            color: #333;
            margin-bottom: 20px;
        }

        .container {
            max-width: 1000px;
            margin: 0 auto;
            background: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }

        button {
            background-color: #007BFF;
            color: white;
            border: none;
            padding: 10px 20px;
            font-size: 16px;
            border-radius: 5px;
            cursor: pointer;
            margin-bottom: 20px;
        }

        button:hover {
            background-color: #0056b3;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }

        th, td {
            padding: 10px;
            text-align: left;
            border: 1px solid #ddd;
        }

        th {
            background-color: #f4f4f4;
        }

        tr:nth-child(even) {
            background-color: #f9f9f9;
        }

        tr:hover {
            background-color: #f1f1f1;
        }

        input[type="text"], textarea, select {
            width: 100%;
            padding: 8px;
            margin: 4px 0;
            box-sizing: border-box;
            border: 1px solid #ccc;
            border-radius: 4px;
        }

        input[type="text"]:focus, textarea:focus, select:focus {
            border-color: #007BFF;
            outline: none;
        }

        .action-buttons {
            display: flex;
            gap: 10px;
        }

        button[disabled] {
            background-color: #ccc;
            cursor: not-allowed;
        }

        p.error-message {
            color: red;
            font-weight: bold;
            text-align: center;
        }
    </style>
    <script>
        function confirmUpdate(button) {
            const row = button.closest('tr');
            const serviceName = row.querySelector('.serviceName').value.trim();
            const imageLink = row.querySelector('.imageLink').value.trim();
            const description = row.querySelector('.description').value.trim();
            const category = row.querySelector('.categoryDropdown').value;

            if (!serviceName || !imageLink || !description || !category) {
                alert("Please ensure all fields are filled.");
                return false;
            }

            return confirm("Are you sure you want to update this service?");
        }

        function enableUpdateButton(row) {
            const updateButton = row.querySelector('.updateButton');
            const originalName = row.querySelector('.serviceName').getAttribute('data-original');
            const originalLink = row.querySelector('.imageLink').getAttribute('data-original');
            const originalDescription = row.querySelector('.description').getAttribute('data-original');
            const originalCategory = row.querySelector('.categoryDropdown').getAttribute('data-original');

            const currentName = row.querySelector('.serviceName').value.trim();
            const currentLink = row.querySelector('.imageLink').value.trim();
            const currentDescription = row.querySelector('.description').value.trim();
            const currentCategory = row.querySelector('.categoryDropdown').value;

            updateButton.disabled =
                originalName === currentName &&
                originalLink === currentLink &&
                originalDescription === currentDescription &&
                originalCategory === currentCategory;
        }

        function populateHiddenFields(form) {
            const row = form.closest('tr');
            form.querySelector('.newServiceName').value = row.querySelector('.serviceName').value.trim();
            form.querySelector('.newImageLink').value = row.querySelector('.imageLink').value.trim();
            form.querySelector('.newDescription').value = row.querySelector('.description').value.trim();
            form.querySelector('.newCategoryId').value = row.querySelector('.categoryDropdown').value;
        }

        function confirmDelete() {
            return confirm("Are you sure you want to delete this service?");
        }
    </script>
</head>
<body>
<%@ include file="../navbar.jsp" %>
<div class="container">
    <h1>Service Management</h1>
    <button onclick="window.location.href='adminCreateService.jsp'">Create Service</button>
    <%
        String errCode = request.getParameter("errCode");
        if (errCode != null) {
            String message = null;
            switch (errCode) {
                case "serviceNotFound":
                    message = "The specified service could not be found!";
                    break;
                case "updateFailed":
                    message = "Failed to update the service. Please try again.";
                    break;
                case "deleteFailed":
                    message = "Failed to delete the service. Please try again.";
                    break;
                case "serviceAlreadyExists":
                    message = "The service already exists!";
                    break;
                case "imageLinkAlreadyExists":
                    message = "The image link already exists! Please use a unique link.";
                    break;
                case "serverError":
                    message = "A server error has occurred. Please try again later.";
                    break;
            }
            if (message != null) {
    %>
    <p class="error-message"><%= message %></p>
    <%
            }
        }
    %>
    <table>
        <thead>
            <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Image Link</th>
                <th>Description</th>
                <th>Category</th>
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
                     ResultSet rs = stmt.executeQuery("SELECT s.id, s.name, s.image_link, s.description, s.category_id, c.name AS category_name FROM service s JOIN category c ON s.category_id = c.id")) {
                    while (rs.next()) {
                        int id = rs.getInt("id");
                        String name = rs.getString("name");
                        String imageLink = rs.getString("image_link");
                        String description = rs.getString("description");
                        int categoryId = rs.getInt("category_id");
        %>
        <tr>
            <td><%= id %></td>
            <td>
                <input type="text" class="serviceName" value="<%= name %>" data-original="<%= name %>" oninput="enableUpdateButton(this.closest('tr'))">
            </td>
            <td>
                <input type="text" class="imageLink" value="<%= imageLink %>" data-original="<%= imageLink %>" oninput="enableUpdateButton(this.closest('tr'))">
            </td>
            <td>
                <textarea class="description" rows="2" data-original="<%= description %>" oninput="enableUpdateButton(this.closest('tr'))"><%= description %></textarea>
            </td>
            <td>
                <select class="categoryDropdown" data-original="<%= categoryId %>" onchange="enableUpdateButton(this.closest('tr'))">
                    <%
                        try (Statement stmtCat = conn.createStatement();
                             ResultSet rsCat = stmtCat.executeQuery("SELECT id, name FROM category")) {
                            while (rsCat.next()) {
                                int catId = rsCat.getInt("id");
                                String catName = rsCat.getString("name");
                                boolean selected = catId == categoryId;
                    %>
                    <option value="<%= catId %>" <%= selected ? "selected" : "" %>><%= catName %></option>
                    <%
                            }
                        }
                    %>
                </select>
            </td>
            <td class="action-buttons">
                <form action="${pageContext.request.contextPath}/service" method="post" style="display:inline;" onsubmit="populateHiddenFields(this)">
                    <input type="hidden" name="serviceId" value="<%= id %>">
                    <input type="hidden" class="newServiceName" name="serviceName">
                    <input type="hidden" class="newImageLink" name="image_link">
                    <input type="hidden" class="newDescription" name="description">
                    <input type="hidden" class="newCategoryId" name="category">
                    <button type="submit" class="updateButton" disabled onclick="return confirmUpdate(this)">Update</button>
                </form>
                <form action="${pageContext.request.contextPath}/service" method="post" style="display:inline;">
                    <input type="hidden" name="serviceId" value="<%= id %>">
                    <button type="submit" onclick="return confirmDelete()">Delete</button>
                </form>
            </td>
        </tr>
        <%
                    }
                }
            } catch (Exception e) {
                out.println("<p class='error-message'>Error loading services. Please try again later.</p>");
            }
        %>
        </tbody>
    </table>
</div>
</body>
</html>
