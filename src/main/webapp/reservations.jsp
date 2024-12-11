<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Ticket Reservation</title>
</head>
<body>

    <h1>Make a Reservation</h1>
    <form action="submitReservation.jsp" method="post">
        <label for="origin">Origin:</label>
        <input type="text" id="origin" name="origin" placeholder="Enter Origin" required>

        <label for="destination">Destination:</label>
        <input type="text" id="destination" name="destination" placeholder="Enter Destination" required>

        <label for="date">Date of Travel:</label>
        <input type="date" id="date" name="date" required>

        <label for="tripType">Trip Type:</label>
        <select id="tripType" name="tripType" required>
            <option value="oneway">One Way</option>
            <option value="roundtrip">Round Trip</option>
        </select>

        <label for="discount">Discount:</label>
        <select id="discount" name="discount">
            <option value="none">None</option>
            <option value="child">Child</option>
            <option value="senior">Senior</option>
            <option value="disabled">Disabled</option>
        </select>

        <input type="submit" value="Reserve Ticket">
    </form>

</body>
</html>
