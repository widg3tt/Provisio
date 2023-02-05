<%@page import="Beans.ReservationSummaryBean"%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>Provisio - Loyalty Points</title>
<link href="provisio.css" type="text/css" rel="stylesheet" />
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="Content-Type" content="text/html">
</head>
<body>
<%@include file="nav.html" %>
<%
	if (session.getAttribute("sessionID") == null) {
	%>
	
        <% }else 
{
ReservationSummaryBean summary = new ReservationSummaryBean();
		String email = (String)session.getAttribute("sessionID");
		
                    String[][] res = summary.getReservation(email);
		
                
		int lp = summary.getLoyaltyPoints(email);
%>
<center><h1 class="formHeading"> Loyalty Points</h1><hr /><br /> 
    <h3 align="left"> My Account </h3> <br><br>
<a  class="highlight" href="LookUp.jsp" style="float: left;">Reservation Lookup</a><br />
<a  class="highlight" href="ContactUs.jsp" style="float: left;">Give Us Feedback</a><br />
<font size="5">
<table align="right">

    <tr>
				<td>Email: </td>
				<td>
				<%out.print(email);%>
				</td>
			</tr>
			<tr>
				<td>Total Points: </td>
				<td>
				<%out.print(lp);%>
				</td>
                        </tr><!-- Table for email and total points -->
</table> </font> <br><br><br><br><br>

<div class=""> <!-- Table to hold the rest of the info -->
		<font size="5">
                <table border="1" style="background-color:#F5C554;">
                    <tr>
                        <th>Reservation ID </th>
                        
                        <th>Location</th>
                        <th>Check-In Date</th>
                        <th>Check-Out Date</th>
                        <th>Points Earned</th>
                    </tr>
<%


		
                int  i=0;
                while(i < res.length)
{
		
		
			
	%>
	
			<tr>
				<td><% out.print(res[i][0]);%> </td>
				<td><% out.print(res[i][9]);%> </td>
                                <td><% out.print(res[i][1]);%> </td>
                                <td><% out.print(res[i][2]);%> </td>
                                <td><% out.print(res[i][3]);%> </td>
			</tr>
		
		
	<% 
		i ++;
		}

%>
  </table>
  </font>
	</div>      
  </center>
                        
                        <%
}%>
</body>
</html>