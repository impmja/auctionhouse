package de.auctionhouse.controller;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import de.auctionhouse.model.Article;

public class ArticleController {

	public ArticleController() {
	}
	
	
	public Article findById(int _id) throws SQLException {
		
		Statement stmt = ConnectionController.sharedInstance().newStatement();
		ResultSet rs = stmt.executeQuery("SELECT * FROM article where id =" + _id);
		rs.next();
		
		return new Article(rs);	
	}
	
	public List<Article> findAll() throws SQLException {
		
		Statement stmt = ConnectionController.sharedInstance().newStatement();
		ResultSet rs = stmt.executeQuery("SELECT * FROM article");
		
		List<Article> result =  new ArrayList<Article>();
		while(rs.next()) {
			result.add(new Article(rs));
		}
		
		return result;
	}
	
}
