<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Browse List of Reservations</title>
</head>
<body>
      <%
        String transitLine = request.getParameter("transitLine");

        if (transitLine != null && !transitLine.trim().isEmpty()) {
            Connection conn = null;
            PreparedStatement stmt = null;
            ResultSet rs = null;

            try {
                // Database connection
                String url = "jdbc:mysql://localhost:3306/TrainDatabase";
                String username = "root";
                String password = "cs336"; // Replace with your credentials

                Class.forName("com.mysql.jdbc.Driver");
                conn = DriverManager.getConnection(url, username, password);

                // SQL query to fetch train reservations for the given transit line
                String sql = "SELECT c.cid, CONCAT(c.firstname, ' ', c.lastname) AS name, c.email, ts.tid AS trainNumber, ts.origin, ts.destination, ts.departure, ts.arrival, ts.fare, rd.date " +
                             "FROM customer c " +
                             "JOIN reservationData rd ON c.cid = rd.cid " +
                             "JOIN trainSchedule ts ON rd.schid = ts.schid " +
                             "JOIN transitLine tl ON ts.tlid = tl.tlid " +
                             "WHERE tl.tlname = ?" +
                            	"AND rd.cancelled = 0";

                stmt = conn.prepareStatement(sql);
                stmt.setString(1, transitLine);
                rs = stmt.executeQuery();

                if (!rs.isBeforeFirst()) {
                    out.println("<p>No reservations found for the selected transit line.</p>");
                } else {
    %>
                    <table border="1">
                        <tr>
                            <th>Customer ID</th>
                            <th>Name</th>
                            <th>Email</th>
                            <th>Train Number</th>
                            <th>Origin</th>
                            <th>Destination</th>
                            <th>Departure Time</th>
                            <th>Arrival Time</th>
                            <th>Price</th>
                            <th>Date</th>
                        </tr>
    <%
                    while (rs.next()) {
    %>
                        <tr>
                            <td><%= rs.getInt("cid") %></td>
                            <td><%= rs.getString("name") %></td>
                            <td><%= rs.getString("email") %></td>
                            <td><%= rs.getInt("trainNumber") %></td>
                            <td><%= rs.getString("origin") %></td>
                            <td><%= rs.getString("destination") %></td>
                            <td><%= rs.getString("departure") %></td>
                            <td><%= rs.getString("arrival") %></td>
                            <td><%= rs.getString("fare") %></td>
                            <td><%= rs.getString("date") %></td>
                        </tr>
    <%
                    }
                }
    %>
                    </table>
    <%
            } catch (Exception e) {
                out.println("<p>Error: " + e.getMessage() + "</p>");
            } finally {
                if (rs != null) try { rs.close(); } catch (SQLException ignore) {}
                if (stmt != null) try { stmt.close(); } catch (SQLException ignore) {}
                if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
            }
        }
    %>

</body>
</html>
