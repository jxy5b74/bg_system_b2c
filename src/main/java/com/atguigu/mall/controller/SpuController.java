package com.atguigu.mall.controller;

import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.atguigu.mall.bean.T_Mall_Product;
import com.atguigu.mall.service.SpuService;
import com.atguigu.mall.utils.MyUploadUtil;

@Controller
public class SpuController {
	/**
	* Logger for this class
	*/
	private static final Logger logger = Logger.getLogger(SpuController.class);

	
	
	@Autowired
	private SpuService spuServiceImpl;
	
	//跳转发布商品信息页面
	@RequestMapping("/bg_system_add_product_spu_info")
	public String to_back_guound_add_product_info_page(@RequestParam(value="success",required=false)String success,Map map){
		map.put("success", success);
		return "bg_system/bg_add_product_spu_info";
	}
	
	//向t_mall_product表中插入新的spu信息t_mall_product
	@RequestMapping("/save_spu")
	public ModelAndView save_spu_info_to_t_mall_product
		          (T_Mall_Product spu, 
		           @RequestParam("files")MultipartFile[] files)
	{
		logger.info("----------------------查看前台数据是否封装成功----------------------");
		//上传文件，返回文件的URL（注：★★★★这里要保存的是图片的url而不是图片的路径）
		
		List<String> upLoad_images = MyUploadUtil.upLoad_images(files);
		
		spu.setShp_tp(upLoad_images.get(0));
		
		//调用业务层的保存spu的方法 （一张表示spu表，一张表是商品图片表）
		spuServiceImpl.saveSpuInfo(spu,upLoad_images);
		
		String success = new String("商品spu信息发布成功！~");
		
		ModelAndView mav = new ModelAndView("redirect:/index_background_manager_system.do?call_back_page=spu");
		//采用ModelAndView作为Controller方法的返回值的时候，
		//框架在读取转发地址的时候是采用ISO8859-1去解析重定向路径
		//为了采用UTF-8的编码集解析在重定向路径后面所挂的参数，使用ModelAndView来解决
		mav.addObject("success", success);
		//addObject()作用是在重定向命令中加入参数的意思
		//其会单独采用UTF-8的字符集去处理参数的编码格式
		return mav;
		//如果是return "redirect:/bg_system_add_product_spu_info.do?携带参数";这种情况
		//特别是redirect命令的时候
		//dispatcherServlet默认使用ISO8859-1的编码集来解析重定向地址
		//spring官方文档推荐使用ModelAndView对象做为Controller的返回对象
		//使用ModelAndView作为返回对象，框架会使用UTF-8来进行重定向地址的编码
	}
}
