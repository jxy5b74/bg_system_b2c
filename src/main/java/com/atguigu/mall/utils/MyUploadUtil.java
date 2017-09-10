package com.atguigu.mall.utils;

import org.apache.log4j.Logger;

import java.io.File;
import java.io.IOException;
import java.security.Timestamp;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import org.springframework.web.multipart.MultipartFile;

public class MyUploadUtil {
	/**
	* Logger for this class
	*/
	private static final Logger logger = Logger.getLogger(MyUploadUtil.class);

	public static List<String> upLoad_images(MultipartFile[] files){
		//使用写好的MyPropertyUtils类的getProperty方法
		//加载外部的.properties配置文件中的配置信息
		String property = MyPropertyUtils.getProperty("windows_path");
		
		//创建一个盛放上传文件的文件名的ArrayList集合
		List<String> image_url_list = new ArrayList<>();
		
		for(int i = 0 ; i < files.length ; i++){
			
			if(files[i].getSize() != 0){
				//获得上传的图片的原始文件名，并加上时间戳或者UUID防止上传重名的文件发生覆盖
				UUID uuid = UUID.randomUUID();
				
				String originalFilename = uuid.toString()+"_"+files[i].getOriginalFilename();
				
				image_url_list.add(originalFilename);
				//创建上传文件对应的目标文件
				//（将上传的文件通过transferTo方法copy到共享数据服务器的指定目录
				//也即MyPropertyUtils的getPropery()方法获得的配置文件中的路径）
				File file = new File(property+"\\"+originalFilename);
				
				try {
					files[i].transferTo(file);
				} catch (IllegalStateException | IOException e) {
					e.printStackTrace();
				}
			}
		}
		
		return image_url_list;
	}
	
	
}


///**
// * 返回所有上传文件名称的String类型的集合
// * @param files
// * @return
// */
//public static List<String> upLoad_images(MultipartFile[] files){
//	
//	List<String> list_image = new ArrayList<String>();
//	
//	String property = MyPropertyUtils.getProperty("windows_path");
//	
//	for(int i = 0; i<files.length ;i++){
//		
//		String originalFilename = System.currentTimeMillis() + "_" + files[i].getOriginalFilename();
//		
//		//String string = UUID.randomUUID().toString();
//		logger.info("处理后的图片名称：------------>"+originalFilename);
//		
//		File file = new File(property+"\\"+originalFilename);
//		
//		list_image.add(originalFilename);
//		try {
//			files[i].transferTo(file);
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//	}
//	
//	return list_image;
//}