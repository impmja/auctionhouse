package de.auctionhouse.controller;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import de.auctionhouse.model.Comment;

public class CommentController {

	private static CommentController sharedCommentController;
	
	
	private CommentController() {
	}
	
	// Singleton
	public static CommentController sharedInstance() throws SQLException {
		if (sharedCommentController == null) {
			sharedCommentController = new CommentController();
		}
		return sharedCommentController;
	}
	
	public List<Comment> findAll(int _articleId, int _limit) throws SQLException {
		
		Statement stmt = ConnectionController.sharedInstance().newStatement();
		
		ResultSet rs = stmt.executeQuery("SELECT c.comment, u.email, u.first_name, u.last_name " +
											"FROM Comments AS c " +
											"LEFT JOIN Users AS u ON c.user_id = u.id " +
											"WHERE c.article_id = " + _articleId + " ORDER BY c.creation_date LIMIT " + _limit);

		List<Comment> result =  new ArrayList<Comment>();
		while(rs.next()) {
			Comment a = new Comment(rs);
			result.add(a);
		}
		
		return result;
	}

	
}
