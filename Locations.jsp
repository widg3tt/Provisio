<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>Provisio - Locations</title>
<link href="provisio.css" type="text/css" rel="stylesheet" />
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="Content-Type" content="text/html">
<div class="navbar">
	<img src="logo.png" class="navimg">
	   <div class="navtext">Provisio</div>
	<a class="navbarButton" href="index.jsp">Home</a>
	<a class="navbarButton" href="AboutUs.jsp">About Us</a>
	<a class="navbarButton" href="ContactUs.jsp">Contact Us</a>
	<a class="navbarButton" href="Locations.jsp">Locations</a>
	<a class="navbarButton" href="Registration.jsp">Register</a>
	<a class="navbarButton" href="Reservation.jsp">Booking</a>
	
	<% if (session.getAttribute("sessionID") == null){ %>
	<a class="navbarButtonLogOut" href="Login.jsp">Login</a>
	<% } else { %>
	<a class="navbarButtonLogOut" href="LogOut.jsp">Log Out</a>
	<% } %>
	<a class="navbarButtonLogOut" href="LookUp.jsp">Reservation LookUp</a>
</div>

</head>
<body>
	
	<div class="main-container">
    <div class="left-container">
		<img src="usa2b.png" alt="">
		<p>Welcome to our luxurious hotel, located in the heart of the city. Our rooms are equipped<br> with all the amenities you need for a comfortable and relaxing stay. Take advantage of our<br/> on-site restaurant and fitness center, or explore the nearby shopping and dining options.<br/> Book your stay today and experience the best of city living!</p>
    </div>
    <div class="right-container">
		<!--Top left image-->
		<div class="frame">
		<p style="margin-left: 7%;">San Francisco, CA</p>
		<div class="image-box">			
			<img src="san_francisco.jpg" alt="sanfrancisco">						
		</div>
			<a href="Reservation.jsp" class="link_text">Click Here to Book</a>
		</div>
		<!--Top Right image-->
		<div class="frame">
		<p style="margin-left: 9%;">Denver, CO</p>
        <div class="image-box">
            <img src="colorado.jpg" alt="Colorado">            
		</div>
		<a href="Reservation.jsp" class="link_text">Click Here to Book</a>
		</div>
		<!--Bottom Left image-->
		<div class="frame">
		<p style="margin-left: 7%;">Springfield, OR</p>
        <div class="image-box">
            <img src="oregon.jpg" alt="Oregon">            
		</div>
		<a href="Reservation.jsp" class="link_text">Click Here to Book</a>
		</div>
    </div>
</div>

<!--
	<div>
	-->
		<!-- <div>
			<img id="locationimg"  src="map.jpg" alt="Map">
		</div> -->
	<!--
	<div>
		<div class="boxes2">
			<img class="cities" src="san francisco.jpg" style="width: 100%">
			<h2 style="text-align: center;">San Francisco, California</h2>

		</div>
		<div class="boxes2">
			<img class="cities" src="colorado.jpg" style="width: 100%">
			<h2 style="text-align: center;">Denver, Colorado</h2>

		</div>
		<div class="boxes2">
			<img class="cities" src="oregon.jpg" style="width: 100%">
			<h2 style="text-align: center;">Springfield, Oregon</h2>

		</div>
	</div>
	</div>
	-->

</body>
</html>