<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
	<title>Login Form</title>
</head>
<body>
	<h2 style="text-align: center;">Create a new account</h2>
    <form action="checkAdminLogin.jsp" method="POST">
        <table style="margin: 0 auto; text-align: left;">
            <tr>
                <td>Username:</td>
                <td><input type="text" name="username" style="width: 100%;"></td>
            </tr>
            <tr>
                <td>Password:</td>
                <td><input type="password" name="password" style="width: 100%;"></td>
            </tr>
            <tr>
                <td colspan="2" style="text-align: center;">
                	Already have an account?
                    <a href="login.jsp">Login</a>
                    
                </td>
            </tr>
        </table>
    </form>
</body>
</html>

// NEEDS TO BE FIXED