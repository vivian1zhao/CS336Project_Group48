<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Best Customers</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
        }
        table {
            width: 50%;
            border-collapse: collapse;
            margin: 20px auto;
        }
        table, th, td {
            border: 1px solid #ddd;
        }
        th, td {
            padding: 10px;
            text-align: left;
        }
        th {
            background-color: #f4f4f4;
        }
        .back-btn {
            display: block;
            width: 200px;
            padding: 10px 15px;
            margin: 20px auto;
            background-color: #007BFF;
            color: white;
            border: none;
            border-radius: 5px;
            text-align: center;
            cursor: pointer;
            text-decoration: none;
        }
        .back-btn:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>

<h2 style="text-align:center;">Best Customers</h2>

<table>
    <thead>
        <tr>
            <th>Customer Name</th>
            <th>Total Purchases</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>Matt</td>
            <td>$19.25</td>
        </tr>
    </tbody>
</table>

<!-- Back Button -->
<a href="homeAdmin.jsp" class="back-btn">Back to Dashboard</a>

</body>
</html>
