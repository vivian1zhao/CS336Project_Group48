<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Home</title>
</head>
<body>
<h2>Home</h2>
    <%
    if (session.getAttribute("user") == null) {
    %>
        <p>You are not logged in</p>
        <a href="login.jsp">Please Login</a>
    <%
    } else {
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;
    %>
        <p>Welcome, <%= session.getAttribute("user") %></p>
        <!-- Button to redirect to the search page -->
        <form action="searchSchedules.jsp" method="GET">
            <button type="submit">Go to Search Page</button>
        </form>
        <form action="reservations.jsp" method="GET">
            <button type="submit">Go to Reservations Page</button>
        </form>
        
         <!-- Button to redirect to the view reservations page -->
        <form action="viewReservations.jsp" method="GET">
            <button type="submit">View My Reservations</button>
        </form>
        
        <br />
        <a href="logout.jsp">Log out</a>

        <!-- Q&A Section -->
        <h3>Customer Q&A Section</h3>
        
        <!-- Search Questions -->
        <form action="searchQuestions.jsp" method="GET">
            <input type="text" name="keyword" placeholder="Search questions..." required>
            <button type="submit">Search</button>
        </form>
        
        <!-- Send a Question -->
        <form action="submitQuestion.jsp" method="POST">
            <textarea name="question" rows="4" cols="50" placeholder="Type your question here..." required></textarea>
            <button type="submit">Send Question</button>
        </form>
        
        <!-- Browse Questions and Answers -->
        <h4>Recently Answered Questions</h4>
        <ul>
            <%
                try {
                    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/trainDatabase", "root", "cs336");
                    stmt = conn.createStatement();
                    rs = stmt.executeQuery("SELECT question, answer FROM questions WHERE answered = TRUE");
                    while (rs.next()) {
            %>
                <li>Q: <%= rs.getString("question") %> <br/> A: <%= rs.getString("answer") %></li>
            <%
                    }
                } catch (SQLException e) {
                    out.println("Error retrieving questions: " + e.getMessage());
                } finally {
                    try { if (rs != null) rs.close(); } catch (Exception e) {}
                    try { if (stmt != null) stmt.close(); } catch (Exception e) {}
                    try { if (conn != null) conn.close(); } catch (Exception e) {}
                }
            %>
        </ul>
    <%
    }
    %>
</body>
</html>
