<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
    %>
        <p>Welcome, <%= session.getAttribute("user") %></p>
        <!-- Button to redirect to the search page -->
        <form action="searchSchedules.jsp" method="GET">
            <button type="submit">Go to Search Page</button>
        </form>
        <form action="reservations.jsp" method="GET">
            <button type="submit">Go to Reservations Page</button>
        </form>
        <br />
        <a href="logout.jsp">Log out</a>
    <%
    }
    %>
</body>
</html>
