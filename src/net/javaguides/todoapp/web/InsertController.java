package net.javaguides.todoapp.web;

import java.io.IOException;
import java.time.LocalDate;
import java.time.YearMonth;
import java.time.format.DateTimeFormatter;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.javaguides.todoapp.dao.TodoDao;
import net.javaguides.todoapp.dao.TodoDaoImpl;
import net.javaguides.todoapp.model.LoginBean;
import net.javaguides.todoapp.model.Todo;

import java.io.*;
import java.sql.*;

public class InsertController extends HttpServlet{
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
			insertTodo(request, response);
		}catch (SQLException ex) {
			throw new ServletException(ex);
		}		
	}
	
private void insertTodo(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException {
		
		String title = request.getParameter("title");
		/**/
		HttpSession session=request.getSession(false);
	    String username=(String)session.getAttribute("uname");
	    String fname=(String)session.getAttribute("fname");
	    String lname=(String)session.getAttribute("lname");
	    /**/
		String description = request.getParameter("description");
		//System.out.println(username);
		
		DateTimeFormatter df = DateTimeFormatter.ofPattern("yyyy-MM-dd");
		LocalDate targetDate = LocalDate.parse(request.getParameter("targetDate"),df);
		// ym = YearMonth.parse(request.getParameter("targetDate"), df);
		
		boolean isDone = Boolean.valueOf(request.getParameter("isDone"));
		Todo newTodo = new Todo(title, username, description, /*LocalDate.now()*/ targetDate, isDone);
		todoDAO.insertTodo(newTodo);
		response.sendRedirect("list");
	}

}
