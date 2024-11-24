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
import java.sql.ResultSet;
import java.sql.Statement;

@WebServlet("/BookingServlet")
public class BookingServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // Database connection details
    private static final String DB_URL = "jdbc:mysql://localhost/javaca1?user=root&password=Jasper1402@123&serverTimezone=UTC";

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);

        if (session == null) {
            response.getWriter().println("Session is null");
            return;
        }

        if (session.getAttribute("sessId") == null) {
            response.getWriter().println("userId attribute is missing in session");
            return;
        }

        String userIdStr = (String) session.getAttribute("sessId"); // Retrieve as a String
        int userId = Integer.parseInt(userIdStr); // Convert to an int

        // Get the selected date and time from the form
        String selectedDate = request.getParameter("selectedDate");
        String selectedTime = request.getParameter("selectedTime");

        if (selectedDate == null || selectedDate.isEmpty() || selectedTime == null || selectedTime.isEmpty()) {
            response.getWriter().println("Error: Invalid date or time.");
            return;
        }

        // Insert the booking into the database
        try (Connection conn = DriverManager.getConnection(DB_URL)) {
            String sql = "INSERT INTO bookings (user_id, booking_date, booking_time, service_id) VALUES (?, ?, ?, ?)";
            PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            stmt.setInt(1, userId);
            stmt.setString(2, selectedDate);
            stmt.setString(3, selectedTime);
            stmt.setInt(4, 1);  // Assuming service_id is 1

            int rowsInserted = stmt.executeUpdate();
            if (rowsInserted > 0) {
                ResultSet generatedKeys = stmt.getGeneratedKeys();
                if (generatedKeys.next()) {
                    int bookingId = generatedKeys.getInt(1); // Get the generated booking ID

                    // Store the booking ID in the session
                    session.setAttribute("bookingId", bookingId);

                    // Redirect to AddToCart servlet (POST)
                    response.sendRedirect("AddToCart");
                } else {
                    response.getWriter().println("Booking created but ID retrieval failed.");
                }
            } else {
                response.getWriter().println("Error: Could not save booking.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Database error: " + e.getMessage());
        }
    }
}
