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
        PreparedStatement pstmt = null;
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

        <!-- Q&A Section -->
        <h3>Customer Q&A Section</h3>
        
        
	<form action="submitQuestions.jsp" method="POST">
    <button type="submit">Submit Question</button>
	
	</form> 
        <!-- Browse Questions and Answers -->
        <h4>Recently Answered Questions</h4>
        <form action="questions.jsp" method="POST">
            <button type="submit">View Asked Questions</button>
        </form>
         
        
        <br />
        <a href="logout.jsp">Log out</a>
    <%
    }
    %>
</body>
</html>
