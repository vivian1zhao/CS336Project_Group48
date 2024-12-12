<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Submit Reservation</title>
</head>
<body>
    <%
        // Retrieve form parameters
        String originName = request.getParameter("origin");
        String destinationName = request.getParameter("destination");
        String tripType = request.getParameter("tripType");
        String discount = request.getParameter("discount");
        String username = (String) session.getAttribute("user");

        if (username == null) {
            out.println("<p>Please log in to make a reservation.</p>");
            return;
        }

        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            String url = "jdbc:mysql://localhost:3306/TrainDatabase";
            String dbUsername = "root";
            String dbPassword = "cs336";

            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection(url, dbUsername, dbPassword);
            
            double baseFare = 19.25;
            
            // discount calculations
            double totalFare = baseFare;
            if ("child".equals(discount)) {
                totalFare *= 0.75; // 25% discount
            } else if ("senior".equals(discount)) {
                totalFare *= 0.65; // 35% discount
            } else if ("disabled".equals(discount)) {
                totalFare *= 0.50; // 50% discount
            }

            // round trip adjustment
            if ("roundtrip".equals(tripType)) {
                totalFare *= 2; // Double the fare for round trip
            }

            // Get the station IDs for origin and destination
            String getStationIdQuery = "SELECT sid FROM station WHERE name = ?";
            int originId = -1;
            int destinationId = -1;

            // Get origin station ID
            stmt = conn.prepareStatement(getStationIdQuery);
            stmt.setString(1, originName);
            rs = stmt.executeQuery();
            if (rs.next()) {
                originId = rs.getInt("sid");
            }
            rs.close();
            stmt.close();

            // Get destination station ID
            stmt = conn.prepareStatement(getStationIdQuery);
            stmt.setString(1, destinationName);
            rs = stmt.executeQuery();
            if (rs.next()) {
                destinationId = rs.getInt("sid");
            }
            rs.close();
            stmt.close();

            if (originId == -1 || destinationId == -1) {
                out.println("<p>Invalid origin or destination station name.</p>");
                return;
            }
            
            // Insert reservation data into reservationData table
            String insertReservationQuery = "INSERT INTO reservationData (date, cid, schid, totalfare, originStation, destinationStation, tid, cancelled) " +
                                            "VALUES (CURDATE(), (SELECT cid FROM customer WHERE username = ?), 1, ?, ?, ?, '3868', 0)";
            stmt = conn.prepareStatement(insertReservationQuery);
            stmt.setString(1, username);
            stmt.setDouble(2, totalFare);
            stmt.setInt(3, originId);
            stmt.setInt(4, destinationId);

            int rowsInserted = stmt.executeUpdate();
            if (rowsInserted > 0) {
                out.println("<p>Reservation successful! Total Fare: $" + String.format("%.2f", totalFare) + "</p>");
            } else {
                out.println("<p>Failed to make reservation.</p>");
            }


        } catch (Exception e) {
            out.println("<p>Error: " + e.getMessage() + "</p>");
        } finally {
            if (rs != null) try { rs.close(); } catch (SQLException ignore) {}
            if (stmt != null) try { stmt.close(); } catch (SQLException ignore) {}
            if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
        }
    %>
    <a href="home.jsp">Back to Home</a>
</body>
</html>
