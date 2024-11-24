<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Profile</title>
    <link rel="stylesheet" href="styles/memberPage.css">
</head>
<body>
    <%
        // Retrieve session attributes
        String sessName = (String) session.getAttribute("sessName");
        String sessEmail = (String) session.getAttribute("sessEmail");
        String sessMobileNumber = (String) session.getAttribute("sessMobileNumber");
        String sessAddress = (String) session.getAttribute("sessAddress");

        // If no session attributes found, redirect to login
        if (sessName == null) {
            response.sendRedirect("login.jsp?errCode=invalidLogin");
        }
    %>
    <% 
        // Check for login success parameter
        String loginSuccess = request.getParameter("loginSuccess");
        if ("true".equals(loginSuccess)) { 
    %>
        <div class="popup">
            <div class="popup-content">
                <p>Welcome, <%= sessName %>! You have successfully logged in.</p>
                <a href="memberPage.jsp" class="close-btn">OK</a>
            </div>
        </div>
    <% 
        }  
    %>
    <%@ include file="navbar.jsp" %>

    <div class="profile-container">
        <!-- Left Section -->
        <div class="profile-left">
            <img src="images/profileAvatar.png" alt="User Avatar" class="profile-avatar">
            <h2><%= sessName %></h2>
            <p><%= sessEmail %></p>
        </div>

        <!-- Right Section -->
        <div class="profile-right">
            <h2>Profile Settings</h2>
            <form action="${pageContext.request.contextPath}/saveMember" method="POST">
                <div class="form-group">
                    <label for="Name">Name</label>
                    <input type="text" id="Name" name="Name" value="<%= sessName %>" placeholder="Name">
                </div>
                <div class="form-group">
                    <label for="mobileNumber">Mobile Number</label>
                    <input type="tel" id="mobileNumber" name="mobileNumber" value="<%= sessMobileNumber %>" placeholder="Enter phone number">
                </div>
                <div class="form-group">
                    <label for="address">Address</label>
                    <input type="text" id="address" name="address" value="<%= sessAddress %>" placeholder="Enter address">
                </div>
                <div class="form-group">
                    <label for="email">Email ID</label>
                    <input type="email" id="email" name="email" value="<%= sessEmail %>" placeholder="Enter email ID">
                </div>
                <button type="submit" class="save-btn">Save Profile</button>
            </form>
            <div class="container">
            	<!-- Logout Section -->
            	<div class="logout-section">
                	<form action="${pageContext.request.contextPath}/LogOutMember" method="get">
                	    <button type="submit" class="logout-btn">Logout</button>
                	</form>
            	</div>
            	<!-- Delete Profile Section -->
            	<div class="delete-profile-section">
                	<form action="${pageContext.request.contextPath}/deleteMember" method="POST">
                    	<button type="submit" class="delete-btn" onclick="return confirm('Are you sure you want to delete your profile? This action cannot be undone.')">Delete Profile</button>
                	</form>
            	</div>
            </div>
            
        </div>
    </div>
</body>
</html>

