package com.atguigu.mall.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class MyDispatcherController {

	//跳转后台管理页面
	@RequestMapping("/index_background_manager_system")
	public String to_back_guound_system_page(){
		return "manager_system";
	}
	

}
