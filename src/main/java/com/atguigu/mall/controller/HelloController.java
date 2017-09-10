package com.atguigu.mall.controller;

import org.apache.log4j.Logger;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.atguigu.mall.service.ClassService;

@Controller
public class HelloController {
	/**
	* Logger for this class
	*/
	private static final Logger logger = Logger.getLogger(HelloController.class);

	@Autowired
	private ClassService classServiceImpl;
	
	
	@RequestMapping("/hello")
	public String test(){
		return "hello";
	}
	
	@RequestMapping("/index_get_class_1_num")
	public String getClass1Num(){
		int num = classServiceImpl.getClass_1_num();
		logger.info("以及分类条目数为：-------------------->"+num);
		return "hello";
	}
	
}
