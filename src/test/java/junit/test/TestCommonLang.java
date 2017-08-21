package junit.test;

import org.apache.commons.lang.ArrayUtils;

public class TestCommonLang {
	public static void main(String[] args) {
		Object[] array={};
		boolean notEmpty = ArrayUtils.isNotEmpty(array);
		System.out.println(notEmpty);
	}
}
