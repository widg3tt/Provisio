<%@page import="Beans.ReservationSummaryBean"%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>Provisio - Home</title>
<link href="provisio.css" type="text/css" rel="stylesheet" />
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="Content-Type" content="text/html">
</head>
<body>
<%@include file="nav.html" %> <!--Nav file-->

	<div class="image"> <!--Picture-->
		<img src="hotel.jpg" style="width: 100%;"> <!--Text-->
		<div class="top-left">"I haven't been everywhere, but it's on my
			list"</div>
		<div class="centered">Lorem ipsum dolor sit amet, consectetur
			adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore
			magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation
			ullamco laboris nisi</div>
	</div>

	<div width="98%">
		<div class="boxes"> <!--Boxes to add more to the page-->
			<h2>Lorem Ipsum 1</h2>
			<br>
			<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed
				do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut
				enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi
				ut aliquip ex ea commodo consequat. Duis aute irure dolor in
				reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla
				pariatur. Excepteur sint occaecat cupidatat non proident, sunt in
				culpa qui officia deserunt mollit anim id est laborum.</p>

			<form class="center" action="ContactUs.jsp" method="post">
				<input style="background-color: #f6c453;" type="submit" value="Get in contact with us" />
			</form>
			
		</div>
		<div class="boxes">
			<h2>Lorem Ipsum 2</h2>
			<br>
			<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed
				do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut
				enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi
				ut aliquip ex ea commodo consequat. Duis aute irure dolor in
				reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla
				pariatur. Excepteur sint occaecat cupidatat non proident, sunt in
				culpa qui officia deserunt mollit anim id est laborum.</p>

			<form class="center" action="Locations.jsp" method="post">
				<input style="background-color: #f6c453;" type="submit" value="Where you want to be" />
			</form>
			
		</div>
		<div class="boxes">
			<h2>Lorem Ipsum 3</h2>
			<br>
			<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed
				do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut
				enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi
				ut aliquip ex ea commodo consequat. Duis aute irure dolor in
				reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla
				pariatur. Excepteur sint occaecat cupidatat non proident, sunt in
				culpa qui officia deserunt mollit anim id est laborum.</p>

			<form  class="center" action="Registration.jsp">
				<input style="background-color: #f6c453;" type="submit" value="Earn loyalty points" />
			</form>

		</div>
	</div>
       
</body>
</html>