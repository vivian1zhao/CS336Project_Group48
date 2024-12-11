<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Cancel Reservation</title>
</head>
<body>
<%
    String resnum = request.getParameter("resnum");

    Connection conn = null;
    PreparedStatement stmt = null;

    try {
        String url = "jdbc:mysql://localhost:3306/TrainDatabase";
        String dbUsername = "root";
        String dbPassword = "cs336";

        Class.forName("com.mysql.jdbc.Driver");
        conn = DriverManager.getConnection(url, dbUsername, dbPassword);

        String sql = "UPDATE reservationData SET cancelled = 1 WHERE resnum = ?";
        stmt = conn.prepareStatement(sql);
        stmt.setInt(1, Integer.parseInt(resnum));
        int rowsAffected = stmt.executeUpdate();

        if (rowsAffected > 0) {
%>
            <p>Reservation canceled successfully!</p>
            <form action="home.jsp" method="GET">
                <button type="submit">Back to Home</button>
            </form>
<%
        } else {
%>
            <p class="error">No reservation found with that ID.</p>
            <form action="home.jsp" method="GET">
                <button type="submit">Back to Home</button>
            </form>
<%
        }
    } catch (Exception e) {
%>
        <p class="error">Error: <%= e.getMessage() %></p>
        <form action="home.jsp" method="GET">
            <button type="submit">Back to Home</button>
        </form>
<%
    } finally {
        if (stmt != null) try { stmt.close(); } catch (SQLException ignore) {}
        if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
    }
%>
</body>
</html>
