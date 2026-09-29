<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>

<head>

    <meta charset="UTF-8">

    <title>Issue Book</title>

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
            width: 400px;
            margin: 50px auto;
            background-color: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 3px 15px rgba(0,0,0,0.2);
        }

        h1 {
            text-align: center;
            color: #2c3e50;
        }

        label {
            display: block;
            margin-top: 15px;
            margin-bottom: 5px;
        }

        input {
            width: 100%;
            padding: 10px;
            box-sizing: border-box;
            border: 1px solid #ccc;
            border-radius: 5px;
        }

        button {
            width: 100%;
            padding: 12px;
            margin-top: 25px;
            background-color: #3498db;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
        }

        button:hover {
            background-color: #2980b9;
        }

        .back {
            display: block;
            text-align: center;
            margin-top: 20px;
            color: #2c3e50;
            text-decoration: none;
        }

    </style>

</head>

<body>

<div class="navbar">

    <h2>Library Management System</h2>

</div>


<div class="container">

    <h1>Issue Book</h1>

   <form action="IssueBookServlet" method="post">

        <label>Student ID</label>

        <input type="number" name="student_id" required>


        <label>Book ID</label>

        <input type="number" name="book_id" required>


        <label>Issue Date</label>

        <input type="date" name="issue_date" required>


        <label>Due Date</label>

        <input type="date" name="due_date" required>


        <button type="submit">Issue Book</button>

    </form>


    <a class="back" href="display.jsp">
        ← Back to Dashboard
    </a>

</div>

</body>

</html>