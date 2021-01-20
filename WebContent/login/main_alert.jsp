<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link href="basic.css" rel="stylesheet" type="text/css"/>
</head>
<body>
	<script type="text/javascript">		
		 alert("Email already in use!"); 
	</script>
	
	
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
  <a class="active" href="main.html">HOME</a>
  <a href="ourteam_logout.html">OUR TEAM</a>
  
  <button class="dropbtn" onclick="document.getElementById('id01').style.display='block'" style="width:auto;">JOIN</button>

    <div id="id01" class="modal">
             
         <div class="container">
      <div id="left-form-container">
        <div id="left-form">
          <form class="sub-form" action="Login" method="post"><p><table>
          <tr></tr>
          <h3 style="color: LightYellow"><u>Login to your Account</u></h3>
          <tr>
            <td><font face="Lucida Handwriting" size="2px" style="color: LightYellow" style="font-family: Lucida Handwriting">Email:</font></td>
            <td><input type="text" id="username" name="username" maxlength="100" size="20" required></td>
          </tr>
          
          <tr>
            <td><font face="Lucida Handwriting" size="2px" style="color: LightYellow" style="font-family: Lucida Handwriting">Password:</font></td>
            <td><input type="password" id="password" name="password" maxlength="100" size="20" required></td>
          </tr>
          <tr></tr>
          <tr>
            <td><input type="submit" value="Login" class="dropbtn"></td>
          </tr>
          
          </table></p></form>
        </div>
      </div>
    
    
      <div id="right-form-container">
        <div id="right-form">
          <form class="sub-form" action="Register" method="post"><p><table>
          <tr></tr>
          <h3 style="color: LightYellow"><u>Create an Account</u></h3>
          <tr>
            <td><font face="Lucida Handwriting" size="2px" style="color: LightYellow">First Name:</font></td>
            <td><input type="text" id="uname" name="firstname" maxlength="100" size="20" required></td> 
          </tr>

          <tr>
            <td><font face="Lucida Handwriting" size="2px" style="color: LightYellow">Last Name:</font></td>
            <td><input type="text" id="uname" name="lastname" maxlength="100" size="20" required></td> 
          </tr>

          <tr>
            <td><font face="Lucida Handwriting" size="2px" style="color: LightYellow">Email:</font></td>
            <td><input type="text" id="username" name="username" maxlength="100" size="20" required></td> 
          </tr>
          
          <tr>
            <td><font face="Lucida Handwriting" size="2px" style="color: LightYellow" style="font-family: Lucida Handwriting">Password:</font></td>
            <td><input type="password" name="password" id="password" maxlength="100" size="20" required></td>
          </tr>
          <tr></tr>
          <tr>
          <td><input type="submit" value="Sign Up" class="dropbtn"></td>
          </tr>
          
          </table>
          </form>
        </div>
      </div>
    </div> 
</div> 
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