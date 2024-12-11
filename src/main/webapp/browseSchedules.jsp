<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Browse Train Schedules</title>
</head>
<body>
    <h2>Available Train Schedules</h2>
    
    <!-- Sorting Form -->
    <form action="" method="get">
        <input type="hidden" name="origin" value="<%= request.getParameter("origin") %>">
        <input type="hidden" name="destination" value="<%= request.getParameter("destination") %>">
        <label for="sort">Sort by:</label>
        <select name="sort" onchange="this.form.submit()">
        	<option value="">Select...</option>
            <option value="arrival">Arrival Time</option>
            <option value="departure">Departure Time</option>
            <option value="fare">Fare</option>
        </select>
    </form>

    <%
        String origin = request.getParameter("origin");
        String destination = request.getParameter("destination");
        String sort = request.getParameter("sort");
        String orderBy = "";
        if (sort != null) {
            if (sort.equals("arrival")) {
                orderBy = " ORDER BY ts.arrival";
            } else if (sort.equals("departure")) {
                orderBy = " ORDER BY ts.departure";
            } else if (sort.equals("fare")) {
                orderBy = " ORDER BY ts.fare";
            }
        }

        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            String url = "jdbc:mysql://localhost:3306/trainDatabase";
            String username = "root";
            String password = "cs336";
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection(url, username, password);

            String sql = "SELECT ts.schid, ts.tid, tl.tlname, ts.origin, ts.destination, ts.departure, ts.arrival, ts.traveltime, ts.fare " +
                         "FROM trainSchedule ts JOIN transitLine tl ON ts.tlid = tl.tlid " +
                         "WHERE ts.origin = ? AND ts.destination = ?" + orderBy;

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
                        <th>Stops</th>
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
                            <td>
                                <a href="viewTrainStops.jsp?schid=<%= rs.getString("schid") %>">View Stops</a>
                            </td>
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
    <a href="home.jsp">Return Home</a>
</body>
</html>
