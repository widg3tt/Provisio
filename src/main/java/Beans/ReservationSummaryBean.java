package Beans;

import java.util.Date;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.sql.*;


public class ReservationSummaryBean {
	
	// Create variables for database connection
  		String dbUser = "root";
  		String dbPass = "Password";
  		String dbURLandName = "jdbc:mysql://localhost:3306/Provisio";
  		
	
	public String setCity(String city) {
		String cityLocation = "";
				
		if(city == "San Francisco")
		{
			cityLocation = "San Francisco";
		}
		else if(city == "Denver")
		{
			cityLocation = "Denver";
		}
		else
		{
			cityLocation = "Springfield";
		}
		
		return cityLocation;
	}
	
	// Nights between the dates 
	public int dayLength(String checkin, String checkout) throws ParseException {
		String dateIn = checkin;
		String dateOut = checkout;
		
		// Format for date
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	    
		Date inDate = sdf.parse(dateIn);
		Date outDate = sdf.parse(dateOut);
	   
	    
		// https://beginnersbook.com/2013/04/number-of-days-calculation-between-two-dates/
		long difference = outDate.getTime() - inDate.getTime();
		float daysBetween = (difference / (1000*60*60*24));
		
		// Remove decimal
		// https://www.codegrepper.com/code-examples/typescript/remove+decimal+from+double+java
		int days = (int) daysBetween;
		
		return days;
	}	
	
	public int pointsEarned(int totalDays)  {
		int pointsEarned = 150 * totalDays;
		return pointsEarned;
	}	
	
	// If there are amenities.
	public String amenities(String a) {
		String extra = "";
		
		if(a == null){
			extra = "No";
		} else {
			extra = "Yes";
		}
		
		return extra;
	}
	
	public int numbOfGuests(String guests) {
		int numbOfGuests = 0;
		if (guests.equalsIgnoreCase("1")) {
			numbOfGuests = 1;
		}
		else if (guests.equalsIgnoreCase("2")) {
			numbOfGuests = 2;
		}
		else if (guests.equalsIgnoreCase("3")) {
			numbOfGuests = 3;
		}
		else if (guests.equalsIgnoreCase("4")) {
			numbOfGuests = 4;
		}
		else if (guests.equalsIgnoreCase("5")) {
			numbOfGuests = 5;
		}
		return numbOfGuests;
	}
	
	// Amenities for the hotel
	public String selectedAmenities(String wifiSelected, String breakfastSelected, String parkingSelected) {
		String selectedAmenities = ""; 
		if (wifiSelected.equalsIgnoreCase("yes")) {
			selectedAmenities += " wifi ";
		}
		if (breakfastSelected.equalsIgnoreCase("yes")) {
			selectedAmenities += " breakfast ";
		}
		if (parkingSelected.equalsIgnoreCase("yes")) {
			selectedAmenities += " parking ";
		}
		return selectedAmenities;
	}
	
