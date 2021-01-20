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
ResultSet resultset = st.executeQuery("select * from liked_comments where username="+"'"+uname+"'"+ "and comment_id="+id);
resultset.next();
int old_clicks = resultset.getInt("clicks");
old_clicks++;
int i=st.executeUpdate("update liked_comments set clicks="+1+" where username="+"'"+uname+"'"+"and comment_id="+id);

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