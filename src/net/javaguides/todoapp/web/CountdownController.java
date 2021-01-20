package net.javaguides.todoapp.web;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.javaguides.todoapp.dao.ImageDao;
import net.javaguides.todoapp.model.ProfileImage;

public class CountdownController extends HttpServlet{
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
   
		try {
			 ImageDao dao = new ImageDao();
		        
		    ProfileImage pi;
			pi = dao.get(username);
			request.setAttribute("pi", pi);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        
        
	}
}
