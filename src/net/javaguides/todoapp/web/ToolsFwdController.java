package net.javaguides.todoapp.web;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpServlet;

import net.javaguides.todoapp.dao.ImageDao;
import net.javaguides.todoapp.model.ProfileImage;

public class ToolsFwdController extends HttpServlet{
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		HttpSession session=request.getSession(false);
	    String username=(String)session.getAttribute("uname");
	    String fname=(String)session.getAttribute("fname");
	    String lname=(String)session.getAttribute("lname");
	    
	   
        try{
        	
            ImageDao dao = new ImageDao();
            
            ProfileImage pi = dao.get(username);
            
            request.setAttribute("pi", pi);
            
            RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/tools.jsp");
    		dispatcher.forward(request, response);
        } catch (Exception ex) {
            ex.printStackTrace();
        }
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request,response);
	}
}
