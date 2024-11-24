package javaca1servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.*;

@WebServlet("/service")
public class ServiceServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public ServiceServlet() {
        super();
    }

    private Connection getConnection() throws SQLException, ClassNotFoundException {
        Class.forName("com.mysql.cj.jdbc.Driver");
        String connURL = "jdbc:mysql://localhost/javaca1?user=root&password=passwordLHRH3nry570&serverTimezone=UTC";
        return DriverManager.getConnection(connURL);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        String serviceName = request.getParameter("serviceName");
        String imageLink = request.getParameter("image_link");
        String categoryId = request.getParameter("category");
        String serviceId = request.getParameter("serviceId");

        try (Connection conn = getConnection()) {
            if ("create".equals(action)) {
                handleCreateService(response, conn, serviceName, imageLink, categoryId);
            } else if ("update".equals(action)) {
                handleUpdateService(response, conn, serviceId, serviceName, imageLink, categoryId);
            } else if ("delete".equals(action)) {
                handleDeleteService(response, conn, serviceId);
            }
        } catch (Exception e) {
            System.err.println("Error: " + e.getMessage());
            response.sendRedirect("JavaCA1/JAVACA1/service/viewUpdateDeleteService.jsp?errCode=serverError");
        }
    }

    private void handleCreateService(HttpServletResponse response, Connection conn, String serviceName, String imageLink, String categoryId) throws SQLException, IOException {
        String checkQuery = "SELECT * FROM service WHERE name = ?";
        String insertQuery = "INSERT INTO service (name, image_link, category_id) VALUES (?, ?, ?)";

        try (PreparedStatement checkStmt = conn.prepareStatement(checkQuery)) {
            checkStmt.setString(1, serviceName);
            try (ResultSet rs = checkStmt.executeQuery()) {
                if (rs.next()) {
                    response.sendRedirect("JavaCA1/JAVACA1/service/createService.jsp?errCode=serviceAlreadyExists");
                    return;
                }
            }
        }

        try (PreparedStatement insertStmt = conn.prepareStatement(insertQuery)) {
            insertStmt.setString(1, serviceName);
            insertStmt.setString(2, imageLink);
            insertStmt.setInt(3, Integer.parseInt(categoryId));
            int rowsInserted = insertStmt.executeUpdate();
            if (rowsInserted > 0) {
                response.sendRedirect("JavaCA1/JAVACA1/service/createService.jsp");
            } else {
                response.sendRedirect("JavaCA1/JAVACA1/service/createService.jsp?errCode=invalidService");
            }
        }
    }

    private void handleUpdateService(HttpServletResponse response, Connection conn, String serviceId, String newName, String newImageLink, String newCategoryId) throws SQLException, IOException {
        String checkQuery = "SELECT * FROM service WHERE name = ? AND id != ?";
        String updateQuery = "UPDATE service SET name = ?, image_link = ?, category_id = ? WHERE id = ?";

        try (PreparedStatement checkStmt = conn.prepareStatement(checkQuery)) {
            checkStmt.setString(1, newName);
            checkStmt.setInt(2, Integer.parseInt(serviceId));
            try (ResultSet rs = checkStmt.executeQuery()) {
                if (rs.next()) {
                    response.sendRedirect("JavaCA1/JAVACA1/service/viewUpdateDeleteService.jsp");
                    return;
                }
            }
        }

        try (PreparedStatement updateStmt = conn.prepareStatement(updateQuery)) {
            updateStmt.setString(1, newName);
            updateStmt.setString(2, newImageLink);
            updateStmt.setInt(3, Integer.parseInt(newCategoryId));
            updateStmt.setInt(4, Integer.parseInt(serviceId));
            updateStmt.executeUpdate();
            response.sendRedirect("JavaCA1/JAVACA1/service/viewUpdateDeleteService.jsp");
        }
    }

    private void handleDeleteService(HttpServletResponse response, Connection conn, String serviceId) throws SQLException, IOException {
        String deleteQuery = "DELETE FROM service WHERE id = ?";

        try (PreparedStatement deleteStmt = conn.prepareStatement(deleteQuery)) {
            deleteStmt.setInt(1, Integer.parseInt(serviceId));
            deleteStmt.executeUpdate();
            response.sendRedirect("JavaCA1/JAVACA1/service/viewUpdateDeleteService.jsp");
        }
    }
}