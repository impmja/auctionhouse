package de.auctionhouse.model;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Date;

public class Image implements IModel {

	public int			id;
	public Article		article;
	public String		uri;
	public Date			creationDate;
	
	public Image(ResultSet _result) throws SQLException {
		this.loadFrom(_result);
	}
	  
	@Override
	public void loadFrom(ResultSet _result) throws SQLException {
		id = _result.getInt("id");
		
		// TODO: Resolve Artikel
		
		uri = _result.getString("uri");
		creationDate = _result.getTimestamp("creation_date");
	}
	
}
