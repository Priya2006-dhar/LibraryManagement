package com.library;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class AddBookServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        String title = request.getParameter("title");
        String author = request.getParameter("author");
        String category = request.getParameter("category");

        int quantity = Integer.parseInt(
                request.getParameter("quantity"));

        try {

            Connection con = DBConnection.getConnection();

            if (con == null) {

                response.getWriter().println(
                        "Database connection failed.");

                return;
            }

            String sql =
                    "INSERT INTO books " +
                    "(title, author, category, quantity) " +
                    "VALUES (?, ?, ?, ?)";

            PreparedStatement ps =
                    con.prepareStatement(sql);

            ps.setString(1, title);
            ps.setString(2, author);
            ps.setString(3, category);
            ps.setInt(4, quantity);

            int result = ps.executeUpdate();

            if (result > 0) {

            	response.setContentType("text/html;charset=UTF-8");

            	response.getWriter().println(
            	    "<!DOCTYPE html>" +
            	    "<html>" +
            	    "<head>" +
            	    "<title>Book Added</title>" +
            	    "<style>" +

            	    "body {" +
            	        "margin: 0;" +
            	        "font-family: Arial, sans-serif;" +
            	        "background-color: #f4f6f8;" +
            	        "text-align: center;" +
            	    "}" +

            	    ".success-box {" +
            	        "width: 400px;" +
            	        "margin: 120px auto;" +
            	        "background-color: white;" +
            	        "padding: 40px;" +
            	        "border-radius: 12px;" +
            	        "box-shadow: 0 3px 15px rgba(0,0,0,0.2);" +
            	    "}" +

            	    "h1 {" +
            	        "color: #27ae60;" +
            	    "}" +

            	    "p {" +
            	        "color: #555;" +
            	        "font-size: 16px;" +
            	    "}" +

            	    ".btn {" +
            	        "display: inline-block;" +
            	        "margin-top: 20px;" +
            	        "padding: 12px 25px;" +
            	        "background-color: #3498db;" +
            	        "color: white;" +
            	        "text-decoration: none;" +
            	        "border-radius: 5px;" +
            	        "margin-right: 10px;" +
            	    "}" +

            	    ".btn:hover {" +
            	        "background-color: #2980b9;" +
            	    "}" +

            	    "</style>" +
            	    "</head>" +

            	    "<body>" +

            	    "<div class='success-box'>" +

            	    "<h1>Book Added Successfully!</h1>" +

            	    "<p>Book: " + title + "</p>" +

            	    "<p>The book has been added to the library.</p>" +

            	    "<a href='books.jsp' class='btn'>View Books</a>" +

            	    "<a href='display.jsp' class='btn'>Dashboard</a>" +

            	    "</div>" +

            	    "</body>" +
            	    "</html>"
            	);

            } else {

                response.getWriter().println(
                        "Book could not be added.");

            }

            ps.close();
            con.close();

        } catch (Exception e) {

            e.printStackTrace();

            response.getWriter().println(
                    "Error: " + e.getMessage());
        }
    }
}