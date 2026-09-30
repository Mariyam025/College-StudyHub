
<%
String username = request.getParameter("username");
String password = request.getParameter("password");

if ("admin".equals(username) && "admin123".equals(password)) {

    session.setAttribute("adminLoggedIn", true);
    session.setAttribute("adminName", "Administrator");

    response.sendRedirect("admin-dashboard.html");

} else {

    out.println("<h2>Invalid Admin Username or Password</h2>");
    out.println("<a href='admin-login.html'>Back to Admin Login</a>");

}
%>
