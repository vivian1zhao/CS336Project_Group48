<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Submit Answer</title>
</head>
<body>
<h2>Submit Your Answer</h2>

<!-- Check if the form has been submitted -->
<%
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String answer = request.getParameter("answer");
        String qidString = request.getParameter("qid");

        if(answer != null && !answer.trim().isEmpty() && qidString != null) {
            Connection conn = null;
            PreparedStatement pstmt = null;
            try {
                int qid = Integer.parseInt(qidString); // Parse the question ID
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/trainDatabase", "root", "cs336");

                // Prepare SQL query to update the answer
                String sql = "UPDATE questions SET answer = ? WHERE qid = ?";
                pstmt = conn.prepareStatement(sql);
                pstmt.setString(1, answer);
                pstmt.setInt(2, qid);

                // Execute the update
                int result = pstmt.executeUpdate();
                if (result > 0) {
                    out.println("<p>Answer submitted successfully!</p>");
                } else {
                    out.println("<p>Failed to submit answer. Please ensure the question exists.</p>");
                }
            } catch (SQLException e) {
                out.println("SQL Error: " + e.getMessage());
            } catch (NumberFormatException e) {
                out.println("<p>Error: Invalid question ID format.</p>");
            } finally {
                // Clean up database resources
                try { if (pstmt != null) pstmt.close(); } catch (SQLException e) { /* Ignored */ }
                try { if (conn != null) conn.close(); } catch (SQLException e) { /* Ignored */ }
            }
        } else {
            out.println("<p>Please enter a valid answer.</p>");
        }
    }
%>

<!-- Form for submitting an answer -->
<form action="submitAnswer.jsp" method="POST">
    <input type="hidden" name="qid" value="<%= request.getParameter("qid") %>"> <!-- Preserves the question ID on resubmit -->
    <textarea name="answer" rows="4" cols="50" placeholder="Type your answer here..." required></textarea>
    <button type="submit">Submit Answer</button>
</form>

<a href="home.jsp">Return Home</a>
</body>
</html>
