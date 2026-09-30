
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

String idParam = request.getParameter("id");

if(idParam == null){
    out.print("{\"success\":false,\"message\":\"Note ID missing\"}");
    return;
}

int noteId = Integer.parseInt(idParam);

Connection con = null;
PreparedStatement ps = null;

try{

    con = DBConnection.getConnection();

    String sql =
        "DELETE FROM personal_notes " +
        "WHERE id=? AND user_id=?";

    ps = con.prepareStatement(sql);

    ps.setInt(1, noteId);
    ps.setInt(2, userId);

    int rows = ps.executeUpdate();

    if(rows > 0){

        out.print(
            "{\"success\":true,\"message\":\"Note deleted successfully\"}"
        );

    }else{

        out.print(
            "{\"success\":false,\"message\":\"Note not found\"}"
        );

    }

}catch(Exception e){

    out.print(
        "{\"success\":false,\"message\":\"Delete failed\"}"
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
