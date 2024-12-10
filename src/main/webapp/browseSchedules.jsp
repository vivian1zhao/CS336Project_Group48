<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Browse Train Schedules</title>
</head>
<body>
    <h2>Available Train Schedules</h2>

    <%
        String origin = request.getParameter("origin");
        String destination = request.getParameter("destination");

        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            // Database connection
            String url = "jdbc:mysql://localhost:3306/TrainDatabase";
            String username = "root";
            String password = "cs336"; // 

            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection(url, username, password);

            // SQL query to fetch matching train schedules
            String sql = "SELECT ts.tid, tl.tlname, ts.origin, ts.destination, ts.departure, ts.arrival, ts.traveltime, ts.fare " +
                         "FROM trainSchedule ts " +
                         "JOIN transitLine tl ON ts.tlid = tl.tlid " +
                         "WHERE ts.origin = ? AND ts.destination = ?";
            
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, origin);
            stmt.setString(2, destination);
            rs = stmt.executeQuery();

            if (!rs.isBeforeFirst()) {
                out.println("<p>No train schedules found for the given criteria.</p>");
            } else {
    %>
            <table border="1">
                <tr>
                    <th>Train ID</th>
                    <th>Transit Line</th>
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
                    <td><%= rs.getString("tlname") %></td>
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
        } catch (Exception e) {
            out.println("<p>Error: " + e.getMessage() + "</p>");
        } finally {
            if (rs != null) try { rs.close(); } catch (SQLException ignore) {}
            if (stmt != null) try { stmt.close(); } catch (SQLException ignore) {}
            if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
        }
    %>
            </table>

    <a href="searchSchedules.jsp">Search Again</a>
</body>
</html>
