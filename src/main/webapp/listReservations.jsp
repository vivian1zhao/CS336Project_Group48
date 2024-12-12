<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>List of Reservations</title>
</head>
<body>
    <h2>List of Reservations</h2>
    
    <!-- Sorting Form -->
    <form action="" method="get">
        <input type="hidden" name="origin" value="<%= request.getParameter("origin") %>">
        <input type="hidden" name="destination" value="<%= request.getParameter("destination") %>">
        <label for="sort">Sort by:</label>
        <select name="sort" onchange="this.form.submit()">
            <option value="">Select...</option>
            <option value="customerName" <%= "customerName".equals(request.getParameter("sort")) ? "selected" : "" %>>Customer Name</option>
            <option value="transitLine" <%= "transitLine".equals(request.getParameter("sort")) ? "selected" : "" %>>Transit Line</option>
        </select>
    </form>
    
    <%
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;

        try {
            String url = "jdbc:mysql://localhost:3306/TrainDatabase";
            String dbUsername = "root";
            String dbPassword = "cs336";

            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection(url, dbUsername, dbPassword);
            stmt = conn.createStatement();

            String sortOrder = request.getParameter("sort");
            String sql = "SELECT r.resnum, c.firstname, c.lastname, ts.tid, ts.origin, ts.destination, r.date, r.totalfare, tl.tlname, r.cancelled FROM reservationData r JOIN customer c ON r.cid = c.cid JOIN trainSchedule ts ON r.schid = ts.schid JOIN transitLine tl ON ts.tlid = tl.tlid WHERE r.cancelled = 0";

            if ("customerName".equals(sortOrder)) {
                sql += " ORDER BY c.lastname, c.firstname";
            } else if ("transitLine".equals(sortOrder)) {
                sql += " ORDER BY tl.tlname";
            }

            rs = stmt.executeQuery(sql);

            out.println("<table border='1'><tr><th>Reservation Number</th><th>Customer</th><th>Train ID</th><th>Origin</th><th>Destination</th><th>Date</th><th>Total Fare</th><th>Transit Line</th></tr>");
            while (rs.next()) {
                out.println("<tr>");
                out.println("<td>" + rs.getInt("resnum") + "</td>");
                out.println("<td>" + rs.getString("firstname") + " " + rs.getString("lastname") + "</td>");
                out.println("<td>" + rs.getString("tid") + "</td>");
                out.println("<td>" + rs.getString("origin") + "</td>");
                out.println("<td>" + rs.getString("destination") + "</td>");
                out.println("<td>" + rs.getDate("date") + "</td>");
                out.println("<td>" + rs.getString("totalfare") + "</td>");
                out.println("<td>" + rs.getString("tlname") + "</td>");
                out.println("</tr>");
            }
            out.println("</table>");
        } catch (Exception e) {
            out.println("<p>Error: " + e.getMessage() + "</p>");
        } finally {
            if (rs != null) try { rs.close(); } catch (SQLException ignore) {}
            if (stmt != null) try { stmt.close(); } catch (SQLException ignore) {}
            if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
        }
    %>
    
    <br />
    <a href="homeAdmin.jsp">Back to Admin Home</a>
</body>
</html>
