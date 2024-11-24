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
                    <input type="text" id="firstName" name="firstName" placeholder="First Name">
                    <input type="text" id="surname" name="surname" placeholder="Surname">
                </div>
                <div class="form-group">
                    <label for="mobileNumber">Mobile Number</label>
                    <input type="tel" id="mobileNumber" name="mobileNumber" placeholder="Enter phone number">
                </div>
                <div class="form-group">
                    <label for="address1">Address Line 1</label>
                    <input type="text" id="address1" name="address1" placeholder="Enter address line 1">
                </div>
                <div class="form-group">
                    <label for="address2">Address Line 2</label>
                    <input type="text" id="address2" name="address2" placeholder="Enter address line 2">
                </div>
                <div class="form-group">
                    <label for="postcode">Postcode</label>
                    <input type="text" id="postcode" name="postcode" placeholder="Enter postcode">
                </div>
                <div class="form-group">
                    <label for="state">State</label>
                    <input type="text" id="state" name="state" placeholder="Enter state">
                </div>
                <div class="form-group">
                    <label for="area">Area</label>
                    <input type="text" id="area" name="area" placeholder="Enter area">
                </div>
                <div class="form-group">
                    <label for="email">Email ID</label>
                    <input type="email" id="email" name="email" placeholder="Enter email ID">
                </div>
                <div class="form-group">
                    <label for="education">Education</label>
                    <input type="text" id="education" name="education" placeholder="Education">
                </div>
                <div class="form-group">
                    <label for="country">Country</label>
                    <input type="text" id="country" name="country" placeholder="Country">
                    <input type="text" id="stateRegion" name="stateRegion" placeholder="State/Region">
                </div>
                <button type="submit" class="save-btn">Save Profile</button>
            </form>
        </div>
    </div>
</body>
</html>
