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

import antlr.collections.impl.BitSet;
import net.javaguides.todoapp.utils.JDBCUtils;

import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

import net.javaguides.todoapp.dao.ImageDao;
import net.javaguides.todoapp.model.ProfileImage;
import net.javaguides.todoapp.model.Todo;
import net.javaguides.todoapp.utils.JDBCUtils;

public class SaveController extends HttpServlet{
	
	private static final String INSERT_TODOS_SQL = "INSERT INTO todos"
			+ "  (title, username, description, target_date,  is_done) VALUES " + " (?, ?, ?, ?, ?);";
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request,response);
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		HttpSession session=request.getSession(false);
	    String username=(String)session.getAttribute("uname");
	    String fname=(String)session.getAttribute("fname");
	    String lname=(String)session.getAttribute("lname");
	    
	    String origin = request.getParameter("origin2");
	    String destination = request.getParameter("destination2");
	    String ret = request.getParameter("return2");
	    String departure = request.getParameter("departure2");
	    String name = request.getParameter("hotel_name2");
	    String price = request.getParameter("price2");
	    String nights = request.getParameter("nights2");
	    
	    System.out.println("DEP DATE:" + departure);
	    
	    departure = departure.substring(0, 10);
	 
	    
	    String title = origin + " - " + destination;
	    String des = name + " for " + nights + " nights :" + price + ".";
	    
	    System.out.println("DESCRIPTION:" + des);
	    
	    boolean isdone = false;
	    
	    String url = "jdbc:mysql://localhost:3306/wishlist";
		String dbUser = "root";
		String dbPassword = "ksql4321!";
		
		
			try (Connection connection = JDBCUtils.getConnection();
					PreparedStatement preparedStatement = connection.prepareStatement(INSERT_TODOS_SQL)) {
				preparedStatement.setString(1, title);
				preparedStatement.setString(2, username);
				preparedStatement.setString(3, des);
				preparedStatement.setDate(4, JDBCUtils.getSQLDate(LocalDate.parse(departure)));
				preparedStatement.setBoolean(5, false);
				System.out.println(preparedStatement);
				preparedStatement.executeUpdate();
				
				ImageDao dao = new ImageDao();
	            
	            ProfileImage pi = dao.get(username);
	            
	            request.setAttribute("pi", pi);
				
				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/login.jsp");
				dispatcher.forward(request, response);
			} catch (SQLException exception) {
				JDBCUtils.printSQLException(exception);
			}
			
			
	}
}
