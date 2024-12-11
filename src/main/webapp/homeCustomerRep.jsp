
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Customer Representative Home</title>
<style>
	body {
        text-align: center;
</style>
</head>
<body>
<h2>Customer Representative Dashboard</h2>

<!-- Search feature -->
<div>

            <form action="answerQuestion.jsp" method="POST">
                <button type="submit">Answer Customer Questions Here</button>
            </form>
</div>

<br>
<br>
        
<form action="customerRepSearchResult.jsp" method="GET">
    <input type="text" name="station" placeholder="Enter station name..." required>
    <select name="searchType">
        <option value="origin">Origin</option>
        <option value="destination">Destination</option>
    </select>
    <button type="submit">Search Schedules</button>
</form>

<br>

    <h2>Train Reservations for Transit Line:</h2>

    <!-- Form to select a transit line -->
    <form method="get" action="getCustomerReserList.jsp">
        <label for="transitLine">Select Transit Line:</label>
        <select name="transitLine">
            <option value="Northeast Corridor">Northeast Corridor</option>
            <option value="Raritan Valley">Raritan Valley</option>
            <option value="North Jersey Coast">North Jersey Coast</option>
            <option value="Morris & Essex">Morris & Essex</option>
            <option value="Montclair-Boonton">Montclair-Boonton</option>
            <option value="Main-Bergen County">Main-Bergen County</option>
        </select>
        <input type="submit" value="Search"/>
    </form>


</body>
</html>
	
<br>

<a href="login.jsp">Log Out</a>

</body>
</html>