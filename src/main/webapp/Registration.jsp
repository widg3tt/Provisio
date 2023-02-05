<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="Beans.RegistrationBean"%>
<%@ page import="java.security.*, Beans.*" %>

<!DOCTYPE html>
<html lang="en">
	<head>
		<title>Provisio - Register</title>
    	<link href="provisio.css" type="text/css" rel="stylesheet"/>
    	<meta charset="UTF-8">
    	<meta name="viewport" content="width=device-width, initial-scale=1.0">
    	<meta http-equiv="Content-Type" content="text/html">

	</head>
	<body>
	<%@include file="nav.html" %>
		<div id="container">
        <%
        // Get parameters
        if(request.getMethod().equals("POST")){
        	try{
        		// Create new user 
                RegistrationBean newUser = new RegistrationBean();
                        			
                String fName = request.getParameter("fName"); 
                String lName = request.getParameter("lName"); 
                String email = request.getParameter("email"); 
                String password = request.getParameter("password");
                
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
               	
                String available = newUser.checkUser(email);
        
                    
                    
                if (available == "taken") {
                	%>
                	<div class="response">
        				<h3 class="responseHeader">That email is already in use</h3><br />
        				<a class="highlight" href="Registration.jsp">Try Again</a>
        			</div>
        			<%
                }
                
                else if (available == "available") {

                	newUser.setUser(fName, lName, email, passw);
                      
                    String [] user = newUser.getUser(email);
                    
                	%>	
                	<div class="response">
                		<h3 class="responseHeader">Congratulations<%=" " + user[0] + " " + user[1] + " "%> your account was created successfully!</h3><br />
                	    <a class="highlight" href="Login.jsp">Login</a>
                	</div>
                	<% 
                	}
        		}
        		catch(Exception e){
        			e.printStackTrace();
        			%>
        			<div class="response">
        				<h3 class="responseHeader">Oops! Something went wrong.</h3><br />
        				<a class="highlight" href="Registration.jsp">
                                            <%= e.getMessage()%>
                                        </a>
        			</div>
        			<%
                }
        	}
        	if(request.getMethod().equals("GET")){
        %>

        <form class="randl" method='post' action='Registration.jsp'>   
                <h1 class="formHeading">Register</h1> <hr /><br />
                
                	<table>
                		<tr>
                			<td>First Name:</td>
                			<td><input class="formInput" name="fName" type="text" min="0" maxlength="15" required="required"> </td>
                		</tr>
                		<tr>
                			<td>Last Name:</td>
                			<td><input class="formInput" name="lName" type="text" min="0" maxlength="15" required="required"> </td>
                		</tr>
                   		<tr>
                			<td>Email:</td>
                			<td><input class="formInput" name="email" type="text" min="0" maxlength="30" required="required"> </td>
                		</tr>
                		<tr>
                			<td>Password:</td>
                			<td><input class="formInput" name="password" type="password" min="0" maxlength="20" pattern="(?=.*[a-z])(?=.*[A-Z]).{8,}" title="Must contain at least one number and one uppercase and lowercase letter, and at least 8 or more characters" required="required"> </td>
                		</tr>
                    </table>
            	<div class="center">
                	<button type='submit'>Register</button><br />  
                	<a class="highlight" href="Login.jsp">Login</a>
                	<div id="message">
  						<p>Password must contain the following:</p>
  						<p id="letter" class="invalid">A <b>lowercase</b> letter</p>
  						<p id="capital" class="invalid">A <b>capital (uppercase)</b> letter</p>
 					    <p id="length" class="invalid">Minimum <b>8 characters</b></p>
 					</div>
            	</div>
    	</form>
    	<%
        }
    	%>
		</div>
	</body>
</html>