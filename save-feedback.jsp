<%@ page import="java.sql.*" %>
<%@ page import="dao.DBConnection" %>

<%
response.setContentType("application/json");

Connection con = null;
PreparedStatement ps = null;

try {

    Object userIdObj = session.getAttribute("userId");

    int userId = 0;

    if (userIdObj != null) {
        userId = (Integer) userIdObj;
    }

    String name = request.getParameter("name");
    String reviewType = request.getParameter("reviewType");
    String rating = request.getParameter("rating");
    String message = request.getParameter("message");

    if (name == null || name.trim().isEmpty()) {
        name = "Student";
    }

    if (reviewType == null) {
        reviewType = "General";
    }

    if (message == null || message.trim().isEmpty()) {
        out.print("{\"success\":false,\"message\":\"Feedback message is required\"}");
        return;
    }

    con = DBConnection.getConnection();

    String sql =
        "INSERT INTO feedback " +
        "(user_id,name,review_type,rating,message) " +
        "VALUES (?,?,?,?,?)";

    ps = con.prepareStatement(sql);

    if (userId > 0) {
        ps.setInt(1, userId);
    } else {
        ps.setNull(1, Types.INTEGER);
    }

    ps.setString(2, name);
    ps.setString(3, reviewType);

    if (rating != null && !rating.isEmpty()) {
        ps.setInt(4, Integer.parseInt(rating));
    } else {
        ps.setNull(4, Types.INTEGER);
    }

    ps.setString(5, message);

    ps.executeUpdate();

    out.print(
        "{\"success\":true,\"message\":\"Feedback submitted successfully\"}"
    );

}
catch(Exception e) {

    out.print(
        "{\"success\":false,\"message\":\"" +
        e.getMessage().replace("\"", "'") +
        "\"}"
    );

}
finally {

    try {
        if (ps != null) ps.close();
    } catch(Exception e) {}

    try {
        if (con != null) con.close();
    } catch(Exception e) {}

}
%>
