<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Create Table and Insert Data</title>
</head>
<body>
<%
            java.sql.Connection con = null;
            java.sql.Statement stmt = null;
            
            try{                
                Class.forName("com.mysql.cj.jdbc.Driver");
                String url = "jdbc:mysql://localhost:3306/module11?";
                
                con = java.sql.DriverManager.getConnection(url + "user=root&password=root");                
                stmt = con.createStatement();
            }
            catch(Exception e){
                out.println("<h1>Error connection to database.</h1>");
            }
            
            try{                
                stmt.executeUpdate("DROP TABLE Team");
                out.println("<b>Table Team Dropped</b><br />");
            }
            catch(java.sql.SQLException e){                
                out.println("<b>Table Team does not exist</b><br />");
            }
            
            try{
                stmt.executeUpdate("CREATE TABLE Team(id int NOT NULL AUTO_INCREMENT, city CHAR(20) NOT NULL, mascot CHAR(20) NOT NULL, manager CHAR(20) NOT NULL, stadium CHAR(20) NOT NULL, championships int NOT NULL, established int NOT NULL, pennants int NOT NULL, divisions int NOT NULL, PRIMARY KEY(id))");
                out.println("<b>Table Team Created</b><br />");
            }
            catch(java.sql.SQLException e){
                out.println("<b>Table Team Creation failed</b><br />");
            }
            
            try{
                stmt.executeUpdate("INSERT INTO Team(city, mascot, manager, stadium, championships, established, pennants, divisions)VALUES('San Diego', 'Padres', 'Bob Melvin', 'Petco Park', 0, 1969, 2, 5)");
                stmt.executeUpdate("INSERT INTO Team(city, mascot, manager, stadium, championships, established, pennants, divisions)VALUES('Los Angeles', 'Dodgers', 'Dave Roberts', 'Dodger Stadium', 7, 1958, 24, 20)");
                stmt.executeUpdate("INSERT INTO Team(city, mascot, manager, stadium, championships, established, pennants, divisions)VALUES('New York', 'Yankees', 'Aaron Boone', 'Yankee Stadium', 27, 1913, 40, 20)");
                stmt.executeUpdate("INSERT INTO Team(city, mascot, manager, stadium, championships, established, pennants, divisions)VALUES('Chicago', 'Cubs', 'David Ross', 'Wrigley Field', 3, 1903, 17, 8)");
                stmt.executeUpdate("INSERT INTO Team(city, mascot, manager, stadium, championships, established, pennants, divisions)VALUES('San Francisco', 'Giants', 'Gabe Kapler', 'Oracle Park', 8, 1958, 23, 9)");

                stmt.executeUpdate("COMMIT");
                
                out.println("<b>Team Data Inserted</b><br />");
            }
            catch(java.sql.SQLException e){
                out.println("<b>Error inserting data</b><br />");
            }
            
            try{
                stmt.close();
                con.close();
                out.println("<b>Database connection closed</b><br />");
            }
            catch(java.sql.SQLException e){
                out.println("<b>Database connection close failed</b><br />");
            }
        %>
 
</body>
</html>