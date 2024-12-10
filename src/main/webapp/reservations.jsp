<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Ticket Reservation</title>
<style>
	body {
        text-align: center;
    }
	form {
        display: inline-block;
        text-align: left;
    }
    h1 {
        text-align: center;
    }
    input[type="submit"] {
    	display: block;
        margin: 0 auto;
    }
</style>
</head>
<body>

        <h1>Ticket Reservation</h1>
        <form action="submitReservation.jsp" method="post">
            <label for="origin">Origin:</label>
            <input type="text" id="origin" name="origin" placeholder="Enter Origin" required>

			<br>
			
            <label for="destination">Destination:</label>
            <input type="text" id="destination" name="destination" placeholder="Enter Destination" required>

			<br>
			
            <input type="submit" value="Reserve Ticket">
        </form>

</body>
</html>