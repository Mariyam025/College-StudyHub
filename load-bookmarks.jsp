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

    ps = con.prepareStatement(
        "SELECT id,title,subject,type,url,created_at " +
        "FROM bookmarks " +
        "WHERE user_id=? " +
        "ORDER BY id DESC"
    );

    ps.setInt(1,userId);

    rs = ps.executeQuery();

    StringBuilder json = new StringBuilder("[");
    boolean first = true;

    while(rs.next()){

        if(!first){
            json.append(",");
        }

        first = false;

        String title = rs.getString("title");
        String subject = rs.getString("subject");
        String type = rs.getString("type");
        String url = rs.getString("url");

        title = title == null ? "" :
            title.replace("\\","\\\\")
                 .replace("\"","\\\"");

        subject = subject == null ? "" :
            subject.replace("\\","\\\\")
                   .replace("\"","\\\"");

        type = type == null ? "" :
            type.replace("\\","\\\\")
                .replace("\"","\\\"");

        url = url == null ? "" :
            url.replace("\\","\\\\")
               .replace("\"","\\\"");

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

        json.append("\"type\":\"")
            .append(type)
            .append("\",");

        json.append("\"url\":\"")
            .append(url)
            .append("\",");

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
