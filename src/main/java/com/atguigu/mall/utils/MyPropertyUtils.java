package com.atguigu.mall.utils;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

public class MyPropertyUtils {

	public static String getProperty(String string){
		
		Properties properties = new Properties();
		
		InputStream resourceAsStream 
		            = MyPropertyUtils.class
		            	.getClassLoader()
		            	.getResourceAsStream("upload.properties");
	
		try {
			properties.load(resourceAsStream);
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		String property = properties.getProperty(string);
		
		return property;
	}
}
