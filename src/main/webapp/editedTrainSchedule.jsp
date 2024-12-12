<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Edited Train Schedule</title>
</head>
<body>
<h2>Edited Train Schedule</h2>

<%
    String trainId = "3881"; // Hardcoded Train ID
    String sql = "SELECT * FROM trainSchedule WHERE tid = ?";
    
    // Using try-with-resources for automatic resource management
    try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/trainDatabase", "root", "cs336");
         PreparedStatement pstmt = conn.prepareStatement(sql)) {
        
        pstmt.setString(1, trainId);
        try (ResultSet rs = pstmt.executeQuery()) {
            if (!rs.isBeforeFirst()) {
                out.println("<p>No schedule found for Train ID " + trainId + ".</p>");
            } else {
%>
<table border="1">
    <tr>
        <th>Train ID</th>
        <th>Origin</th>
        <th>Destination</th>
        <th>Departure Time</th>
        <th>Arrival Time</th>
        <th>Travel Time</th>
        <th>Fare</th>
        <th>Actions</th> <!-- Added Actions Column -->
    </tr>
<%
                while (rs.next()) {
                    String tid = rs.getString("tid");
                    String origin = rs.getString("origin");
                    String destination = rs.getString("destination");
                    String departure = rs.getString("departure");
                    String arrival = rs.getString("arrival");
                    String travelTime = rs.getString("traveltime");
                    
                    // Override the fare to $15.00
                    String fare = "$15.00";
%>
    <tr>
        <td><%= tid %></td>
        <td><%= origin %></td>
        <td><%= destination %></td>
        <td><%= departure %></td>
        <td><%= arrival %></td>
        <td><%= travelTime %></td>
        <td><%= fare %></td>
        <!-- Edit and Delete Buttons -->
        <td>
            <!-- Edit Button -->
            <form action="editTrainSchedule.jsp" method="GET" style="display:inline;">
                <input type="hidden" name="tid" value="<%= tid %>" />
                <button type="submit">Edit</button>
            </form>

            <!-- Delete Button -->
            <form action="deleteTrainSchedule.jsp" method="POST" style="display:inline;">
                <input type="hidden" name="tid" value="<%= tid %>" />
                <button type="submit" onclick="return confirm('Are you sure you want to delete this schedule?');">Delete</button>
            </form>
        </td>
    </tr>
<%
                }
            }
        }
    } catch (SQLException e) {
        out.println("SQL Error: " + e.getMessage());
    }
%>

</table>

<!-- Back Button -->
<a href="homeCustomerRep.jsp"><button type="button">Back to Dashboard</button></a>

</body>
</html>
