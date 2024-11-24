<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="servlets.CartItem" %>
<%-- Fetch the cart items from the request attribute set by the servlet --%>
<%
    List<CartItem> cartItems = (List<CartItem>) request.getAttribute("cartItems");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Your Cart</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f4f4;
        }
        .container {
            width: 80%;
            margin: 0 auto;
            padding: 20px;
            background-color: white;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        table {
            width: 100%;
            margin-bottom: 20px;
            border-collapse: collapse;
        }
        table, th, td {
            border: 1px solid #ddd;
        }
        th, td {
            padding: 12px;
            text-align: left;
        }
        th {
            background-color: #f4f4f4;
        }
        .total {
            text-align: right;
            font-weight: bold;
        }
        .button {
            background-color: #4CAF50;
            color: white;
            padding: 10px 20px;
            border: none;
            cursor: pointer;
            text-align: center;
            display: inline-block;
            margin-top: 20px;
        }
        .button:hover {
            background-color: #45a049;
        }
         .button:hover {
            background-color: #45a049;
        }
        .delete-button {
            background-color: #f44336;
            color: white;
            padding: 5px 10px;
            border: none;
            cursor: pointer;
        }
        .delete-button:hover {
            background-color: #d32f2f;
        }
    </style>
</head>
<body>
<%@ include file="navbar.jsp" %>

<%-- Check if the cart is empty --%>
<%
    if (cartItems == null || cartItems.isEmpty()) {
%>
        <p>Your cart is empty. Please add items to your cart.</p>
        <button class="button" onclick="window.location.href='booking.jsp'">Go to book</button>
<%
    } else {
%>
    <div class="container">
        <h1>Your Cart</h1>
        <table>
            <thead>
                <tr>
                    <th>Service Name</th>
                    <th>Booking Date</th>
                    <th>Booking Time</th>
                    <th>Description</th>
                    <th>remove</th>
                </tr>
            </thead>
            <tbody>
            <%
          
                // Loop through each item in the cart
                for (CartItem item : cartItems) {
                    String serviceName = item.getServiceName();
                    String bookingDate = item.getBookingDate();
                    String bookingTime = item.getBookingTime();
                    String description = item.getDescription();
                    int bookingId = item.getBookingId(); 

            %>
                <tr>
                    <td><%= serviceName %></td>
                    <td><%= bookingDate %></td>
                    <td><%= bookingTime %></td>
                    <td><%= description %></td>
                    <td>
                        <!-- Delete button -->
                        <form action="RemoveFromCart" method="post" style="display:inline;">
                            <input type="hidden" name="bookingId" value="<%= bookingId %>">
                            <button type="submit" class="delete-button">Delete</button>
                        </form>
                    </td>
                </tr>
            <% 
                }
            %>
            </tbody>
        </table>

        

        <button class="button" onclick="window.location.href='checkout.jsp'">Proceed to Checkout</button>
    </div>
<%  
    }
%>

</body>
</html>


