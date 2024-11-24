<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>View, Update, Delete Service</title>
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
            const row = button.closest('tr');
            const serviceName = row.querySelector('.serviceName').value.trim();
            const imageLink = row.querySelector('.imageLink').value.trim();
            const category = row.querySelector('.categoryDropdown').value;

            if (!serviceName || !imageLink || !category) {
                alert("Please ensure all fields are filled.");
                return false;
            }

            return confirm("Are you sure you want to update this service?");
        }

        function enableUpdateButton(row) {
            const updateButton = row.querySelector('.updateButton');
            const originalName = row.querySelector('.serviceName').getAttribute('data-original');
            const originalLink = row.querySelector('.imageLink').getAttribute('data-original');
            const originalCategory = row.querySelector('.categoryDropdown').getAttribute('data-original');

            const currentName = row.querySelector('.serviceName').value.trim();
            const currentLink = row.querySelector('.imageLink').value.trim();
            const currentCategory = row.querySelector('.categoryDropdown').value;

            updateButton.disabled = 
                originalName === currentName &&
                originalLink === currentLink &&
                originalCategory === currentCategory;
        }

        function populateHiddenFields(form) {
            const row = form.closest('tr');
            const serviceNameField = row.querySelector('.serviceName');
            const imageLinkField = row.querySelector('.imageLink');
            const categoryDropdown = row.querySelector('.categoryDropdown');

            // Populate hidden fields with current values or original values if unchanged
            form.querySelector('.newServiceName').value = serviceNameField.value.trim() || serviceNameField.getAttribute('data-original');
            form.querySelector('.newImageLink').value = imageLinkField.value.trim() || imageLinkField.getAttribute('data-original');
            form.querySelector('.newCategoryId').value = categoryDropdown.value || categoryDropdown.getAttribute('data-original');
        }

        function confirmDelete() {
            return confirm("Are you sure you want to delete this service?");
        }
    </script>
</head>
<body>
<%
    // Error handling logic
    String errCode = request.getParameter("errCode");
    String message = null;
    if ("serviceNotFound".equals(errCode)) {
        message = "The specified service could not be found!";
    } else if ("updateFailed".equals(errCode)) {
        message = "Failed to update the service. Please try again.";
    } else if ("deleteFailed".equals(errCode)) {
        message = "Failed to delete the service. Please try again.";
    } else if ("serviceAlreadyExists".equals(errCode)) {
        message = "The service already exists!";
    } else if ("imageLinkAlreadyExists".equals(errCode)) {
        message = "The image link already exists! Please use a unique link.";
    } else if ("serverError".equals(errCode)) {
        message = "A server error has occurred. Please try again later.";
    }

    if (message != null) {
%>
    <script>
        alert("<%= message %>");
    </script>
<%
    }
%>

    <h1>Service Management</h1>
    <table>
        <thead>
            <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Image Link</th>
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
                         ResultSet serviceRs = stmt.executeQuery("SELECT s.id, s.name, s.image_link, s.category_id, c.name AS category_name FROM service s JOIN category c ON s.category_id = c.id")) {
                        while (serviceRs.next()) {
                            int id = serviceRs.getInt("id");
                            String name = serviceRs.getString("name");
                            String imageLink = serviceRs.getString("image_link");
                            int categoryId = serviceRs.getInt("category_id");
            %>
            <tr>
                <td><%= id %></td>
                <td>
                    <input type="text" value="<%= name %>" class="serviceName" data-original="<%= name %>" oninput="enableUpdateButton(this.closest('tr'))">
                </td>
                <td>
                    <input type="text" value="<%= imageLink %>" class="imageLink" data-original="<%= imageLink %>" oninput="enableUpdateButton(this.closest('tr'))">
                </td>
                <td>
                    <select class="categoryDropdown" data-original="<%= categoryId %>" onchange="enableUpdateButton(this.closest('tr'))">
                        <%
                            try (Statement categoryStmt = conn.createStatement();
                                 ResultSet categoryRs = categoryStmt.executeQuery("SELECT id, name FROM category")) {
                                while (categoryRs.next()) {
                                    int catId = categoryRs.getInt("id");
                                    String catName = categoryRs.getString("name");
                                    boolean isSelected = catId == categoryId;
                        %>
                        <option value="<%= catId %>" <%= isSelected ? "selected" : "" %>><%= catName %></option>
                        <%
                                }
                            }
                        %>
                    </select>
                </td>
                <td>
                    <form action="${pageContext.request.contextPath}/service" method="post" style="display:inline;" onsubmit="populateHiddenFields(this)">
                        <input type="hidden" name="serviceId" value="<%= id %>">
                        <input type="hidden" name="action" value="update">
                        <input type="hidden" class="newServiceName" name="serviceName">
                        <input type="hidden" class="newImageLink" name="image_link">
                        <input type="hidden" class="newCategoryId" name="category">
                        <button type="submit" class="updateButton" disabled onclick="return confirmUpdate(this)">Update</button>
                    </form>
                    <form action="${pageContext.request.contextPath}/service" method="post" style="display:inline;">
                        <input type="hidden" name="serviceId" value="<%= id %>">
                        <input type="hidden" name="action" value="delete">
                        <button type="submit" onclick="return confirmDelete()">Delete</button>
                    </form>
                </td>
            </tr>
            <%
                        }
                    }
                } catch (Exception e) {
                    out.println("<p style='color:red;'>Error loading services.</p>");
                }
            %>
        </tbody>
    </table>
</body>
</html>