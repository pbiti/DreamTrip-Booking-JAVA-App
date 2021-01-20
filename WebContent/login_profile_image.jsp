<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import = "java.io.*,java.util.*,java.sql.*"%>
<%@ page import = "javax.servlet.http.*,javax.servlet.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix = "c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix = "sql"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">

<link href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
<link href="styletest.css" rel="stylesheet" type="text/css"/>
<link href="rateus.css" rel="stylesheet" type="text/css"/>
<link rel="stylesheet" href="image.css">
</head>
<body>

<% String uname = request.getParameter("username");%>

<sql:setDataSource var = "snapshot" driver = "com.mysql.jdbc.Driver"
         url = "jdbc:mysql://localhost:3306/wishlist"
         user = "root"  password = "ksql4321!"/>
 
      <sql:query dataSource = "${snapshot}" var = "result1">
         SELECT first_name FROM users WHERE username="${uname}";
      </sql:query>
      
      <sql:query dataSource = "${snapshot}" var = "result2">
         SELECT * FROM reviews ORDER BY id DESC;
      </sql:query>
      
      <sql:query dataSource = "${snapshot}" var = "result3">
         SELECT COUNT(id) FROM reviews WHERE rating=1;
      </sql:query>
      
      <sql:query dataSource = "${snapshot}" var = "result4">
         SELECT COUNT(id) FROM reviews WHERE rating=2;
      </sql:query>
      
      <sql:query dataSource = "${snapshot}" var = "result5">
         SELECT COUNT(id) FROM reviews WHERE rating=3;
      </sql:query>
      
      <sql:query dataSource = "${snapshot}" var = "result6">
         SELECT COUNT(id) FROM reviews WHERE rating=4;
      </sql:query>
      
      <sql:query dataSource = "${snapshot}" var = "result7">
         SELECT COUNT(id) FROM reviews WHERE rating=5;
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


  <div class="header-right">
  <a class="active" href="login.jsp">HOME</a>
  <a href="ourteam.jsp">OUR TEAM</a>
  <a href ="book.jsp" >BOOK</a>
  
  
  <div class="dropdown">
    <button class="dropbtn">MY PROFILE 
      <i class="fa fa-caret-down"></i>
    </button>
    <div class="dropdown-content">
         
          
          <div class="column" style="width: 100%">
              <h1>Hello,</h1>
	          <c:forEach var = "row" items = "${result1.rows}">
	              <h2> <c:out value = "${row.first_name}"/></h2>	          
	          </c:forEach>
	          <form action="list" method="post"><button>DREAM TRIPS</button></form>
	          <form action="view_trips" method="post"><button>VIEW YOUR TRIPS</button></form>                           
        </div>
        </div>
      </div>

  <a href = "tools.jsp">TOOLS</a>
  <a href ="main.html">LOGOUT</a>  
  
</div>
</div>


<div class="slideshow-container">
  

<div class="mySlides fade">
  
  <img src="village_austria2.jpg" style="width:100%" style="height: 100%">
  <div class="text" style="color: LightBlue">Hallstatt, Austria</div>
</div>

<div class="mySlides fade">
  
  <img src="gland.jpg" style="width:100%" style="height: 100%">
  <div class="text" style="color: LightBlue">Nuuk, Greenland</div>
</div>

<div class="mySlides fade">
 
  <img src="japan1.jpg" style="width:100%" style="height: 100%">
  <div class="text" style="color: #34170b">Kyoto, Japan</div>
</div>

<div class="mySlides fade">
 
  <img src="poland2.jpg" style="width:100%" style="height: 100%">
  <div class="text" style="color: #34170b">Warsaw, Poland</div>
</div>

<div class="mySlides fade">
 
  <img src="meteora.jpg" style="width:100%" style="height: 100%">
  <div class="text" style="color: Tan">Meteora, Greece</div>
</div>

</div>
<br>

<div style="text-align:center">
  <span class="dot"></span> 
  <span class="dot"></span> 
  <span class="dot"></span> 
  <span class="dot"></span> 
  <span class="dot"></span> 
</div>


<br><br><br>
<center>


<br>
<h4>. . . . .</h4>
<h2>Hello There,</h2>
<h3>Welcome to our page. We are travel enthousiasts and we are here to make your</h3>
<h3>Dream Trip become reality. We offer a variety of unique experiences</h3>
<h3>around the world. Travelling is meeting new places, cultures and traditions</h3>
<h3>and through our travel offers you will discover all of the above.</h3>
<h2>You have nothing to lose and a world to see!</h2>
<h4>. . . . .</h4>
<br>
<h4>. . . . .</h4>
<h2>Travel Memories</h2>
<h4>. . . . .</h4>
</center>


<div class="row">
  <div class="column_gallery">
     <img src='phlio.jpg'>
 <div>Pelion 2019</div>
  </div>
  <div class="column_gallery">
    <img src='italygroup.jpg'>
 <div>Italy 2017</div>
  </div>
  <div class="column_gallery">
    <img src="elvetiagroup.jpg">
    <div>Switzerland 2019</div>
  </div>
  <div class="column_gallery">
    <img src="nhsi.jpg">
    <div>Paros 2018</div>
  </div>
  <div class="column_gallery">
    <img src="icelandgroup.jpg">
    <div>Iceland 2020</div>
  </div>
  <div class="column_gallery">
    <img src="norwaygroup.jpg">
    <div>Norway 2019</div>
  </div>
  <div class="column_gallery">
    <img src="kapadokia.jpg">
    <div>Cappadocia 2018</div>
  </div>
  <div class="column_gallery">
    <img src="egyptgroup.jpg">
    <div>Egypt 2018</div>
  </div>
