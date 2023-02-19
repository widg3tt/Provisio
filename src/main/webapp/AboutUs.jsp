<!DOCTYPE html>
<html lang="en">
<head>
<title>Provisio - About Us</title>
<link href="provisio.css" type="text/css" rel="stylesheet" />
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="Content-Type" content="text/html">
</head>

<body>
<%@include file="nav.html" %> <!--Nav file-->
<div class="container">
	<div style="text-align: left">
		<h1>About Us</h1> <!--Header-->
	</div>
	<%
	if (request.getMethod().equals("POST")) {
		String user = request.getParameter("name");
	%>
	<%
	} else {
	%>
	<div>
		<img src="hotel.jpg" class="aboutusimg"><br /> <!--Image for about us page-->
	</div>
	<div class="aboutUs">
		<div class="aboutBox">
			<h3>Who is Provisio?</h3> <!--Text for about us page-->
			<br />
			<p>Our way of being</p>
			<br>
			<p>At Provisio we strive to be the first choice in the mind of
				guests, owners, and talent. In our journey to achieve this, we
				practice strong beliefs and actions that respect the diversity of
				people, the community, ethics and the planet. Together with our
				partners, we continue to develop new hotels and generate synergies
				to go much further. People at the heart of our business. Our team is
				committed to extra thoughtful care and is passionate about
				delivering an amazing hotel experience. While each of our team
				members at Provisio Hotel Group plays a unique role, they all serve
				as brand ambassadors working to deliver memorable moments and turn
				guests into passionate brand advocates.</p>
		</div>
	</div>
	<%
	}
	%>
</div>
</body>
</html>