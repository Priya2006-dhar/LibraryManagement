package com.library;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class DeleteBookServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        int bookId = Integer.parseInt(
                request.getParameter("book_id")
        );

        try {

            Connection con = DBConnection.getConnection();

            String sql = "DELETE FROM books WHERE book_id=?";

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setInt(1, bookId);

            int result = ps.executeUpdate();

            ps.close();
            con.close();

            if (result > 0) {

                response.sendRedirect("books.jsp");

            } else {

                response.getWriter().println(
                    "Book not found"
                );
            }

        } catch (Exception e) {

            e.printStackTrace();

            response.getWriter().println(
                "Delete Error: " + e.getMessage()
            );
        }
    }
}