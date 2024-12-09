<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
	<title>Login Form</title>
</head>
<body>
	<h2 style="text-align: center;">Login</h2>
    <form action="checkLoginDetails.jsp" method="POST">
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
                    <input type="submit" value="Log In" style="width: 100%;">
                </td>
            </tr>
            <tr>
                <td colspan="2" style="text-align: center;">
                    <a href="AdminLogin.jsp">Administrator Login</a> | 
                    <a href="CustomerRepLogin.jsp">Customer Rep Login</a>
                </td>
            </tr>
            <tr>
                <td colspan="2" style="text-align: center;">
                    <a href="register.jsp">Create an account</a>
                </td>
            </tr>
        </table>
    </form>
</body>
</html>

