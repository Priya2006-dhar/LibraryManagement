package com.library;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class UpdateBookServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request,
                           HttpServletResponse response)
            throws ServletException, IOException {

        int bookId = Integer.parseInt(request.getParameter("book_id"));
        String title = request.getParameter("title");
        String author = request.getParameter("author");
        String category = request.getParameter("category");
        int quantity = Integer.parseInt(request.getParameter("quantity"));

        try {

            Connection con = DBConnection.getConnection();

            String sql = "UPDATE books SET title=?, author=?, category=?, quantity=? WHERE book_id=?";

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setString(1, title);
            ps.setString(2, author);
            ps.setString(3, category);
            ps.setInt(4, quantity);
            ps.setInt(5, bookId);

            int result = ps.executeUpdate();

            ps.close();
            con.close();

            if (result > 0) {
                response.sendRedirect("books.jsp");
            } else {
                response.getWriter().println("Book not found");
            }

        } catch (Exception e) {

            e.printStackTrace();

            response.getWriter().println(
                "Update Error: " + e.getMessage()
            );
        }
    }
}