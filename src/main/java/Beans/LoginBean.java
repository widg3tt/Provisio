package Beans;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.security.*;

public class LoginBean {
	
	public String checkLogin(String email, String password) {
		
		// Create variables for database connection
  		String dbUser = "root";
  		String dbPass = "Password";
  		String dbURLandName = "jdbc:mysql://localhost:3306/Provisio";
  		
  		// Initialize
  
        
                     
          
		
		// MD5 hash password encryption
        String algorithm="";
        byte[] unencodedPassword = password.getBytes();
        MessageDigest md = null;
        try {
        md = MessageDigest.getInstance("MD5");
        } catch (Exception e) {}
        md.reset();
        md.update(unencodedPassword);
        byte[] encodedPassword = md.digest();
        StringBuffer buf = new StringBuffer();
        for (int i = 0; i < encodedPassword.length; i++) {
        if (((int) encodedPassword[i] & 0xff) < 0x10) {
        buf.append("0");
        }
        buf.append(Long.toString((int) encodedPassword[i] & 0xff, 16));
        }
        String passw=buf.toString();
		
		// Initialize variables 
		Connection con = null;
		Statement stmt = null;
		ResultSet rs = null;
		String check = "";
        
		try{
			// Load DB Driver
			  Class.forName("com.mysql.jdbc.Driver");  
            
            con = DriverManager.getConnection(dbURLandName , dbUser, dbPass); 
            stmt = con.createStatement();  
			rs = stmt.executeQuery("SELECT Email FROM Users WHERE Email = '" + email + "'" +
			"AND Password = '" + passw + "'");
			if (rs.next()) {
				check = "loginSuccess";
			}
			else {
				check = "loginFail";
			}
            rs.close();
				stmt.close();
				con.close();
		}
		catch(Exception e){
			System.out.println(e.getMessage());
			
		}
    
		//Attempt to retrieve user data from the table
		
		
		return check;
	} 
}