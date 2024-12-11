<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Customer Representative Home</title>
</head>
<body>
<h2>Customer Representative Dashboard</h2>
<%
    Connection conn = null;
    Statement stmt = null;
    ResultSet rs = null;
    try {
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/yourDatabase", "user", "password");
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
