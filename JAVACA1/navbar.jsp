
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
			<a href="${pageContext.request.contextPath}/JAVACA1/home.jsp">Home</a>
        	<a href="${pageContext.request.contextPath}/JAVACA1/services.jsp">Services</a>
        	<a href="${pageContext.request.contextPath}/JAVACA1/register.jsp">Register</a>
        	<a href="${pageContext.request.contextPath}/JAVACA1/booking.jsp">Booking</a>
        	<a href="${pageContext.request.contextPath}/getCart">cart</a>
		</div>
		<a href="${pageContext.request.contextPath}/getMember">Profile</a>
    </div>
</body>
</html>