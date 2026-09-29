package com.library;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.time.LocalDate;
import java.time.temporal.ChronoUnit;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class ReturnBookServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        int borrowId = Integer.parseInt(
                request.getParameter("borrow_id"));

        String returnDate =
                request.getParameter("return_date");

        try {

            Connection con = DBConnection.getConnection();

            if (con == null) {
                response.getWriter().println(
                        "Database connection failed.");
                return;
            }

            // Get due date
            String selectSql =
                    "SELECT due_date FROM borrow_records " +
                    "WHERE borrow_id=? AND status='Borrowed'";

            PreparedStatement selectPs =
                    con.prepareStatement(selectSql);

            selectPs.setInt(1, borrowId);

            ResultSet rs = selectPs.executeQuery();

            if (!rs.next()) {

                response.getWriter().println(
                        "Borrow record not found.");

                rs.close();
                selectPs.close();
                con.close();

                return;
            }

            String dueDate = rs.getString("due_date");

            // Calculate late days
            LocalDate due =
                    LocalDate.parse(dueDate);

            LocalDate returned =
                    LocalDate.parse(returnDate);

            long lateDays =
                    ChronoUnit.DAYS.between(due, returned);

            if (lateDays < 0) {
                lateDays = 0;
            }

            // ₹5 per day
            int finePerDay = 5;

            long fine =
                    lateDays * finePerDay;

            // Update record
            String updateSql =
                    "UPDATE borrow_records " +
                    "SET return_date=?, fine_amount=?, status='Returned' " +
                    "WHERE borrow_id=?";

            PreparedStatement updatePs =
                    con.prepareStatement(updateSql);

            updatePs.setString(1, returnDate);
            updatePs.setLong(2, fine);
            updatePs.setInt(3, borrowId);

            int result =
                    updatePs.executeUpdate();

            if (result > 0) {

            	response.setContentType("text/html;charset=UTF-8");

            	response.getWriter().println(
            	    "<!DOCTYPE html>" +
            	    "<html>" +
            	    "<head>" +
            	    "<title>Book Returned</title>" +
            	    "<style>" +

            	    "body {" +
            	        "margin: 0;" +
            	        "font-family: Arial, sans-serif;" +
            	        "background-color: #f4f6f8;" +
            	        "text-align: center;" +
            	    "}" +

            	    ".success-box {" +
            	        "width: 400px;" +
            	        "margin: 100px auto;" +
            	        "background-color: white;" +
            	        "padding: 40px;" +
            	        "border-radius: 12px;" +
            	        "box-shadow: 0 3px 15px rgba(0,0,0,0.2);" +
            	    "}" +

            	    "h1 {" +
            	        "color: #27ae60;" +
            	    "}" +

            	    ".details {" +
            	        "background-color: #f4f6f8;" +
            	        "padding: 15px;" +
            	        "margin-top: 20px;" +
            	        "border-radius: 8px;" +
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

            	    "<h1>✅ Book Returned Successfully!</h1>" +

            	    "<div class='details'>" +

            	    "<p><strong>Late Days:</strong> " + lateDays + "</p>" +

            	    "<p><strong>Fine:</strong> Rs." + fine + "</p>" +

            	    "</div>" +

            	    "<a href='display.jsp' class='btn'>Go to Dashboard</a>" +

            	    "</div>" +

            	    "</body>" +
            	    "</html>"
            	);

            } else {

                response.getWriter().println(
                        "Book return failed.");

            }

            rs.close();
            selectPs.close();
            updatePs.close();
            con.close();

        } catch (Exception e) {

            e.printStackTrace();

            response.getWriter().println(
                    "Error: " + e.getMessage());
        }
    }
}