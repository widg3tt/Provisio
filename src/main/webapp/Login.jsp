<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="Beans.LoginBean"%>

<!DOCTYPE html>
<html lang="en">
<head>
	<title>Provisio - Login</title>
    <link href="provisio.css" type="text/css" rel="stylesheet"/>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="Content-Type" content="text/html">

</head>
<body>
<%@include file="nav.html" %> <!--Nav file-->
	<div id="container">
	
	   <%
        // Get values from parameters
        if(request.getMethod().equals("POST")){
        	try{
        		// Create new user 
                LoginBean newUser = new LoginBean();
                        			
                String email = request.getParameter("email"); 
                String password = request.getParameter("password"); 
               	
                String available = newUser.checkLogin(email, password);
                
                if (session.getAttribute("sessionID") == null || session.getAttribute("sessionID") == "") {
                	
                	// If fields are incorrect
                	if (available == "loginFail") {
                		%>
                		<div class="response"> <!--Error if login does not work-->
        					<h3 class="responseHeader">Error: Incorrect Username or Password</h3><br />
        					<a class="highlight" href="Login.jsp">Please Try Again</a>
        				</div>
        				<%
                	}
                
                	else if (available == "loginSuccess") { // Login success
                		session.setAttribute("sessionID", email);
                		String redirectURL = "LoyaltyPoints.jsp";
                	    response.sendRedirect(redirectURL);
                		%>	
                		<!-- <div class="response">
                			<h3 class="responseHeader">Login Successful</h3><br />
                			<a class="highlight" href="index.jsp">Go Home</a><br />
                		
                		</div> -->
                		<% 
                		}
        			}
                else {
                	%>	
            		<div class="response"> <!--Logged in already-->
            			<h3 class="responseHeader">You are already logged in</h3><br />
            			<a class="highlight" href="index.jsp">Go Home</a><br />
            		</div>
            		<% 
                }
        	}
        	
        	catch(Exception e){
        		e.printStackTrace();
        		%>
        		<div class="response"> <!--Error-->
        			<h3 class="responseHeader">Oops! Something went wrong.</h3><br />
        			<a class="highlight" href="Registration.jsp">Try Again</a>
        		</div>
        		<%
               }
        	}
        %>
         
        <% 
        	if(request.getMethod().equals("GET")){
        %>


		<form class="randl" method="post" action='Login.jsp'>
		<h1 class="formHeading">Login</h1><hr /><br /> 
		
			<table> <!--Table to take the information for login-->
				<tr>
					<td>Email: </td>
					<td><input class="formInput" name="email" type="text" min="0" maxlength="30" required="required"> </td>
				</tr>
				<tr>
					<td>Password: </td>
					<td><input class="formInput" name="password" type="password" min="0" maxlength="20" required="required"> </td>
				</tr>
			</table>
			<div class="center">
                	<button type='submit'>Login</button><br /> <!--Button for login-->
                	<a class="highlight" href="Registration.jsp">Register</a>
            </div>
		</form>
		<%
        	}
    	%>
		</div>
</body>
</html>