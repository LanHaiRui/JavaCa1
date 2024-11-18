<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cleaning Services</title>
    <style>
        /* General styles */
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f7f8fa;
        }

        header {
            background-color: #4CAF50;
            color: white;
            padding: 20px;
            text-align: center;
        }

        nav {
            display: flex;
            justify-content: center;
            background-color: #333;
        }

        nav a {
            color: white;
            padding: 14px 20px;
            text-decoration: none;
            text-align: center;
        }

        nav a:hover {
            background-color: #575757;
        }

        .hero-section {
            background-image: url('images/cleaning-hero.jpg'); /* Replace with a relevant image path */
            background-size: cover;
            background-position: center;
            color: white;
            text-align: center;
            padding: 100px 20px;
        }

        .hero-section h1 {
            font-size: 50px;
            margin: 0;
        }

        .hero-section p {
            font-size: 20px;
            margin: 10px 0 20px;
        }

        .hero-section button {
            padding: 15px 30px;
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 5px;
            font-size: 18px;
            cursor: pointer;
        }

        .hero-section button:hover {
            background-color: #45a049;
        }

        .services-section {
            padding: 50px 20px;
            text-align: center;
        }

        .services-section h2 {
            margin-bottom: 30px;
            font-size: 36px;
        }

        .services-container {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            gap: 20px;
        }

        .service-card {
            background-color: white;
            border: 1px solid #ddd;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            width: 300px;
            padding: 20px;
            text-align: center;
        }

        .service-card img {
            max-width: 100%;
            border-radius: 5px;
        }

        .service-card h3 {
            margin: 15px 0;
            font-size: 24px;
        }

        .service-card p {
            color: #555;
        }

        .service-card button {
            padding: 10px 20px;
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }

        .service-card button:hover {
            background-color: #45a049;
        }

        footer {
            background-color: #333;
            color: white;
            text-align: center;
            padding: 10px 0;
        }
    </style>
</head>
<body>
    <header>
        <h1>Welcome to Our Cleaning Services</h1>
    </header>
    <nav>
        <a href="home.jsp">Home</a>
        <a href="services.jsp">Services</a>
        <a href="register.jsp">Register</a>
        <a href="login.jsp">Login</a>
    </nav>
    <div class="hero-section">
        <h1>Professional Cleaning Services</h1>
        <p>We make your space sparkling clean and comfortable.</p>
        <button onclick="window.location.href='services.jsp'">Explore Our Services</button>
    </div>
    <div class="services-section">
        <h2>Our Services</h2>
        <div class="services-container">
            <div class="service-card">
                <img src="images/home-cleaning.jpg" alt="Home Cleaning">
                <h3>Home Cleaning</h3>
                <p>Professional cleaning for your home, customized to your needs.</p>
                <button>Learn More</button>
            </div>
            <div class="service-card">
                <img src="images/office-cleaning.jpg" alt="Office Cleaning">
                <h3>Office Cleaning</h3>
                <p>Keep your office spotless with our expert cleaning team.</p>
                <button>Learn More</button>
            </div>
            <div class="service-card">
                <img src="images/carpet-cleaning.jpg" alt="Carpet Cleaning">
                <h3>Carpet Cleaning</h3>
                <p>Deep cleaning for carpets to remove dirt, stains, and allergens.</p>
                <button>Learn More</button>
            </div>
        </div>
    </div>
    <footer>
        <p>&copy; 2024 Cleaning Services. All rights reserved.</p>
    </footer>
</body>
</html>