	// Amenities prices are added
	public double amenitiesPrice(String wifiSelected, String breakfastSelected, String parkingSelected, int totalDays) {
  		
  		// Insert data
    	Connection con = null;
        Statement stmt = null;
        ResultSet rsWifiCost = null;
        ResultSet rsbreakfastCost = null; 
        ResultSet rsparkingCost = null;  
        
        double amenitiesCost = 0.0;
            
        try{
             Class.forName("com.mysql.jdbc.Driver");  
            
            con = DriverManager.getConnection(dbURLandName , dbUser, dbPass);  stmt = con.createStatement();  
            System.out.println("Connection Successful");
        }
        catch(Exception e){
            System.out.println("Error connecting to the database.");
            e.printStackTrace();
        }
		
        
        try { // If amenities are selected
        	if (wifiSelected.equalsIgnoreCase("yes")) {
        		rsWifiCost = stmt.executeQuery("SELECT Cost FROM Amenities WHERE name = 'WI-FI'");
        			while(rsWifiCost.next()) {
        				double wifiCost = rsWifiCost.getDouble("Cost");
        				amenitiesCost = amenitiesCost + wifiCost;
        			}
        	}
        	
        	if (breakfastSelected.equalsIgnoreCase("yes")) {
        		rsbreakfastCost = stmt.executeQuery("SELECT Cost FROM Amenities WHERE name = 'Breakfast'");
                	while(rsbreakfastCost.next()) {
                		double breakfastCost = rsbreakfastCost.getDouble("Cost");
                		breakfastCost = breakfastCost * totalDays; 
                		amenitiesCost = amenitiesCost + breakfastCost;
                	}
            }
        	
        	if (parkingSelected.equalsIgnoreCase("yes")) {
        		rsparkingCost = stmt.executeQuery("SELECT Cost FROM Amenities WHERE name = 'Parking'");
                	while(rsparkingCost.next()) {
                		double parkingCost = rsparkingCost.getDouble("Cost");
                		parkingCost = parkingCost * totalDays; 
                		amenitiesCost = amenitiesCost + parkingCost;
                	}
            }
        }
        catch(SQLException e){ // Error message
			System.out.println("Error retrieving data");
			e.printStackTrace();
		}
		finally {
			try {
				stmt.close();
				con.close();
			}
			catch(SQLException e){
				System.out.println("Connection close failed");
				e.printStackTrace();
			}
		}
        amenitiesCost = round(amenitiesCost, 2);
		return amenitiesCost;
	}
	
	public double round(double value, int places) {
	    
	    BigDecimal bd = new BigDecimal(value).setScale(places, RoundingMode.HALF_UP);
	    double val2 = bd.doubleValue();
	    
	    return val2;
	}

	// Finds and returns cost of room
	public double getRoomPrice(int hotelId, String roomSize, int totalDays){
  		
    	Connection con ;
        Statement stmt ;
        
        ResultSet rsCity ;
        ResultSet rsRoom ;
        
        int cityId = 0;
        double roomCost=0.0 ;  
            
        try{
              Class.forName("com.mysql.jdbc.Driver");  
            
            con = DriverManager.getConnection(dbURLandName , dbUser, dbPass); 
            stmt = con.createStatement();  
       
        	
        	// Finds price per HotelID
        	rsRoom = stmt.executeQuery("SELECT Price FROM Rooms WHERE size = '" + roomSize + "' AND HotelID = '" + hotelId + "'");
        	if(rsRoom.next()) {
        		roomCost = rsRoom.getInt("Price")  * totalDays;
        		
        	}
               
                roomCost = round(roomCost, 2);
                
				rsRoom.close();
				stmt.close();
				con.close();
        }
        catch(Exception e){
            System.out.println(e.getMessage());
            
        }
        
      
        
		return roomCost;
	}
        
        // Finds and returns cost of room
        public double getRoomPrice2(int guests, int days){
            double roomCost = 0.0;
            if (guests == 1) {
                roomCost = 115.00;
            }
            else if (guests == 2) {
                roomCost = 115.00;
            }
            else {
                roomCost = 150.00;
            }
            double total = roomCost * days;
            double total2 = round(total, 2);
        return total2;
    }

	
	public double getGrandTotal(double amenities, double room) { // Total for the room and amenities
		double grandTotal = amenities + room;
		double val2 = round(grandTotal, 2);
		return val2;
	}
	
	public int getHotelId(String city) {
			
	    Connection con ;
	    Statement stmt ;
	        
	    ResultSet rsCity;
	        
	    int cityId = 0;
	            
	    try{
	      Class.forName("com.mysql.jdbc.Driver");  
            
            con = DriverManager.getConnection(dbURLandName , dbUser, dbPass); 
            stmt = con.createStatement();  
             rsCity = stmt.executeQuery("SELECT HotelId FROM Hotels WHERE Address LIKE '%" + city + "%'");
	        while(rsCity.next()) {
	        	cityId = rsCity.getInt("HotelId");
	        }
                
                rsCity.close();
				stmt.close();
				con.close();
	       
	    }
	    catch(Exception e){
	    	System.out.println(e.getMessage());
	        
	    }
	        
	   
	   
		return cityId;
	}
	
