package de.auctionhouse.controller;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;

public class ConnectionController {
	private static ConnectionController gConnectionController;
	
	private Connection mConnection;
	
	public ConnectionController() throws SQLException {
		try {
			Class.forName("org.postgresql.Driver");
		} catch (ClassNotFoundException e) {
			System.out.println("<h1>Driver not found:" + e + e.getMessage() + "</h1>");
		}
		
		this.mConnection = DriverManager.getConnection("jdbc:postgresql:auctionhouse", "auctionhouse_root", "1234");
	}

	// Singleton
	public static ConnectionController sharedInstance() throws SQLException {
		if (gConnectionController == null) {
			gConnectionController = new ConnectionController();
		}
		return gConnectionController;
	}
	
	public Statement newStatement() throws SQLException {
		return this.mConnection.createStatement();
	}
}
