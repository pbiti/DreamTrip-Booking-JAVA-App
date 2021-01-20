package net.javaguides.todoapp.web;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import static javax.swing.JOptionPane.showMessageDialog;
import javax.swing.*;



import net.javaguides.todoapp.dao.ImageDao;
import net.javaguides.todoapp.dao.UserDao;
import net.javaguides.todoapp.model.ProfileImage;
import net.javaguides.todoapp.model.User;


public class UserController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private UserDao userDao;

	public void init() {
		userDao = new UserDao();
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		register(request, response);
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		//response.sendRedirect("register/register.jsp");
		  response.sendRedirect("login.jsp");
	}

	private void register(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		String firstName = request.getParameter("firstname");
		String lastName = request.getParameter("lastname");
		String username = request.getParameter("username");
		String password = request.getParameter("password");

		User employee = new User();
		employee.setFirstName(firstName);
		employee.setLastName(lastName);
		employee.setUsername(username);
		employee.setPassword(password);
		int res = 0;
		try {
			int result = res = userDao.registerEmployee(employee);
			if(result == 1) {
				res = 1;
				request.setAttribute("NOTIFICATION", "User Registered Successfully!");
				HttpSession session=request.getSession();
				session.setAttribute("uname",username);
				session.setAttribute("fname", firstName);
				session.setAttribute("lname", lastName);
				
				File initialFile = new File("C:\\Users\\kseni\\Downloads\\default.jpg");
			    InputStream targetStream = new FileInputStream(initialFile);
					
				String sql = "update users set image = ? where username = ?";
				
				String myDriver = "org.gjt.mm.mysql.Driver";
		  	    String myUrl = "jdbc:mysql://localhost/wishlist";
		  	    Class.forName(myDriver);
		  	    Connection conn = DriverManager.getConnection(myUrl, "root", "ksql4321!");
	            PreparedStatement preparedStatement = conn.prepareStatement(sql);
	            preparedStatement.setBinaryStream(1, targetStream);
	            preparedStatement.setString(2, username);
	            preparedStatement.executeUpdate();
	            
	            ImageDao dao = new ImageDao();
	            
	            ProfileImage pi = dao.get(username);
	            
	            request.setAttribute("pi", pi);
			}else {
				
				RequestDispatcher dispatcher = request.getRequestDispatcher("login/main_alert.jsp");
				dispatcher.forward(request, response);
			}
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		if(res==1) {
			//RequestDispatcher dispatcher = request.getRequestDispatcher("register/register.jsp");
			/**/
			HttpSession session=request.getSession();
			session.setAttribute("uname",username);
			/**/
			RequestDispatcher dispatcher = request.getRequestDispatcher("login.jsp");
			dispatcher.forward(request, response);
			/*RequestDispatcher dp = request.getRequestDispatcher("Login");
			dp.forward(request, response);*/
		}
	}
}