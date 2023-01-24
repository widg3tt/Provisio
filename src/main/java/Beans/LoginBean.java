package Beans;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.security.*;
import javax.crypto.*;

public class LoginBean {
	
	private static String algorithm = "DESede";
    private static Key key = null;
    private static Cipher cipher = null;
    
    private static String decrypt(byte[] encryptionBytes)throws Exception {
        cipher.init(Cipher.DECRYPT_MODE, key);
        byte[] recoveredBytes =  cipher.doFinal(encryptionBytes);
        String recovered =  new String(recoveredBytes);
        return recovered;
      }
	
	public String checkLogin(String email, String password) throws Exception {
		
		// Create variables for database connection
		String dbUser = "root";
		String dbPass = "Password";
		String dbURLandName = "jdbc:mysql://localhost:3306/Provisio";
		
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
			"AND Password = '" + password + "'");
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