<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import = "java.io.*,java.util.*,java.sql.*"%>
<%@ page import = "javax.servlet.http.*,javax.servlet.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix = "c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix = "sql"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	
	<script src = "https://code.jquery.com/jquery-3.5.1.min.js"></script>
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
	
	<link href="tools2.css" rel="stylesheet" type="text/css"/>
	<script>
		var local_time;
		function weather(name){
	        $.getJSON("http://api.openweathermap.org/data/2.5/weather?q="+name+"&units=metric&APPID=77f636943b4f843fb5bed09624b825a4", 
	        function (data) {
	        console.log(data);

	        var icon = "http://openweathermap.org/img/w/" + data.weather[0].icon + ".png";
	        var temp = data.main.temp;
	        var weather = data.weather[0].main;
	        document.getElementById("icon").innerHTML = "";
	        document.getElementById("weather").innerHTML = "";
	        document.getElementById("temp").innerHTML = "";

	        $(".icon").attr("src", icon);
	        $('.weather').append(weather);
	        $('.temp').append(temp + " Degrees Celcius");
	        });
	    }



		function timezone(){
			var city_name = document.myForm.city.value;
			var url = "https://weatherapi-com.p.rapidapi.com/current.json?q=".concat(city_name);
			document.getElementById("timezone_form").innerHTML += " ";
			fetch(url, {
			"method": "GET",
			"headers": {
				"x-rapidapi-key": "b224f16294mshd9aab121e05708bp1ce92bjsna50a03d64be2",
				"x-rapidapi-host": "weatherapi-com.p.rapidapi.com"
				}
			})
			.then(response => {
		    	return response.json();
			})
			.then(function(ob){
		    	console.log(ob);
		    	var local_time = JSON.stringify(ob.location.localtime);
		    	local_time = local_time.substring(1, local_time.length-1);
		    	document.getElementById("time").innerHTML = `<strong>`+city_name.toUpperCase()+ ":  " +local_time+`</strong>`;
		    	weather(city_name);

			})
		}
    </script>
    
    
</head>


<body>
<%   
    String uname=(String)session.getAttribute("uname"); 
%>

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
  <form action="login-forward" method="post"><input type="submit" class="dropbtn_nav" value="HOME"></form>
  <form action="ourteam" method="post"><input type="submit" class="dropbtn_nav" value="OUR TEAM"></form>
  <form action="book" method="post"><input type="submit" class="dropbtn_nav" value="BOOK"></form>
  
  
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
	          <form action="list" method="post"><button class="profilebtn" style="left:40%">
    Dream Trips 
    <span></span>
    <span></span>
    <span></span>
    <span></span>
  </button></form>
	          <form action="view_trips" method="post"><button class="profilebtn" style="left:40%">
    Your Trips 
    <span></span>
    <span></span>
    <span></span>
    <span></span>
  </button></form> 
	                                    
        </div>
        </div>
      </div>

  <form action="tools-forward" method="post"><input type="submit" class="dropbtn_nav" value="TOOLS"></form>
  <form action="main.html" method="post"><input type="submit" class="dropbtn_nav" value="LOGOUT"></form>
      </div>
  </div>
	
	
<div class="divider"><span></span><span><strong>The Holy Trinity of Travelling</strong></span><span></span></div>

<br><br><br>

<center>
<h3>The  weather  is  the  single  factor  most  likely  to  positively  or  negatively  affect  your  trip<br> 
though it's also one of the things most travelers take for granted<br>and people quite often find themselves caught off guard.<br><br></h3>
</center>

<div id="timezone_form">
	<form onsubmit="return timezone();" name="myForm" action="" method="post">
		<input placeholder="City" name="city" type="text" id="city" class="form-control-small" />
		<button class="profilebtn" style="top:9px; left:60%">
    Get Info
    <span></span>
    <span></span>
    <span></span>
    <span></span>
  </button>
	</form>
</div>
<center>
<br><br>
<div id ="time"></div>

<div class="weather-container">
    <img class = "icon" id = "icon">
    <strong><p class = "weather" id = "weather"></p></strong>
    <strong><p class = "temp" id = "temp"></p></strong>
</div>
<br><br>
</center>
<center>
<h3>The world is filled with such a wide variety of wonderful destinations and beautiful places to visit<br>
it can be quite difficult to compile a list of the best ones<br>so help us make it easier for fellow travellers.
<abbr title="Below you can see the 5 most voted destinations. Submit your top destination and see if it will climb the chart." style="text-decoration: none;">
<i class="fa fa-info-circle"></i></abbr> 
<br><br></h3>
</center>

<form action="vote" method="post">
	<input name="voting" id="voting" placeholder="City/Town" class="form-control-small" style="left:50%"/>
	<button class="profilebtn" style="top:9px; left:60%">
    Vote
    <span></span>
    <span></span>
    <span></span>
    <span></span>
  </button>
</form>
<input type="hidden" id="count" name="count"/>
<input type="hidden" id="id" name="id"/>

