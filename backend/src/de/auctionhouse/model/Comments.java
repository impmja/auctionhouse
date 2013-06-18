package de.auctionhouse.model;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;
import de.auctionhouse.utils.DBUtils;


public class Comments implements IModel {
	
	public Map<String, String>	fields = new HashMap<String, String>();
	public Map<String, Object>	relations = new HashMap<String, Object>();
	
	public static final String RENAMED_FIELDS[] = { "image_id" };
	public static final String FIELDS[] = { "id", "article_id", "user_id", "comment", "creation_date" };
	public static enum FIELD_INDEX { ID, URI, CREATION_DATE };
	
	public Comments(ResultSet _result) throws SQLException {
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
	public <T> T getRelation(String _fieldName, Class<T> _class) {
		return (T)null;
	}
}
