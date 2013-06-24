package de.auctionhouse.utils;

public class CurrencyHelper {

	static public String toEuro(String _value) {
		long value = Integer.parseInt(_value);
		return String.format("%d.%02d", value / 100, value % 100);
	}
	
	static public int toCents(String _value) {
		String parsedBid = _value.replaceAll("\\.", "");
		parsedBid = parsedBid.replaceAll("\\,", "");
		return Integer.parseInt(parsedBid);
	}
}
