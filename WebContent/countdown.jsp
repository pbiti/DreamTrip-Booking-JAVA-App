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
	<title>Countdown</title>
	<link rel="stylesheet" href="countdown.css">
</head>
<body>
	<%String Date= request.getParameter("departure"); %>
	<input type="hidden" id="date" name="date" value=<%=request.getParameter("departure")%>>
	<div class = "container">
		<h2><span>Countdown to Your Trip</h2>
		<div class="countdown">
			<div id="day"></div>
			<div id="hour"></div>
			<div id="minute"></div>
			<div id="second"></div>
		</div>
	</div>
	<script type="text/javascript">
		//var countDate = new Date('Jan 1, 2022 00:00:00').getTime();
		var date = document.getElementById("date").value;
		var countDate = new Date(date).getTime();
		document.getElementById('day').innerHTML = '';
		function newYear(){
			var now = new Date().getTime();
				gap = countDate - now;

				var second = 1000;
				var minute = second * 60;
				var hour = minute * 60;
				var day = hour *24;

				var d = Math.floor(gap/(day));
				var h = Math.floor((gap%(day))/(hour));
				var m = Math.floor((gap%(hour))/(minute));
				var s = Math.floor((gap%(minute))/(second));

				


				document.getElementById('day').innerText = d;
				document.getElementById('hour').innerText = h;
				document.getElementById('minute').innerText = m;
				document.getElementById('second').innerText = s;

		}

		setInterval(function(){
			newYear();
		},1000)
	</script>
</body>
</html>