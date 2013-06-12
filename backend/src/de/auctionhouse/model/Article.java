package de.auctionhouse.model;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Date;

public class Article implements IModel {

	public int		id;
	public User		seller;
	public int		imageId; // TODO: Image Model hier anhängen
	public String	title;
	public String	description;
	public Boolean	isDirectBuy;
	public int		startPrice;
	public Date		endDate;
	public Date		creationDate;
	
	public Article(ResultSet _result) throws SQLException {
		this.loadFrom(_result);
	}
	  
	@Override
	public void loadFrom(ResultSet _result) throws SQLException {
		id = _result.getInt("id");
		
		// TODO: resolve user
		// TODO: resolve image
		
		title = _result.getString("title");
		description = _result.getString("description");
		isDirectBuy = _result.getBoolean("is_direct_buy");
		startPrice = _result.getInt("start_price");
		endDate = _result.getTimestamp("end_date");
		creationDate = _result.getTimestamp("creation_date");
	}

}
