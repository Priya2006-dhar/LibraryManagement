
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="com.library.DBConnection" %>

<!DOCTYPE html>
<html>

<head>

    <meta charset="UTF-8">

    <title>Library Books</title>

    <style>

        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background-color: #f4f6f8;
        }

        .navbar {
            background-color: #2c3e50;
            color: white;
            padding: 20px 40px;
        }

        .navbar h2 {
            margin: 0;
        }

        .container {
            width: 90%;
            margin: 40px auto;
        }

        h1 {
            text-align: center;
            color: #2c3e50;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            background-color: white;
            margin-top: 30px;
            box-shadow: 0 3px 15px rgba(0,0,0,0.1);
        }

        th {
            background-color: #2c3e50;
            color: white;
            padding: 15px;
        }

        td {
            padding: 13px;
            text-align: center;
            border-bottom: 1px solid #ddd;
        }

        .available {
            color: #27ae60;
            font-weight: bold;
        }

        .unavailable {
            color: #e74c3c;
            font-weight: bold;
        }

        .action-link {
            text-decoration: none;
            font-weight: bold;
            margin: 0 5px;
        }

        .update {
            color: #3498db;
        }

        .delete {
            color: #e74c3c;
        }

        .back {
            display: inline-block;
            margin-top: 25px;
            padding: 10px 20px;
            background-color: #3498db;
            color: white;
            text-decoration: none;
            border-radius: 5px;
        }

        .back:hover {
            background-color: #2980b9;
        }

    </style>

</head>

<body>

<div class="navbar">

    <h2>Library Management System</h2>

</div>


<div class="container">

    <h1>Library Books</h1>


    <table>

        <tr>

            <th>Book ID</th>

            <th>Book Title</th>

            <th>Author</th>

            <th>Category</th>

            <th>Total Books</th>

            <th>Available</th>

            <th>Actions</th>

        </tr>


<%

    try {

        Connection con = DBConnection.getConnection();

        String sql =
            "SELECT book_id, title, author, category, quantity " +
            "FROM books";

        PreparedStatement ps =
            con.prepareStatement(sql);

        ResultSet rs =
            ps.executeQuery();


        while (rs.next()) {

            int bookId =
                rs.getInt("book_id");

            String title =
                rs.getString("title");

            String author =
                rs.getString("author");

            String category =
                rs.getString("category");

            int quantity =
                rs.getInt("quantity");

            int available =
                quantity;

%>

        <tr>

            <td>
                <%= bookId %>
            </td>

            <td>
                <%= title %>
            </td>

            <td>
                <%= author %>
            </td>

            <td>
                <%= category %>
            </td>

            <td>
                <%= quantity %>
            </td>


            <td>

                <% if (available > 0) { %>

                    <span class="available">
                        <%= available %>
                    </span>

                <% } else { %>

                    <span class="unavailable">
                        Not Available
                    </span>

                <% } %>

            </td>


            <td>

                <a
                    href="updateBook.jsp?book_id=<%= bookId %>"
                    class="action-link update">
                    Update
                </a>

                <a
                    href="DeleteBookServlet?book_id=<%= bookId %>"
                    class="action-link delete"
                    onclick="return confirm('Are you sure you want to delete this book?');">
                    Delete
                </a>

            </td>

        </tr>


<%

        }

        rs.close();

        ps.close();

        con.close();

    }

    catch (Exception e) {

        out.println(
            "<tr><td colspan='7'>Error: "
            + e.getMessage()
            + "</td></tr>"
        );

    }

%>

    </table>


    <a href="display.jsp" class="back">
        ← Back to Dashboard
    </a>

</div>

</body>

</html>

