<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Top 5 Most Active Transit Lines</title>
    <style>
        table {
            width: 50%;
            margin: 20px auto;
            border-collapse: collapse;
        }
        table, th, td {
            border: 1px solid black;
        }
        th, td {
            padding: 10px;
            text-align: center;
        }
        h2 {
            text-align: center;
        }
    </style>
</head>
<body>
    <h2>Top 5 Most Active Transit Lines</h2>
    <%
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;

        try {
            String url = "jdbc:mysql://localhost:3306/TrainDatabase";
            String dbUsername = "root";
            String dbPassword = "cs336";

            // Load the MySQL JDBC driver
            Class.forName("com.mysql.jdbc.Driver");

            // Establish the connection
            conn = DriverManager.getConnection(url, dbUsername, dbPassword);

            // Execute the SQL query to get the top 5 most active transit lines
            stmt = conn.createStatement();
            String sql = "SELECT tl.tlname, COUNT(*) AS reservation_count " +
                         "FROM reservationData r " +
                         "JOIN trainSchedule ts ON r.schid = ts.schid " +
                         "JOIN transitLine tl ON ts.tlid = tl.tlid " +
                         "WHERE r.cancelled = 0 " +
                         "GROUP BY tl.tlname " +
                         "ORDER BY reservation_count DESC " +
                         "LIMIT 5";

            rs = stmt.executeQuery(sql);

            // Display the results in a table
            out.println("<table>");
            out.println("<tr><th>Transit Line</th><th>Number of Reservations</th></tr>");

            while (rs.next()) {
                out.println("<tr>");
                out.println("<td>" + rs.getString("tlname") + "</td>");
                out.println("<td>" + rs.getInt("reservation_count") + "</td>");
                out.println("</tr>");
            }

            out.println("</table>");

        } catch (Exception e) {
            out.println("<p style='color:red; text-align: center;'>Error: " + e.getMessage() + "</p>");
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
