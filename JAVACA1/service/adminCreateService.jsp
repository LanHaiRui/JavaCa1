<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Create Service</title>
</head>
<body>
<%
    // Error handling logic
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
    <form action="${pageContext.request.contextPath}/service" method="post" id="createServiceForm">
        <input type="hidden" name="action" value="create">
        <label for="serviceName">New Service Name:</label>
        <input type="text" id="serviceName" name="serviceName" required><br><br>
        
        <label for="image_link">Image Link:</label>
        <input type="text" id="image_link" name="image_link" required><br><br>
        
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
        </select><br><br>
    
        <label for="description">Description:</label>
        <textarea id="description" name="description" rows="4" cols="50" required></textarea><br><br>
    
        <input type="submit" id="submitButton" value="Create" disabled>
        <input type="reset" value="Reset">
    </form>
<%
    } catch (Exception e) {
        out.println("<p style='color:red;'>Error loading categories. Please try again later.</p>");
    } finally {
        try { if (rs != null) rs.close(); } catch (SQLException ignore) {}
        try { if (conn != null) conn.close(); } catch (SQLException ignore) {}
    }

    if (!allowSubmit) {
        out.println("<p style='color:red;'>No categories available. Please add categories first.</p>");
        out.print("<p><a href='../category/adminCreateCategory.jsp' style='color:blue; text-decoration:underline;'>Click here to add categories</a></p>");
    }
%>

<script>
    const form = document.getElementById('createServiceForm');
    const submitButton = document.getElementById('submitButton');

    // Function to check if all fields are filled
    function validateForm() {
        const serviceName = document.getElementById('serviceName').value.trim();
        const imageLink = document.getElementById('image_link').value.trim();
        const category = document.getElementById('category').value;
        const description = document.getElementById('description').value.trim();

        // Enable the submit button only if all fields are filled
        submitButton.disabled = !(serviceName && imageLink && category && description);
    }

    // Attach event listeners to form fields
    form.addEventListener('input', validateForm);
    form.addEventListener('change', validateForm);
</script>
</body>
</html>