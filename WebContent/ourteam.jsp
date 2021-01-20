<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import = "java.io.*,java.util.*,java.sql.*"%>
<%@ page import = "javax.servlet.http.*,javax.servlet.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix = "c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix = "sql"%>

<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link href="team.css" rel="stylesheet" type="text/css"/>
<link href="https://fonts.googleapis.com/css2?family=Cookie&display=swap" rel="stylesheet">

</head>

<body>

<% String uname = request.getParameter("username"); %>

<sql:setDataSource var = "snapshot" driver = "com.mysql.jdbc.Driver"
         url = "jdbc:mysql://localhost:3306/wishlist"
         user = "root"  password = "ksql4321!"/>
 
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
  <form action="login-forward" method="post"><input type="submit" class="dropbtn_nav" value="HOME"></form>
  <form action="ourteam" method="post"><input type="submit" class="dropbtn_nav" value="OUR TEAM"></form>
  <form action="book" method="post"><input type="submit" class="dropbtn_nav" value="BOOK"></form>
  
  <form>
  <div class="dropdown_des">
    <button class="dropbtn_nav"><c:forEach var = "row" items = "${result1.rows}">
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
	          <form action="list" method="post"><button class="profilebtn">
    Dream Trips 
    <span></span>
    <span></span>
    <span></span>
    <span></span>
  </button></form>
	          <form action="view_trips" method="post"><button class="profilebtn">
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
<center>
  <h1>Meet our Team...</h1>
</center>


<br>

<div class="row_ot">
  <div class="column_ot">
    <div class="card">
      <img src="aboutus.png" alt="Charis" style="width:100%">
      <div class="container">
        <h2>Charalampos Makris</h2>
        <p class="title">Tour Guide</p>
        <p>cmakris@uth.gr</p>
      </div>
    </div>
  </div>

  <div class="column_ot">
    <div class="card">
      <img src="aboutus.png" alt="Antonia" style="width:100%">
      <div class="container">
        <h2>Antonia Kourouniotou</h2>
        <p class="title">Tour Guide</p>
        <p>kourouniotou@uth.gr</p>
      </div>
    </div>
  </div>
  
  <div class="column_ot">
    <div class="card">
      <img src="aboutus.png" alt="Ksenia" style="width:100%">
      <div class="container">
        <h2>Polyxeni Biti</h2>
        <br>
        <p class="title">Tour Guide</p>
        <p>pbiti@uth.gr</p>
      </div>
    </div>
  </div>
</div>

</body>
</html>