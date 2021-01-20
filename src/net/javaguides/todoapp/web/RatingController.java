package net.javaguides.todoapp.web;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.javaguides.todoapp.dao.ImageDao;
import net.javaguides.todoapp.model.ProfileImage;

import javax.servlet.*;
import javax.servlet.http.*;

public class RatingController extends HttpServlet{
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request,response);
	}
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		/****Get username*****/
		HttpSession session=request.getSession(false);
	    String username=(String)session.getAttribute("uname");
	    String fname=(String)session.getAttribute("fname");
	    String lname=(String)session.getAttribute("lname");
		/**************************/
	    
	    String rating = request.getParameter("rating");
	    String review = request.getParameter("description");
	    
	    String url = "jdbc:mysql://localhost:3306/wishlist";
		String dbUser = "root";
		String dbPassword = "ksql4321!";
		
		try {
			Class.forName("com.mysql.jdbc.Driver");
			Connection myConn = DriverManager.getConnection(url, dbUser, dbPassword); 
			Statement myStmt = myConn.createStatement();
			
			//ResultSet searchResult = myStmt.executeQuery("select * from items " + " where barcode='" + bc + "';");
			
			
				myStmt.executeUpdate("insert into reviews " + "(rating, username, review)"+ " values('" + rating + "', '" + username + "', '"
						+ review +"');");
				
				ImageDao dao = new ImageDao();
	            
	            ProfileImage pi = dao.get(username);
	            
	            request.setAttribute("pi", pi);
				
				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/login.jsp");
				dispatcher.forward(request, response);
			
			
		}catch(Exception exc){
			exc.printStackTrace();
		}
	}

}