	public String getHotelName(int hotelId) { // Getting hotel name

		Connection con ;
		Statement stmt ;
						        
		ResultSet rs ;
						        
		String hotelName = "";
						            
		try{
			  Class.forName("com.mysql.jdbc.Driver");  
            
            con = DriverManager.getConnection(dbURLandName , dbUser, dbPass); stmt = con.createStatement();  
	rs = stmt.executeQuery("SELECT Address FROM Hotels WHERE HotelId = '" + hotelId + "'");
			if(rs.next()) {
				hotelName = rs.getString("Address");
			}
                        else
                        {
                            hotelName="Not Found";
                        }
            rs.close();
				stmt.close();
				con.close();
		}
		catch(Exception e){
			return e.getMessage();
		
		}
		
				
			
		return hotelName;
	}
	
	public int getroomId(int hotelId, String roomSize) {
		  		
		// Insert data
		Connection con ;
		Statement stmt ;
		        
		ResultSet rsRoom;
		        
		int roomId = 0;
		            
		try{
		    Class.forName("com.mysql.jdbc.Driver");  
            
            con = DriverManager.getConnection(dbURLandName , dbUser, dbPass);   
            stmt = con.createStatement();  
		    rsRoom = stmt.executeQuery("SELECT RoomId FROM Rooms WHERE Size = '" + roomSize + "' AND HotelID = '" + hotelId + "'");
		    while(rsRoom.next()) {
		    	roomId = rsRoom.getInt("RoomId");
		    }
                    rsRoom.close();
				stmt.close();
				con.close();
		}
		catch(Exception e){
			System.out.println(e.getMessage());
		   
		}
		        
		
		return roomId;
	}
	
	public String getRoomSize(int roomId) { // Getting room size

		Connection con;
		Statement stmt ;		        
		ResultSet rs;			        
		String roomSize = "";
				            
		try{
			  Class.forName("com.mysql.jdbc.Driver");  
            
            con = DriverManager.getConnection(dbURLandName , dbUser, dbPass); 
            stmt = con.createStatement();  
			rs = stmt.executeQuery("SELECT Size FROM Rooms WHERE RoomId = '" + roomId + "'");
			if(rs.next()) {
				roomSize = rs.getString("Size");
			}
                        rs.close();
				stmt.close();
				con.close();
		}
		catch(Exception e){
			return e.getMessage();
		}
				        
		
				
			
		return roomSize; // Outprint room size
	}

	public void setReservation(String bookDate, String arrive, String depart, int points, int guest, String amenities, int totalDays, double roomCost, double amenitiesCost, double totalCost, int hotelId, String email, int roomId) {
		
    	Connection con = null;
        Statement stmt = null;
            
        try{
             Class.forName("com.mysql.jdbc.Driver");  
            
            con = DriverManager.getConnection(dbURLandName , dbUser, dbPass); 
            stmt = con.createStatement();  
             stmt.execute("INSERT INTO Reservations(CheckInDate, CheckOutDate, Points, Guests, Amenities, Nights, CostPerNight, TotalCost, HotelID, Email, RoomID) VALUES ('" + arrive + "', '" + depart + "', '" + points + "', '" + guest + "', '" + amenities + "', '" + totalDays + "', '" + roomCost + "', '"   + totalCost + "', '" + hotelId + "', '" + email + "', '" + roomId + "')"); 
            stmt.close();
            con.close();
        }
        catch(Exception e){
            System.out.println(e.getMessage());
          
        }
        
       
        
       
	}
        
        public int getReservationCount(String email) // Reservations
        {
            Connection con ;
        Statement stmt ;
        ResultSet rsres ;
        
      
            int p=0;
        try{
            Class.forName("com.mysql.jdbc.Driver");  
            
            con = DriverManager.getConnection(dbURLandName , dbUser, dbPass); 
            stmt = con.createStatement();  
            
            rsres = stmt.executeQuery("SELECT * FROM Reservations WHERE Email = '" + email + "'"); 
            while(rsres.next())
            {
                p++;
            }
       
           
            rsres.close();
            stmt.close();
            con.close();
            return p;
        }
        catch(Exception e){
            
          return p;
        }
         
        }
	
