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

@WebServlet("/VerifyMembers") // Servlet mapping
public class VerifyMembers extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // Database connection details
    private static final String DB_URL = "jdbc:mysql://localhost/javaca1?user=root&password=Jasper1402@123&serverTimezone=UTC";

    public VerifyMembers() {
        super();
    }

    /**
     * Handles POST requests from the login form for member verification.
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve form data
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            // Load MySQL JDBC driver
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Connect to the database
            conn = DriverManager.getConnection(DB_URL);

            // SQL query to verify member credentials
            String sql = "SELECT name, userRole, user_id FROM users WHERE email = ? AND password = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, email);
            pstmt.setString(2, password);

            // Execute query
            rs = pstmt.executeQuery();

            if (rs.next()) {
                // If user is found, retrieve details
                String name = rs.getString("name");
                String userRole = rs.getString("userRole");
                String userId = rs.getString("user_id");


                // Start session and set attributes
                HttpSession session = request.getSession();
                session.setAttribute("sessId", userId);
                session.setAttribute("sessEmail", email);
                session.setAttribute("sessName", name);
                session.setAttribute("sessUserRole", userRole);

                response.sendRedirect("getMember?loginSuccess=true");
            } else {
                // If user is not found, redirect back to login with an error message
                response.sendRedirect("JAVACA1/login.jsp?errCode=invalidLogin");
            }
        } catch (Exception e) {
            // Log the exception (replace with proper logging in production)
            e.printStackTrace();
            response.getWriter().println("Error: " + e.getMessage());
        } finally {
            // Close database resources
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
