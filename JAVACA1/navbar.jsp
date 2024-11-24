<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Navbar with Dropdowns</title>
<style>
    /* General styles */
    body {
        margin: 0;
        font-family: 'Arial', sans-serif;
        background-color: #f4f4f4;
    }

    .navbar {
        background: linear-gradient(90deg, #2E8B57, #66CDAA); /* Green gradient */
        padding: 10px 20px;
        display: flex;
        justify-content: space-between;
        align-items: center;
        box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        position: sticky;
        top: 0;
        z-index: 1000;
    }

    .navbar a {
        color: white;
        padding: 10px 15px;
        text-decoration: none;
        border-radius: 5px;
        font-size: 16px;
        transition: all 0.3s ease;
    }

    .navbar a:hover {
        background-color: rgba(255, 255, 255, 0.2);
    }

    .dropdown {
        position: relative;
        display: inline-block;
    }

    .dropdown a {
        cursor: pointer;
    }

    .dropdown-content {
        display: none;
        position: absolute;
        background-color: white;
        box-shadow: 0px 8px 16px rgba(0, 0, 0, 0.2);
        border-radius: 8px;
        padding: 10px 0;
        z-index: 100;
        min-width: 200px;
        text-align: left;
    }

    .dropdown-content a {
        color: #333;
        padding: 10px 15px;
        text-decoration: none;
        display: block;
        border-radius: 5px;
        font-size: 14px;
        transition: all 0.3s ease;
    }

    .dropdown-content a:hover {
        background-color: #f2f2f2;
    }

    .dropdown:hover .dropdown-content {
        display: block;
        animation: fadeIn 0.3s ease;
    }

    .dropdown:hover > a {
        background-color: rgba(255, 255, 255, 0.2);
    }

    @keyframes fadeIn {
        from {
            opacity: 0;
            transform: translateY(-10px);
        }
        to {
            opacity: 1;
            transform: translateY(0);
        }
    }

    /* Mobile Responsive */
    @media (max-width: 768px) {
        .navbar {
            flex-direction: column;
            align-items: flex-start;
        }

        .navbar a {
            margin: 5px 0;
        }
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
    <div class="navbar">
        <div>
        <%
        String navbaruserRole = (String) session.getAttribute("sessUserRole"); // getting attribute in session
        if (navbaruserRole != null && navbaruserRole.equals("admin")) { // Check if userRole is not null and equals "admin"
        %>
            <a href="${pageContext.request.contextPath}/JAVACA1/home.jsp">Home</a>
            
            <!-- Category Dropdown -->
            <div class="dropdown">
                <a href="javascript:void(0)">Category</a>
                <div class="dropdown-content">
                    <a href="${pageContext.request.contextPath}/JavaCA1/JAVACA1/category/adminCreateCategory.jsp">Create Categories</a>
                    <a href="${pageContext.request.contextPath}/JavaCA1/JAVACA1/category/adminViewUpdateDeleteCategory.jsp">Manage Categories</a>
                </div>
            </div>

            <!-- Service Dropdown -->
            <div class="dropdown">
                <a href="javascript:void(0)">Service</a>
                <div class="dropdown-content">
                    <a href="${pageContext.request.contextPath}/JavaCA1/JAVACA1/service/adminCreateService.jsp">Create Services</a>
                    <a href="${pageContext.request.contextPath}/JavaCA1/JAVACA1/service/adminViewUpdateDeleteService.jsp">Manage Services</a>
                </div>
            </div>

            <a href="${pageContext.request.contextPath}/JAVACA1/booking.jsp">Booking</a>
            <a href="${pageContext.request.contextPath}/getCart">Cart</a>
        <%
        } else if (navbaruserRole != null && navbaruserRole.equals("member")) { // Check if userRole equals "member"
        %>
            <a href="${pageContext.request.contextPath}/JAVACA1/home.jsp">Home</a>
            <a href="${pageContext.request.contextPath}/JavaCA1/JAVACA1/service/generalViewService.jsp">Services</a>
            <a href="${pageContext.request.contextPath}/JavaCA1/JAVACA1/category/generalViewCategory.jsp">Categories</a>
            <a href="${pageContext.request.contextPath}/JAVACA1/register.jsp">Register</a>
            <a href="${pageContext.request.contextPath}/JAVACA1/booking.jsp">Booking</a>
            <a href="${pageContext.request.contextPath}/getCart">Cart</a>
        <%
        } else { // Default for users with no role
        %>
            <a href="${pageContext.request.contextPath}/JAVACA1/home.jsp">Home</a>
            <a href="${pageContext.request.contextPath}/JavaCA1/JAVACA1/service/generalViewService.jsp">Services</a>
            <a href="${pageContext.request.contextPath}/JavaCA1/JAVACA1/category/generalViewCategory.jsp">Categories</a>
            <a href="${pageContext.request.contextPath}/JAVACA1/register.jsp">Register</a>
        <%
        }
        %>
        </div>
        <a href="${pageContext.request.contextPath}/memberPage.jsp">Profile</a>
    </div>
</body>
</html>
