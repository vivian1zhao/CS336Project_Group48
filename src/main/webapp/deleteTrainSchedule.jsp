<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Delete Train Schedule</title>
</head>
<body>
<%
    String tid = request.getParameter("tid");
    if (tid != null && !tid.isEmpty()) {
        try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/trainDatabase", "root", "cs336");
             PreparedStatement pstmt = conn.prepareStatement("DELETE FROM trainSchedule WHERE tid = ?")) {

            pstmt.setString(1, tid);
            int rowsAffected = pstmt.executeUpdate();

            if (rowsAffected > 0) {
                out.println("Train schedule with ID " + tid + " deleted successfully.");
            } else {
                out.println("Error: Train schedule not found.");
            }
        } catch (SQLException e) {
            out.println("SQL Error: " + e.getMessage());
        }
    }
%>


<a href="homeCustomerRep.jsp"><button type="button">Back to Dashboard</button></a>

</body>
</html>
