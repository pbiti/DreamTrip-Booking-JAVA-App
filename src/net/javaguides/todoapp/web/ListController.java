package net.javaguides.todoapp.web;

import java.io.IOException;
import java.time.LocalDate;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.javaguides.todoapp.dao.ImageDao;
import net.javaguides.todoapp.dao.TodoDao;
import net.javaguides.todoapp.dao.TodoDaoImpl;
import net.javaguides.todoapp.model.ProfileImage;
import net.javaguides.todoapp.model.Todo;

import java.io.*;
import java.sql.*;

public class ListController extends HttpServlet{
	private static final long serialVersionUID = 1L;
	private TodoDao todoDAO;

	public void init() {
		todoDAO = new TodoDaoImpl();
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		System.out.println("IN MODIFY SERVLET BUT LIST POST");
		doGet(request, response);
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String action = request.getServletPath();
		System.out.println("IN MODIFY SERVLET BUT LIST GET");
		System.out.println("ACTION: " + action);
		try {
			listTodo(request, response);
		}catch (SQLException ex) {
			throw new ServletException(ex);
		}		
	}
	private void listTodo(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, IOException, ServletException {
		/**/
		HttpSession session=request.getSession(false);
	    String username=(String)session.getAttribute("uname");
	    String fname=(String)session.getAttribute("fname");
	    String lname=(String)session.getAttribute("lname");
	    /**/
	    //System.out.println("USERNAME FROM LIST: " + username);
	    /*Todo todo = new Todo(Long.parseLong(request.getParameter("id")), 
	    		(String)request.getParameter("title"), username, 
	    		(String)request.getParameter("description"),
	    		LocalDate.parse(request.getParameter("targetDate")), 
	    		Boolean.parseBoolean(request.getParameter("isDone")));*/
	    
		List<Todo> listTodo = todoDAO.selectTodoByuname(username);
		request.setAttribute("listTodo", listTodo);
		
		 try{
	        	
	            ImageDao dao = new ImageDao();
	            
	            ProfileImage pi = dao.get(username);
	            
	            request.setAttribute("pi", pi);

	        } catch (Exception ex) {
	            ex.printStackTrace();
	        }
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("/todo-list.jsp");
		dispatcher.forward(request, response);
	}
}
