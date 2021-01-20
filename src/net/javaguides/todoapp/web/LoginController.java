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


public class LoginController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private LoginDao loginDao;

	public void init() {
		loginDao = new LoginDao();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request,response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {		
		authenticate(request, response);
	}

	private void authenticate(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		LoginBean loginBean = new LoginBean();
		loginBean.setUsername(username);
		loginBean.setPassword(password);

		try {
			
			String url = "jdbc:mysql://localhost:3306/wishlist";
			String dbUser = "root";
			String dbPassword = "ksql4321!";
			Class.forName("com.mysql.jdbc.Driver");
			Connection myConn = DriverManager.getConnection(url, dbUser, dbPassword); 
			Statement myStmt = myConn.createStatement();
			
			
			
			if (loginDao.validate(loginBean)) {
				//RequestDispatcher dispatcher = request.getRequestDispatcher("todo/todo-list.jsp");
				/**/
				ResultSet searchResult = myStmt.executeQuery("select first_name, last_name from users " + " where username='" + username + "';");
				searchResult.next();
				String fname = searchResult.getString("first_name");
				String lname = searchResult.getString("last_name");
				
				HttpSession session=request.getSession();
				session.setAttribute("uname",username);
				session.setAttribute("fname",fname);
				session.setAttribute("lname",lname);
				ImageDao dao = new ImageDao();
	            
	            ProfileImage pi = dao.get(username);
	            
	            request.setAttribute("pi", pi);
			   /**/
	            System.out.println("STO LOGIN CONTROLLER");
				RequestDispatcher dispatcher = request.getRequestDispatcher("login.jsp");
				dispatcher.forward(request, response);
			} else {
	            
				RequestDispatcher dispatcher = request.getRequestDispatcher("login/try.jsp");
				dispatcher.forward(request, response);
				//HttpSession session = request.getSession();
				// session.setAttribute("user", username);
				// response.sendRedirect("login.jsp");
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}

	}
}
