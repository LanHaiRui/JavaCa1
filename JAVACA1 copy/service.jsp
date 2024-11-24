<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Home Cleaning Service</title>
    <style>
        /* General styles */
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f7f8fa;
        }

        .header-section {
            background-color: #4CAF50;
            color: white;
            padding: 20px 0;
            text-align: center;
        }

        .header-section h1 {
            margin: 0;
            font-size: 36px;
        }

        .service-details {
            padding: 50px 20px;
            max-width: 900px;
            margin: 0 auto;
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        .service-details img {
            width: 100%;
            border-radius: 8px;
            margin-bottom: 20px;
        }

        .service-details h2 {
            margin: 20px 0;
            font-size: 28px;
            color: #333;
        }

        .service-details p {
            color: #555;
            line-height: 1.6;
        }

        .service-details ul {
            list-style: disc;
            padding-left: 20px;
            margin: 20px 0;
        }

        .service-details ul li {
            margin-bottom: 10px;
            color: #555;
        }

        .cta-button {
            display: inline-block;
            padding: 15px 30px;
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 5px;
            font-size: 18px;
            cursor: pointer;
            text-decoration: none;
            margin-top: 20px;
        }

        .cta-button:hover {
            background-color: #45a049;
        }

        footer {
            background-color: #333;
            color: white;
            text-align: center;
            padding: 10px 0;
            margin-top: 20px;
        }
    </style>
</head>
<body>
    <%@ include file="navbar.jsp" %>
    <div class="header-section">
        <h1>Home Cleaning Service</h1>
    </div>
    <div class="service-details">
        <img src="images/home-cleaning.jpg" alt="Home Cleaning">
        <h2>Why Choose Our Home Cleaning Service?</h2>
        <p>
            Our professional home cleaning service ensures your living space is spotless, healthy, and inviting. 
            We use eco-friendly cleaning products and tailor our services to meet your specific needs.
        </p>
        <h2>What’s Included:</h2>
        <ul>
            <li>Dusting and wiping of surfaces</li>
            <li>Vacuuming and mopping floors</li>
            <li>Bathroom and kitchen cleaning</li>
            <li>Window cleaning (interior)</li>
            <li>Customized cleaning based on your preferences</li>
        </ul>
        <h2>Contact Us</h2>
        <p>
            Ready to transform your home? Get in touch today to schedule a cleaning session!
        </p>
        <a class="cta-button" href="contact.jsp">Book Now</a>
    </div>
    <footer>
        <p>&copy; 2024 Cleaning Services. All rights reserved.</p>
    </footer>
</body>
</html>