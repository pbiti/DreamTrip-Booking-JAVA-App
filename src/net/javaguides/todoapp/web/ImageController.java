package net.javaguides.todoapp.web;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
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
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.PreparedStatement;

import net.javaguides.todoapp.dao.ImageDao;
import net.javaguides.todoapp.model.ProfileImage;
import net.javaguides.todoapp.utils.DbConnect;

public class ImageController extends HttpServlet{
	
	protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, ClassNotFoundException {
		HttpSession session=request.getSession(false);
	    String username=(String)session.getAttribute("uname");
	    String fname=(String)session.getAttribute("fname");
	    String lname=(String)session.getAttribute("lname");
	    
        response.setContentType("text/html;charset=UTF-8");
        
        //Part CLASS gets the file to read from the SERVLET with the name given to the file(index.html)
        Part p = request.getPart("myFile");
        
        //WE assign a string to get the name(user doesn't give it we might set it ourselves or someone other.)
        String filename = p.getSubmittedFileName();
          
        System.out.println("FILENAME: " + filename);
        String sql = "update users set image = ? where username = ?";
        try{
        	String myDriver = "com.mysql.jdbc.Driver";
	  	    String myUrl = "jdbc:mysql://localhost/wishlist";
	  	    Class.forName(myDriver);
	  	    Connection conn = DriverManager.getConnection(myUrl, "root", "ksql4321!");
            PreparedStatement preparedStatement = conn.prepareStatement(sql);
            preparedStatement.setBinaryStream(1, p.getInputStream());
            preparedStatement.setString(2, username);
            preparedStatement.executeUpdate();
            
            ImageDao dao = new ImageDao();
            
            ProfileImage pi = dao.get(username);
            
            request.setAttribute("pi", pi);

        } catch (Exception ex) {
            ex.printStackTrace();
        }

        RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/login.jsp");
		dispatcher.forward(request, response);
    }
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
			processRequest(request, response);
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (ServletException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    }
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }

}
