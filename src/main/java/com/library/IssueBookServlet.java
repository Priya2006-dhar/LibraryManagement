package com.library;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class IssueBookServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        int studentId = Integer.parseInt(
                request.getParameter("student_id"));

        int bookId = Integer.parseInt(
                request.getParameter("book_id"));

        String issueDate =
                request.getParameter("issue_date");

        String dueDate =
                request.getParameter("due_date");

        try {

            Connection con = DBConnection.getConnection();

            if (con == null) {
                response.getWriter().println(
                        "Database connection failed");
                return;
            }

            String sql =
                "INSERT INTO borrow_records " +
                "(student_id, book_id, issue_date, due_date, fine_amount, status) " +
                "VALUES (?, ?, ?, ?, ?, ?)";

            PreparedStatement ps =
                    con.prepareStatement(sql);

            ps.setInt(1, studentId);
            ps.setInt(2, bookId);
            ps.setString(3, issueDate);
            ps.setString(4, dueDate);
            ps.setInt(5, 0);
            ps.setString(6, "Borrowed");

            int result = ps.executeUpdate();

            if (result > 0) {

            	response.setContentType("text/html;charset=UTF-8");

            	response.getWriter().println(
            	    "<!DOCTYPE html>" +
            	    "<html>" +
            	    "<head>" +
            	    "<title>Book Issued</title>" +
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
            	    "}" +

            	    ".btn:hover {" +
            	        "background-color: #2980b9;" +
            	    "}" +

            	    "</style>" +
            	    "</head>" +

            	    "<body>" +

            	    "<div class='success-box'>" +

            	    "<h1>✅ Book Issued Successfully!</h1>" +

            	    "<p>The book has been successfully issued to the student.</p>" +

            	    "<a href='display.jsp' class='btn'>Go to Dashboard</a>" +

            	    "</div>" +

            	    "</body>" +
            	    "</html>"
            	);

            } else {

                response.getWriter().println(
                        "Book issue failed.");

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