<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Search Results</title>
</head>
<body>
<h2>Search Results</h2>

<%
    String station = request.getParameter("station");
    String searchType = request.getParameter("searchType");
    String sql = "";
    
    // Determine the SQL query based on the search type
    if ("origin".equalsIgnoreCase(searchType)) {
        sql = "SELECT * FROM trainSchedule WHERE origin = ?";
    } else {
        sql = "SELECT * FROM trainSchedule WHERE destination = ?";
    }
    
    // Using try-with-resources for automatic resource management
    try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/trainDatabase", "root", "cs336");
         PreparedStatement pstmt = conn.prepareStatement(sql)) {
        
        pstmt.setString(1, station);
        try (ResultSet rs = pstmt.executeQuery()) {
            if (!rs.isBeforeFirst()) {
                out.println("<p>No schedules found for " + station + " as " + searchType + ".</p>");
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
    </tr>
<%
                while (rs.next()) {
%>
    <tr>
        <td><%= rs.getString("tid") %></td>
        <td><%= rs.getString("origin") %></td>
        <td><%= rs.getString("destination") %></td>
        <td><%= rs.getString("departure") %></td>
        <td><%= rs.getString("arrival") %></td>
        <td><%= rs.getString("traveltime") %></td>
        <td><%= rs.getString("fare") %></td>
    </tr>
<%
                }
            }
        }
    } catch (SQLException e) {
        out.println("SQL Error: " + e.getMessage());
    }
%>

<!-- Back Button -->
<a href="homeCustomerRep.jsp"><button type="button">Back to Dashboard</button></a>

</body>
</html>
