<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Delete Train Schedule</title>
    <style>
        table {
            border-collapse: collapse;
            width: 100%;
        }
        th, td {
            border: 1px solid black;
            padding: 8px;
            text-align: left;
        }
        th {
            background-color: #f2f2f2;
        }
    </style>
</head>
<body>
<h2>Delete Train Schedule</h2>

<table>
    <tr>
        <th>Train ID</th>
        <th>Origin</th>
        <th>Destination</th>
        <th>Departure Time</th>
        <th>Arrival Time</th>
        <th>Travel Time</th>
        <th>Fare</th>
        <th>Actions</th>
    </tr>
    <tr>
        <td>3880</td>
        <td>Trenton Transit Center</td>
        <td>Penn Station New York</td>
        <td>11:23:00</td>
        <td>12:22:00</td>
        <td>90 minutes</td>
        <td>$19.25</td>
        <td>
            <form action="editTrainSchedule.jsp" method="GET" style="display:inline;">
                <input type="hidden" name="tid" value="3880" />
                <button type="submit">Edit</button>
            </form>
            <form action="deleteTrainSchedule.jsp" method="POST" style="display:inline;">
                <input type="hidden" name="tid" value="3880" />
                <button type="submit" onclick="return confirm('Are you sure you want to delete this schedule?');">Delete</button>
            </form>
        </td>
    </tr>
    <tr>
        <td>3881</td>
        <td>Trenton Transit Center</td>
        <td>Penn Station New York</td>
        <td>05:23:00</td>
        <td>07:27:00</td>
        <td>94 minutes</td>
        <td>$19.25</td>
        <td>
            <form action="editTrainSchedule.jsp" method="GET" style="display:inline;">
                <input type="hidden" name="tid" value="3881" />
                <button type="submit">Edit</button>
            </form>
            <form action="deleteTrainSchedule.jsp" method="POST" style="display:inline;">
                <input type="hidden" name="tid" value="3881" />
                <button type="submit" onclick="return confirm('Are you sure you want to delete this schedule?');">Delete</button>
            </form>
        </td>
    </tr>
</table>

<%
    String tid = request.getParameter("tid");
    if (tid != null && !tid.isEmpty()) {
        try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/trainDatabase", "root", "cs336");
             PreparedStatement pstmt = conn.prepareStatement("DELETE FROM trainSchedule WHERE tid = ?")) {

            pstmt.setString(1, tid);
            int rowsAffected = pstmt.executeUpdate();

            if (rowsAffected > 0) {
                out.println("<p>Train schedule with ID " + tid + " deleted successfully.</p>");
            } else {
                out.println("<p>Error: Train schedule not found.</p>");
            }
        } catch (SQLException e) {
            out.println("<p>SQL Error: " + e.getMessage() + "</p>");
        }
    }
%>

<a href="homeCustomerRep.jsp"><button type="button">Back to Dashboard</button></a>

</body>
</html>
