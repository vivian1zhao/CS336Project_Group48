<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>

String userid = request.getParameter("username");
String pwd = request.getParameter("password");

Class.forName("com.mysql.jdbc.Driver");
Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/cs336project","root","cs336");

Statement stmt = con.createStatement();
ResultSet rs;
rs = stmt.executeQuery("select * from user where username='" + userid + "' and password='" + pwd + "'");

if (rs.next()) {
	session.setAttribute("user", userid); // username will be stored in the session
	out.println("welcome " + userid);
	out.println("<a href='logout.jsp'>Log out</a>");
	response.sendRedirect("homeAdmin.jsp");
} else {
	out.println("Invalid password <a href='checkAdminLogin.jsp'>try again</a>");
}

rs.close();
stmt.close();
con.close();
%>