<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>

<head>

    <meta charset="UTF-8">

    <title>Library Registration</title>

    <style>

        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background-color: #f4f6f8;
        }

        .register-container {
            width: 400px;
            margin: 60px auto;
            background-color: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 3px 15px rgba(0, 0, 0, 0.2);
        }

        h1 {
            text-align: center;
            color: #2c3e50;
        }

        h2 {
            text-align: center;
            color: #555;
            margin-bottom: 25px;
        }

        label {
            display: block;
            margin-top: 15px;
            margin-bottom: 5px;
            color: #333;
        }

        input {
            width: 100%;
            padding: 11px;
            box-sizing: border-box;
            border: 1px solid #ccc;
            border-radius: 5px;
        }

        input:focus {
            border-color: #3498db;
            outline: none;
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

        .login {
            text-align: center;
            margin-top: 20px;
        }

        .login a {
            color: #3498db;
            text-decoration: none;
        }

        .home {
            text-align: center;
            margin-top: 15px;
        }

        .home a {
            color: #2c3e50;
            text-decoration: none;
        }

    </style>

</head>

<body>

<%
    String pageTitle = "Library Management";
    String registrationTitle = "Student Registration";
%>

<div class="register-container">

    <h1><%= pageTitle %></h1>

    <h2><%= registrationTitle %></h2>

    <form action="RegisterServlet" method="post">

        <label>Full Name</label>

        <input type="text" name="name" required>


        <label>Email</label>

        <input type="email" name="email" required>


        <label>Username</label>

        <input type="text" name="username" required>


        <label>Password</label>

        <input type="password" name="password" required>


        <button type="submit">Register</button>

    </form>


    <div class="login">

        Already have an account?

        <a href="login.jsp">Login</a>

    </div>


    <div class="home">

        <a href="index.html">← Back to Home</a>

    </div>

</div>

</body>

</html>