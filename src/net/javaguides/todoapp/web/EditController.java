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

public class EditController extends HttpServlet{
	private static final long serialVersionUID = 1L;
	private TodoDao todoDAO;

	public void init() {
		todoDAO = new TodoDaoImpl();
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		//String action = request.getServletPath();
		try {
			showEditForm(request, response);
			
		}catch (SQLException ex) {
			throw new ServletException(ex);
		}		
	}
	private void showEditForm(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, ServletException, IOException {
		
		HttpSession session=request.getSession(false);
	    String username=(String)session.getAttribute("uname");
	    String fname=(String)session.getAttribute("fname");
	    String lname=(String)session.getAttribute("lname");
		
		int id = Integer.parseInt(request.getParameter("id"));
		//System.out.println("ID IS:" + id);
		Todo existingTodo = todoDAO.selectTodo(id,username);
		
		
		ImageDao dao = new ImageDao();
        
        ProfileImage pi = dao.get(username);
        
        request.setAttribute("pi", pi);
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("/todo-form.jsp");
		
		request.setAttribute("todo", existingTodo);
		dispatcher.forward(request, response);
	}

}
