<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Ticket Reservation</title>
</head>
<body>
    <div class="container">
        <h1>Ticket Reservation</h1>
        <form action="submitReservation.jsp" method="post">
            <label for="origin">Origin:</label>
            <input type="text" id="origin" name="origin" placeholder="Enter Origin" required>

            <label for="destination">Destination:</label>
            <input type="text" id="destination" name="destination" placeholder="Enter Destination" required>

            <input type="submit" value="Reserve Ticket">
        </form>
    </div>
</body>
</html>