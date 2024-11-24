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
    String errCode = request.getParameter("errCode");
    if ("serviceAlreadyExists".equals(errCode)) {
        out.println("<p style='color:red;'>This service already exists!</p>");
    }
    if ("invalidService".equals(errCode)) {
        out.println("<p style='color:red;'>This service is invalid!</p>");
    }
    if ("serverError".equals(errCode)) {
        out.println("<p style='color:red;'>A server error has occurred!</p>");
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
    <form action="${pageContext.request.contextPath}/service" method="post">
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
        
        <input type="submit" value="Create" <%= allowSubmit ? "" : "disabled" %>>
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
        out.print("<p><a href='../category/createCategory.jsp' style='color:blue; text-decoration:underline;'>Click here to add categories</a></p>");
    }
%>
</body>
</html>