<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register Member</title>
    <link rel="stylesheet" href="styles/register.css">
</head>
<body>
	<%@ include file="navbar.jsp" %>
   <div class="main-container">
    <div class="container">
        <!-- Right Section -->
        <div class="right">
            <h2>Already have an account?</h2>
            <p>CLick here to Login!</p>
            <button class="btn" onclick="window.location.href='login.jsp'">Login</button>
        </div>
        <!-- Left Section -->
        <div class="left">
            <div class="logo">SparkleShine</div>
            <h1>Register Here</h1>
            <!-- Registration Form -->
    <form action="${pageContext.request.contextPath}/registerMember" method="POST">
        <div class="form-group">
            <label for="name">Full Name</label>
            <input type="text" id="name" name="name" required placeholder="Enter your full name">
        </div>
        
        <div class="form-group">
            <label for="email">Email</label>
            <input type="email" id="email" name="email" required placeholder="Enter your email address">
        </div>
        
        <div class="form-group">
            <label for="password">Password</label>
            <input type="password" id="password" name="password" required placeholder="Enter your password">
        </div>
        
        <div class="form-group">
            <label for="mobileNumber">Mobile Number</label>
            <input type="tel" id="mobileNumber" name="mobileNumber" required 
           placeholder="Enter your phone number" 
           pattern="\d{8}" 
           title="Phone number must be exactly 8 digits" 
           maxlength="8">
        </div>
        
        <div class="form-group">
            <label for="address">Address</label>
            <input type="text" id="address" name="address" required placeholder="Enter your address">
        </div>
        
        <button type="submit" class="btn">Register</button>
    </form>
        </div>
    </div>
    </div>
   
</body>
</html>
