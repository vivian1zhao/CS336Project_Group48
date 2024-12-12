<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Home</title>
</head>
<body>
    <%
        if (session.getAttribute("user") == null) {
    %>
        <p>You are not logged in</p>
        <a href="loginAdmin.jsp?referrer=admin">Please Login</a>
    <%
        } else {
            String username = (String) session.getAttribute("user");
    %>
        <h2>Welcome, <%= username %></h2>

        <div class="button-container">
            <form action="searchSchedules.jsp" method="GET">
                <button type="submit">Go to Search Page</button>
            </form>
            <br><a href="manageReps.jsp">Manage Representatives</a>
            <br><a href="monthlySalesReport.jsp">View Monthly Sales Report</a>
            <br><a href="listReservations.jsp">List Reservations</a>
            <br><a href="activeTransitLines.jsp">Active Transit Lines</a>
            <br><a href="bestCustomer.jsp">Best Customers</a>
            <br><a href="revenue.jsp">Revenue</a>
            
            
        </div>

        <div class="logout">
            <a href="logout.jsp">Log Out</a>
        </div>
    <%
        }
    %>
</body>
</html>
