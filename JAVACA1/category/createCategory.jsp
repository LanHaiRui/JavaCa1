<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Create Category</title>
</head>
<body>

    <%
        String errCode = request.getParameter("errCode");
        if ("categoryAlreadyExists".equals(errCode)) {
            out.println("<p style='color:red;'>This category already exists!</p>");
        }
        if ("invalidCategory".equals(errCode)) {
            out.println("<p style='color:red;'>This category is invalid!</p>");
        }
	    if ("serverError".equals(errCode)) {
	        out.println("<p style='color:red;'>This category is invalid!</p>");
	    }
        
    %>
    
    <form action="${pageContext.request.contextPath}/category" method="post">
    	<input type="hidden" name="action" value="create">
        <label for="categoryName">New Category Name:</label>
        <input type="text" id="categoryName" name="categoryName" required><br><br>
        <input type="submit" value="Create">		
        <input type="reset" value="Reset">
    </form> 
</body>
</html>