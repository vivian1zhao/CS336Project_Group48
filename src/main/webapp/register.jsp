<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Register Form</title>
</head>
<body>
    <h2 style="text-align: center;">Create a New Customer Account</h2>
    <form action="registerProcess.jsp" method="POST">
        <table style="margin: 0 auto; text-align: left;">
            <tr>
                <td>First Name:</td>
                <td><input type="text" name="firstname" required style="width: 100%;"></td>
            </tr>
            <tr>
                <td>Last Name:</td>
                <td><input type="text" name="lastname" required style="width: 100%;"></td>
            </tr>
            <tr>
                <td>Email:</td>
                <td><input type="email" name="email" required style="width: 100%;"></td>
            </tr>
            <tr>
                <td>Username:</td>
                <td><input type="text" name="username" required style="width: 100%;"></td>
            </tr>
            <tr>
                <td>Password:</td>
                <td><input type="password" name="password" required style="width: 100%;"></td>
            </tr>
            <tr>
                <td colspan="2" style="text-align: center;">
                    <input type="submit" value="Register">
                </td>
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
