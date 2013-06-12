package de.auctionhouse.controller;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Statement;

public class ConnectionController {
	private static ConnectionController sharedConnectionController;
	
	private Connection mConnection;
	
	private ConnectionController() throws SQLException {
		try {
			Class.forName("org.postgresql.Driver");
		} catch (ClassNotFoundException e) {
			System.out.println("<h1>Driver not found:" + e + e.getMessage() + "</h1>");
		}
		
		this.mConnection = DriverManager.getConnection("jdbc:postgresql:auctionhouse", "auctionhouse_root", "1234");
	}

	// Singleton
	public static ConnectionController sharedInstance() throws SQLException {
		if (sharedConnectionController == null) {
			sharedConnectionController = new ConnectionController();
		}
		return sharedConnectionController;
	}
	
	public Statement newStatement() throws SQLException {
		return this.mConnection.createStatement();
	}
	
	public PreparedStatement newPreparedStatement(String _statement) throws SQLException {
		return this.mConnection.prepareStatement(_statement);
	}
}
