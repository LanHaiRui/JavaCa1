package servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
/**
 * Servlet implementation class getMember
 */
@WebServlet("/getMember")
public class getMember extends HttpServlet {
	private static final long serialVersionUID = 1L;

    // Database connection details
    private static final String DB_URL = "jdbc:mysql://localhost/javaca1?user=root&password=Jasper1402@123&serverTimezone=UTC";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Retrieve user ID from session
        HttpSession session = request.getSession(false); // Don't create a new session
        if (session == null || session.getAttribute("sessId") == null) {
            response.sendRedirect("JAVACA1/login.jsp?errCode=invalidLogin");
            return;
        }

        String userIdStr = (String) session.getAttribute("sessId"); // Retrieve as a String
        int userId = Integer.parseInt(userIdStr); // Convert to an int

        // Initialize database connection objects
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            // Load MySQL JDBC driver
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Connect to the database
            conn = DriverManager.getConnection(DB_URL);

            // Query to get user information based on user_id
            String sql = "SELECT name, email, phone, address FROM users WHERE user_id = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, userId);  // Use the userId from session
            rs = pstmt.executeQuery();

            if (rs.next()) {
                // Retrieve user info
                String name = rs.getString("name");
                String email = rs.getString("email");
                String mobileNumber = rs.getString("phone");
                String address = rs.getString("address");

                // Set the user info in session
                session.setAttribute("sessName", name);
                session.setAttribute("sessEmail", email);
                session.setAttribute("sessMobileNumber", mobileNumber);
                session.setAttribute("sessAddress", address);
                String loginSuccess = request.getParameter("loginSuccess");
                if ("true".equals(loginSuccess)) { 
                // Redirect to memberPage.jsp with login success flag
                	response.sendRedirect("JAVACA1/memberPage.jsp?loginSuccess=true");
                }else {
                	response.sendRedirect("JAVACA1/memberPage.jsp");
                }
            } else {
                // If user is not found, redirect to login
                response.sendRedirect("${pageContext.request.contextPath}/JAVACA1/Login.jsp?errCode=invalidUser");
            }
        } catch (Exception e) {
            // Handle exceptions
            e.printStackTrace();
            response.getWriter().println("Database error: " + e.getMessage());
        } finally {
            // Close the database resources
            try {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}
