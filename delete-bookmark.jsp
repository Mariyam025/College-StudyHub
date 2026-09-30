<%@ page import="java.sql.*" %>
<%@ page import="dao.DBConnection" %>

<%
response.setContentType("application/json");

Object userIdObj = session.getAttribute("userId");

if(userIdObj == null){
    out.print("{\"success\":false,\"message\":\"Please login first\"}");
    return;
}

String idParam = request.getParameter("id");

if(idParam == null){
    out.print("{\"success\":false,\"message\":\"Bookmark ID missing\"}");
    return;
}

int userId = (Integer) userIdObj;
int bookmarkId = Integer.parseInt(idParam);

Connection con = null;
PreparedStatement ps = null;

try{

    con = DBConnection.getConnection();

    ps = con.prepareStatement(
        "DELETE FROM bookmarks WHERE id=? AND user_id=?"
    );

    ps.setInt(1,bookmarkId);
    ps.setInt(2,userId);

    int rows = ps.executeUpdate();

    if(rows > 0){

        out.print(
            "{\"success\":true,\"message\":\"Bookmark deleted successfully\"}"
        );

    }else{

        out.print(
            "{\"success\":false,\"message\":\"Bookmark not found\"}"
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
