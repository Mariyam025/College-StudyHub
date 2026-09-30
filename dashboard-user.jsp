
<%@ page import="java.sql.*" %>
<%@ page import="dao.DBConnection" %>

<%
response.setContentType("application/json");
response.setCharacterEncoding("UTF-8");

Object userIdObj = session.getAttribute("userId");

if (userIdObj == null) {
    out.print("{\"loggedIn\":false}");
    return;
}

int userId = (Integer) userIdObj;

try {

    Connection con = DBConnection.getConnection();

    String sql = "SELECT id,name,email,course,semester,points,xp FROM users WHERE id=?";

    PreparedStatement ps = con.prepareStatement(sql);
    ps.setInt(1, userId);

    ResultSet rs = ps.executeQuery();

    if (rs.next()) {

        String name = rs.getString("name");
        String email = rs.getString("email");
        String course = rs.getString("course");
        int semester = rs.getInt("semester");
        int points = rs.getInt("points");
        int xp = rs.getInt("xp");

        out.print("{"
            + "\"loggedIn\":true,"
            + "\"id\":" + userId + ","
            + "\"name\":\"" + name.replace("\"", "\\\"") + "\","
            + "\"email\":\"" + email.replace("\"", "\\\"") + "\","
            + "\"course\":\"" + course.replace("\"", "\\\"") + "\","
            + "\"semester\":" + semester + ","
            + "\"points\":" + points + ","
            + "\"xp\":" + xp
            + "}");

    } else {

        out.print("{\"loggedIn\":false}");
    }

    rs.close();
    ps.close();
    con.close();

} catch(Exception e) {

    out.print("{\"loggedIn\":false}");
    e.printStackTrace();
}
%>

