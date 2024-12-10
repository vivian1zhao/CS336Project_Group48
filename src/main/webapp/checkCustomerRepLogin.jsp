<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.*, java.util.*, java.sql.*"%>
<%
    String username = request.getParameter("username");
    String password = request.getParameter("password");

    Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;

    try {
        // Database connection details
        String url = "jdbc:mysql://localhost:3306/TrainDatabase";
        String dbUsername = "root";
        String dbPassword = "cs336";

        // Load MySQL JDBC driver
        Class.forName("com.mysql.jdbc.Driver");
        conn = DriverManager.getConnection(url, dbUsername, dbPassword);

        // SQL query to check username and password in employeeCustomerRep table
        String sql = "SELECT * FROM employeeCustomerRep WHERE username = ? AND password = ?";
        stmt = conn.prepareStatement(sql);
        stmt.setString(1, username);
        stmt.setString(2, password);

        rs = stmt.executeQuery();

        if (rs.next()) {
            // Successful login, set session attribute and redirect to homeCustomerRep.jsp
            session.setAttribute("user", username);
            response.sendRedirect("homeCustomerRep.jsp");
        } else {
            // Failed login, show error message
            out.println("<p style='color:red;'>Invalid username or password. Please try again.</p>");
            out.println("<a href='loginCustomerRep.jsp'>Go Back to Login</a>");
        }
    } catch (Exception e) {
        out.println("<p style='color:red;'>Error: " + e.getMessage() + "</p>");
    } finally {
        if (rs != null) try { rs.close(); } catch (SQLException ignore) {}
        if (stmt != null) try { stmt.close(); } catch (SQLException ignore) {}
        if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
    }
%>
