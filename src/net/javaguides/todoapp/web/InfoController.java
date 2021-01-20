package net.javaguides.todoapp.web;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
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

import com.mysql.jdbc.PreparedStatement;

import javax.servlet.*;
import javax.servlet.http.*;

import net.javaguides.todoapp.dao.ImageDao;
import net.javaguides.todoapp.dao.LoginDao;
import net.javaguides.todoapp.model.LoginBean;
import net.javaguides.todoapp.model.ProfileImage;

public class InfoController extends HttpServlet{
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

		String url = "jdbc:mysql://localhost:3306/wishlist";
		String dbUser = "root";
		String dbPassword = "ksql4321!";
		System.out.println(username);
		
		String origin = request.getParameter("origin");
		String destination = request.getParameter("destination");
		String price = request.getParameter("price");
		String departure = request.getParameter("departure");
		String ret = request.getParameter("ret");
		String carrier_phgaine = request.getParameter("carrier_phgaine");
		String carrier_ela = request.getParameter("carrier_ela");
		String air_depart_1 = request.getParameter("air_depart_1");
		String air_depart_2 = request.getParameter("air_depart_2");
		String air_arrive_1 = request.getParameter("air_arrive_1");
		String air_arrive_2 = request.getParameter("air_arrive_2");
		String hotel_name = request.getParameter("hotel_name");
		String hotel_address = request.getParameter("hotel_address");
		String checkin = request.getParameter("checkin");
		String checkout = request.getParameter("checkout");
		
		System.out.println(hotel_name);
		
		
		try {
			Class.forName("com.mysql.jdbc.Driver");
			Connection myConn = DriverManager.getConnection(url, dbUser, dbPassword); 
			Statement myStmt = myConn.createStatement();
			
			
			String query = "insert into trips set username = ?, origin = ?, destination=?, price=?, departure=?, ret=?, carrier_phgaine=?, "
					+ "carrier_ela=?, air_depart_1=?, air_depart_2=?, air_arrive_1=?, air_arrive_2=?, hotel_name=?, hotel_address=?,"
					+ "checkin=?, checkout=?";
		      PreparedStatement preparedStmt = (PreparedStatement) myConn.prepareStatement(query);
		      preparedStmt.setString   (1, username);
		      preparedStmt.setString(2, origin);
		      preparedStmt.setString(3, destination);
		      preparedStmt.setFloat(4, Float.parseFloat(price));
		      preparedStmt.setString(5, departure);
		      preparedStmt.setString(6, ret);
		      preparedStmt.setString(7, carrier_phgaine);
		      preparedStmt.setString(8, carrier_ela);
		      preparedStmt.setString(9, air_depart_1);
		      preparedStmt.setString(10, air_depart_2);
		      preparedStmt.setString(11, air_arrive_1);
		      preparedStmt.setString(12, air_arrive_2);
		      preparedStmt.setString(13, hotel_name);
		      preparedStmt.setString(14, hotel_address);
		      preparedStmt.setString(15, checkin);
		      preparedStmt.setString(16, checkout);
		     

		      // execute the java preparedstatement
		      preparedStmt.executeUpdate();
		      
		      myConn.close();
			
			
			
									
				/*myStmt.executeUpdate("insert into trips "  + " values('" + username + "', '" + origin + "', '"
						+ destination +  "', '" + price +  "', '" + departure +  "', '" + ret +  "', '" + carrier_phgaine +  "', '" + carrier_ela +  "', '" + air_depart_1 +  "', '" + air_depart_2 +  "', '" + air_arrive_1 +  "', '" + air_arrive_2 +  "', '" + hotel_name +  "', '" + hotel_address +  "', '" + checkin +  "', '" + checkout +  "');");*/
				
		      ImageDao dao = new ImageDao();
	            
	          ProfileImage pi = dao.get(username);
	            
	          request.setAttribute("pi", pi);
		      
		      
		      RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/ViewTrips.jsp");
			  dispatcher.forward(request, response);
			
			
		}catch(Exception exc){
			exc.printStackTrace();
		}
	}
}
