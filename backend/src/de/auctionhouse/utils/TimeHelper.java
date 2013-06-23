package de.auctionhouse.utils;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

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
			/*
			System.out.println("Now: " + now.getTime());
			System.out.println("End: " + date.getTime());
			System.out.println("Diff: " + (date.getTime() - now.getTime()));
			*/
			return (date.getTime() - now.getTime()) <= 0; 
		} catch (ParseException e) {
			return true;
		}
	}
	
	static public String computeDifferenceAsString(String _endDate) {
		try {
			SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			Date date = format.parse(_endDate);
			Date now = new Date();
			
			Calendar calendar1 = Calendar.getInstance();
			Calendar calendar2 = Calendar.getInstance();
			calendar1.setTime(now);
			calendar2.setTime(date);
			
			long milliseconds1 = calendar1.getTimeInMillis();
			long milliseconds2 = calendar2.getTimeInMillis();
			long diff = milliseconds2 - milliseconds1;
			
			long diffDays = diff / (24 * 60 * 60 * 1000);
			diff = diff - diffDays * (24 * 60 * 60 * 1000);
			long diffHours = diff / (60 * 60 * 1000);
			diff = diff - diffHours * (60 * 60 * 1000);
			long diffMinutes = diff / (60 * 1000);
			diff = diff - diffMinutes * (60 * 1000);
			long diffSeconds = diff / 1000;
			
			String result = "";
			if (diffDays >= 1) {
				if (diffDays == 1) {
					result = "1 Tag ";
				} else {
					result = String.format("%d Tage ", diffDays);
				}
			}
			
			if (diffHours >= 1) {
				if (diffHours == 1) {
					result = result + "1 Std. ";
				} else {
					result = result + String.format("%d Std. ", diffHours);
				}
			}
			
			if (diffDays <= 0) {
				if (diffMinutes >= 1) {
					if (diffMinutes == 1) {
						result = result + "1 Min. ";
					} else {
						result = result + String.format("%d Min. ", diffMinutes);
					}
				}
			}
			
			if (diffDays <= 0 && diffHours <= 0 && diffMinutes <= 0) {
				if (diffSeconds >= 1) {
					if (diffSeconds == 1) {
						result = result + "1 Sek.";
					} else {
						result = result + String.format("%d Sek.", diffSeconds);
					}
				}
			}
			
			return result;
		} catch (ParseException e) {
			return "Error: Invalid date format";
		}
	}
	
}
