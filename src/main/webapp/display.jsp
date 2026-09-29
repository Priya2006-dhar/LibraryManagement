
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="com.library.DBConnection" %>

<%

    Integer studentId = (Integer) session.getAttribute("studentId");

    if (studentId == null) {
        response.sendRedirect("login.jsp");
        return;
    }

%>

<%

    String studentName = "";
    String registerNumber = "";
    String department = "";

    try {

        Connection con = DBConnection.getConnection();

        String sql =
            "SELECT name, register_number, department " +
            "FROM students WHERE username=?";

        PreparedStatement ps = con.prepareStatement(sql);

        ps.setString(1, "priya");

        ResultSet rs = ps.executeQuery();

        if (rs.next()) {

            studentName = rs.getString("name");
            registerNumber = rs.getString("register_number");
            department = rs.getString("department");

        }

        rs.close();
        ps.close();
        con.close();

    } catch (Exception e) {

        out.println("Database Error: " + e.getMessage());

    }

%>

<%

    int fineAmount = 0;

    try {

        Connection con = DBConnection.getConnection();

        String sql =
            "SELECT COALESCE(SUM(fine_amount), 0) AS fine " +
            "FROM borrow_records " +
            "WHERE student_id = ?";

        PreparedStatement ps = con.prepareStatement(sql);

        ps.setInt(1, studentId);

        ResultSet rs = ps.executeQuery();

        if (rs.next()) {

            fineAmount = rs.getInt("fine");

        }

        rs.close();
        ps.close();
        con.close();

    } catch (Exception e) {

        out.println("Profile Error: " + e.getMessage());

    }

%>

<%

    int dueTomorrow = 0;
    int overdueBooks = 0;

    try {

        Connection con = DBConnection.getConnection();

        String sql =
            "SELECT due_date, status " +
            "FROM borrow_records " +
            "WHERE student_id = ?";

        PreparedStatement ps = con.prepareStatement(sql);

        ps.setInt(1, studentId);

        ResultSet rs = ps.executeQuery();

        while (rs.next()) {

            String dueDate = rs.getString("due_date");
            String status = rs.getString("status");

            if ("Borrowed".equals(status)) {

                java.time.LocalDate due =
                    java.time.LocalDate.parse(dueDate);

                java.time.LocalDate today =
                    java.time.LocalDate.now();

                java.time.LocalDate tomorrow =
                    today.plusDays(1);

                if (due.equals(tomorrow)) {

                    dueTomorrow++;

                }

                if (due.isBefore(today)) {

                    overdueBooks++;

                }

            }

        }

        rs.close();
        ps.close();
        con.close();

    } catch (Exception e) {

        out.println("Reminder Error: " + e.getMessage());

    }

%>

<!DOCTYPE html>

<html>

<head>

    <meta charset="UTF-8">

    <title>Library Dashboard</title>

    <style>

        * {
            box-sizing: border-box;
        }

        body {

            margin: 0;

            font-family: Arial, sans-serif;

            background: #f3f8f5;

            color: #34423a;

        }

        .navbar {

            background: #176b57;

            color: white;

            padding: 20px 45px;

            display: flex;

            justify-content: space-between;

            align-items: center;

        }

        .navbar h2 {

            margin: 0;

        }

        .logout {

            color: white;

            text-decoration: none;

            padding: 9px 18px;

            border: 1px solid white;

            border-radius: 20px;

        }

        .logout:hover {

            background: white;

            color: #176b57;

        }

        .container {

            width: 90%;

            max-width: 1150px;

            margin: 35px auto;

        }

        .welcome {

            color: #176b57;

            margin-bottom: 25px;

        }

        .section {

            background: white;

            padding: 28px;

            margin-top: 25px;

            border-radius: 15px;

            box-shadow: 0 4px 14px rgba(0,0,0,0.07);

        }

        .section h2 {

            color: #176b57;

            margin-top: 0;

        }

        .profile {

            display: grid;

            grid-template-columns: repeat(2, 1fr);

            gap: 18px;

        }

        .profile-box {

            background: white;

            padding: 20px;

            border-radius: 12px;

            border: 1px solid #e0e0e0;

            box-shadow: 0 2px 8px rgba(0,0,0,0.08);

            transition: 0.3s;

        }

        .profile-box:hover {

            transform: translateY(-3px);

            box-shadow: 0 5px 15px rgba(0,0,0,0.12);

        }

        .profile-box strong {

            display: block;

            margin-bottom: 7px;

            color: #176b57;

        }

        .fine {

            color: #e74c3c;

            font-weight: bold;

        }

        .reminders {

            display: grid;

            grid-template-columns: repeat(2, 1fr);

            gap: 20px;

        }

        .reminder {

            padding: 22px;

            border-radius: 14px;

            background: white;

            box-shadow: 0 3px 12px rgba(0,0,0,0.08);

        }

        .due {

            border: 2px solid #f0ad4e;

        }

        .overdue {

            background: #fcebea;

            border-left: 5px solid #c0392b;

        }

        /* Borrow & Return History */

        .history-table {

            width: 100%;

            border-collapse: collapse;

            margin-top: 20px;

            background: white;

            border-radius: 10px;

            overflow: hidden;

        }

        .history-table th {

            background: #176b57;

            color: white;

            padding: 14px;

            text-align: center;

        }

        .history-table td {

            padding: 13px;

            text-align: center;

            border-bottom: 1px solid #e0e0e0;

        }

        .history-table tr:hover {

            background: #f3f8f5;

        }

        .borrowed {

            color: #e67e22;

            font-weight: bold;

        }

        .returned {

            color: #27ae60;

            font-weight: bold;

        }

        .no-records {

            text-align: center;

            padding: 20px;

            color: #777;

        }

        /* Book Management Buttons */

        .dashboard-buttons {

            display: grid;

            grid-template-columns: repeat(4, 1fr);

            gap: 15px;

        }

        .btn {

            padding: 15px;

            background: #176b57;

            color: white;

            text-decoration: none;

            border-radius: 8px;

            text-align: center;

            font-weight: bold;

            transition: 0.3s;

        }

        .btn:hover {

            background: #105242;

            transform: translateY(-2px);

        }

        @media (max-width: 768px) {

            .profile {

                grid-template-columns: 1fr;

            }

            .reminders {

                grid-template-columns: 1fr;

            }

            .dashboard-buttons {

                grid-template-columns: 1fr;

            }

            .history-table {

                display: block;

                overflow-x: auto;

            }

        }

    </style>

