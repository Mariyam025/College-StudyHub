<%@ page import="java.io.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="dao.DBConnection" %>

<%
response.setContentType("text/html;charset=UTF-8");

String uploadPath =
    application.getRealPath("/") +
    "uploads" +
    File.separator +
    "handwritten";

File uploadDir = new File(uploadPath);

if (!uploadDir.exists()) {
    uploadDir.mkdirs();
}


Object userIdObj =
    session.getAttribute("userId");

int userId = 0;

if (userIdObj != null) {
    userId = (Integer) userIdObj;
}


if (userId == 0) {

    out.println(
        "<script>" +
        "alert('Please login first.');" +
        "window.location='login.html';" +
        "</script>"
    );

    return;
}


String studentName =
    (String) session.getAttribute("userName");

if (studentName == null) {
    studentName = "Student";
}


String subject =
    request.getParameter("subject");

String title =
    request.getParameter("title");

String fileName =
    request.getParameter("fileName");


if (subject == null || subject.trim().isEmpty()) {

    out.println(
        "<script>" +
        "alert('Please select a subject.');" +
        "history.back();" +
        "</script>"
    );

    return;
}


if (title == null || title.trim().isEmpty()) {

    out.println(
        "<script>" +
        "alert('Please enter note title.');" +
        "history.back();" +
        "</script>"
    );

    return;
}


if (fileName == null || fileName.trim().isEmpty()) {

    out.println(
        "<script>" +
        "alert('Please select a file.');" +
        "history.back();" +
        "</script>"
    );

    return;
}


/*
   NOTE:
   This JSP receives the file name/path information.
   The actual file upload will be connected
   from the frontend in the next step.
*/


Connection con = null;
PreparedStatement ps = null;

try {

    con = DBConnection.getConnection();


    String sql =
        "INSERT INTO handwritten_notes " +
        "(user_id, student_name, subject, title, file_path, points) " +
        "VALUES (?, ?, ?, ?, ?, ?)";


    ps = con.prepareStatement(sql);


    ps.setInt(
        1,
        userId
    );

    ps.setString(
        2,
        studentName
    );

    ps.setString(
        3,
        subject
    );

    ps.setString(
        4,
        title
    );

    ps.setString(
        5,
        "uploads/handwritten/" + fileName
    );

    ps.setInt(
        6,
        25
    );


    ps.executeUpdate();


    out.println(
        "<script>" +
        "alert('📚 Handwritten note uploaded successfully! You earned 25 points.');" +
        "window.location='handwritten-notes.html';" +
        "</script>"
    );


}
catch(Exception e) {

    out.println(
        "<h2>Upload Error</h2>"
    );

    out.println(
        "<pre>" +
        e.getMessage() +
        "</pre>"
    );

}
finally {

    try {
        if (ps != null) ps.close();
    }
    catch(Exception e) {}

    try {
        if (con != null) con.close();
    }
    catch(Exception e) {}

}
%>
