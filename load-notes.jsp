
<%@ page import="java.sql.*" %>
<%@ page import="dao.DBConnection" %>

<%
response.setContentType("application/json");

Object userIdObj = session.getAttribute("userId");

if(userIdObj == null){

    out.print("[]");
    return;

}

int userId = (Integer) userIdObj;

Connection con = null;
PreparedStatement ps = null;
ResultSet rs = null;

try{

    con = DBConnection.getConnection();

    String sql =
        "SELECT id,title,subject,content,color,starred,created_at " +
        "FROM personal_notes " +
        "WHERE user_id=? " +
        "ORDER BY updated_at DESC";

    ps = con.prepareStatement(sql);

    ps.setInt(1,userId);

    rs = ps.executeQuery();

    StringBuilder json = new StringBuilder();

    json.append("[");

    boolean first = true;

    while(rs.next()){

        if(!first){
            json.append(",");
        }

        first = false;

        String title =
            rs.getString("title");

        String subject =
            rs.getString("subject");

        String content =
            rs.getString("content");

        String color =
            rs.getString("color");

        title = title == null ? "" :
            title.replace("\\","\\\\")
                 .replace("\"","\\\"")
                 .replace("\n","\\n")
                 .replace("\r","");

        subject = subject == null ? "" :
            subject.replace("\\","\\\\")
                   .replace("\"","\\\"")
                   .replace("\n","\\n")
                   .replace("\r","");

        content = content == null ? "" :
            content.replace("\\","\\\\")
                   .replace("\"","\\\"")
                   .replace("\n","\\n")
                   .replace("\r","");

        color = color == null ? "" :
            color.replace("\"","\\\"");

        json.append("{");

        json.append("\"id\":")
            .append(rs.getInt("id"))
            .append(",");

        json.append("\"title\":\"")
            .append(title)
            .append("\",");

        json.append("\"subject\":\"")
            .append(subject)
            .append("\",");

        json.append("\"content\":\"")
            .append(content)
            .append("\",");

        json.append("\"color\":\"")
            .append(color)
            .append("\",");

        json.append("\"starred\":")
            .append(rs.getBoolean("starred"))
            .append(",");

        json.append("\"createdAt\":\"")
            .append(rs.getTimestamp("created_at"))
            .append("\"");

        json.append("}");

    }

    json.append("]");

    out.print(json.toString());

}catch(Exception e){

    out.print("[]");

}finally{

    try{
        if(rs != null) rs.close();
    }catch(Exception e){}

    try{
        if(ps != null) ps.close();
    }catch(Exception e){}

    try{
        if(con != null) con.close();
    }catch(Exception e){}

}
%>
