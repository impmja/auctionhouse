package de.auctionhouse.controller;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

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
	
	public User login(String _email, String _password) throws SQLException {
		
		PreparedStatement stmt = ConnectionController.sharedInstance().newPreparedStatement("SELECT * FROM Users WHERE email = ?");
		stmt.setString(1, _email);
		ResultSet rs = stmt.executeQuery();
		
		try {
			rs.next();
			
			User result = new User(rs);
			if (result.password.equalsIgnoreCase(_password)) {
				return result;
			} else {
				return null;
			}
			
		} catch (SQLException e) {
			return null;
		}
	}
	
}
