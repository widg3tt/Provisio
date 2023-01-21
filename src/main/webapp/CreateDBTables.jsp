<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@ page import="java.io.*" %>
<%@ page import="java.net.URL" %>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>

<html>
<head>
	<title>Create DB Tables</title>
	<meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="Content-Type" content="text/html">
</head>
<body>
	<a href="setup.html">Setup</a>
	<h1>Create DB Tables</h1>

	<%
	
		//used init param from XML file
		String dbName = application.getInitParameter("dbName");
		String dbUser = application.getInitParameter("dbUser");
		String dbPass = application.getInitParameter("dbPass");
		String dbURL = application.getInitParameter("dbURL");
		String dbURLandName = application.getInitParameter("dbURLandName");
			
     		
        // Tries to create the table if it does not exist
        Connection con = null;
        Statement stmt = null;
            
        try{
        	Class.forName("com.mysql.cj.jdbc.Driver");
            String url = dbURLandName + "?";
                
            con = DriverManager.getConnection(url + "user=" + dbUser + "&" + "password=" + dbPass);                 
            stmt = con.createStatement();
        }
        catch(Exception e){
            out.println("<h1>Error connecting to database.</h1>");
        }
            
        try{
            stmt.executeUpdate("DROP TABLE Amenities");
            out.println("<b>Table Amenities Dropped</b><br />");
            
        }
        catch(SQLException e){                
            out.println("<b>Table Amenities does not exist</b><br />");
        }
            
        try{
            String query = "CREATE TABLE Amenities(AmenityId int NOT NULL, Name varchar(255) NOT NULL, " +
                    "Cost double NOT NULL, ChargeRecurrence varchar(15) NOT NULL, PRIMARY KEY (AmenityId));";
            	
            stmt.executeUpdate(query);
            out.println("<b>Table Amenities Created</b><br />");
        }
        catch(SQLException e){
            out.println("<b>Table Amenities Creation failed</b><br />");
        }
        
        try{                
            stmt.executeUpdate("DROP TABLE Hotels");
            out.println("<b>Table Hotels Dropped</b><br />");
        }
        catch(SQLException e){                
            out.println("<b>Table Hotels does not exist</b><br />");
        }
        
        try{
            String query = "CREATE TABLE Hotels(HotelId int NOT NULL, HotelName varchar(30) NOT NULL, Address varchar(255) NOT NULL, " +
       				 "NumberOfRooms int NOT NULL, PhoneNumber varchar(15) NOT NULL, " + 
       				 		"PRIMARY KEY (HotelId));";
            	
            stmt.executeUpdate(query);
            out.println("<b>Table Hotels Created</b><br />");
        }
        catch(SQLException e){
            out.println("<b>Table Hotels Creation failed</b><br />");
        }
        
        try{                
            stmt.executeUpdate("DROP TABLE Rooms");
            out.println("<b>Table Rooms Dropped</b><br />");
        }
        catch(SQLException e){                
            out.println("<b>Table Rooms does not exist</b><br />");
        }
         
        try{
            String query1 = "CREATE TABLE Rooms(RoomId int NOT NULL, Size varchar(255) NOT NULL, NumberOfGuests int NOT NULL, " +
       				 "Price double NOT NULL, HotelId int NOT NULL, PRIMARY KEY (RoomId), FOREIGN KEY (HotelId) REFERENCES Hotels (HotelId));"; 
            	
            stmt.executeUpdate(query1);
            out.println("<b>Table Rooms Created</b><br />");
        }
        catch(SQLException e){
            out.println("<b>Table Rooms Creation failed</b><br />");
        }
        
        try{                
            stmt.executeUpdate("DROP TABLE Users");
            out.println("<b>Table Users Dropped</b><br />");
        }
        catch(SQLException e){                
            out.println("<b>Table Users does not exist</b><br />");
        }
            
        try{
            String query = "CREATE TABLE Users(UserId int NOT NULL AUTO_INCREMENT, Email varchar(255) NOT NULL, Password varchar(50) NOT NULL, " + 
                    "FirstName varchar(255) NOT NULL, LastName varchar(255) NOT NULL, LoyaltyPoints int NOT NULL, PRIMARY KEY (Email));";
            	
            stmt.executeUpdate(query);
            out.println("<b>Table Users Created</b><br />");
        }
        catch(SQLException e){
            out.println("<b>Table Users Creation failed</b><br />");
        }
            
        try{                
            stmt.executeUpdate("DROP TABLE Reservations");
            out.println("<b>Table Reservations Dropped</b><br />");
        }
        catch(SQLException e){                
            out.println("<b>Table Reservations does not exist</b><br />");
        }
            
        try{
            String query = "CREATE TABLE Reservations(ReservationId int NOT NULL AUTO_INCREMENT, " +
                    "CheckInDate DATE NOT NULL, CheckOutDate DATE NOT NULL, Points int NOT NULL, " +
            		"Guests int NOT NULL, Amenities varchar(255), Nights int NOT NULL, CostPerNight double NOT NULL, " +
            		"TotalCost double NOT NULL, HotelId int NOT NULL, Email varchar(255) NOT NULL, " +
            		"RoomId int NOT NULL, PRIMARY KEY (ReservationId), " +
                    "FOREIGN KEY (HotelId) REFERENCES Hotels (HotelId), " + 
                    "FOREIGN KEY (Email) REFERENCES Users (Email), " + 
                    "FOREIGN KEY (RoomId) REFERENCES Rooms (RoomId));";  
            	
            stmt.executeUpdate(query);
            out.println("<b>Table Reservations Created</b><br />");
        }
        catch(SQLException e){
            out.println("<b>Table Reservations Creation failed</b><br />");
        }
        try{
            stmt.close();
            con.close(); 
            out.println("<b>Database connections closed</b><br />");
        }
        catch(SQLException e){
            out.println("<b>Connection close failed</b><br />");
        }
        
        
    %>    
</body>
</html>