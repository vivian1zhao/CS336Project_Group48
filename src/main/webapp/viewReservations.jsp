<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>View Reservations</title>
</head>
<body>
    <h2 style="text-align: center;">Your Reservations</h2>

    <%
        String user = (String) session.getAttribute("user");

        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            String url = "jdbc:mysql://localhost:3306/TrainDatabase";
            String dbUsername = "root";
            String dbPassword = "cs336";

            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection(url, dbUsername, dbPassword);

            String sql = "SELECT r.resnum, r.date, r.totalfare, s1.name AS origin, s2.name AS destination, r.cancelled " +
                         "FROM reservationData r " +
                         "JOIN customer c ON r.cid = c.cid " +
                         "JOIN station s1 ON r.originStation = s1.sid " +
                         "JOIN station s2 ON r.destinationStation = s2.sid " +
                         "WHERE c.username = ?";

            stmt = conn.prepareStatement(sql);
            stmt.setString(1, user);
            rs = stmt.executeQuery();

            if (!rs.isBeforeFirst()) {
                out.println("<p style='text-align: center;'>No reservations found.</p>");
            } else {
    %>
            <table>
                <tr>
                    <th>Reservation Number</th>
                    <th>Date</th>
                    <th>Total Fare</th>
                    <th>Origin</th>
                    <th>Destination</th>
                    <th>Status</th>
                    <th>Action</th>
                </tr>
    <%
                while (rs.next()) {
                    boolean isCancelled = rs.getInt("cancelled") == 1;
    %>
                <tr>
                    <td><%= rs.getInt("resnum") %></td>
                    <td><%= rs.getDate("date") %></td>
                    <td><%= rs.getString("totalfare") %></td>
                    <td><%= rs.getString("origin") %></td>
                    <td><%= rs.getString("destination") %></td>
                    <td><%= isCancelled ? "Cancelled" : "Active" %></td>
                    <td>
                        <% if (!isCancelled) { %>
                            <form action="cancelReservation.jsp" method="POST" onsubmit="return confirm('Are you sure you want to cancel this reservation?');">
                                <input type="hidden" name="resnum" value="<%= rs.getInt("resnum") %>">
                                <button type="submit">Cancel</button>
                            </form>
                        <% } else { %>
                            <span style="color: grey;">Cancelled</span>
                        <% } %>
                    </td>
                </tr>
    <%
                }
            }
        } catch (Exception e) {
            out.println("<p style='text-align: center;'>Error: " + e.getMessage() + "</p>");
        } finally {
            if (rs != null) try { rs.close(); } catch (SQLException ignore) {}
            if (stmt != null) try { stmt.close(); } catch (SQLException ignore) {}
            if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
        }
    %>
            </table>

    <div style="text-align: center; margin-top: 20px;">
        <a href="home.jsp">Back to Home</a>
    </div>
</body>
</html>
