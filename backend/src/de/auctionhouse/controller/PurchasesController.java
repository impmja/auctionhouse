package de.auctionhouse.controller;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import de.auctionhouse.model.Bid;
import de.auctionhouse.model.Purchase;
import de.auctionhouse.model.User;
import de.auctionhouse.utils.DBUtils;

public class PurchasesController {
	private static PurchasesController sharedPurchasesController;
	
	private PurchasesController() {
	}
	
	// Singleton
	public static PurchasesController sharedInstance() {
		if (sharedPurchasesController == null) {
			sharedPurchasesController = new PurchasesController();
		}
		return sharedPurchasesController;
	}
	
	public Purchase findByArticleId(int _articleId) throws SQLException {
		
		Statement stmt = ConnectionController.sharedInstance().newStatement();
		
		ResultSet rs = stmt.executeQuery("SELECT p.id, p.user_id AS user_id, p.article_id AS article_id, p.price, p.purchase_date, u.first_name, u.last_name " +
				"FROM Purchases AS p " +
				"LEFT JOIN Users AS u ON p.user_id = u.id " +
				"LEFT JOIN Article AS a ON p.article_id = a.id " +
				"WHERE p.article_id = " + _articleId);
				
		if (rs.next()) {
			return new Purchase(rs);	
		}
	
		return null;
	}
	
	public boolean hasBeingPurchased(int _articleId) {
		try {
			Statement stmt = ConnectionController.sharedInstance().newStatement();
		
			ResultSet rs = stmt.executeQuery("SELECT COUNT(*) FROM Purchases WHERE article_id = " + _articleId);
			rs.next();
			
			if (DBUtils.hasColumn(rs, "count")) {
				return rs.getInt("count") != 0;
			} else {
				return false;
			}
		} catch(SQLException e) {
			System.out.println(e.getMessage());
			return false;
		}
	}
	
	public List<Purchase> findAllByUserId(int _userId) throws SQLException {
		
		Statement stmt = ConnectionController.sharedInstance().newStatement();
		
		ResultSet rs = stmt.executeQuery("SELECT p.id, p.user_id AS user_id, p.article_id AS article_id, a.title, a.description, a.is_direct_buy, a.start_price, a.end_date, a.creation_date, p.price, p.purchase_date, u.first_name, u.last_name " +
											"FROM Purchases AS p " +
											"LEFT JOIN Users AS u ON p.user_id = u.id " +
											"LEFT JOIN Article AS a ON p.article_id = a.id " +
											"WHERE p.user_id = " + _userId + " " + 
											"ORDER BY p.purchase_date ASC");
		
		List<Purchase> result =  new ArrayList<Purchase>();
		while(rs.next()) {
			Purchase a = new Purchase(rs);
			result.add(a);
		}
		
		return result;
	}
	
	public void addPurchase(int _articleId) throws Exception {
		
		// check if the purchase has already being made
		if (hasBeingPurchased(_articleId)) {
			throw new Exception("Article already being purchased.");
		}
		
		BidController bc = BidController.sharedInstance();
		Bid lastBid = bc.findLastByArticleId(_articleId);
		if (lastBid != null) {
			User bidder = lastBid.getRelation("bidder", User.class);
			int price =  Integer.parseInt(lastBid.getValue("bid"));
			int bidderId = Integer.parseInt(bidder.getValue("user_id"));
			
			Statement stmt = ConnectionController.sharedInstance().newStatement();
			stmt.executeUpdate("INSERT INTO Purchases(id, user_id, article_id, price, purchase_date) " +
								"VALUES (DEFAULT, " + bidderId + "," + _articleId + "," + price + "," + "DEFAULT)");
		}
	} 
}
