package de.auctionhouse.controller;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import de.auctionhouse.model.Article;
import de.auctionhouse.model.Bid;
import de.auctionhouse.utils.TimeHelper;

public class ArticleController {

	private static ArticleController sharedArticleController;
	
	private ArticleController() {
	}
	
	// Singleton
	public static ArticleController sharedInstance() {
		if (sharedArticleController == null) {
			sharedArticleController = new ArticleController();
		}
		return sharedArticleController;
	}
		
	public Article findById(int _id) throws SQLException {
		
		Statement stmt = ConnectionController.sharedInstance().newStatement();
		
		ResultSet rs = stmt.executeQuery("SELECT * FROM Article AS a " +
											"LEFT JOIN Users AS u ON a.seller_id = u.id " +
											"LEFT JOIN Image AS i ON a.image_id = i.id " +
											"WHERE a.id = " + _id);
		
		if (rs.next()) {
			return new Article(rs);	
		}
	
		return null;
	}
	
	public List<Article> findAll() throws SQLException {
		
		Statement stmt = ConnectionController.sharedInstance().newStatement();
		ResultSet rs = stmt.executeQuery("SELECT a.id, a.seller_id, a.image_id, a.title, a.description, a.is_direct_buy, a.start_price, a.end_date, a.creation_date, " +
											"u.id AS user_id, u.email, u.first_name, u.last_name, " +
											"i.id AS image_id, i.uri " +
											"FROM Article AS a " +
											"LEFT JOIN Users AS u ON a.seller_id = u.id " + 
											"LEFT JOIN Image AS i ON a.image_id = i.id " +
											"ORDER by a.creation_date");
			
		List<Article> result =  new ArrayList<Article>();
		while(rs.next()) {
			Article a = new Article(rs);
			result.add(a);
		}
		
		return result;
	}

	public void bidOnArticle(int _bidderId, int _articleId, int _bidValue) throws Exception {
		
		Article article = findById(_articleId);
		if (article == null) {
			throw new Exception("Invalid article.");
		}
		
		if (TimeHelper.checkIfTimeIsOver(article.getValue("end_date"))) {
			throw new Exception("Article has being sold.");	
		}
		
		BidController bc = BidController.sharedInstance();
		Bid lastBid = bc.findLastByArticleId(_articleId);
		if (lastBid != null) {
			int currentBid =  Integer.parseInt(lastBid.getValue("bid"));
			if (currentBid >= _bidValue) {
				throw new Exception("Bid to low.");	
			}
		}
		
		bc.placeBid(_bidderId, _articleId, _bidValue);
	}
	
}
