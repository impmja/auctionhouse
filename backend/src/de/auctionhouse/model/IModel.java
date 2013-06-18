package de.auctionhouse.model;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

public interface IModel {

	public Map<String, String>	fields = new HashMap<String, String>();
	public Map<String, Object>	relations = new HashMap<String, Object>();
	
	public void loadFrom(ResultSet _result) throws SQLException;
	
	public String getValue(String _fieldName);
	public String getValueById(int _fieldIndex);
	
	public <T> T getRelation(String _fieldName, Class<T> _class);
}
