<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Transit Line Customers</title>
<style>
	body {
        text-align: center;
</style>
</head>
<body>
	<h1>Transit Line Customers</h1>
	<form action="CustomerReserList.jsp" method="get">
		<label for="Transit Line">Transit Line:</label>
		<input type="text" id="transit" name="transit" placeholder="Enter Transit Line" required>
		<input type="submit" value="Search">
	</form>
	
</body>
</html>