</div>
<center>
<h4>. . . . .</h4>
<h2>Your Feedback Matters</h2>
<h4>. . . . .</h4>
</center>
<div class="main">
    <form id="rating-form" action="rate" method="post">
		<span class="rating-star">
			<input type="radio" name="rating" value="5" required><span class="star"></span>
		 
		    <input type="radio" name="rating" value="4"><span class="star"></span>
		 
		    <input type="radio" name="rating" value="3"><span class="star"></span>
		 
		    <input type="radio" name="rating" value="2"><span class="star"></span>
		 
		    <input type="radio" name="rating" value="1"><span class="star"></span>
    
     	</span>
     	<br><br>
    	<div class="textarea">  
    		<textarea cols="30" placeholder="Describe your experience.." name = "description"></textarea>     
    	</div>
	    <br><br>
	    <input class="sub_btn" type="submit" value="Rate Us">
	    
	    <br><br><br>
	</form>
	
</div>
<hr>
<br><br>
<center>
<div class="ratings">
Total Ratings :
<c:forEach var="row" items="${result3.rows}">
   <c:out value="${result3.rowsByIndex[0][0]}" />
</c:forEach><i class="fa fa-star checked"></i><i class="fa fa-star-o unchecked"></i><i class="fa fa-star-o unchecked"></i><i class="fa fa-star-o unchecked"></i><i class="fa fa-star-o unchecked"></i></div>

<br>
<div class="ratings">
Total Ratings :
<c:forEach var="row" items="${result4.rows}">
    <c:out value="${result4.rowsByIndex[0][0]}" />
</c:forEach><i class="fa fa-star checked"></i><i class="fa fa-star checked"></i><i class="fa fa-star-o unchecked"></i><i class="fa fa-star-o unchecked"></i><i class="fa fa-star-o unchecked"></i></div>
<br>

<div class="ratings">
Total Ratings :
<c:forEach var="row" items="${result5.rows}">
    <c:out value="${result5.rowsByIndex[0][0]}" />
</c:forEach><i class="fa fa-star checked"></i><i class="fa fa-star checked"></i><i class="fa fa-star checked"></i><i class="fa fa-star-o unchecked"></i><i class="fa fa-star-o unchecked"></i></div>
<br>

<div class="ratings">
Total Ratings :
<c:forEach var="row" items="${result6.rows}">
   <c:out value="${result6.rowsByIndex[0][0]}" />
</c:forEach><i class="fa fa-star checked"></i><i class="fa fa-star checked"></i><i class="fa fa-star checked"></i><i class="fa fa-star checked"></i><i class="fa fa-star-o unchecked"></i></div>
<br>

<div class="ratings">
Total Ratings :
<c:forEach var="row" items="${result7.rows}">
   <c:out value="${result7.rowsByIndex[0][0]}" />
</c:forEach><i class="fa fa-star checked"></i><i class="fa fa-star checked"></i><i class="fa fa-star checked"></i><i class="fa fa-star checked"></i><i class="fa fa-star checked"></i></div>
<br><br>
</center>
<hr>

<div class="reviews">
<c:forEach var = "row" items = "${result2.rows}">
	  <h2 style="color: #222"> <c:out value = "${row.username}"/></h2>
	  <h2 style="color: #222"> <c:out value = "${row.rating}"/></h2><i class="fa fa-star rate"></i>	  
	  <br>
	  <h2 style="color: LightYellow"> <c:out value = "${row.review}"/></h2>
	  <hr>	   
</c:forEach></div>


<h1>Upload Photo Like Facebook Profile DP</h1>
<form action="submit_image" method="post" enctype="multipart/form-data">
    <div class="profile-pic-div">
      <img src="data:image/jpg;base64,${pi.base64Image}" id="photo"/>
      <input type="file" id="file" name="myFile">
      <label for="file" id="uploadBtn">Choose Photo</label>  
    </div>
    <input type="submit" value="Submit">
</form>
<script src="app.js"></script>
  
<script>
var slideIndex = 0;
showSlides();

function showSlides() {
  var i;
  var slides = document.getElementsByClassName("mySlides");
  var dots = document.getElementsByClassName("dot");
  for (i = 0; i < slides.length; i++) {
    slides[i].style.display = "none";  
  }
  slideIndex++;
  if (slideIndex > slides.length) {slideIndex = 1}    
  for (i = 0; i < dots.length; i++) {
    dots[i].className = dots[i].className.replace(" active", "");
  }
  slides[slideIndex-1].style.display = "block";  
  dots[slideIndex-1].className += " active";
  setTimeout(showSlides, 4000); // Change image every 2 seconds
}
</script>

<script>
// Get the modal
var modal = document.getElementById('id01');

// When the user clicks anywhere outside of the modal, close it
window.onclick = function(event) {
    if (event.target == modal) {
        modal.style.display = "none";
    }
}
</script>


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