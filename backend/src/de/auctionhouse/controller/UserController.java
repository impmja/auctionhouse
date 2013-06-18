package de.auctionhouse.controller;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;


import de.auctionhouse.model.User;

public class UserController {
	
	private static UserController sharedUserController;
	
	
	private UserController() {
	}
	
	// Singleton
	public static UserController sharedInstance() throws SQLException {
		if (sharedUserController == null) {
			sharedUserController = new UserController();
		}
		return sharedUserController;
	}
	
	public User findById(int _id) throws SQLException {
		
		Statement stmt = ConnectionController.sharedInstance().newStatement();
		ResultSet rs = stmt.executeQuery("SELECT * FROM Users WHERE id =" + _id);
		rs.next();
		
		return new User(rs);	
	}
	
	public User login(HttpServletRequest _request) throws SQLException {
		
		String email = _request.getParameter("email");
		String password = _request.getParameter("password");
				
		PreparedStatement stmt = ConnectionController.sharedInstance().newPreparedStatement("SELECT * FROM Users WHERE email = ?");
		stmt.setString(1, email);
		ResultSet rs = stmt.executeQuery();
		
		try {
			rs.next();
			
			User result = new User(rs);
			if (result.password.equalsIgnoreCase(password)) {
				HttpSession session = _request.getSession();
				session.setAttribute("userId", result.id);
				return result;
			} else {
				return null;
			}
			
		} catch (SQLException e) {
			return null;
		}
	}
	
	public boolean logout(HttpServletRequest _request) throws SQLException {
		User loggedIn = getLoggedIn(_request);
		if (loggedIn != null) {
			HttpSession session = _request.getSession();
			session.setAttribute("userId", null);
			return true;
		}
		return false;
	}
	
	public User getLoggedIn(HttpServletRequest _request) throws SQLException {
		HttpSession session = _request.getSession();
		Integer userId = (Integer) session.getAttribute("userId");
		if (userId != null) {
			return this.findById(userId);
		} 
		return null;
	}
}
