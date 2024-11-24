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
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 * Servlet implementation class getCart
 */
@WebServlet("/getCart")
public class getCart extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public getCart() {
        super();
        // TODO Auto-generated constructor stub
    }

    // Method to fetch cart items for the logged-in user
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("sessId") == null) {
            response.sendRedirect("JAVACA1/login.jsp");
            return;
        }

        int userId = Integer.parseInt((String) session.getAttribute("sessId"));

        String DB_URL = "jdbc:mysql://localhost/javaca1?user=root&password=Jasper1402@123&serverTimezone=UTC";
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        List<CartItem> cartItems = new ArrayList<>();

        try {
            conn = DriverManager.getConnection(DB_URL);
            
            // Fetch the cart items for this user
            String query = "SELECT c.cart_id, b.booking_id, b.booking_date, b.booking_time, s.name, s.description " +
                           "FROM cart c " +
                           "JOIN bookings b ON c.booking_id = b.booking_id " +
                           "JOIN service s ON b.service_id = s.id " +
                           "WHERE c.user_id = ?";
            stmt = conn.prepareStatement(query);
            stmt.setInt(1, userId);
            rs = stmt.executeQuery();

            while (rs.next()) {
                CartItem item = new CartItem(
                    rs.getInt("cart_id"),
                    rs.getInt("booking_id"),
                    rs.getString("name"),
                    rs.getString("booking_date"),
                    rs.getString("booking_time"),
                    rs.getString("description")
                );
                cartItems.add(item);
            }

            request.setAttribute("cartItems", cartItems);
            request.getRequestDispatcher("JAVACA1/cart.jsp").forward(request, response);

        } catch (SQLException e) {
            e.printStackTrace();
            response.getWriter().println("Error retrieving cart items.");
        } finally {
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}

