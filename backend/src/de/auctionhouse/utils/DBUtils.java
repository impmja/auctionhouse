package de.auctionhouse.utils;

import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;

public class DBUtils {
	
	public static boolean hasColumn(ResultSet _result, String _columnName) throws SQLException {
	    ResultSetMetaData rsmd = _result.getMetaData();
	    int columns = rsmd.getColumnCount();
	    for (int x = 1; x <= columns; x++) {
	        if (_columnName.equals(rsmd.getColumnName(x))) {
	            return true;
	        }
	    }
	    return false;
	}
	
}
