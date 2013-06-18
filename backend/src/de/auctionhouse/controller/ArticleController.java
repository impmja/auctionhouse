package de.auctionhouse.controller;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import de.auctionhouse.model.Article;

public class ArticleController {

	private static ArticleController sharedArticleController;
	
	private ArticleController() {
	}
	
	// Singleton
	public static ArticleController sharedInstance() throws SQLException {
		if (sharedArticleController == null) {
			sharedArticleController = new ArticleController();
		}
		return sharedArticleController;
	}
		
	public Article findById(int _id) throws SQLException {
		
		Statement stmt = ConnectionController.sharedInstance().newStatement();
		
		//ResultSet rs = stmt.executeQuery("SELECT * FROM Article AS a LEFT JOIN Users AS u ON a.seller_id = u.id WHERE a.id = " + _id);
		ResultSet rs = stmt.executeQuery("SELECT * FROM Article AS a " +
											"LEFT JOIN Users AS u ON a.seller_id = u.id " +
											"LEFT JOIN Image AS i ON a.image_id = i.id " +
											"WHERE a.id = " + _id);
		
		rs.next();
	
		return new Article(rs);	
	}
	
	public List<Article> findAll() throws SQLException {
		
		Statement stmt = ConnectionController.sharedInstance().newStatement();
		
		ResultSet rs = stmt.executeQuery("SELECT a.id, a.seller_id, a.image_id, a.title, a.description, a.is_direct_buy, a.start_price, a.end_date, a.creation_date, " +
											"u.id AS user_id, u.email, u.first_name, u.last_name, " +
											"i.id AS image_id, i.uri " +
											"FROM Article AS a " +
											"LEFT JOIN Users AS u ON a.seller_id = u.id " + 
											"LEFT JOIN Image AS i ON a.image_id = i.id");
		
		//SELECT a.id, a.seller_id, a.image_id, a.title, a.description, a.is_direct_buy, a.start_price, a.end_date, a.creation_date, u.id AS user_id, u.email, u.first_name, u.last_name, i.id AS image_id, i.uri FROM Article AS a LEFT JOIN Users AS u ON a.seller_id = u.id LEFT JOIN Image AS i ON a.image_id = i.id
		
		List<Article> result =  new ArrayList<Article>();
		while(rs.next()) {
			Article a = new Article(rs);
			result.add(a);
		}
		
		return result;
	}
	
}
