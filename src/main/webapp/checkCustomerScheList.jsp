<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Browse List of Reservations</title>
</head>
<body>
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
