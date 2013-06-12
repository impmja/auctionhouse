package de.auctionhouse.model;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Date;

public class User implements IModel {
	public int			id;
	public String		email;
	public String 		password;
	public String		firstName;
	public String		lastName;
	public String		streetName;
	public String		zipCode;
	public String		city;
	public String		state;
	public String		country;
	public Date			creationDate;
	
	public User(ResultSet _result) throws SQLException {
		this.loadFrom(_result);
	}
	
	@Override
	public void loadFrom(ResultSet _result) throws SQLException {
		id = _result.getInt("id");
		email = _result.getString("email");
		password = _result.getString("password");
		firstName = _result.getString("first_name");
		lastName = _result.getString("last_name");
		streetName = _result.getString("street_name");
		zipCode = _result.getString("zip_code");
		city = _result.getString("city");
		state = _result.getString("state");
		country = _result.getString("country");
		creationDate = _result.getTimestamp("creation_date");
	}
	
}
