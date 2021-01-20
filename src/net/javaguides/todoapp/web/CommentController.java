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
import javax.servlet.*;
import javax.servlet.http.*;

import net.javaguides.todoapp.dao.ImageDao;
import net.javaguides.todoapp.dao.LoginDao;
import net.javaguides.todoapp.model.LoginBean;
import net.javaguides.todoapp.model.ProfileImage;

import java.time.format.DateTimeFormatter;  
import java.time.LocalDateTime;   

public class CommentController extends HttpServlet{
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
	    
	    String text = request.getParameter("text");
	    LocalDateTime date = LocalDateTime.now();  
	    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm");

        String formatDateTime = date.format(formatter);

		
		String url = "jdbc:mysql://localhost:3306/wishlist";
		String dbUser = "root";
		String dbPassword = "ksql4321!";
		System.out.println(username);
		System.out.println(text);
		System.out.println(formatDateTime);
		
		try {
			Class.forName("com.mysql.jdbc.Driver");
			Connection myConn = DriverManager.getConnection(url, dbUser, dbPassword); 
			Statement myStmt = myConn.createStatement();
			
			//ResultSet searchResult = myStmt.executeQuery("select * from items " + " where barcode='" + bc + "';");
			
			
				myStmt.executeUpdate("insert into comments " + " (username, text, date,first_name,last_name) " + " values('" + username + "', '" + text + "', '"
						+ formatDateTime + "', '" + fname + "', '" + lname + "');");
				
		ImageDao dao = new ImageDao();
	            
	    ProfileImage pi = dao.get(username);
	            
	    request.setAttribute("pi", pi);	
			
		}catch(Exception exc){
			exc.printStackTrace();
		}
		RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/tools.jsp");
		dispatcher.forward(request, response);
	}
}
