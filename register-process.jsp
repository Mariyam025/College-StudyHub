<%@ page import="java.sql.*" %>
<%@ page import="dao.DBConnection" %>

<%
String name = request.getParameter("name");
String email = request.getParameter("email");
String course = request.getParameter("course");
String semester = request.getParameter("semester");
String password = request.getParameter("password");

try {

    Connection con = DBConnection.getConnection();

    String sql = "INSERT INTO users(name,email,course,semester,password) VALUES(?,?,?,?,?)";

    PreparedStatement ps = con.prepareStatement(sql);

    ps.setString(1, name);
    ps.setString(2, email);
    ps.setString(3, course);
    ps.setInt(4, Integer.parseInt(semester));
    ps.setString(5, password);

    ps.executeUpdate();

    ps.close();
    con.close();

    response.sendRedirect("login.html");

} catch(Exception e) {

    out.println("<h2>Registration Error</h2>");
    out.println("<p>" + e.getMessage() + "</p>");
}
%>