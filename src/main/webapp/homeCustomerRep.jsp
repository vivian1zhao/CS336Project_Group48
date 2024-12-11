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


<h2>Transit Line Customers</h2>
	<form action="getCustomerReserList.jsp" method="get">
		<label for="Transit Line">Transit Line:</label>
		<input type="text" id="transit" name="transit" placeholder="Enter Transit Line" required>
		<input type="submit" value="Search">
	</form>
	
<br>

<a href="login.jsp">Log Out</a>

</body>
</html>
