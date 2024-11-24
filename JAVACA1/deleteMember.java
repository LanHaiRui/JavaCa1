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
/**
 * Servlet implementation class deleteMember
 */
@WebServlet("/deleteMember")
public class deleteMember extends HttpServlet {
	 private static final long serialVersionUID = 1L;

	    // Database connection details
	    private static final String DB_URL = "jdbc:mysql://localhost/javaca1?user=root&password=Jasper1402@123&serverTimezone=UTC";

	    @Override
	    protected void doPost(HttpServletRequest request, HttpServletResponse response)
	            throws ServletException, IOException {

	        // Retrieve user ID from session
	        HttpSession session = request.getSession(false); // Don't create a new session
	        if (session == null || session.getAttribute("sessId") == null) {
	            response.sendRedirect("login.jsp?errCode=invalidLogin");
	            return;
	        }

	        String userId = (String) session.getAttribute("sessId");

	        // Initialize database connection objects
	        Connection conn = null;
	        PreparedStatement pstmt = null;

	        try {
	            // Load MySQL JDBC driver
	            Class.forName("com.mysql.cj.jdbc.Driver");

	            // Connect to the database
	            conn = DriverManager.getConnection(DB_URL);

	            // SQL query to delete user from the database
	            String sql = "DELETE FROM users WHERE user_id = ?";
	            pstmt = conn.prepareStatement(sql);
	            pstmt.setString(1, userId); // Use the userId from session

	            int rowsDeleted = pstmt.executeUpdate();

	            if (rowsDeleted > 0) {
	                // Invalidate the session as the user is deleted
	                session.invalidate();

	                // Redirect to login page with a logout message
	                response.sendRedirect("JAVACA1/login.jsp?errCode=profileDeleted");
	            } else {
	                response.getWriter().println("Error: Unable to delete profile.");
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