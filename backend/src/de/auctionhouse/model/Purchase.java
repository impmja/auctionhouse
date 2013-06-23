package de.auctionhouse.model;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;


import de.auctionhouse.utils.DBUtils;

public class Purchase implements IModel {
	public Map<String, String>	fields = new HashMap<String, String>();
	public Map<String, Object>	relations = new HashMap<String, Object>();
	
	public static final String RENAMED_FIELDS[] = { "purchase_id" };
	public static final String FIELDS[] = { "id", "price", "purchase_date" };
	public static enum FIELD_INDEX { ID, TITLE, DESCRIPTION, IS_DIRECT_BUY, START_PRICE, END_DATE, CREATION_DATE };
	public static final String RELATIONS[] = { "user", "article" }; 
		
	public Purchase(ResultSet _result) throws SQLException {
		this.loadFrom(_result);
	}
	  
	@Override
	public void loadFrom(ResultSet _result) throws SQLException {
		// special cases (renamed fields via JOIN)
		for (int i = 0; i < RENAMED_FIELDS.length; ++i) {
			if (DBUtils.hasColumn(_result, RENAMED_FIELDS[i])) {
				fields.put(RENAMED_FIELDS[i], _result.getString(RENAMED_FIELDS[i]));
			}
		}
				
		for (int i = 0; i < FIELDS.length; ++i) {
			if (DBUtils.hasColumn(_result, FIELDS[i])) {
				fields.put(FIELDS[i], _result.getString(FIELDS[i]));
			}
		}
		
		// resolve relations
		relations.put(RELATIONS[0], new User(_result));
		relations.put(RELATIONS[1], new Article(_result));
	}
	
	@Override
	public String getValue(String _fieldName) {
		if (fields.containsKey(_fieldName)) {
			return fields.get(_fieldName);
		}
		return null;
	}

	@Override
	public String getValueById(int _fieldIndex) {
		if (_fieldIndex >= 0 && _fieldIndex < FIELD_INDEX.values().length) {
			return getValue(FIELDS[_fieldIndex]);
		}
		return null;
	}
	
	@Override
	public <T> T getRelation(String _relationName, Class<T> _class) {
		if (relations.containsKey(_relationName)) {
			Object result = relations.get(_relationName);
			if (_class.isInstance(result)) {
				return _class.cast(relations.get(_relationName));
			}
		}
		return (T)null;
	}
}
