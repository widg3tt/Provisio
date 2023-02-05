 <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
	<head>
		<title>Provisio - Reservation</title>
    	<link href="provisio.css" type="text/css" rel="stylesheet"/>
    	<meta charset="UTF-8">
    	<meta name="viewport" content="width=device-width, initial-scale=1.0">
    	<meta http-equiv="Content-Type" content="text/html">  
        </head>
	<body>
	<%@include file="nav.html" %>
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
        	if (session.getAttribute("ReservationId") != null) {
        		session.removeAttribute("ReservationId");
        		session.removeAttribute("CheckInDate");
        		session.removeAttribute("CheckOutDate");
        		session.removeAttribute("HotelId");
        		session.removeAttribute("RoomId");
        		session.removeAttribute("Points");
        		session.removeAttribute("Guests");
        		session.removeAttribute("Amenities");
        		session.removeAttribute("Nights");
        		session.removeAttribute("CostPerNight");
        		session.removeAttribute("TotalCost");
        	}
            %>
            
                <div width="98%">
                    <form class="Reservation" method='GET' action='ReservationSummary.jsp'>   
                        <h1 class="formHeading">Book Your Trip Today!</h1><br />
                            <fieldset style="background-color:  #F7E3B4;">
                                <legend>Details</legend>
                                <div class="boxes">
                                    <p>
                                        <label>Destination<br />
                                            <select name="City">
                                                <option value="Denver">Denver</option>
                                                <option value="San Francisco">San Francisco</option>
                                                <option value="Springfield">Springfield</option>
                                            </select>
                                        </label>
                                    </p>
                                    <p>
                                        <label>Room Size<br />
                                              <select name="RoomSize">
                                                <option value="Double Full Room">Two Twin Beds</option>
                                                <option value="Queen Room">One Queen Bed</option>
                                                <option value="Double Queen Room">Two Queen Beds</option>
                                                <option value="King Room">One King Bed</option>
                                            </select>
                                        </label>
                                    </p>
                                    <p>
                                        <label>Number of Guests<br />
                                            <select name="Guests">
                                                <option value=1>1 - $115.00/night </option>
                                                <option value=2>2 - $115.00/night</option>
                                                <option value=3>3 - $150.00/night</option>
                                                <option value=4>4 - $150.00/night</option>
                                                <option value=5>5 - $150.00/night</option>
                                            </select>
                                        </label>
                                    </p>
                                </div>
                                <div id="drwho">
                                <div class="boxes">
                                    
                                    <p>
                                        <label>Check-in Date:<input id="CheckInField" type="date" min="1899-01-01" max="2023-12-01" name="CheckIn" required="required"></label>
                                    
                                        <label>Check-out Date:<input id="CheckOutField" type="date" name="CheckOut" required="required"></label>
                                    </p>
                                    <script>
                                        var today = new Date();
                                        var dd = today.getDate();
                                        var ddd = today.getDate() + 1;
                                        var mm = today.getMonth() + 1; //January is 0!
                                        var yyyy = today.getFullYear();
                                        if (dd < 10) {
                                        dd = '0' + dd;
                                        }
                                        if (mm < 10) {
                                        mm = '0' + mm;
                                        } 
                                                
                                        today = yyyy + '-' + mm + '-' + dd;
                                        nextDay = yyyy + '-' + mm + '-' + ddd;
                                        document.getElementById("CheckInField").setAttribute("min", today);
                                        document.getElementById("CheckOutField").setAttribute("min", nextDay);
                                    </script>
                                    
                                    <br/><br/>
                                 
                                    <p>
                                        <label>Amenities<br />
                                            <input type="checkbox" id="Wifi" name="Wifi" value="Wifi">
                                            <label for="vehicle1"> Purchase Wi-Fi for $12.99?</label><br>
                                            <input type="checkbox" id="Breakfast" name="Breakfast" value="Breakfast">
                                            <label for="vehicle2"> Purchase Breakfast for $8.99 per night?</label><br>
                                            <input type="checkbox" id="Parking" name="Parking" value="Parking">
                                            <label for="vehicle3"> Purchase Parking for $19.99 per night?</label>
                                            </select>
                                        </label>
                                    </p>
                                    
                                </div>
                                
                                </div>
                                <div style="float:right;margin-right:2%;margin-top:7%;">
                                <button type='submit' class="button11">Book</button><br />
                                </div>
                            </fieldset>
                    </form>  
                </div>
            <%
        }
        %>
    </body>
</html>