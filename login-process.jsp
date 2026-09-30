
<%@ page import="java.sql.*" %>
<%@ page import="dao.DBConnection" %>

<%
String email = request.getParameter("email");
String password = request.getParameter("password");

out.println("<h3>Received Email: " + email + "</h3>");
out.println("<h3>Password Received: " + password + "</h3>");

try {

    Connection con = DBConnection.getConnection();

    String sql = "SELECT * FROM users WHERE email=?";

    PreparedStatement ps = con.prepareStatement(sql);

    ps.setString(1, email);

    ResultSet rs = ps.executeQuery();

    if (rs.next()) {

        String dbPassword = rs.getString("password");

        out.println("<h3>Database Password: " + dbPassword + "</h3>");

        if (dbPassword.equals(password)) {

            session.setAttribute("userId", rs.getInt("id"));
            session.setAttribute("userName", rs.getString("name"));
            session.setAttribute("userEmail", rs.getString("email"));
            session.setAttribute("userCourse", rs.getString("course"));
            session.setAttribute("userSemester", rs.getInt("semester"));

            response.sendRedirect("dashboard.html");

        } else {

            out.println("<h2>Password does NOT match</h2>");
            out.println("<a href='login.html'>Back to Login</a>");

        }

    } else {

        out.println("<h2>Email NOT found in database</h2>");
        out.println("<a href='login.html'>Back to Login</a>");

    }

    rs.close();
    ps.close();
    con.close();

} catch (Exception e) {

    out.println("<h2>Login Error</h2>");

    out.println("<pre>");
    e.printStackTrace(new java.io.PrintWriter(out));
    out.println("</pre>");

}
%>
