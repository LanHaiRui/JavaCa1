<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Create Category</title>
</head>
<body>
<%
    // Error handling logic
    String errCode = request.getParameter("errCode");
    String message = null;
    if ("categoryAlreadyExists".equals(errCode)) {
        message = "This category already exists!";
    } else if ("invalidCategory".equals(errCode)) {
        message = "This category is invalid!";
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

<h1>Create New Category</h1>
<form action="${pageContext.request.contextPath}/category" method="post">
    <input type="hidden" name="action" value="create">
    <label for="categoryName">Category Name:</label>
    <input type="text" id="categoryName" name="categoryName" required>
    <br><br>
    <input type="submit" value="Create">
    <input type="reset" value="Reset">
</form>
</body>
</html>