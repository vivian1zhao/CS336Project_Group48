<%@ page import="java.sql.*" %>
<%
    String username = request.getParameter("username");
    String password = request.getParameter("password");

    Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;

    try {
        String dbUrl = "jdbc:mysql://localhost:3306/TrainDatabase";
        String dbUser = "root";
        String dbPassword = "cs336";

        Class.forName("com.mysql.jdbc.Driver");
        conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);

        String sql = "SELECT * FROM employeeAdmin WHERE username = ? AND password = ?";
        stmt = conn.prepareStatement(sql);
        stmt.setString(1, username);
        stmt.setString(2, password);

        rs = stmt.executeQuery();

        if (rs.next()) {
            // Successful login: set the session attribute for the user
            session.setAttribute("user", username);
            response.sendRedirect("homeAdmin.jsp");
        } else {
            // Failed login, show error message
            out.println("<p style='color:red;'>Invalid username or password. Please try again.</p>");
            out.println("<a href='loginAdmin.jsp'>Go Back to Login</a>");
        }
    } catch (Exception e) {
        out.println("<p>Error: " + e.getMessage() + "</p>");
    } finally {
        if (rs != null) try { rs.close(); } catch (SQLException ignore) {}
        if (stmt != null) try { stmt.close(); } catch (SQLException ignore) {}
        if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
    }
%>
