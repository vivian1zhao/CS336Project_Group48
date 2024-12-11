<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Customer Representative Home</title>
</head>
<body>
<h2>Customer Representative Dashboard</h2>

<!-- Search feature -->
<form action="customerRepSearchResult.jsp" method="GET">
    <input type="text" name="station" placeholder="Enter station name..." required>
    <select name="searchType">
        <option value="origin">Origin</option>
        <option value="destination">Destination</option>
    </select>
    <button type="submit">Search Schedules</button>
</form>
<div>

            <form action="answerQuestion.jsp" method="POST">
                <button type="submit">Answer Question Here</button>
            </form>
        </div>
<br>
<a href="login.jsp">Log Out</a>
</body>
</html>
