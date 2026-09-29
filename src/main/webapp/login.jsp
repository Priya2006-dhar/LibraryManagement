<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>

<head>

    <meta charset="UTF-8">

    <title>Library Login</title>

    <style>

        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background-color: #f4f6f8;
        }

        .login-container {
            width: 350px;
            margin: 100px auto;
            background-color: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 3px 15px rgba(0,0,0,0.2);
        }

        h1 {
            text-align: center;
            color: #2c3e50;
        }

        h2 {
            text-align: center;
            color: #555;
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
            margin-top: 20px;
            background-color: #3498db;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }

        button:hover {
            background-color: #2980b9;
        }

        .signup {
            text-align: center;
            margin-top: 20px;
        }

        .signup a {
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
    String pageTitle = "Library";
    String loginTitle = "Login";
%>

<div class="login-container">

    <h1><%= pageTitle %></h1>

    <h2><%= loginTitle %></h2>

    <form action="LoginServlet" method="post">

        <label>Username</label>

        <input type="text" name="username" required>


        <label>Password</label>

        <input type="password" name="password" required>


        <button type="submit">Login</button>

    </form>


    <div class="signup">

        Don't have an account?

        <a href="register.jsp">Signup</a>

    </div>


    <div class="home">

        <a href="index.html">← Back to Home</a>

    </div>

</div>

</body>

</html>