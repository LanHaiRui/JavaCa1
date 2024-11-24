<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login Page</title>
    <link rel="stylesheet" href="styles/login.css"> <!-- Link to the CSS file -->
</head>
<body>
	<%@ include file="navbar.jsp" %>
	<div class="main-container">
    <div class="container">
        <!-- Left Section -->
        <div class="left">
            <div class="logo">SparkleShine</div>
            <h1>Login to Your Account</h1>
            <p>Login using social networks</p>
            <div class="social-icons">
                <button class="social-btn fb">f</button>
                <button class="social-btn google">G+</button>
                <button class="social-btn linkedin">in</button>
            </div>
            <div class="or-divider">
                <span>OR</span>
            </div>
            <form action="${pageContext.request.contextPath}/VerifyMembers" method="POST">
                <input type="email" name="email" placeholder="Email" required>
                <div class="password-wrapper">
                    <input type="password" name="password" placeholder="Password" required>
                    <span class="show-password"></span>
                </div>
                <button type="submit" class="btn">Sign In</button>
            </form>
        </div>

        <!-- Right Section -->
        <div class="right">
            <h2>New Here?</h2>
            <p>Sign up and discover a great amount of new opportunities!</p>
            <button class="btn" onclick="window.location.href='register.jsp'">Sign Up</button>
        </div>
    </div>
    </div>
</body>
</html>
