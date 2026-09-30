<%
response.setContentType("text/plain");

Object userId = session.getAttribute("userId");
Object userName = session.getAttribute("userName");
Object userEmail = session.getAttribute("userEmail");

out.println("USER ID = " + userId);
out.println("USER NAME = " + userName);
out.println("USER EMAIL = " + userEmail);
%>
