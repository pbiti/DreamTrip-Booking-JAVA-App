
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
<link href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
<link href="stylerating.css" rel="stylesheet">
<link href='https://fonts.googleapis.com/css?family=Open+Sans:400,700,300' rel='stylesheet' type='text/css'>
<link href="trips2.css" rel="stylesheet" type="text/css"/>
</head>
<body>
<% 
	String uname = (String)session.getAttribute("uname"); 
%>
	
	<sql:setDataSource var = "snapshot" driver = "com.mysql.jdbc.Driver"
         url = "jdbc:mysql://localhost:3306/wishlist"
         user = "root"  password = "ksql4321!"/>
 
      <sql:query dataSource = "${snapshot}" var = "result1">
         SELECT first_name FROM users WHERE username="${uname}";
      </sql:query>
	
	<sql:query dataSource = "${snapshot}" var = "result2">
         SELECT * FROM trips WHERE username="${uname}";
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
	
	
	  <div class="header-right">
	  <form action="login-forward" method="post"><input type="submit" class="dropbtn" value="HOME"></form>
	  <form action="ourteam" method="post"><input type="submit" class="dropbtn" value="OUR TEAM"></form>
	  <form action="book" method="post"><input type="submit" class="dropbtn" value="BOOK"></form>
	  
	  <form>
	  <div class="dropdown">
	    <button class="dropbtn"><c:forEach var = "row" items = "${result1.rows}">
		               <span style="text-transform: uppercase"><c:out value = "${row.first_name}"/></span>          
		          </c:forEach> 
	      <i class="fa fa-caret-down"></i>
	    </button>
	    <div class="dropdown-content">
	        	<form action="submit_image" method="post" enctype="multipart/form-data">
			    <div class="profile-pic-div">
			    
			      <img src="data:image/jpg;base64,${pi.base64Image}" id="photo"/>
			      <input type="file" id="file" name="myFile" onchange="this.form.submit();">
			      <label for="file" id="uploadBtn">Choose Photo</label>
			     		     
			    </div>  		    
			 </form>
		
	          <div class="column" style="width: 100%">
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
	  <form action="tools-forward" method="post"><input type="submit" class="dropbtn" value="TOOLS"></form>
	  <form action="main.html" method="post"><input type="submit" class="dropbtn" value="LOGOUT"></form>
	  
	</div>
</div>

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
%>
<%
try{
connection = DriverManager.getConnection(connectionUrl+database, userid, password);
statement=connection.createStatement();
String sql ="select * from trips where username= ?";
PreparedStatement preparedStmt = (PreparedStatement) connection.prepareStatement(sql);
preparedStmt.setString(1, uname);
resultSet = preparedStmt.executeQuery();

//resultSet = statement.executeQuery(sql);
%>
<br><br><br>
<section id="pricePlans">
<ul id="plans">
<%while(resultSet.next()){
	System.out.println("DESTINATION: ");
%>
			
			<li class="plan">
				<ul class="planContainer">
					<li class="title"><h2><%String destination=resultSet.getString("destination"); out.print(destination); %></h2></li>
					<li class="price"><p><%String price=resultSet.getString("price"); out.print(price+"EUR"); %></p></li>
					<li>
						<ul class="options">
							<li><span><strong>Departure Date: </strong><% String departure =resultSet.getString("departure"); out.print(" " + departure);%></span></li>
							<li><span><strong>Return Date:</strong><%String ret=resultSet.getString("ret"); out.print(" " + ret); %></span></li>
							<li> <span><strong>Outbound Airline Company:</strong><%String carrier_phgaine=resultSet.getString("carrier_phgaine"); out.print(" " + carrier_phgaine); %></span></li>
							<li><span><strong>Inbound Airline Company:</strong><%String carrier_ela=resultSet.getString("carrier_ela"); out.print(" " +carrier_ela); %></span></li>
							<li><span><strong>Outbound Departure Station:</strong><%String depart1=resultSet.getString("air_depart_1"); out.print(" " + depart1); %></span></li>
							<li><span><strong>Outbound Arrival Station:</strong><%String arrive1=resultSet.getString("air_arrive_1"); out.print(" " + arrive1); %></span></li>
							<li><span><strong>Inbound Departure Station:</strong><%String depart2=resultSet.getString("air_depart_2"); out.print(" " + depart2); %></span></li>
							<li><span><strong>Inbound Arrival Station</strong><%String arrive2=resultSet.getString("air_arrive_2"); out.print(" " + arrive2); %></span></li>
							<li><span><strong>Hotel Name:</strong><%String hotelname=resultSet.getString("hotel_name"); out.print(" " + hotelname); %></span></li>
							<li><span><strong>Hotel Address:</strong><%String address=resultSet.getString("hotel_address"); out.print(" " + address); %></span></li>
							<li><span><strong>Check In:</strong><%String checkin=resultSet.getString("checkin"); out.print(" " + checkin); %></span></li>
							<li><span><strong>Check Out:</strong><%String checkout=resultSet.getString("checkout"); out.print(" " + checkout); %></span></li>
						</ul>
					</li>
					<li class="button"><a href="countdown.jsp?departure=<%=resultSet.getString("departure")%>&destination=<%=resultSet.getString("destination")%>">COUNTDOWN</a></li>
				</ul>
			</li>
			
<%
}
%>
</ul>
</section>
<% 
connection.close();
} catch (Exception e) {
e.printStackTrace();
}
%>

</body>
</html>