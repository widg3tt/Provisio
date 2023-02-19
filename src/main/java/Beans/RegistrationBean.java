package Beans;


import java.sql.*;

public class RegistrationBean {
		
	public void setUser(String fName, String lName, String email, String password) {
		
		// Create variables for database connection
  		String dbUser = "root";
  		String dbPass = "Password";
  		String dbURLandName = "jdbc:mysql://localhost:3306/Provisio";
  		
 		
    	// Insert data
    	Connection con;
        Statement stmt ;
            
        try{
              Class.forName("com.mysql.jdbc.Driver");  
            
	con = DriverManager.getConnection(dbURLandName , dbUser, dbPass);             
	stmt = con.createStatement();  
          
                    stmt.execute("INSERT INTO Users(Email, FirstName, LastName, Password, LoyaltyPoints) VALUES ('"+ email + "','" + fName + "' ,'" + lName + "' , '" + password + "', 0)"); 
            
                    stmt.close();
                    con.close();
        }
        catch(    ClassNotFoundException | SQLException e){
            System.out.println(e.getMessage());
            
        }
        
        
	}
	
	public String[] getUser(String email) {
		
		// Create variables for database connection
  		String dbUser = "root";
  		String dbPass = "Password";
  		String dbURLandName = "jdbc:mysql://localhost:3306/Provisio";
  		
  		// Initialize variables 
  		String [] user = new String[2];
    	Connection con;
        Statement stmt;
        ResultSet userdata ;
       
            
        try{
           Class.forName("com.mysql.jdbc.Driver");  
            
            con = DriverManager.getConnection(dbURLandName , dbUser, dbPass);             
            stmt = con.createStatement();  
             userdata = stmt.executeQuery("SELECT * FROM Users WHERE Email = '" + email + "'");
            while (userdata.next()) {
            	user[0] = userdata.getString("FirstName");
            	user[1] = userdata.getString("LastName");
            }
            
            userdata.close();
            stmt.close();
            con.close();
                
        }
        catch(Exception e){
            System.out.println(e.getMessage());
           
        }
        
      
      
       
        return user;
	} 
	
	public String checkUser(String email) {
	
		// Create variables for database connection
		String dbUser = "root";
		String dbPass = "Password";
		String dbURLandName = "jdbc:mysql://localhost:3306/Provisio";
		
		// Initialize variables 
		Connection con ;
		Statement stmt ;
		ResultSet rs;
		String check ;
        
		try{
                    Class.forName("com.mysql.jdbc.Driver");  
            
            con = DriverManager.getConnection(dbURLandName , dbUser, dbPass);             
          	stmt = con.createStatement();  
                
                rs = stmt.executeQuery("SELECT Email FROM Users WHERE Email = '" + email + "'");
			if (rs.next()) {
				check = "taken";
			}
			else {
				check = "available";
                        }
				rs.close();
				stmt.close();
				con.close();
			
                        
		}
		catch(Exception e){
			check= e.getMessage();
			return check;
		}
    
		// User data from table
		
		
		return check;
	} 
}