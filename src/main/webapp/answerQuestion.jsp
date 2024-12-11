<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Answer Question</title>
</head>
<body>
<h2>Unanswered Questions</h2>
<%
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    try {
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/trainDatabase", "root", "cs336");
        String fetchSql = "SELECT qid, qtext FROM questions WHERE answered IS NULL OR answered = FALSE";
        pstmt = conn.prepareStatement(fetchSql);
        rs = pstmt.executeQuery();

        if (!rs.isBeforeFirst()) {
            out.println("<p>No unanswered questions at the moment.</p>");
        } else {
            while (rs.next()) {
                int qid = rs.getInt("qid");
                String question = rs.getString("qtext");
%>
<div>
    <p><strong>Question:</strong> <%= question %></p>
    <form action="answerQuestion.jsp" method="POST">
        <input type="hidden" name="qid" value="<%= qid %>">
        <textarea name="answer" required placeholder="Type your answer here..."></textarea>
        <button type="submit">Submit Answer</button>
    </form>
</div>
<%
            }
        }
    } catch (SQLException e) {
        out.println("<p>SQL Error: " + e.getMessage() + "</p>");
    } finally {
        if (rs != null) try { rs.close(); } catch (SQLException e) { }
        if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { }
        if (conn != null) try { conn.close(); } catch (SQLException e) { }
    }
%>
<a href="homeCustomerRep.jsp">Return Home</a>
</body>
</html>
