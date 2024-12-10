<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>

<%
String firstname = request.getParameter("firstname");
String lastname = request.getParameter("lastname");
String email = request.getParameter("email");
String username = request.getParameter("username");
String password = request.getParameter("password");

try {
    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/TrainDatabase", "root", "cs336");

    // Insert customer details
    String query = "INSERT INTO customer (firstname, lastname, email, username, password) VALUES (?, ?, ?, ?, ?)";
    PreparedStatement pstmt = con.prepareStatement(query);
    pstmt.setString(1, firstname);
    pstmt.setString(2, lastname);
    pstmt.setString(3, email);
    pstmt.setString(4, username);
    pstmt.setString(5, password); // In production, hash the password before storing it!

    int rows = pstmt.executeUpdate();
    if (rows > 0) {
        out.println("Registration successful! <a href='login.jsp'>Login here</a>");
    } else {
        out.println("Registration failed. <a href='register.jsp'>Try again</a>");
    }

    pstmt.close();
    con.close();
} catch (Exception e) {
    out.println("Error: " + e.getMessage());
    e.printStackTrace();
}
%>
