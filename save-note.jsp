
<%@ page import="java.sql.*" %>
<%@ page import="dao.DBConnection" %>

<%
response.setContentType("application/json");

Object userIdObj = session.getAttribute("userId");

if(userIdObj == null){

    out.print("{\"success\":false,\"message\":\"Please login first\"}");
    return;

}

int userId = (Integer) userIdObj;

String title = request.getParameter("title");
String subject = request.getParameter("subject");
String content = request.getParameter("content");
String color = request.getParameter("color");

if(title == null || title.trim().isEmpty()){

    out.print("{\"success\":false,\"message\":\"Title is required\"}");
    return;

}

Connection con = null;
PreparedStatement ps = null;

try{

    con = DBConnection.getConnection();

    String sql =
        "INSERT INTO personal_notes " +
        "(user_id,title,subject,content,color,starred) " +
        "VALUES (?,?,?,?,?,false)";

    ps = con.prepareStatement(sql);

    ps.setInt(1,userId);
    ps.setString(2,title);
    ps.setString(3,subject);
    ps.setString(4,content);
    ps.setString(5,color);

    ps.executeUpdate();

    out.print(
        "{\"success\":true,\"message\":\"Note saved successfully\"}"
    );

}catch(Exception e){

    out.print(
        "{\"success\":false,\"message\":\"" +
        e.getMessage().replace("\"","'") +
        "\"}"
    );

}finally{

    try{
        if(ps != null) ps.close();
    }catch(Exception e){}

    try{
        if(con != null) con.close();
    }catch(Exception e){}

}
%>
