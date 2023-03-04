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
	<%@include file="nav.html" %> <!--Nav file-->
<%
ReservationSummaryBean summary = new ReservationSummaryBean(); // Using reservation summary bean for backend code
%>
	<%
	if (session.getAttribute("sessionID") == null) { // Getting session ID
	%>
	<div class="response">
        <h3 class="responseHeader">You must be logged in to continue.</h3><br /> <!--Need to login-->
        <a class="highlight" href="Login.jsp">Login</a>
    </div>
	<%
	} 
	else {
%>
      <div width="98%">   
     <form class="rand2" method='GET' action='LookUp.jsp'>
       Reservation ID :  <input type="text" class="formInput" name="reserve_id" id="reserve_id">
       <button type="submit" class="btn btn-success btn-sm"> Search </button>
     </form> </br>
     
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
	
	
                        <!--Table for the lookup reservation summary output-->
                   
                        <h1 style="text-align:left;" class="formHeading">Reservation Summary </h1><br />
                      
                        <table>
                            <tr>
                                <tr>Check-In Date: </tr>
                                <tr> <!--Printing results-->
                                <% 
                                out.print(rs_data[1]);
                                %>
                                </tr>
                            </tr>
                            <tr>|</tr>
                            <tr>
                                <tr> Check-out Date: </tr>
                                <tr> <!--Printing results-->
                                <% 
                                out.print(rs_data[2]);
                                %>
                                </tr>
                            </tr>
                            <tr>|</tr>
                            <tr>
                                <tr> Number of Guests: </tr>
                                <tr> <!--Printing results-->
                                <%
                               out.print(rs_data[4]);
                                %>
                                </tr>
                            </tr>
                            <tr>|</tr>
                            <tr>
                                <tr> Nights: </tr>
                                <tr> <!--Printing results-->
                                <% 		
                               out.print(rs_data[6]);
                                %>		
                                </tr>
                            </tr>
                            <br/><br/>
                            <hr/>
                        </table>
                        
                        <table align="left" style="margin-left:15%;"></form>
                            <td style="font-size: 30px;">Details<br></br></td>
                            <tr>
                                <td>Destination: </td>
                                <td> <!--Printing results-->
                                <%
                               out.print(rs_data[9]);
                                %> 
                                </td>
                            </tr>
                            
                            <tr>
                                <td>Room Size: </td>
                                <td> <!--Printing results-->
                                <%
                               out.print(rs_data[11]);
                                %> 
                                </td>
                            </tr>
                            <tr>
                                <td>Room Cost: </td>
                                <td> <!--Printing results-->
                                $<%
                               out.print(rs_data[7]);
                                %>				
                                </td>
                            </tr><br>
                            <tr>
                                <td><br></br><strong>Total Cost: </strong></td>
                                <td><br></br><strong> <!--Printing results-->
                                $<%
                                   out.print(rs_data[8]);

                                %>		
                                </strong></td>
                            </tr>
                        </table>
                        <table align="right" style="margin-right:20%;">
                            <tr>
                                <td>Amenities : </td>
                                <td> <!--Printing results-->
                                <%
                               out.print(rs_data[5]);				
                                %>
                                </td>
                            </tr>
                            <tr>
                                <td>Amenities Cost: </td>
                                <td> <!--Printing results-->
                                $<%
                                // Price will be true and added to total if there are any amenities
                                if (rs_data[12] == "0.0"){
                                	out.print("");
                                } else {
                                out.print(rs_data[12]);
                                }
                                %>				
                                </td>
                            </tr>
                            
                            <p style="text-align:center">Amenities:</p>
 
                            <tr>
                                <td style="text-align:left;"><br></br>Guests Terms & Conditions:<br></br></td></tr>
                            <tr>   
                                <td style="text-align:left;text-indent: 25px;">    
                                    Check-In Date: 3 p.m.</br></td></tr>
                            <tr>    
                                <td style="text-align:left;text-indent: 25px;">
                                    Check-Out Date: 11 a.m.<br></br></td></tr>
                            <tr>    
                                <td style="text-align:left;text-indent: 25px;">    
                                    Guests will be responsible for any</br></td></tr>
                            <tr>    
                                <td style="text-align:left;text-indent: 25px;">    
                                    loss or damage to the property.
                                </td></td>
                            </tr>
                           
                        </table>
             
                        
	        <%
                    }
                    }catch(Exception e) // Error
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