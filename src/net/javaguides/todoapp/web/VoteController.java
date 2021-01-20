package net.javaguides.todoapp.web;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.mysql.jdbc.PreparedStatement;

import javax.servlet.*;
import javax.servlet.http.*;

import net.javaguides.todoapp.dao.ImageDao;
import net.javaguides.todoapp.dao.LoginDao;
import net.javaguides.todoapp.model.LoginBean;
import net.javaguides.todoapp.model.ProfileImage;

import java.time.format.DateTimeFormatter;  
import java.time.LocalDateTime;   

public class VoteController extends HttpServlet{
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request, response);
		
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		HttpSession session=request.getSession(false);
	    String username=(String)session.getAttribute("uname");
	    String fname=(String)session.getAttribute("fname");
	    String lname=(String)session.getAttribute("lname");
	    
	    String text = request.getParameter("voting");
	    text = text.toUpperCase();
	    System.out.println(text);
	    int vote = 1;
	    
	    String url = "jdbc:mysql://localhost:3306/wishlist";
		String dbUser = "root";
		String dbPassword = "ksql4321!";
		
		try {
			Class.forName("com.mysql.jdbc.Driver");
			Connection myConn = DriverManager.getConnection(url, dbUser, dbPassword); 
			Statement myStmt = myConn.createStatement();
			Statement myStmt2 = myConn.createStatement();
			
			ResultSet searchResult = myStmt.executeQuery("select * from topdest " + " where city='" + text + "';");
			
			if(!searchResult.next()) {								
					myStmt.executeUpdate("insert into topdest " + " (city, votes,names) " + " values('" + text + "', '" + vote  +"', '"+ username +"');");
					
			}else {
				
				String names = searchResult.getString("names");
				if(names.contains(username)) {
					
					ImageDao dao = new ImageDao();
		            
		            ProfileImage pi = dao.get(username);
		            
		            request.setAttribute("pi", pi);
					
					RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/tools_denied.jsp");
					dispatcher.forward(request, response);
				}else {
					names = names + username;

					int votes = searchResult.getInt("votes");
					votes++;
					System.out.println(votes);
					/*myStmt.executeUpdate("update topdest set votes=" +votes+ "where city= " +"'" +text +"'"+ ";");*/
					  String myDriver = "org.gjt.mm.mysql.Driver";
				      String myUrl = "jdbc:mysql://localhost/wishlist";
				      Class.forName(myDriver);
				      Connection conn = DriverManager.getConnection(myUrl, "root", "ksql4321!");
				    
				      String query = "update topdest set votes = ?, names = ? where city = ?";
				      PreparedStatement preparedStmt = (PreparedStatement) conn.prepareStatement(query);
				      preparedStmt.setInt   (1, votes);
				      preparedStmt.setString(2, names);
				      preparedStmt.setString(3, text);
	
				      // execute the java preparedstatement
				      preparedStmt.executeUpdate();
				      
				      conn.close();
				      
				}
			}
			ImageDao dao = new ImageDao();
            
            ProfileImage pi = dao.get(username);
            
            request.setAttribute("pi", pi);
            
			RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/tools.jsp");
			dispatcher.forward(request, response);
			
		}catch(Exception exc){
			exc.printStackTrace();
		}
	}
}
