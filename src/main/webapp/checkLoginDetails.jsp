<%-- <%@ page language="java" contentType="text/html; charset=UTF-8"
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
	response.sendRedirect("home.jsp");
} else {
	out.println("Invalid password <a href='login.jsp'>try again</a>");
}

rs.close();
stmt.close();
con.close();
%> --%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>

<%
String userid = request.getParameter("username");
String pwd = request.getParameter("password");

try {
    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/TrainDatabase", "root", "cs336");

    // Use a prepared statement to prevent SQL injection
    String query = "SELECT * FROM customer WHERE username = ? AND password = ?";
    PreparedStatement pstmt = con.prepareStatement(query);
    pstmt.setString(1, userid);
    pstmt.setString(2, pwd);

    ResultSet rs = pstmt.executeQuery();

    if (rs.next()) {
        // Login successful, store username in session
        session.setAttribute("user", userid);
        response.sendRedirect("home.jsp");
    } else {
        // Login failed
        out.println("Invalid username or password. <a href='login.jsp'>Try again</a>");
    }

    rs.close();
    pstmt.close();
    con.close();
} catch (Exception e) {
    out.println("Error: " + e.getMessage());
    e.printStackTrace();
}
%>
