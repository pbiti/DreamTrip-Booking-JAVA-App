<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import = "java.io.*,java.util.*,java.sql.*"%>
<%@ page import = "javax.servlet.http.*,javax.servlet.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix = "c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix = "sql"%>
<html>
<head>


<link href="tools3.css" rel="stylesheet" type="text/css"/>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
</head>

</head>
<body>

 <% String uname = request.getParameter("username"); %>

<sql:setDataSource var = "snapshot" driver = "com.mysql.jdbc.Driver"
         url = "jdbc:mysql://localhost:3306/wishlist"
         user = "root"  password = "ksql4321!"/>
 
      <sql:query dataSource = "${snapshot}" var = "result">
         SELECT first_name FROM users WHERE username="${uname}";
      </sql:query>

 <button onclick="topFunction()" id="myBtn" title="Go to top">Top</button>

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
  <form action="login-forward" method="post"><input type="submit" class="dropbtn_nav" value="HOME"></form>
  <form action="ourteam" method="post"><input type="submit" class="dropbtn_nav" value="OUR TEAM"></form>
  <form action="book" method="post"><input type="submit" class="dropbtn_nav" value="BOOK"></form>
  
  <form>
  <div class="dropdown_des">
    <button class="dropbtn_nav"><c:forEach var = "row" items = "${result.rows}">
	               <span style="text-transform: uppercase"><c:out value = "${row.first_name}"/></span>          
	          </c:forEach> 
      <i class="fa fa-caret-down"></i>
    </button>
    <div class="dropdown-content-nav">
        	<form action="submit_image" method="post" enctype="multipart/form-data">
		    <div class="profile-pic-div">
		    
		      <img src="data:image/jpg;base64,${pi.base64Image}" id="photo"/>
		      <input type="file" id="file" name="myFile" onchange="this.form.submit();">
		      <label for="file" id="uploadBtn">Choose Photo</label>
		     		     
		    </div>  		    
		 </form>
	
          <div class="column_des" style="width: 100%">
          <br><br><br>      
	          <form action="list" method="post"><button class="profilebtn" style="left:40%">
    Dream Trips 
    <span></span>
    <span></span>
    <span></span>
    <span></span>
  </button></form>
	          <form action="view_trips" method="post"><button class="profilebtn"style="left:40%">
    Your Trips 
    <span></span>
    <span></span>
    <span></span>
    <span></span>
  </button></form> 
	                                    
        </div>
        </div>
      </div>
</form>
  <form action="tools-forward" method="post"><input type="submit" class="dropbtn_nav" value="TOOLS"></form>
  <form action="main.html" method="post"><input type="submit" class="dropbtn_nav" value="LOGOUT"></form>
	</div>
</div>	
		<br><br><br><br>
		 <div class="row">

		<div class="container">
			<center>
			<div class="container text-left">
				<form action="action_try" method="post">
					<input class="addtrip" type="submit" value="Add a Dream Trip" >
				</form>
				
			</div>
			<center>
			<br>
			<table class="table table-bordered" style="color: LightYellow">
				<thead>
					<tr>
					
						<th>TITLE</th>
						<th>TARGET DATE</th>
						<th>STATUS</th>
						<th>ACTIONS</th>
					
					</tr>
				</thead>
				<tbody>
					
					<c:forEach var="todo" items="${listTodo}">
						
						<tr>
							<td><c:out value="${todo.title}" /></td>
							<td><c:out value="${todo.targetDate}" /></td>
							<td><c:out value="${todo.status}" /></td>

							<td>
							
							<form action="edit" method="get">
								<a href="edit?id=<c:out value='${todo.id}' />">View & Edit</a>
								&nbsp;&nbsp;&nbsp;&nbsp; 
							</form>
							<form action="delete" method="get">
								<a href="delete?id=<c:out value='${todo.id}' />">Delete</a></td>
							</form>
							
								
						</tr>
					</c:forEach>
					
				</tbody>

			</table>
		</div>
	</div>
	<br><br><br>
	
	<script>
	//Get the button
	var mybutton = document.getElementById("myBtn");
	
	// When the user scrolls down 20px from the top of the document, show the button
	window.onscroll = function() {scrollFunction()};
	
	function scrollFunction() {
	  if (document.body.scrollTop > 20 || document.documentElement.scrollTop > 20) {
	    mybutton.style.display = "block";
	  } else {
	    mybutton.style.display = "none";
	  }
	}
	
	// When the user clicks on the button, scroll to the top of the document
	function topFunction() {
	  document.body.scrollTop = 0;
	  document.documentElement.scrollTop = 0;
	}
	</script>
	
</body>
</html>