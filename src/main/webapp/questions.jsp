<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Questions and Answers</title>
</head>
<body>
<h2>Questions and Answers</h2>

<!-- Search Form -->
<form action="questions.jsp" method="GET">
    <input type="text" name="keyword" placeholder="Search questions..." required>
    <button type="submit">Search</button>
</form>

<%
    String keyword = request.getParameter("keyword");
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    
    try {
        // Establish a connection
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/trainDatabase", "root", "cs336");
        
        String sql = "SELECT q.qtext AS question, a.atext AS answer FROM questions q LEFT JOIN answers a ON q.qid = a.qid";
        
        // Append search condition if keyword is present
        if (keyword != null && !keyword.isEmpty()) {
            sql += " WHERE q.qtext LIKE ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, "%" + keyword + "%");
        } else {
            pstmt = conn.prepareStatement(sql);
        }
        
        // Execute query
        rs = pstmt.executeQuery();

        // Check if there are results
        if (!rs.isBeforeFirst()) {
            out.println("<p>No questions and answers found for your search.</p>");
        } else {
            // Display results in a list
            out.println("<ul>");
            while (rs.next()) {
                String question = rs.getString("question");
                String answer = rs.getString("answer");
                out.println("<li><strong>Q:</strong> " + question + "<br/><strong>A:</strong> " + (answer != null ? answer : "There are 14 trains.") + "</li>");
            }
            out.println("</ul>");
        }
    } catch (SQLException e) {
        out.println("Error connecting to the database: " + e.getMessage());
    } finally {
        // Clean up database resources
        try { if (rs != null) rs.close(); } catch (SQLException e) { /* Ignored */ }
        try { if (pstmt != null) pstmt.close(); } catch (SQLException e) { /* Ignored */ }
        try { if (conn != null) conn.close(); } catch (SQLException e) { /* Ignored */ }
    }
%>

<!-- Back button to return home -->
<form action="home.jsp" method="POST">
    <button type="submit">Return Home</button>
</form>
</body>
</html>
