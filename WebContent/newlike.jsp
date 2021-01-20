<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
 <%@page import="java.sql.*,java.util.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
</head>
<body>

<% String id=request.getParameter("id"); 
   String uname=(String)session.getAttribute("uname");
%>
<%try
{
Class.forName("com.mysql.jdbc.Driver");
Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/wishlist", "root", "ksql4321!");
Statement st=conn.createStatement();
int i=st.executeUpdate("insert into liked_comments (comment_id,username,clicks) values("+ id +", " + "'" + uname+ "'"+ ", " + 1 +");");

ServletContext context= getServletContext();
RequestDispatcher rd= context.getRequestDispatcher("/tools-forward");
rd.forward(request, response);
}
catch(Exception e)
{
System.out.print(e);
e.printStackTrace();
}%>

</body>
</html>