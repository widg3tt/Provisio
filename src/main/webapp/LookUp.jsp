<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*, javax.servlet.*, java.util.Date" %>

<%-- ****Bean**** --%>
<%-- <%@ page import="provisio.beans.ReservationSummaryBean"%> --%>
<%@ page import="Beans.ReservationSummaryBean"%>

<%-- ****Calendar and Dates**** --%>
<%@ page import="java.text.SimpleDateFormat" %>
<%@page import="java.util.concurrent.TimeUnit"%>
<%@page import="java.util.Calendar" %>

<!DOCTYPE html>
<html lang="en">
<head>
<head>
<title>Provisio - Reservation Lookup</title>
<link href="provisio.css" type="text/css" rel="stylesheet" />
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="Content-Type" content="text/html">

<body>
	<%@include file="nav.html" %>
<%
ReservationSummaryBean summary = new ReservationSummaryBean();
%>
	<%
	if (session.getAttribute("sessionID") == null) {
	%>
	<div class="response">
        <h3 class="responseHeader">You are not logged in. Please login to continue.</h3><br />
        <a class="highlight" href="Login.jsp">Login</a>
    </div>
	<%
	} 
	else {
%>
      <div width="98%" class="randl">   
     <form  method='GET' action='LookUp.jsp'>
       Reservation ID :  <input type="text" class="formInput" name="reserve_id" id="reserve_id">
       <button type="submit" class="btn btn-success btn-sm"> Search </button>
     </form>
    <%
		if(request.getMethod().equals("GET")){
			String reserve_id ="";
                       reserve_id = request.getParameter("reserve_id");
			// Get the booking date, check in and out date
                        if(null != reserve_id)
                        {
                        try{
                        ReservationSummaryBean reservation = new ReservationSummaryBean();
                        String [] rs_data = reservation.getReservationByID(reserve_id);
                        if(rs_data.length>0)
                        {
       
                           
	
	%>
	
	
               
                   
                        <h1 class="formHeading">Reservation Summary </h1><hr /><br />
                        <table>
                          
                            <tr>
                                <td>Check-In Date: </td>
                                <td>
                                <% 
                                out.print(rs_data[1]);
                                %>
                                </td>
                            </tr>
                            <tr>
                                <td>Check-out Date: </td>
                                <td>
                                <% 
                                out.print(rs_data[2]);
                                %>
                                </td>
                            </tr>
                            <tr>
                                <td>Destination: </td>
                                <td>
                                <%
                               out.print(rs_data[9]);
                                %> 
                                </td>
                            </tr>
                            <tr>
                                <td>Room Size: </td>
                                <td>
                                <%
                               out.print(rs_data[11]);
                                %> 
                                </td>
                            </tr>
                            <tr>
                                <td>Points Earned: </td>
                                <td>
                                <%
                               out.print(rs_data[3]);
                                %>
                                </td>
                            </tr>
                            <tr>
                                <td>Number of Guests: </td>
                                <td>
                                <%
                               out.print(rs_data[4]);
                                %>
                                </td>
                            </tr>
                            <tr>
                                <td>Amenities : </td>
                                <td>
                                <%
                               out.print(rs_data[5]);				
                                %>
                                </td>
                            </tr>
                            
                           
                            <tr>
                                <td>Nights: </td>
                                <td>
                                <% 		
                               out.print(rs_data[6]);
                                %>		
                                </td>
                            </tr>
                            <tr>
                                <td>Room Cost: </td>
                                <td>
                                $<%
                               out.print(rs_data[7]);
                                %>				
                                </td>
                            </tr>
                            <tr>
                                <td>Amenities Cost: </td>
                                <td>
                                $<%
                                // Price will be true and added to total if there are any amenities
                                out.print(rs_data[12]);
                                %>			
                                </td>
                            </tr>
                            <tr>
                                <td><strong>Total Cost: </strong></td>
                                <td><strong>
                                $<%
                                   out.print(rs_data[8]);

                                %>		
                                </strong></td>
                            </tr>
                        </table>
                	
                
              
	        <%
                    }
                    }catch(Exception e)
{
out.print(e.getMessage());
}

}
    } %>
              </div>    
                        <%
}
%>
</body>
</html>