<div id="top">
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
		ResultSet resultSet2 = null;
		ResultSet resultSet3 = null;
		ResultSet resultSet4 = null;
		ResultSet resultSet5 = null;
	%>
<%
try{
connection = DriverManager.getConnection(connectionUrl+database, userid, password);
statement=connection.createStatement();
String sql ="select city, votes from topdest ORDER BY votes DESC LIMIT 5";
resultSet = statement.executeQuery(sql);
statement=connection.createStatement();
String sql4 = "select * from liked_comments where username=" + "'" +uname+"'"; 
resultSet4 = statement.executeQuery(sql4);
resultSet4.next();
%>
<center>
<ol>
<% 
while(resultSet.next()){
%>

<li><%String city=resultSet.getString("city"); out.print(city +": "); String votes =resultSet.getString("votes"); out.print(votes);%></li>

<%

}
%>
</ol>
</center>
<%
} catch (Exception e) {
e.printStackTrace();
}
%>
</div>
<center>
<h3>Share your travel tips or your travel experiences with fellow travelers in the comment section below.<br><br></h3>
</center>

<div id="comment_form" class="comments">
      	<form action="comments" method="post">
      		<textarea rows="4" cols="50" id="text" name="text" placeholder="Add Your Comment..." class="form-control" ></textarea>
      		<button class="profilebtn" style="top:31px; left:70%;">
		    Add Comment
		    <span></span>
		    <span></span>
		    <span></span>
		    <span></span>
		  </button>
      	</form>
      </div>

<%   
String name=(String)session.getAttribute("uname");
%>
<%
try{
connection = DriverManager.getConnection(connectionUrl+database, userid, password);
statement=connection.createStatement();
String sql ="select * from comments ORDER BY id DESC";
resultSet2 = statement.executeQuery(sql);
%>
<center>
<% 
while(resultSet2.next()){
	%>
		<div class="comment-container">
		<%
		String username=resultSet2.getString("username");
		
		connection = DriverManager.getConnection(connectionUrl+database, userid, password);
		statement=connection.createStatement();
		String sql3 ="select * from users where username= " + "'" + username + "'";
		resultSet3 = statement.executeQuery(sql3);
		
		if (resultSet3.next()) {
            String user_image;
           
            Blob blob = resultSet3.getBlob("image");
             
            InputStream inputStream = blob.getBinaryStream();
            ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
            byte[] buffer = new byte[4096];
            int bytesRead = -1;
             
            while ((bytesRead = inputStream.read(buffer)) != -1) {
                outputStream.write(buffer, 0, bytesRead);                  
            }
             
            byte[] imageBytes = outputStream.toByteArray();
            String base64Image = Base64.getEncoder().encodeToString(imageBytes);
             
             
            inputStream.close();
            outputStream.close();
             
           
            user_image = base64Image;
            
            request.setAttribute("profileimage", user_image);
        }
		
		
		%>
		<img src="data:image/jpg;base64,${profileimage}" id="photo"/>
		<span class="date-right"><%String date =resultSet2.getString("date"); out.print(date);%></span>
		<p style="color: LightYellow;"><strong><%String fname=resultSet2.getString("first_name"); out.print(fname + " ");
		String lname=resultSet2.getString("last_name"); out.print(lname);
		String id = resultSet2.getString("id");
		
		connection = DriverManager.getConnection(connectionUrl+database, userid, password);
		statement=connection.createStatement();
		String sql4 = "select * from liked_comments where username=" + "'" +uname+"'" + "and comment_id=" + id;
		resultSet4 = statement.executeQuery(sql4);
		
		statement=connection.createStatement();
		String sql5 = "select * from liked_comments where comment_id=" + id;		
		resultSet5 = statement.executeQuery(sql5);
		
		%></strong></p>
		<br>
		<p style="color: LightYellow; margin-left:80px"><%String text =resultSet2.getString("text"); out.print(text);%></p>
		
		
		<%	
			int likes=0;
			while(resultSet5.next()){
				likes+=resultSet5.getInt("clicks");
			}
			
		    if(resultSet4.next()==false){%>
		    	<a href="newlike.jsp?id=<%=resultSet2.getString("id")%>"><i class="fa fa-heart"></i><%out.print(likes); %></a>
		    <%}else if(resultSet4.getInt("clicks")==0){%>
		    	<a href="like.jsp?id=<%=resultSet2.getString("id")%>"><i class="fa fa-heart" ></i><%out.print(likes); %></a>
		    <%}else if(resultSet4.getInt("clicks")==1){%>
		    	<a href="dislike.jsp?id=<%=resultSet2.getString("id")%>"><i class="fa fa-heart" style="color: red"></i><%out.print(likes); %></a>
		    <%} 
			if(name.equals(username)){%>
				<a class="time-right" href="delete.jsp?id=<%=resultSet2.getString("id") %>">Delete</a>
		   <% 
			}%> </div><br>
		
	<%
}
connection.close();
} catch (Exception e) {
e.printStackTrace();
}
%>
</center>
</body>
</html>