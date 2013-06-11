package de.auctionhouse.controller;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;


import de.auctionhouse.model.User;

public class UserController {
	
	public UserController() {
	}
	
	
	public User findById(int _id) throws SQLException {
		
		Statement stmt = ConnectionController.sharedInstance().newStatement();
		ResultSet rs = stmt.executeQuery("SELECT * FROM users where id =" + _id);
		rs.next();
		
		return new User(rs);	
	}
	
	public User login(String _email, String _password) throws SQLException {
		
		Statement stmt = ConnectionController.sharedInstance().newStatement();
		ResultSet rs = stmt.executeQuery("SELECT * FROM users where email =" + _email);
		try {
			rs.next();
			
			User result = new User(rs);
			if (result.password == _password) {
				//session.setAttribute("id", result.id);
				
				return result;
			} else {
				return null;
			}
			
		} catch (SQLException e) {
			return null;
		}
	}
	
}
