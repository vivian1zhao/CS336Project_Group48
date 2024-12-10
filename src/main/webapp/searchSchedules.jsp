<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Search Train Schedules</title>
</head>
<body>
    <h2>Search for Train Schedules</h2>
    <form action="browseSchedules.jsp" method="GET">
        <label for="origin">Origin Station:</label>
        <input type="text" name="origin" required><br><br>

        <label for="destination">Destination Station:</label>
        <input type="text" name="destination" required><br><br>

        <label for="date">Date of Travel:</label>
        <input type="date" name="date" required><br><br>

        <input type="submit" value="Search">
    </form>
    <!-- Add a back button -->
    <button onclick="window.location.href='home.jsp';">Back to Home</button>
</body>
</html>
