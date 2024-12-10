<!-- displaySchedules.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
    <title>Train Schedules</title>
</head>
<body>
    <h1>Train Schedules</h1>
    <% 
    // Example: Retrieve and display train schedules from the database
    // Assume 'origin', 'destination', and 'date' are received as request parameters
    String origin = request.getParameter("origin");
    String destination = request.getParameter("destination");
    String date = request.getParameter("date");

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/yourDatabase", "root", "yourPassword");
        PreparedStatement ps = con.prepareStatement("SELECT * FROM trains WHERE origin=? AND destination=? AND travel_date=?");
        ps.setString(1, origin);
        ps.setString(2, destination);
        ps.setString(3, date);
        ResultSet rs = ps.executeQuery();

        while (rs.next()) {
            out.println("<p>" + rs.getString("train_id") + " - From " + rs.getString("origin") + " to " + rs.getString("destination") + " at " + rs.getString("departure_time") + "</p>");
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    %>
</body>
</html>
