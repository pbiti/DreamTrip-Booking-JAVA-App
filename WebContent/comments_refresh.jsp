<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import = "java.io.*,java.util.*,java.sql.*"%>
<%@ page import = "javax.servlet.http.*,javax.servlet.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix = "c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix = "sql"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link href="todo.css" rel="stylesheet" type="text/css"/>
</head>
<body style="background-color : #333">
	<sql:setDataSource var = "snapshot" driver = "com.mysql.jdbc.Driver"
         url = "jdbc:mysql://localhost:3306/wishlist"
         user = "root"  password = "ksql4321!"/>
 
      <sql:query dataSource = "${snapshot}" var = "result">
         SELECT * FROM comments ORDER BY id DESC;
      </sql:query>
      
      <sql:query dataSource = "${snapshot}" var = "result1">
         SELECT first_name FROM users WHERE username="${uname}";
      </sql:query>
    
    

      <div class="navbar">

  <a href="#default" class="logo"><i class="fa fa-globe" style="color: LightYellow" size = "8px"></i> DREAM TRIP</a>
  
  <div class="icons">
    <a class="fa fa-phone" target="_blank" title="(+30)242100000" style="color: black"></a>
    <a class="fa fa-envelope" target="_blank" title="dreamtrip@gmail.com" style="color: black"></a>
    <a target="_blank" href="https://www.facebook.com/"><i class="fa fa-facebook" style="color: black"></i></a>
    <a target="_blank" href="https://www.facebook.com/"><i class="fa fa-instagram" style="color: black"></i></a>
    <a target="_blank" href="https://www.twitter.com/"><i class="fa fa-twitter" style="color: black"></i></a>
    <a target="_blank" href="https://www.youtube.com/"><i class="fa fa-youtube" style="color: black"></i></a>
  </div>


  <div class="header-right-nav">
  <a href="login.jsp">HOME</a>
  <a href="ourteam.jsp">OUR TEAM</a>
  <a href="book.jsp">BOOK</a>
  
  
  <div class="dropdown_des">
    <button class="dropbtn_nav">MY PROFILE 
      <i class="fa fa-caret-down"></i>
    </button>
    	 <div class="dropdown-content-nav">
         
          
          <div class="column_profile" style="width: 100%">
          <h1>Hello,</h1>
		      <c:forEach var = "row" items = "${result1.rows}">
		              <h2> <c:out value = "${row.first_name}"/></h2>	          
		      </c:forEach>
		      <form action="list" method="post"><button>DREAM TRIPS</button></form>
		      <form action="view_trips" method="post"><button>VIEW YOUR TRIPS</button></form> 
        </div>
        </div>
        </div>
        <a class="active" href = "comments.jsp">COMMENTS</a>
        <a href ="main.html">LOGOUT</a>  
      </div>
  </div>
      
      <div id="comment_form" class="comments">
      	<form action="comments" method="post">
      		<textarea rows="4" cols="50" id="text" name="text" placeholder="Add Your Comment..."></textarea>
      		<button type="submit" >Submit</button>
      	</form>
      </div>

    <%   
    String name=(String)session.getAttribute("uname"); 
    %>
    <% 
      
      String driver = "com.mysql.jdbc.Driver";
	  String connectionUrl = "jdbc:mysql://localhost:3306/";
	  String database = "wishlist";
	  String userid = "root";
	  String password = "ksql4321!";
	  try{ 
		  Class.forName(driver);
		} catch (ClassNotFoundException e) {
		e.printStackTrace();
		}
		Connection connection = null;
		Statement statement = null;
		ResultSet resultSet = null;
	%>
<table border="1">
<tr>
<td>username</td>
<td>text</td>
<td>date</td>

</tr>
<%
try{
connection = DriverManager.getConnection(connectionUrl+database, userid, password);
statement=connection.createStatement();
String sql ="select * from comments";
resultSet = statement.executeQuery(sql);
while(resultSet.next()){
%>
<tr>
<td><%String username=resultSet.getString("username"); out.print(username);%></td>
<td><%String text =resultSet.getString("text"); out.print(text);%></td>
<td><%String date =resultSet.getString("date"); out.print(date);%></td>
<td><%
    String id = resultSet.getString("id"); 
	if(name.equals(username)){%>
		<a href="delete.jsp?id=<%=resultSet.getString("id") %>"><button type="button" class="delete">Delete</button></a>
   <% 
	}%> </td>
</tr>
<%

}
 resultSet = null;
connection.close();
} catch (Exception e) {
e.printStackTrace();
}
%>
</table>     
      
      
</body>
</html>