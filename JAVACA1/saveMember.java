package servlets;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Servlet implementation class saveMember
 */
@WebServlet("/saveMember")
public class saveMember extends HttpServlet {
	private static final long serialVersionUID = 1L;

    // Database connection details
    private static final String DB_URL = "jdbc:mysql://localhost/javaca1?user=root&password=Jasper1402@123&serverTimezone=UTC";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {

        // Retrieve the session and the user ID from session
        HttpSession session = request.getSession(false); // Don't create a new session
        if (session == null || session.getAttribute("sessId") == null) {
            response.sendRedirect("JAVACA1/login.jsp?errCode=invalidLogin");
            return;
        }

        // Get the updated user information from the form
        String userId = (String) session.getAttribute("sessId");
        String name = request.getParameter("Name");
        String mobileNumber = request.getParameter("mobileNumber");
        String address = request.getParameter("address");
        String email = request.getParameter("email");

        // Initialize database connection objects
        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            // Load MySQL JDBC driver
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Connect to the database
            conn = DriverManager.getConnection(DB_URL);

            // SQL query to update user information
            String sql = "UPDATE users SET name = ?, email = ?, phone = ?, address = ? WHERE user_id = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, name);
            pstmt.setString(2, email);
            pstmt.setString(3, mobileNumber);
            pstmt.setString(4, address);
            pstmt.setString(5, userId);  // Use the userId from session

            int rowsUpdated = pstmt.executeUpdate();

            if (rowsUpdated > 0) {
                // Update session attributes with the new user data
                session.setAttribute("sessName", name);
                session.setAttribute("sessEmail", email);
                session.setAttribute("sessMobileNumber", mobileNumber);
                session.setAttribute("sessAddress", address);

                // Redirect back to the member page with success
                response.sendRedirect("JAVACA1/memberPage.jsp?profileUpdated=true");
            } else {
                response.getWriter().println("Error: Unable to update profile.");
            }
        } catch (Exception e) {
            // Handle exceptions
            e.printStackTrace();
            response.getWriter().println("Database error: " + e.getMessage());
        } finally {
            // Close the database resources
            try {
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}