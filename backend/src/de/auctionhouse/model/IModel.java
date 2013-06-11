package de.auctionhouse.model;

import java.sql.ResultSet;
import java.sql.SQLException;

public interface IModel {

	public void loadFrom(ResultSet _result) throws SQLException;
}
