
package servlet;

import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import dao.DBConnection;

@WebServlet("/UploadHandwrittenServlet")

@MultipartConfig(
    maxFileSize = 200 * 1024 * 1024,
    maxRequestSize = 220 * 1024 * 1024
)

public class UploadHandwrittenServlet extends HttpServlet {

    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html;charset=UTF-8");

        HttpSession session = request.getSession();

        Object userIdObj =
                session.getAttribute("userId");

        if (userIdObj == null) {

            response.sendRedirect("login.html");
            return;
        }

        int userId =
                (Integer) userIdObj;

        String studentName =
                (String) session.getAttribute("userName");

        String subject =
                request.getParameter("subject");

        String title =
                request.getParameter("title");

        Part filePart =
                request.getPart("file");

        if (filePart == null ||
            filePart.getSize() == 0) {

            response.getWriter().println(
                "<h2>Please select a file.</h2>"
            );

            return;
        }


        String originalName =
                filePart.getSubmittedFileName();

        originalName =
                new File(originalName).getName();


        String lowerName =
                originalName.toLowerCase();


        if (!lowerName.endsWith(".pdf") &&
            !lowerName.endsWith(".jpg") &&
            !lowerName.endsWith(".jpeg") &&
            !lowerName.endsWith(".png")) {

            response.getWriter().println(
                "<h2>Only PDF, JPG, JPEG or PNG files are allowed.</h2>"
            );

            return;
        }


        String extension = "";

        int dot =
                originalName.lastIndexOf(".");

        if (dot >= 0) {

            extension =
                originalName.substring(dot);

        }


        String fileName =
                System.currentTimeMillis()
                + extension;


        String uploadPath =
                getServletContext().getRealPath("/")
                + "uploads"
                + File.separator
                + "handwritten";


        File folder =
                new File(uploadPath);


        if (!folder.exists()) {

            folder.mkdirs();

        }


        File savedFile =
                new File(folder, fileName);


        filePart.write(
                savedFile.getAbsolutePath()
        );


        Connection con = null;
        PreparedStatement ps = null;


        try {

            con =
                DBConnection.getConnection();


            if (con == null) {

                throw new Exception(
                    "Database connection failed."
                );

            }


            con.setAutoCommit(false);


            // 1. Save handwritten note

            String noteSQL =
                "INSERT INTO handwritten_notes " +
                "(user_id, student_name, subject, title, file_path, points) " +
                "VALUES (?, ?, ?, ?, ?, ?)";


            ps =
                con.prepareStatement(noteSQL);


            ps.setInt(1, userId);

            ps.setString(2, studentName);

            ps.setString(3, subject);

            ps.setString(4, title);

            ps.setString(
                5,
                "uploads/handwritten/" + fileName
            );

            ps.setInt(6, 25);


            ps.executeUpdate();


            ps.close();


            // 2. Add 25 points + 25 XP

            String userSQL =
                "UPDATE users " +
                "SET points = points + 25, " +
                "xp = xp + 25 " +
                "WHERE id = ?";


            ps =
                con.prepareStatement(userSQL);


            ps.setInt(1, userId);


            ps.executeUpdate();


            ps.close();


            // 3. Save everything

            con.commit();


            con.close();


            response.getWriter().println(

                "<script>" +

                "alert('📚 Note uploaded successfully! +25 Points and +25 XP 🎉');" +

                "window.location='handwritten-notes.html';" +

                "</script>"

            );


        } catch (Exception e) {


            try {

                if (con != null)
                    con.rollback();

            } catch (Exception ignored) {}


            if (savedFile.exists()) {
                savedFile.delete();
            }


            response.getWriter().println(

                "<h2>Upload Error</h2>" +

                "<pre>" +
                e.getMessage() +
                "</pre>"

            );


        } finally {


            try {

                if (ps != null)
                    ps.close();

            } catch (Exception ignored) {}


            try {

                if (con != null &&
                    !con.isClosed()) {

                    con.close();

                }

            } catch (Exception ignored) {}

        }

    }
}
