<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
        /* General styles */

        .navbar {
            background-color: #9C89B8;
            overflow: hidden;
            padding: 10px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .navbar a {
            color: white;
            padding: 14px 20px;
            text-decoration: none;
            float: left;
        }
        .navbar a:hover {
            background-color: #ddd;
            color: black;
        }
</style>
</head>
<body>
	<div class="navbar">
		<div>
			<a href="index.jsp">Home</a>
        	<a href="services.jsp">Services</a>
        	<a href="register.jsp">Register</a>
        	<a href="contact.jsp">Contact Us</a>
		</div>
		<a href="memberPage.jsp">Profile</a>
    </div>
</body>
</html>