package util;

import java.text.DecimalFormat;

public class Utils {
	
	public static final DecimalFormat decimalFormat = new DecimalFormat("##,###");

	/**
	 * 객체가 null이면 빈 문자열을 반환한다.
	 * @param value 객체
	 * @return 빈 문자열 혹은 객체
	 */
	public static Object nullToBlank(Object value) {
		if (value == null) {
			return "";
		}
		return value;
	}
	
	/**
	 * 정수를 금융통화 형식의 문자열로 반환한다.
	 * @param value 정수
	 * @return 3자리마다 ,가 포함된 문자열
	 */
	public static String toCurrency(int value) {
		return decimalFormat.format(value);
	}

	/**
	 * 문자열을 전달받아서 정수로 변환해서 반환한다.
	 * @param value 문자열
	 * @param defaultValue 기본값
	 * @return 정수, 문자열이 null, 빈문자열, 공백문자, 숫자가 아닌 값이 포함된 문자열인 경우 defaultValue가 반환된다.
	 */
	public static int toInt(String value, int defaultValue) {
		if (value == null) {
			return defaultValue;
		}
		if (value.isBlank()) {
			return defaultValue;
		}
		
		try {
			return Integer.parseInt(value.trim());
		} catch (NumberFormatException ex) {
			return defaultValue;
		}
	}
	
	/**
	 * 문자열을 전달받아서 정수로 변환 후 반환한다.
	 * @param value
	 * @return 정수, 기본값이 0인 경우다.
	 */
	public static int toInt(String value) {
		return Utils.toInt(value, 0);
	}
	
	/**
	 * x를 y로 나눈 결과를 올림
	 * @param x
	 * @param y
	 * @return
	 */
	public static int ceil(int x, int y) {
	    final int q = x / y;
	    if ((x ^ y) >= 0 && (q * y != x)) {
	        return q + 1;
	    }
	    return q;
	}
}
