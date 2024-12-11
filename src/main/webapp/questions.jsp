<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Answer Questions</title>
</head>
<body>
<h2>Answer Questions</h2>
<%
    Connection conn = null;
    Statement stmt = null;
    ResultSet rs = null;
    try {
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/trainDatabase", "root", "cs336");
        stmt = conn.createStatement();
        String sql = "SELECT qid, qtext FROM questions";
        rs = stmt.executeQuery(sql);
        while (rs.next()) {
            int qid = rs.getInt("qid");
            String question = rs.getString("qtext");
%>
<div>
    <p><strong>Question:</strong> <%= question %></p>
    <form action="submitAnswer.jsp" method="POST">
        <input type="hidden" name="qid" value="<%= qid %>">
        <textarea name="answer" required placeholder="Type your answer here..."></textarea>
        <button type="submit">Submit Answer</button>
    </form>
</div>
<%
        }
    } catch (SQLException e) {
        out.println("SQL Error: " + e.getMessage());
    } finally {
        if (rs != null) try { rs.close(); } catch (SQLException e) { /* ignored */ }
        if (stmt != null) try { stmt.close(); } catch (SQLException e) { /* ignored */ }
        if (conn != null) try { conn.close(); } catch (SQLException e) { /* ignored */ }
    }
%>
</body>
</html>
