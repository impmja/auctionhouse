package de.auctionhouse.model;

import java.sql.ResultSet;
import java.sql.SQLException;

public class Article implements IModel {

	public int		id;
	public User		seller;
	public int		imageId; // TODO: Image Model hier anhängen
	public String	title;
	public String	description;
	public Boolean	isDirectBuy;
	public int		startPrice;
	public String	endDate;
	public String   creationDate;
	
	public Article(ResultSet _result) throws SQLException {
		this.loadFrom(_result);
	}
	  
	@Override
	public void loadFrom(ResultSet _result) throws SQLException {
		id = _result.getInt("id");
		// TODO: resolve user
		title = _result.getString("title");
		description = _result.getString("description");
		// TODO: Rest der Felder
	}

}