	public String[][] getReservation(String email) { // Calculations for reservation summary page
		
    	Connection con ;
        Statement stmt ;
        ResultSet rsres ;
        
        String [][] reservation;
         int p=0;
         p = getReservationCount(email);
            reservation = new String[p][13];
           
        try{
            Class.forName("com.mysql.jdbc.Driver");  
            
            con = DriverManager.getConnection(dbURLandName , dbUser, dbPass); 
            stmt = con.createStatement();  
            
            rsres = stmt.executeQuery("SELECT * FROM Reservations WHERE Email = '" + email + "'"); 
            int i=0;
            
           
            while (rsres.next()) {
               
            	reservation[i][0] =  rsres.getString("ReservationId");
            	reservation[i][1] =  rsres.getString("CheckInDate");
            	reservation[i][2] = rsres.getString("CheckOutDate");
            	reservation[i][3] =  rsres.getString("Points");
            	reservation[i][4] =  rsres.getString("Guests");
            	reservation[i][5] = rsres.getString("Amenities");
            	reservation[i][6] =  rsres.getString("Nights");
            	reservation[i][7] =  rsres.getString("CostPerNight");
            	reservation[i][8] =   rsres.getString("TotalCost");
            	reservation[i][9] = getHotelName(rsres.getInt("HotelID"));
            	reservation[i][10] =  rsres.getString("Email");
            	reservation[i][11] = getRoomSize(rsres.getInt("RoomId"));
                reservation[i][12] = Integer.toString(rsres.getInt("TotalCost") - rsres.getInt("CostPerNight"));
                
                i ++;
            }
            rsres.close();
            stmt.close();
            con.close();
           
        }
        catch(Exception e){
            
         System.out.println(e.getMessage());
           
        }
        
       return reservation;
	}
	
	public void setLoyaltyPoints(int points, String email) { // Calculations for loyalty points page
		
    	Connection con = null;
        Statement stmt = null;
        ResultSet rs = null; 
        int currentLoyaltyPoints = 0;
            
        try{
             Class.forName("com.mysql.jdbc.Driver");  
            
            con = DriverManager.getConnection(dbURLandName , dbUser, dbPass);              
            stmt = con.createStatement();  
            System.out.println("Connection Successful");
        }
        catch(Exception e){
            System.out.println("Error connecting to the database.");
            e.printStackTrace();
        }
        
        try{
        	rs = stmt.executeQuery("SELECT LoyaltyPoints FROM Users WHERE Email = '" + email + "'");
		    while(rs.next()) {
		    	currentLoyaltyPoints = rs.getInt("LoyaltyPoints");
		    }
		    int newLoyaltypoints = currentLoyaltyPoints + points;
            stmt.execute("UPDATE Users SET LoyaltyPoints = '" + newLoyaltypoints + "' WHERE Email = '" + email + "'"); 
            System.out.println();  
        }
        catch(SQLException e){
            System.out.println("Error inserting data");
            e.printStackTrace();
            
        }
        
        try{
        	rs.close();
            stmt.close();
            con.close();
        }
        catch(SQLException e){
            System.out.println("Connection close failed");
            e.printStackTrace();
        }
	}
	
	public int getLoyaltyPoints(String email) {
		Connection con = null;
		Statement stmt = null;		        
		ResultSet rs = null;			        
		int lp = 0;  
				            
		try{
		  Class.forName("com.mysql.jdbc.Driver");  
            
            con = DriverManager.getConnection(dbURLandName , dbUser, dbPass); 
            stmt = con.createStatement();  
			rs = stmt.executeQuery("SELECT LoyaltyPoints FROM Users WHERE Email = '" + email + "'");
			while(rs.next()) {
				lp = rs.getInt("LoyaltyPoints");
			}
                        
                        rs.close();
				stmt.close();
				con.close();
		}
		catch(Exception e){
			System.out.println(e.getMessage());
			
		}
				        
		
		
		return lp; // Print 
	}
	
