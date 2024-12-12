<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Edit Train Schedule</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }
        table, th, td {
            border: 1px solid #ddd;
        }
        th, td {
            padding: 10px;
            text-align: left;
        }
        th {
            background-color: #f4f4f4;
        }
        .submit-btn {
            display: block;
            width: 200px;
            padding: 10px 15px;
            margin: 0 auto;
            background-color: #007BFF;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            text-align: center;
        }
        .submit-btn:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>

<h1>Edit Train Schedule</h1>

<form action="#" method="post">
    <table>
        <thead>
            <tr>
                <th>Train ID</th>
                <th>Origin</th>
                <th>Destination</th>
                <th>Departure Time</th>
                <th>Arrival Time</th>
                <th>Travel Time</th>
                <th>Fare</th>
            </tr>
        </thead>
        <tbody>
            <!-- Example row for editing -->
            <tr>
                <td><input type="text" name="trainId" value="3881"></td>
                <td><input type="text" name="origin" value="Trenton Transit Center	"></td>
                <td><input type="text" name="destination" value="Penn Station New York	"></td>
                <td><input type="time" name="departureTime" value="05:23:00	"></td>
                <td><input type="time" name="arrivalTime" value="07:27:00"></td>
                <td><input type="text" name="travelTime" value="94 minutes"></td>
                <td><input type="number" name="fare" value="$19.25" step="0.01"></td>
            </tr>

            <!-- Add more rows as needed -->
        </tbody>
    </table>

    <!-- Submit button -->
    <a href="editedTrainSchedule.jsp"><button type="button">Submit Changes</button></a>
    
</form>

</body>
</html>
