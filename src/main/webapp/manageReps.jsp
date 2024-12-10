<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Manage Customer Representatives</title>
</head>
<body>
    <h2>Manage Customer Representatives</h2>

    <%
        // Database connection parameters
        String url = "jdbc:mysql://localhost:3306/TrainDatabase";
        String dbUsername = "root";
        String dbPassword = "cs336";
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        String action = request.getParameter("action");

        try {
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection(url, dbUsername, dbPassword);

            // Handle Add Operation
            if ("Add".equals(action)) {
                String ssn = request.getParameter("ssn");
                String firstname = request.getParameter("firstname");
                String lastname = request.getParameter("lastname");
                String username = request.getParameter("username");
                String password = request.getParameter("password");

                String addSql = "INSERT INTO employeeCustomerRep (ssn, firstname, lastname, username, password) VALUES (?, ?, ?, ?, ?)";
                stmt = conn.prepareStatement(addSql);
                stmt.setString(1, ssn);
                stmt.setString(2, firstname);
                stmt.setString(3, lastname);
                stmt.setString(4, username);
                stmt.setString(5, password);
                stmt.executeUpdate();
            }

            // Handle Delete Operation
            if ("Delete".equals(action)) {
                String ssn = request.getParameter("ssn");

                String deleteSql = "DELETE FROM employeeCustomerRep WHERE ssn = ?";
                stmt = conn.prepareStatement(deleteSql);
                stmt.setString(1, ssn);
                stmt.executeUpdate();
            }
        } catch (Exception e) {
            out.println("<p style='color:red;'>Error: " + e.getMessage() + "</p>");
        } finally {
            if (stmt != null) try { stmt.close(); } catch (SQLException ignore) {}
            if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
        }
    %>

    <!-- Form to Add a New Representative -->
    <h3>Add New Representative</h3>
    <form action="manageReps.jsp" method="POST">
        <input type="hidden" name="action" value="Add">
        <label>SSN:</label>
        <input type="text" name="ssn" required>

        <label>First Name:</label>
        <input type="text" name="firstname" required>

        <label>Last Name:</label>
        <input type="text" name="lastname" required>

        <label>Username:</label>
        <input type="text" name="username" required>

        <label>Password:</label>
        <input type="password" name="password" required>

        <button type="submit">Add Representative</button>
    </form>

    <hr>

    <!-- Display Current Representatives with Delete Option -->
    <h3>Current Representatives</h3>
    <%
        try {
            conn = DriverManager.getConnection(url, dbUsername, dbPassword);
            stmt = conn.prepareStatement("SELECT * FROM employeeCustomerRep");
            rs = stmt.executeQuery();

            out.println("<table>");
            out.println("<tr><th>SSN</th><th>First Name</th><th>Last Name</th><th>Username</th><th>Actions</th></tr>");

            while (rs.next()) {
                out.println("<tr>");
                out.println("<td>" + rs.getString("ssn") + "</td>");
                out.println("<td>" + rs.getString("firstname") + "</td>");
                out.println("<td>" + rs.getString("lastname") + "</td>");
                out.println("<td>" + rs.getString("username") + "</td>");
                out.println("<td>");
                out.println("<form action='manageReps.jsp' method='POST' style='display:inline;'>");
                out.println("<input type='hidden' name='action' value='Delete'>");
                out.println("<input type='hidden' name='ssn' value='" + rs.getString("ssn") + "'>");
                out.println("<button type='submit'>Delete</button>");
                out.println("</form>");
                out.println("</td>");
                out.println("</tr>");
            }

            out.println("</table>");
        } catch (Exception e) {
            out.println("<p style='color:red;'>Error: " + e.getMessage() + "</p>");
        } finally {
            if (rs != null) try { rs.close(); } catch (SQLException ignore) {}
            if (stmt != null) try { stmt.close(); } catch (SQLException ignore) {}
            if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
        }
    %>

    <br />
    <a href="homeAdmin.jsp">Back to Admin Home</a>
</body>
</html>