	public int getReservationId(int hotelId, String email, int roomId) throws SQLException { // Calculations for Reservation ID
		
		Connection con = null;
		Statement stmt = null;
		        
		ResultSet rs = null;
		        
		int reservationId = 0; 
		            
		try{
		     Class.forName("com.mysql.jdbc.Driver");  
            
            con = DriverManager.getConnection(dbURLandName , dbUser, dbPass); 
            stmt = con.createStatement();  
		    System.out.println("Connection Successful");
		}
		catch(Exception e){
			System.out.println("Error connecting to the database.");
		    e.printStackTrace();
		}
		        
		try {
			rs = stmt.executeQuery("SELECT ReservationId FROM Reservations WHERE HotelId = '" + hotelId + "' AND Email = '" + email + "' AND RoomId = '" + roomId + "'");
		    while(rs.next()) {
		    	reservationId = rs.getInt("ReservationId");
		    }
		}
		catch(SQLException e){
		    System.out.println("Error retrieving data");
			e.printStackTrace();
		}
		finally {
			try{
				rs.close();
				stmt.close();
				con.close();
			}
			catch(SQLException e){
				System.out.println("Connection close failed");
				e.printStackTrace();
			}
		}
		return reservationId; // Print ID
	}
        
        public String[] getReservationByID(String ID) {
		
    	Connection con;
        Statement stmt;
        ResultSet rsres;
        
        String [] reservation = new String[13];
            
        try{
            Class.forName("com.mysql.jdbc.Driver");  
            
            con = DriverManager.getConnection(dbURLandName , dbUser, dbPass); 
            stmt = con.createStatement();  
          
            rsres = stmt.executeQuery("SELECT * FROM Reservations WHERE ReservationId = " + ID ); 
           
           // rsres2 = stmt2.executeQuery("SELECT Address FROM Hotels WHERE HotelID = '2'"  ); 
           
            if (rsres.next()) {
            	BigDecimal r7 = rsres.getBigDecimal("CostPerNight");
            	r7.setScale(2, BigDecimal.ROUND_HALF_UP); // this does change bd
            	r7 = r7.setScale(2, BigDecimal.ROUND_HALF_UP);
            	BigDecimal r8 = rsres.getBigDecimal("TotalCost");
            	r8.setScale(2, BigDecimal.ROUND_HALF_UP); // this does change bd
            	r8 = r8.setScale(2, BigDecimal.ROUND_HALF_UP);
            	Double r12 = round(rsres.getDouble("TotalCost") - rsres.getDouble("CostPerNight"),2);
            	BigDecimal numBigDecimal = new BigDecimal(r12).setScale(2,BigDecimal.ROUND_HALF_UP);
                
               
             //  ResultSet rs2 = stmt2.executeQuery("SELECT * FROM Hotels WHERE HotelID=2");
            	reservation[0] =  rsres.getString("ReservationId");
            	reservation[1] =  rsres.getString("CheckInDate");
            	reservation[2] = rsres.getString("CheckOutDate");
            	reservation[3] =  rsres.getString("Points");
            	reservation[4] =  rsres.getString("Guests");
            	reservation[5] = rsres.getString("Amenities");
            	reservation[6] =  rsres.getString("Nights");
            	reservation[7] =  r7.toString();
            	reservation[8] =  r8.toString();
            	reservation[9] = getHotelName(rsres.getInt("HotelID"));
            	reservation[10] =  rsres.getString("Email");
            	reservation[11] = getRoomSize(rsres.getInt("RoomId"));
                reservation[12] = r12.toString();
                  
            }
           
          
            rsres.close();
            stmt.close();
          
            con.close();
           
        }
        catch(Exception e){
           reservation[9] =e.getMessage();
        }
        	
		return reservation;
	}
        
        
}