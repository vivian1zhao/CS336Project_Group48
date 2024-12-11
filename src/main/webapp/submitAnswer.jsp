<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Submit Answer</title>
</head>
<body>
<h2>Submit Your Answer</h2>

<% 
    // Check if the form has been submitted
    boolean isSubmitted = "POST".equalsIgnoreCase(request.getMethod());
%>

<form action="submitAnswer.jsp" method="POST">
    <textarea name="answer" rows="4" cols="50" placeholder="Type your answer here..." required></textarea>
    <button type="submit">Submit Answer</button>
</form>




<!-- Back button to return home -->
<a href="homeCustomerRep.jsp">Return Home</a>
</body>
</html>
