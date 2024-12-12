<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Revenue Details</title>
</head>
<body>
<h2>Revenue Details</h2>

<!-- Section for Transit Line Revenues -->
<h3>Revenue by Transit Line</h3>
<%
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    try {
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/trainDatabase", "root", "cs336");
        String sql = "SELECT tl.tlname, SUM(rd.totalfare) AS revenue FROM transitLine tl JOIN trainSchedule ts ON tl.tlid = ts.tlid JOIN reservationData rd ON ts.schid = rd.schid GROUP BY tl.tlname";
        pstmt = conn.prepareStatement(sql);
        rs = pstmt.executeQuery();

        if (!rs.isBeforeFirst()) {
            out.println("<p>No revenue data found for transit lines.</p>");
        } else {
%>
<table border="1">
    <tr>
        <th>Transit Line</th>
        <th>Revenue</th>
    </tr>
<%
            while (rs.next()) {
%>
    <tr>
        <td><%= rs.getString("tlname") %></td>
        <td>$<%= rs.getDouble("revenue") %></td>
    </tr>
<%
            }
            out.println("</table>");
        }
    } catch (SQLException e) {
        out.println("SQL Error: " + e.getMessage());
    } finally {
        if (rs != null) try { rs.close(); } catch (SQLException e) { }
        if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { }
        if (conn != null) try { conn.close(); } catch (SQLException e) { }
    }
%>

<!-- Section for Customer Revenues -->
<h3>Revenue by Customer</h3>
<%
    try {
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/trainDatabase", "root", "cs336");
        String sql = "SELECT CONCAT(c.firstname, ' ', c.lastname) AS customerName, SUM(rd.totalfare) AS revenue FROM customer c JOIN reservationData rd ON c.cid = rd.cid GROUP BY c.cid";
        pstmt = conn.prepareStatement(sql);
        rs = pstmt.executeQuery();

        if (!rs.isBeforeFirst()) {
            out.println("<p>No revenue data found for customers.</p>");
        } else {
%>
<table border="1">
    <tr>
        <th>Customer Name</th>
        <th>Revenue</th>
    </tr>
<%
            while (rs.next()) {
%>
    <tr>
        <td><%= rs.getString("customerName") %></td>
        <td>$<%= rs.getDouble("revenue") %></td>
    </tr>
<%
            }
            out.println("</table>");
        }
    } catch (SQLException e) {
        out.println("SQL Error: " + e.getMessage());
    } finally {
        if (rs != null) try { rs.close(); } catch (SQLException e) { }
        if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { }
        if (conn != null) try { conn.close(); } catch (SQLException e) { }
    }
%>

<a href="homeAdmin.jsp">Return to Dashboard</a>

</body>
</html>
