package Beans;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class DataManager {
	
	public Connection createConnection() { 
		
		// Create variables for database connection
  		String dbUser = "root";
  		String dbPass = "Password";
  		String dbURLandName = "jdbc:mysql://localhost:3306/Provisio";
  		
  		// Tries to insert data into the table 
    	Connection con = null;
       
        try{
            Class.forName("com.mysql.cj.jdbc.Driver");
            String url = dbURLandName + "?";
            con = DriverManager.getConnection(url + "user=" + dbUser + "&" + "Password=" + dbPass);             
            System.out.println("Connection Successful");
        }
        catch(Exception e){
            System.out.println("Error connecting to the database.");
            e.printStackTrace();
        }
		
		return con;
	}
}