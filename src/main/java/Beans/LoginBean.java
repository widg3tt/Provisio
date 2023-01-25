package Beans;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.security.*;
import javax.crypto.*;

public class LoginBean {
	
	public String checkLogin(String email, String password) {
		
		// Create variables for database connection
		String dbUser = "root";
		String dbPass = "Password";
		String dbURLandName = "jdbc:mysql://localhost:3306/Provisio";
		
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
		
		//initialize variables 
		Connection con = null;
		Statement stmt = null;
		ResultSet rs = null;
		String check = "";
        
		try{
			// Load DB Driver
			Class.forName("com.mysql.cj.jdbc.Driver");
			String url = dbURLandName + "?";
            
			// Add data into DB
			con = DriverManager.getConnection(url + "user=" + dbUser + "&" + "password=" + dbPass);             
			stmt = con.createStatement();  
			System.out.println("Connection Successful");
		}
		catch(Exception e){
			System.out.println("Error connecting to the database.");
			e.printStackTrace();
		}
    
		//Attempt to retrieve user data from the table
		try{ 
    	
			rs = stmt.executeQuery("SELECT Email FROM Users WHERE Email = '" + email + "'" +
			"AND Password = '" + passw + "'");
			if (rs.next()) {
				check = "loginSuccess";
			}
			else {
				check = "loginFail";
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
		return check;
	} 
}