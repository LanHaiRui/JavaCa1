package servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

@WebServlet("/AddToCart")
public class AddToCart extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // Database connection details
    private static final String DB_URL = "jdbc:mysql://localhost/javaca1?user=root&password=Jasper1402@123&serverTimezone=UTC";

    // Handle GET request (this will be triggered by the redirection from BookingServlet)
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get the session and user ID
        HttpSession session = request.getSession(false);
        if (session == null) {
            response.getWriter().println("Session is null");
            return;
        }

        if (session.getAttribute("sessId") == null) {
            response.getWriter().println("userId attribute is missing in session");
            return;
        }

        String userIdStr = (String) session.getAttribute("sessId");
        int userId = Integer.parseInt(userIdStr);

        // Retrieve the bookingId from the session
        Integer bookingId = (Integer) session.getAttribute("bookingId");

        if (bookingId == null) {
            response.getWriter().println("Error: No booking ID found in session.");
            return;
        }

        // Insert the booking into the cart
        try (Connection conn = DriverManager.getConnection(DB_URL)) {
            String sql = "INSERT INTO cart (user_id, booking_id) VALUES (?, ?)";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setInt(1, userId);
                stmt.setInt(2, bookingId);
                stmt.executeUpdate();
            }

            // Redirect to the cart page after adding the booking
            response.sendRedirect("getCart");

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write("Error adding booking to cart. Please try again later.");
        }
    }
}





