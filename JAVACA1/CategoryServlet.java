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

        System.out.println("Action: " + action); // Debugging
        System.out.println("Category Name: " + categoryName);
        System.out.println("Category ID: " + categoryId);

        try (Connection conn = getConnection()) {
            if ("create".equals(action)) {
                System.out.println("Handling Create Category...");//debugging
                handleCreateCategory(response, conn, categoryName);
            } else if ("update".equals(action)) {
                System.out.println("Handling Update Category...");//debugging
                handleUpdateCategory(response, conn, categoryId, categoryName);
            } else if ("delete".equals(action)) {
                System.out.println("Handling Delete Category...");//debugging
                handleDeleteCategory(response, conn, categoryId);
            }
        } catch (Exception e) {
            System.err.println("Error: " + e.getMessage());
            response.sendRedirect("createCategory.jsp?errCode=serverError");
        }
    }

    private void handleCreateCategory(HttpServletResponse response, Connection conn, String categoryName) throws SQLException, IOException {
        String checkQuery = "SELECT name FROM category WHERE name = ?";
        String insertQuery = "INSERT INTO category (name) VALUES (?)";

        try (PreparedStatement checkStmt = conn.prepareStatement(checkQuery)) {
            checkStmt.setString(1, categoryName);
            try (ResultSet rs = checkStmt.executeQuery()) {
                if (rs.next()) {
                	System.out.println("Category already exists: " + categoryName); // Debugging
                    response.sendRedirect("JavaCA1/JAVACA1/category/createCategory.jsp?errCode=categoryAlreadyExists");
                    return;
                }
            }
        }

        try (PreparedStatement insertStmt = conn.prepareStatement(insertQuery)) {
            insertStmt.setString(1, categoryName);
            int rows = insertStmt.executeUpdate();
            if (rows > 0) {
                System.out.println("Category created successfully: " + categoryName); // Debugging
                response.sendRedirect("JavaCA1/JAVACA1/category/createCategory.jsp");
            } else {
                System.out.println("Failed to create category: " + categoryName); // Debugging
                response.sendRedirect("createCategory.jsp?errCode=invalidCategory");
            }
        }
    }

    private void handleUpdateCategory(HttpServletResponse response, Connection conn, String categoryId, String newName) throws SQLException, IOException {
        String checkQuery = "SELECT name FROM category WHERE name = ?";
        String updateQuery = "UPDATE category SET name = ? WHERE id = ?";

        try (PreparedStatement checkStmt = conn.prepareStatement(checkQuery)) {
            checkStmt.setString(1, newName);
            try (ResultSet rs = checkStmt.executeQuery()) {
                if (rs.next()) {
                    response.sendRedirect("JavaCA1/JAVACA1/category/viewUpdateDeleteCategory.jsp?errCode=categoryAlreadyExists");
                    return;
                }
            }
        }

        try (PreparedStatement updateStmt = conn.prepareStatement(updateQuery)) {
            updateStmt.setString(1, newName);
            updateStmt.setInt(2, Integer.parseInt(categoryId));
            updateStmt.executeUpdate();
            response.sendRedirect("JavaCA1/JAVACA1/category/viewUpdateDeleteCategory.jsp");
        }
    }

    private void handleDeleteCategory(HttpServletResponse response, Connection conn, String categoryId) throws SQLException, IOException {
        String deleteQuery = "DELETE FROM category WHERE id = ?";

        try (PreparedStatement deleteStmt = conn.prepareStatement(deleteQuery)) {
            deleteStmt.setInt(1, Integer.parseInt(categoryId));
            deleteStmt.executeUpdate();
            response.sendRedirect("JavaCA1/JAVACA1/category/viewUpdateDeleteCategory.jsp");
        }
    }
}