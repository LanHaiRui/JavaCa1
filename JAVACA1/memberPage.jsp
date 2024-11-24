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
        String sessUserRole = (String) session.getAttribute("sessUserRole");

        // If no session attributes found, redirect to login
        if (sessName == null) {
            response.sendRedirect("login.jsp?errCode=invalidLogin");
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
            <form action="saveProfileServlet" method="POST">
                <div class="form-group">
                    <label for="firstName">Name</label>
                    <input type="text" id="Name" name="Name" placeholder="Name">
                </div>
                <div class="form-group">
                    <label for="mobileNumber">Mobile Number</label>
                    <input type="tel" id="mobileNumber" name="mobileNumber" placeholder="Enter phone number">
                </div>
                <div class="form-group">
                    <label for="address">Address</label>
                    <input type="text" id="address" name="address" placeholder="Enter address">
                </div>
      			<div class="form-group">
                    <label for="email">Email ID</label>
                    <input type="email" id="email" name="email" placeholder="Enter email ID">
                </div>
                <button type="submit" class="save-btn">Save Profile</button>
            </form>
        </div>
    </div>
</body>
</html>
