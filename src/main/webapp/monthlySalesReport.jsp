<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Monthly Sales Report</title>
</head>
<body>
    <h2>Monthly Sales Report</h2>
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
            rs = stmt.executeQuery("SELECT DATE_FORMAT(date, '%Y-%m') AS month, SUM(CAST(REPLACE(totalfare, '$', '') AS DECIMAL(10,2))) AS revenue FROM reservationData WHERE cancelled = 0 GROUP BY month");

            out.println("<table border='1'><tr><th>Month</th><th>Total Revenue ($)</th></tr>");
            while (rs.next()) {
                out.println("<tr>");
                out.println("<td>" + rs.getString("month") + "</td>");
                out.println("<td>" + rs.getString("revenue") + "</td>");
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
