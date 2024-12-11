<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Customer Representative Home</title>
</head>
<body>
<h2>Customer Representative Dashboard</h2>
</head>
<body>

<!-- This goes in homeCustomerRep.jsp or wherever you initiate the search -->
<form action="customerRepSearchResult.jsp" method="GET">
    <input type="text" name="station" placeholder="Enter station name..." required>
    <select name="searchType">
        <option value="origin">Origin</option>
        <option value="destination">Destination</option>
    </select>
    <button type="submit">Search Schedules</button>
</form>


<%
    Connection conn = null;
    Statement stmt = null;
    ResultSet rs = null;
    try {
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/trainDatabase", "root", "cs336");
        stmt = conn.createStatement();
        String sql = "SELECT id, question FROM questions WHERE answered = FALSE";
        rs = stmt.executeQuery(sql);
        
        while (rs.next()) {
%>
        <div>
            <p><strong>Question:</strong> <%= rs.getString("question") %></p>
            <form action="answerQuestion.jsp" method="POST">
                <input type="hidden" name="id" value="<%= rs.getInt("id") %>">
                <textarea name="answer" required placeholder="Type your answer here..."></textarea>
                <button type="submit">Submit Answer</button>
            </form>
        </div>
<%
        }
    } catch (SQLException e) {
        out.println("SQL Error: " + e.getMessage());
    } finally {
        try { if (rs != null) rs.close(); } catch (Exception e) {}
        try { if (stmt != null) stmt.close(); } catch (Exception e) {}
        try { if (conn != null) conn.close(); } catch (Exception e) {}
    }
%>
</body>
</html>
