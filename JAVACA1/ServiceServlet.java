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
        String description = request.getParameter("description");
        String categoryId = request.getParameter("category");
        String serviceId = request.getParameter("serviceId");

        try (Connection conn = getConnection()) {
            if ("create".equals(action)) {
                handleCreateService(response, conn, serviceName, imageLink, description, categoryId);
            } else if ("update".equals(action)) {
                handleUpdateService(response, conn, serviceId, serviceName, imageLink, description, categoryId);
            } else if ("delete".equals(action)) {
                handleDeleteService(response, conn, serviceId);
            }
        } catch (Exception e) {
            System.err.println("Error: " + e.getMessage());
            response.sendRedirect("JavaCA1/JAVACA1/service/adminViewUpdateDeleteService.jsp?errCode=serverError");
        }
    }

    private void handleCreateService(HttpServletResponse response, Connection conn, String serviceName, String imageLink, String description, String categoryId) throws IOException {
        String checkNameQuery = "SELECT * FROM service WHERE name = ?";
        String checkImageLinkQuery = "SELECT * FROM service WHERE image_link = ?";
        String insertQuery = "INSERT INTO service (name, image_link, description, category_id) VALUES (?, ?, ?, ?)";

        // Check for existing service with the same name
        try (PreparedStatement checkNameStmt = conn.prepareStatement(checkNameQuery)) {
            checkNameStmt.setString(1, serviceName);
            try (ResultSet rs = checkNameStmt.executeQuery()) {
                if (rs.next()) {
                    response.sendRedirect("JavaCA1/JAVACA1/service/adminCreateService.jsp?errCode=serviceAlreadyExists");
                    return;
                }
            }
        } catch (SQLException e) {
            System.err.println("Error checking service name: " + e.getMessage());
            response.sendRedirect("JavaCA1/JAVACA1/service/adminCreateService.jsp?errCode=serverError");
            return;
        }

        // Check for existing service with the same image_link
        try (PreparedStatement checkImageLinkStmt = conn.prepareStatement(checkImageLinkQuery)) {
            checkImageLinkStmt.setString(1, imageLink);
            try (ResultSet rs = checkImageLinkStmt.executeQuery()) {
                if (rs.next()) {
                    response.sendRedirect("JavaCA1/JAVACA1/service/adminCreateService.jsp?errCode=imageLinkAlreadyExists");
                    return;
                }
            }
        } catch (SQLException e) {
            System.err.println("Error checking image link: " + e.getMessage());
            response.sendRedirect("JavaCA1/JAVACA1/service/adminCreateService.jsp?errCode=serverError");
            return;
        }

        // Insert new service
        try (PreparedStatement insertStmt = conn.prepareStatement(insertQuery)) {
            insertStmt.setString(1, serviceName);
            insertStmt.setString(2, imageLink);
            insertStmt.setString(3, description);
            insertStmt.setInt(4, Integer.parseInt(categoryId));
            int rowsInserted = insertStmt.executeUpdate();
            if (rowsInserted > 0) {
                response.sendRedirect("JavaCA1/JAVACA1/service/adminViewUpdateDeleteService.jsp");
            } else {
                response.sendRedirect("JavaCA1/JAVACA1/service/adminCreateService.jsp?errCode=invalidService");
            }
        } catch (SQLException e) {
            System.err.println("Error creating service: " + e.getMessage());
            response.sendRedirect("JavaCA1/JAVACA1/service/adminCreateService.jsp?errCode=serverError");
        }
    }

    private void handleUpdateService(HttpServletResponse response, Connection conn, String serviceId, String newName, String newImageLink, String newDescription, String newCategoryId) throws IOException {
        String checkNameQuery = "SELECT * FROM service WHERE name = ? AND id != ?";
        String checkImageLinkQuery = "SELECT * FROM service WHERE image_link = ? AND id != ?";
        String updateQuery = "UPDATE service SET name = ?, image_link = ?, description = ?, category_id = ? WHERE id = ?";

        // Check for existing service with the same name
        try (PreparedStatement checkNameStmt = conn.prepareStatement(checkNameQuery)) {
            checkNameStmt.setString(1, newName);
            checkNameStmt.setInt(2, Integer.parseInt(serviceId));
            try (ResultSet rs = checkNameStmt.executeQuery()) {
                if (rs.next()) {
                    response.sendRedirect("JavaCA1/JAVACA1/service/adminViewUpdateDeleteService.jsp?errCode=serviceAlreadyExists");
                    return;
                }
            }
        } catch (SQLException e) {
            System.err.println("Error checking service name: " + e.getMessage());
            response.sendRedirect("JavaCA1/JAVACA1/service/adminViewUpdateDeleteService.jsp?errCode=serverError");
            return;
        }

        // Check for existing service with the same image_link
        try (PreparedStatement checkImageLinkStmt = conn.prepareStatement(checkImageLinkQuery)) {
            checkImageLinkStmt.setString(1, newImageLink);
            checkImageLinkStmt.setInt(2, Integer.parseInt(serviceId));
            try (ResultSet rs = checkImageLinkStmt.executeQuery()) {
                if (rs.next()) {
                    response.sendRedirect("JavaCA1/JAVACA1/service/adminViewUpdateDeleteService.jsp?errCode=imageLinkAlreadyExists");
                    return;
                }
            }
        } catch (SQLException e) {
            System.err.println("Error checking image link: " + e.getMessage());
            response.sendRedirect("JavaCA1/JAVACA1/service/adminViewUpdateDeleteService.jsp?errCode=serverError");
            return;
        }

        // Update the service
        try (PreparedStatement updateStmt = conn.prepareStatement(updateQuery)) {
            updateStmt.setString(1, newName);
            updateStmt.setString(2, newImageLink);
            updateStmt.setString(3, newDescription);
            updateStmt.setInt(4, Integer.parseInt(newCategoryId));
            updateStmt.setInt(5, Integer.parseInt(serviceId));
            int rowsUpdated = updateStmt.executeUpdate();
            if (rowsUpdated > 0) {
                response.sendRedirect("JavaCA1/JAVACA1/service/adminViewUpdateDeleteService.jsp");
            } else {
                response.sendRedirect("JavaCA1/JAVACA1/service/adminViewUpdateDeleteService.jsp?errCode=updateFailed");
            }
        } catch (SQLException e) {
            System.err.println("Error updating service: " + e.getMessage());
            response.sendRedirect("JavaCA1/JAVACA1/service/adminViewUpdateDeleteService.jsp?errCode=serverError");
        }
    }

    private void handleDeleteService(HttpServletResponse response, Connection conn, String serviceId) throws IOException {
        String deleteQuery = "DELETE FROM service WHERE id = ?";

        try (PreparedStatement deleteStmt = conn.prepareStatement(deleteQuery)) {
            deleteStmt.setInt(1, Integer.parseInt(serviceId));
            int rowsDeleted = deleteStmt.executeUpdate();
            if (rowsDeleted > 0) {
                response.sendRedirect("JavaCA1/JAVACA1/service/adminViewUpdateDeleteService.jsp");
            } else {
                response.sendRedirect("JavaCA1/JAVACA1/service/adminViewUpdateDeleteService.jsp?errCode=deleteFailed");
            }
        } catch (SQLException e) {
            System.err.println("Error deleting service: " + e.getMessage());
            response.sendRedirect("JavaCA1/JAVACA1/service/adminViewUpdateDeleteService.jsp?errCode=serverError");
        }
    }
}