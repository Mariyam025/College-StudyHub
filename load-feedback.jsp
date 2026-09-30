
<%@ page import="java.sql.*" %>
<%@ page import="dao.DBConnection" %>

<%
response.setContentType("application/json");

Connection con = null;
PreparedStatement ps = null;
ResultSet rs = null;

try {

    con = DBConnection.getConnection();

    ps = con.prepareStatement(
        "SELECT name, review_type, rating, message " +
        "FROM feedback " +
        "ORDER BY id DESC"
    );

    rs = ps.executeQuery();

    StringBuilder json =
        new StringBuilder("[");

    boolean first = true;

    while (rs.next()) {

        if (!first) {
            json.append(",");
        }

        first = false;

        String name =
            rs.getString("name");

        String reviewType =
            rs.getString("review_type");

        String message =
            rs.getString("message");

        name =
            name == null ? "" :
            name.replace("\\", "\\\\")
                .replace("\"", "\\\"");

        reviewType =
            reviewType == null ? "" :
            reviewType.replace("\\", "\\\\")
                      .replace("\"", "\\\"");

        message =
            message == null ? "" :
            message.replace("\\", "\\\\")
                   .replace("\"", "\\\"");


        json.append("{");

        json.append("\"name\":\"")
            .append(name)
            .append("\",");

        json.append("\"reviewType\":\"")
            .append(reviewType)
            .append("\",");

        json.append("\"rating\":")
            .append(rs.getInt("rating"))
            .append(",");

        json.append("\"message\":\"")
            .append(message)
            .append("\"");

        json.append("}");

    }

    json.append("]");

    out.print(
        json.toString()
    );

}

catch(Exception e) {

    out.print("[]");

}

finally {

    try {
        if (rs != null) rs.close();
    } catch(Exception e) {}

    try {
        if (ps != null) ps.close();
    } catch(Exception e) {}

    try {
        if (con != null) con.close();
    } catch(Exception e) {}

}
%>
