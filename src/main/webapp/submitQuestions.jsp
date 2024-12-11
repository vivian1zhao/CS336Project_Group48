<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Submit Question</title>
</head>
<body>
<h2>Submit Your Question</h2>

<!-- Form for submitting a question -->
<form action="submitQuestions.jsp" method="POST">
    <textarea name="question" rows="4" cols="50" placeholder="Type your question here..." required></textarea>
    <button type="submit">Submit Question</button>
</form>

<%
    // Only process the request if it's a POST request
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String userQuestion = request.getParameter("question");
        if(userQuestion != null && !userQuestion.trim().isEmpty()) {
            int customerId = 1; // This should be dynamically set based on logged-in user ID

            Connection conn = null;
            PreparedStatement pstmt = null;
            try {
                // Establish a connection
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/trainDatabase", "root", "cs336");

                // Prepare SQL query to insert the new question
                String sql = "INSERT INTO questions (cid, qtext) VALUES (?, ?)";
                pstmt = conn.prepareStatement(sql);
                pstmt.setInt(1, customerId);
                pstmt.setString(2, userQuestion);

                // Execute the update
                int result = pstmt.executeUpdate();
                if (result > 0) {
                    out.println("<p>Question submitted successfully!</p>");
                } else {
                    out.println("<p>Failed to submit question.</p>");
                }
            } catch (SQLException e) {
                out.println("SQL Error: " + e.getMessage());
            } finally {
                // Clean up database resources
                try { if (pstmt != null) pstmt.close(); } catch (SQLException e) { /* Ignored */ }
                try { if (conn != null) conn.close(); } catch (SQLException e) { /* Ignored */ }
            }
        } else {
            out.println("<p>Please enter a valid question.</p>");
        }
    }
%>
<a href="home.jsp">Return Home</a>
</body>
</html>
