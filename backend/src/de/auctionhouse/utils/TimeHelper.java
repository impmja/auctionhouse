package de.auctionhouse.utils;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;


// TODO: Einbinden? http://joda-time.sourceforge.net/
public class TimeHelper {

	static public Date computeDifference(Date _startDate, Date _endDate) {
		return new Date(_startDate.getTime() - _endDate.getTime()); 
	}
	
	static public String computeDifferenceFromNow(String _startDate) {
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		
		try {
			SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			Date date = format.parse(_startDate);
			Date now = new Date();
			return df.format(new Date(now.getTime() - date.getTime())); 
		} catch (ParseException e) {
			return df.format(new Date());
		}
	}
	
	static public boolean checkIfTimeIsOver(String _startDate) {
		try {
			SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			Date date = format.parse(_startDate);
			Date now = new Date();
			return (now.getTime() - date.getTime()) < 0; 
		} catch (ParseException e) {
			return true;
		}
	}
}
