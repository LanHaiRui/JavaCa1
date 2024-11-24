package javaca1servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.*;

@WebServlet("/category")
public class CategoryServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public CategoryServlet() {
        super();
    }

    private Connection getConnection() throws SQLException, ClassNotFoundException {
        Class.forName("com.mysql.cj.jdbc.Driver");
        String connURL = "jdbc:mysql://localhost/javaca1?user=root&password=passwordLHRH3nry570&serverTimezone=UTC";
        return DriverManager.getConnection(connURL);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        String categoryName = request.getParameter("categoryName");
        String categoryId = request.getParameter("categoryId");

        try (Connection conn = getConnection()) {
            if ("create".equals(action)) {
                handleCreateCategory(response, conn, categoryName);
            } else if ("update".equals(action)) {
                handleUpdateCategory(response, conn, categoryId, categoryName);
            } else if ("delete".equals(action)) {
                handleDeleteCategory(response, conn, categoryId);
            }
        } catch (Exception e) {
            System.err.println("Error: " + e.getMessage());
            response.sendRedirect("JavaCA1/JAVACA1/category/adminViewUpdateDeleteCategory.jsp?errCode=serverError");
        }
    }

    private void handleCreateCategory(HttpServletResponse response, Connection conn, String categoryName) throws IOException {
        String checkQuery = "SELECT * FROM category WHERE name = ?";
        String insertQuery = "INSERT INTO category (name) VALUES (?)";

        // Check for existing category with the same name
        try (PreparedStatement checkStmt = conn.prepareStatement(checkQuery)) {
            checkStmt.setString(1, categoryName);
            try (ResultSet rs = checkStmt.executeQuery()) {
                if (rs.next()) {
                    response.sendRedirect("JavaCA1/JAVACA1/category/adminCreateCategory.jsp?errCode=categoryAlreadyExists");
                    return;
                }
            }
        } catch (SQLException e) {
            System.err.println("Error checking category name: " + e.getMessage());
            response.sendRedirect("JavaCA1/JAVACA1/category/adminCreateCategory.jsp?errCode=serverError");
            return;
        }

        // Insert new category
        try (PreparedStatement insertStmt = conn.prepareStatement(insertQuery)) {
            insertStmt.setString(1, categoryName);
            int rowsInserted = insertStmt.executeUpdate();
            if (rowsInserted > 0) {
                response.sendRedirect("JavaCA1/JAVACA1/category/adminViewUpdateDeleteCategory.jsp");
            } else {
                response.sendRedirect("JavaCA1/JAVACA1/category/adminCreateCategory.jsp?errCode=invalidCategory");
            }
        } catch (SQLException e) {
            System.err.println("Error creating category: " + e.getMessage());
            response.sendRedirect("JavaCA1/JAVACA1/category/adminCreateCategory.jsp?errCode=serverError");
        }
    }

    private void handleUpdateCategory(HttpServletResponse response, Connection conn, String categoryId, String categoryName) throws IOException {
        String checkQuery = "SELECT * FROM category WHERE name = ? AND id != ?";
        String updateQuery = "UPDATE category SET name = ? WHERE id = ?";

        // Check for existing category with the same name
        try (PreparedStatement checkStmt = conn.prepareStatement(checkQuery)) {
            checkStmt.setString(1, categoryName);
            checkStmt.setInt(2, Integer.parseInt(categoryId));
            try (ResultSet rs = checkStmt.executeQuery()) {
                if (rs.next()) {
                    response.sendRedirect("JavaCA1/JAVACA1/category/adminViewUpdateDeleteCategory.jsp?errCode=categoryAlreadyExists");
                    return;
                }
            }
        } catch (SQLException e) {
            System.err.println("Error checking category name: " + e.getMessage());
            response.sendRedirect("JavaCA1/JAVACA1/category/adminViewUpdateDeleteCategory.jsp?errCode=serverError");
            return;
        }

        // Update the category
        try (PreparedStatement updateStmt = conn.prepareStatement(updateQuery)) {
            updateStmt.setString(1, categoryName);
            updateStmt.setInt(2, Integer.parseInt(categoryId));
            int rowsUpdated = updateStmt.executeUpdate();
            if (rowsUpdated > 0) {
                response.sendRedirect("JavaCA1/JAVACA1/category/adminViewUpdateDeleteCategory.jsp");
            } else {
                response.sendRedirect("JavaCA1/JAVACA1/category/adminViewUpdateDeleteCategory.jsp?errCode=updateFailed");
            }
        } catch (SQLException e) {
            System.err.println("Error updating category: " + e.getMessage());
            response.sendRedirect("JavaCA1/JAVACA1/category/adminViewUpdateDeleteCategory.jsp?errCode=serverError");
        }
    }

    private void handleDeleteCategory(HttpServletResponse response, Connection conn, String categoryId) throws IOException {
        String deleteQuery = "DELETE FROM category WHERE id = ?";

        try (PreparedStatement deleteStmt = conn.prepareStatement(deleteQuery)) {
            deleteStmt.setInt(1, Integer.parseInt(categoryId));
            int rowsDeleted = deleteStmt.executeUpdate();
            if (rowsDeleted > 0) {
                response.sendRedirect("JavaCA1/JAVACA1/category/adminViewUpdateDeleteCategory.jsp");
            } else {
                response.sendRedirect("JavaCA1/JAVACA1/category/adminViewUpdateDeleteCategory.jsp?errCode=deleteFailed");
            }
        } catch (SQLException e) {
            System.err.println("Error deleting category: " + e.getMessage());
            response.sendRedirect("JavaCA1/JAVACA1/category/adminViewUpdateDeleteCategory.jsp?errCode=serverError");
        }
    }
}