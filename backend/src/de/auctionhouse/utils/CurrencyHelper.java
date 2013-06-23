package de.auctionhouse.utils;

import java.text.DecimalFormat;
import java.text.DecimalFormatSymbols;
import java.text.NumberFormat;
import java.util.Locale;
import java.text.NumberFormat;
import java.util.Currency;
import java.util.Date;
import java.util.Locale;

public class CurrencyHelper {

	static public String toEuro(String _value) {
		/*
		NumberFormat nf = NumberFormat.getCurrencyInstance(Locale.GERMANY);
		nf.setCurrency(Currency.getInstance("EUR"));
		DecimalFormatSymbols decimalFormatSymbols = ((DecimalFormat) nf).getDecimalFormatSymbols();
		decimalFormatSymbols.setCurrencySymbol("");
		((DecimalFormat) nf).setDecimalFormatSymbols(decimalFormatSymbols);
		return nf.format(Integer.parseInt(_value) / 100).trim();
		*/
		
		long value = Integer.parseInt(_value);
		return String.format("%d.%02d", value / 100, value % 100);
	}
	
	static public int toCents(String _value) {
		String parsedBid = _value.replaceAll("\\.", "");
		parsedBid = parsedBid.replaceAll("\\,", "");
		System.out.println(parsedBid);
		return Integer.parseInt(parsedBid);
	}
}
