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
<title>Provisio - Reservation Summary</title>
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
		if(request.getMethod().equals("POST")){
			
			// Get the booking, check in and out date
			String bd = (String)session.getAttribute("bookingDate");
			String ad = (String)session.getAttribute("CheckInDate");
			String dd = (String)session.getAttribute("CheckOutDate");
			int hotelId = (Integer)session.getAttribute("HotelId");
			int roomId = (Integer)session.getAttribute("RoomId");
			int pointsEarned = (int)session.getAttribute("Points");
			int guestNum = (int)session.getAttribute("Guests");
			String selectedAmenities = (String)session.getAttribute("Amenities");
			int totalDays = (Integer)session.getAttribute("Nights");
			double roomCost = (Double)session.getAttribute("CostPerNight");
			double amenitiesCost = (Double)session.getAttribute("amenitiesPrice");
			double totalCost = (Double)session.getAttribute("grandTotal");
			
			String email = (String)session.getAttribute("sessionID");
			
		
			summary.setReservation(bd, ad, dd, pointsEarned, guestNum, selectedAmenities, totalDays, roomCost, amenitiesCost, totalCost, hotelId, email, roomId);
			summary.setLoyaltyPoints(pointsEarned, email); 
			int reservationId = summary.getReservationId(hotelId, email, roomId);
			session.setAttribute("reservationId", reservationId);
	%>
	<div class="response">
        <h3 class="responseHeader">
        <%
        out.println("Congratulations you have successfully booked your room, your confirmation number is " +  reservationId );
        %>  </h3><br />
        <a class="highlight" href="index.jsp">Home Page</a> 
    </div>
	<% 
		}
		else if(request.getMethod().equals("GET")) {
			
            String checkInDate = request.getParameter("CheckIn");
            String checkOutDate = request.getParameter("CheckOut");
            int totalDays = summary.dayLength(checkInDate, checkOutDate);
    		int pointsEarned = summary.pointsEarned(totalDays);
            Date holi1 = new SimpleDateFormat("yyyy-MM-dd").parse("2023-07-04");
            Date holi2 = new SimpleDateFormat("yyyy-MM-dd").parse("2022-12-24");
            Date holi3 = new SimpleDateFormat("yyyy-MM-dd").parse("2022-12-31");
            Date holiStart = new SimpleDateFormat("yyyy-MM-dd").parse(checkInDate);
            Date holiEnd = new SimpleDateFormat("yyyy-MM-dd").parse(checkOutDate);
                
            String city = request.getParameter("City");
            int hotelId = summary.getHotelId(city);
            String roomSize = request.getParameter("RoomSize");
            int roomId = summary.getroomId(hotelId, roomSize);
        	String guest = request.getParameter("Guests");
			int guestNum = summary.numbOfGuests(guest);
				
            String wifi = request.getParameter("Wifi");
			String amenWifi = summary.amenities(wifi);
			String breakfast = request.getParameter("Breakfast");
			String amenBreakfast = summary.amenities(breakfast);
    		String parking = request.getParameter("Parking");
			String amenParking = summary.amenities(parking);
			String selectedAmenities = summary.selectedAmenities(amenWifi, amenBreakfast, amenParking);
				
            double roomPrice = summary.getRoomPrice(hotelId, roomSize, totalDays);
                            double amenitiesPrice = summary.amenitiesPrice(amenWifi, amenBreakfast, amenParking, totalDays);
            double grandTotal = summary.getGrandTotal(amenitiesPrice, roomPrice);
            summary.round(grandTotal, 2);
                
            if (totalDays < 1){
                %>
                    <div class="response">
                        <h3 class="responseHeader">
                            <a href="Reservation.jsp">Error: The check-out date must be after the check-in date, please try again.</a>
                        </h3>
                    </div>
                <%
            }
            else {
                %>
                <div width="98%">
                    <form class="rand2" method='POST' action='ReservationSummary.jsp'>
                        <h1 class="formHeading">Reservation Summary </h1><br />
                        
                        <table>
                            <tr>
                                <tr>Booking Date: </tr>
                                <tr>
                                <% 
                                // Current booking date
                                // https://www.tutorialspoint.com/how-to-format-date-in-jsp
                                // Date must be formated with correct upper and lower case
                                Date dateToday = new Date();
                                SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
                                String bd = df.format(dateToday);
                                session.setAttribute("bookingDate", bd);
                                out.println(bd);
                                %>
                                </tr>
                            </tr>
                            <tr>|</tr>
                            <tr>
                                <tr> Check-In Date: </tr>
                                <tr>
                                <% 
                                session.setAttribute("CheckInDate", checkInDate);
                                out.print(checkInDate);
                                %>
                                </tr>
                            </tr>
                            <tr>|</tr>
                            <tr>
                                <tr> Check-out Date: </tr>
                                <tr>
                                <% 
                                session.setAttribute("CheckOutDate", checkOutDate); 
                                out.print(checkOutDate);
                                %>
                                </tr>
                            </tr>
                            <tr>|</tr>
                            <tr>
                                <tr> Number of Guests: </tr>
                                <tr>
                                <%
                                session.setAttribute("Guests", guestNum); 
                                out.print(guestNum);
                                %>
                                </tr>
                            </tr>
                            <tr>|</tr>
                            <tr>
                                <tr> Nights: </tr>
                                <tr>
                                <% 		
                                session.setAttribute("Nights", totalDays);
                                out.println(totalDays);
                                %>		
                                </tr>
                            </tr>
                            <br/><br/>
                            <hr/>
                        </table>
                        
                        <table align="left" style="margin-left:10%;">
                            <td style="font-size: 30px;">Details<br></br></td>
                            <tr>
                                <td>Destination:  </td>
                                <td>
                                <%
                                  
                                session.setAttribute("HotelId", hotelId); 
                                out.print(city);
                                %> 
                                </td>
                            </tr>
                            <tr>
                                <td>Room Size:  </td>
                                <td>
                                <%
                                session.setAttribute("RoomId", roomId); 
                                out.print(roomSize);	
                                %> 
                                </td>
                            </tr>
                            <tr>
                                <td>Points Earned:  </td>
                                <td>
                                <%
                                session.setAttribute("Points", pointsEarned);
                                out.print(pointsEarned);
                                %>
                                </td>
                            </tr>
                            <tr>
                                <td>Room Cost:  </td>
                                <td>
                                <%
                                session.setAttribute("CostPerNight", roomPrice);
                                out.print("$" + String.format("%.2f", roomPrice)); 
                                %>				
                                </td>
                            </tr> <br>
                            <tr>
                                <td><br></br><strong>Total Cost:  </strong></td>
                                <td><br></br><strong>
                                <%
                                    { 
                                    	session.setAttribute("grandTotal", grandTotal); 
                                        out.print("$" + String.format("%.2f", grandTotal));
                                    }

                                %>		
                                </strong></td>
                            </tr>
                            </table> 
                                
                            <table align="right" style="margin-right:10%;">
                         
                            <tr>
                           
                                <td>Wifi: </td>
                                <td>
                                <%
                                out.print(amenWifi);					
                                %>
                                </td>
                            </tr>
                            <tr>
                                <td>Breakfast:  </td>
                                <td>
                                <%
                                out.print(amenBreakfast);
                                %>
                                </td>
                            </tr>
                            <tr>
                                <td>Parking:  </td>
                                <td>
                                <%
                                session.setAttribute("Amenities", selectedAmenities); 
                                out.print(amenParking);					
                                %>
                                </td>
                            </tr>  
                            <tr>
                                <td>Amenities Cost:  </td>
                                <td>
                                <%
                                // Amenities will be true and added if selected
                                session.setAttribute("amenitiesPrice", amenitiesPrice);
                                out.print("$" + String.format("%.2f", amenitiesPrice)); 
                                %>			
                                </td>     
                            </tr>
                           
                            <p style="text-align:center">Amenities:</p>
 
                            <tr>
                                <td style="text-align:left;"></br>Guests Terms & Conditions:<br></br></td></tr>
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
                      
                               
                	<div class="center">
                    	<button style="margin-top:28%;" type='submit'>Confirm</button>
                    	<button style="margin-top:28%;" type='submit' id="cancel" formaction="Reservation.jsp">Cancel</button>
                	</div>
                </form>
                </div>
	        <%
		}
    }
}
%>
</body>
</html>