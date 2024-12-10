<!-- trainSearchPage.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Train Search</title>
</head>
<body>
    <h1>Welcome to Train Search</h1>
    <p>Here, you can search for train schedules.</p>
    <form action="displaySchedules.jsp" method="get">
        <label for="origin">Origin:</label>
        <input type="text" id="origin" name="origin">
        <label for="destination">Destination:</label>
        <input type="text" id="destination" name="destination">
        <label for="date">Travel Date:</label>
        <input type="date" id="date" name="date">
        <input type="submit" value="Search">
    </form>
</body>
</html>
