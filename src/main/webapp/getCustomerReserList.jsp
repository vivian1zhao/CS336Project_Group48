
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Browse List of Customer</title>
</head>
<body>
	<h2>Customers Reservations on this Transit Line:</h2>
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

            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(url, username, password);

            // SQL query to fetch customers for the given transit line
            String sql = "SELECT c.cid, c.name, c.email, r.tid, r.originStation, r.destinationStation, r.date " +
                         "FROM customers c " +
                         "JOIN reservationData r ON c.cid = r.cid " +
                         "JOIN trainSchedule ts ON r.schid = ts.schid " +
                         "JOIN transitLine tl ON ts.tlid = tl.tlid " +
                         "WHERE tl.tlname = ?";
            
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, transitLine);
            rs = stmt.executeQuery();

            if (!rs.isBeforeFirst()) {
                out.println("<p>No reservations found for the given transit line.</p>");
            } else {
%>
                <table>
                    <tr>
                        <th>Customer ID</th>
                        <th>Name</th>
                        <th>Email</th>
                        <th>Train ID</th>
                        <th>Origin</th>
                        <th>Destination</th>
                        <th>Reservation Date</th>
                    </tr>
<%
                while (rs.next()) {
%>
                    <tr>
                        <td><%= rs.getInt("cid") %></td>
                        <td><%= rs.getString("name") %></td>
                        <td><%= rs.getString("email") %></td>
                        <td><%= rs.getInt("tid") %></td>
                        <td><%= rs.getString("origin") %></td>
                        <td><%= rs.getString("destination") %></td>
                        <td><%= rs.getDate("date") %></td>
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