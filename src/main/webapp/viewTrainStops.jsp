<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Browse Train Stops</title>
</head>
<body>
    <h2>Train Stops</h2>

    <% 
        String scheduleIdParam = request.getParameter("schid");

        // Debugging output for scheduleIdParam
        /* out.println("<p>Debug: Schedule ID parameter = " + scheduleIdParam + "</p>"); */

        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            // Database connection
            String url = "jdbc:mysql://localhost:3306/TrainDatabase";
            String username = "root";
            String password = "cs336";

            // Load the MySQL JDBC driver
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection(url, username, password);

            // SQL query to fetch train stops
            String sql = "SELECT tss.schid, s.name AS station_name, s.city, s.state, tss.stopNum, tss.departureTime " +
                         "FROM trainScheduleStops tss " +
                         "JOIN station s ON tss.sid = s.sid " +
                         "WHERE tss.schid = ? " +
                         "ORDER BY tss.stopNum";

            stmt = conn.prepareStatement(sql);
            stmt.setString(1, scheduleIdParam.trim());
            rs = stmt.executeQuery();

            // Check if the result set has rows
            if (!rs.isBeforeFirst()) {
                out.println("<p>No stops found for the given schedule ID.</p>");
            } else {
    %>
            <table border="1">
                <tr>
                    <th>Schedule ID</th>
                    <th>Station Name</th>
                    <th>City</th>
                    <th>State</th>
                    <th>Stop Number</th>
                    <th>Departure Time</th>
                </tr>
    <%
                // Iterate through the result set
                while (rs.next()) {
    %>
                <tr>
                    <td><%= rs.getString("schid") %></td>
                    <td><%= rs.getString("station_name") %></td>
                    <td><%= rs.getString("city") %></td>
                    <td><%= rs.getString("state") %></td>
                    <td><%= rs.getInt("stopNum") %></td>
                    <td><%= rs.getString("departureTime") %></td>
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