</head>

<body>

<div class="navbar">

    <h2>Library Management System</h2>

    <a class="logout" href="index.html">

        Logout

    </a>

</div>


<div class="container">

    <h1 class="welcome">

        Welcome, <%= studentName %>

    </h1>


    <!-- Student Profile -->

    <div class="section">

        <h2>Student Profile</h2>

        <div class="profile">

            <div class="profile-box">

                <strong>Name:</strong>

                <%= studentName %>

            </div>

            <div class="profile-box">

                <strong>Register Number:</strong>

                <%= registerNumber %>

            </div>

            <div class="profile-box">

                <strong>Department:</strong>

                <%= department %>

            </div>

            <div class="profile-box">

                <strong>Fine Amount:</strong>

                <span class="fine">

                    ₹<%= fineAmount %>

                </span>

            </div>

        </div>

    </div>


    <!-- Borrow & Return History -->

    <div class="section">

        <h2>Borrow & Return History</h2>

        <table class="history-table">

            <tr>

                <th>Book Title</th>

                <th>Issue Date</th>

                <th>Due Date</th>

                <th>Return Date</th>

                <th>Status</th>

                <th>Fine</th>

            </tr>

<%

    try {

        Connection con = DBConnection.getConnection();

        String sql =
            "SELECT b.title, br.issue_date, br.due_date, " +
            "br.return_date, br.status, br.fine_amount " +
            "FROM borrow_records br " +
            "JOIN books b ON br.book_id = b.book_id " +
            "WHERE br.student_id = ? " +
            "ORDER BY br.borrow_id DESC";

        PreparedStatement ps = con.prepareStatement(sql);

        ps.setInt(1, studentId);

        ResultSet rs = ps.executeQuery();

        boolean hasRecords = false;

        while (rs.next()) {

            hasRecords = true;

            String title = rs.getString("title");

            String issueDate =
                rs.getString("issue_date");

            String dueDate =
                rs.getString("due_date");

            String returnDate =
                rs.getString("return_date");

            String status =
                rs.getString("status");

            int fine =
                rs.getInt("fine_amount");

%>

            <tr>

                <td>
                    <%= title %>
                </td>

                <td>
                    <%= issueDate %>
                </td>

                <td>
                    <%= dueDate %>
                </td>

                <td>
                    <%= returnDate != null
                        ? returnDate
                        : "-" %>
                </td>

                <td>

                    <% if ("Returned".equals(status)) { %>

                        <span class="returned">
                            Returned
                        </span>

                    <% } else { %>

                        <span class="borrowed">
                            Borrowed
                        </span>

                    <% } %>

                </td>

                <td>
                    ₹<%= fine %>
                </td>

            </tr>

<%

        }

        if (!hasRecords) {

%>

            <tr>

                <td colspan="6" class="no-records">

                    No borrow or return records found.

                </td>

            </tr>

<%

        }

        rs.close();

        ps.close();

        con.close();

    } catch (Exception e) {

%>

            <tr>

                <td colspan="6" class="no-records">

                    Error: <%= e.getMessage() %>

                </td>

            </tr>

<%

    }

%>

        </table>

    </div>


    <!-- Due Date Reminder -->

    <div class="section">

        <h2>Due Date Reminder</h2>

        <div class="reminders">

            <div class="reminder due">

                <h3>Due Tomorrow</h3>

                <p>

                    <%= dueTomorrow %>
                    books are due tomorrow.

                </p>

            </div>

            <div class="reminder overdue">

                <h3>Overdue</h3>

                <p>

                    <%= overdueBooks %>
                    books are overdue.

                </p>

            </div>

        </div>

    </div>


    <!-- Book Management -->

    <div class="section">

        <h2>Book Management</h2>

        <div class="dashboard-buttons">

            <a class="btn" href="addBook.jsp">

                Add Book

            </a>

            <a class="btn" href="books.jsp">

                View Books

            </a>

            <a class="btn" href="issueBook.jsp">

                Issue Book

            </a>

            <a class="btn" href="returnBook.jsp">

                Return Book

            </a>

        </div>

    </div>

</div>

</body>

</html>

