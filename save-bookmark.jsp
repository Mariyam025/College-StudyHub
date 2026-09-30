
<%@ page import="java.sql.*" %>
<%@ page import="dao.DBConnection" %>

<%
response.setContentType("application/json");

Connection con = null;
PreparedStatement ps = null;
ResultSet rs = null;

try {

    con = DBConnection.getConnection();

    int userId = 0;

    Object sessionUserId =
        session.getAttribute("userId");

    if(sessionUserId != null){

        userId = (Integer) sessionUserId;

    }else{

        Object sessionEmail =
            session.getAttribute("userEmail");

        if(sessionEmail != null){

            ps = con.prepareStatement(
                "SELECT id FROM users WHERE email=?"
            );

            ps.setString(
                1,
                sessionEmail.toString()
            );

            rs = ps.executeQuery();

            if(rs.next()){

                userId =
                    rs.getInt("id");

            }

            rs.close();
            ps.close();

        }
    }


    if(userId == 0){

        out.print(
            "{\"success\":false,\"message\":\"Login session not found. Please login again.\"}"
        );

        return;
    }


    String title =
        request.getParameter("title");

    String subject =
        request.getParameter("subject");

    String type =
        request.getParameter("type");

    String url =
        request.getParameter("url");


    if(title == null ||
       title.trim().isEmpty()){

        out.print(
            "{\"success\":false,\"message\":\"Title is required\"}"
        );

        return;
    }


    ps = con.prepareStatement(
        "INSERT INTO bookmarks " +
        "(user_id,title,subject,type,url) " +
        "VALUES (?,?,?,?,?)"
    );


    ps.setInt(1,userId);
    ps.setString(2,title);
    ps.setString(3,subject);
    ps.setString(4,type);
    ps.setString(5,url);


    ps.executeUpdate();


    out.print(
        "{\"success\":true,\"message\":\"Bookmark saved successfully\"}"
    );


}
catch(Exception e){

    out.print(
        "{\"success\":false,\"message\":\"" +
        e.getMessage()
        .replace("\"","'") +
        "\"}"
    );

}
finally{

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
