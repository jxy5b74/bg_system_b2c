package com.atguigu.mall.controller;

import org.apache.log4j.Logger;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.atguigu.mall.bean.Model_T_Mall_Attr;
import com.atguigu.mall.bean.Object_T_Mall_Attr;
import com.atguigu.mall.bean.T_Mall_Attr;
import com.atguigu.mall.service.AttrService;

@Controller
public class AttrController {
	/**
	* Logger for this class
	*/
	private static final Logger logger = Logger.getLogger(AttrController.class);
	
	@Autowired
	private AttrService attrServiceImpl;
	
	
	
	
	//跳转添加商品属性的页面bg_product_maintain_attr_info_page
	@RequestMapping("/bg_product_maintain_attr_info_page")
	public String bg_product_maintain_attr_info_page(
			@RequestParam("flbh2")int flbh2,
			@RequestParam("flmch2")String flmch2,
			@RequestParam(value="success",required=false)String success,
			Map map){
		map.put("success", success);
		map.put("flbh2", flbh2);
		map.put("flmch2", flmch2);
		return "bg_system/bg_product_maintain_attr_info";
	}
	
	//执行批量插入商品的attr信息bg_project_run_batch_insert_attr_info
	@RequestMapping("/bg_project_run_batch_insert_attr_info")
	public ModelAndView bg_project_run_batch_insert_attr_info(
			Model_T_Mall_Attr model_t_mall_attr,
			@RequestParam("flbh2")int flbh2,
			@RequestParam("flmch2")String flmch2,
			@RequestParam(value="success",required=false)String success,
			Map map){
		
		List<Object_T_Mall_Attr> attrList = model_t_mall_attr.getAttrList();
		
		
		int affectRows = attrServiceImpl.multi_add_product_attr_info(attrList,flbh2);
		System.out.println(affectRows);
		ModelAndView mav = new ModelAndView("redirect:/bg_product_maintain_attr_info_page.do");
		mav.addObject("success", "新增商品attr信息成功！~");
		map.put("flbh2", flbh2);
		map.put("flmch2", flmch2);
		return mav;
	}
	
	
	
	//跳转发布商品信息页面
	@RequestMapping("/bg_system_product_attr_info")
	public String to_back_guound_add_product_info_page(@RequestParam(value="success",required=false)String success,Map map){
		map.put("success", success);
		logger.error("---------------------------------");
		return "bg_system/bg_product_attr_info";
	}
	
/*	
 * 不用easyUI的情况下，异步加载商品二级分类属性信息到内嵌页面中
	//异步显示二级分类商品属性信息
	@SuppressWarnings("unchecked")
	@RequestMapping("/bg_product_attr_info_show")
	public String bg_product_attr_info_show(@RequestParam("flbh2")int flbh2 , 
											@RequestParam("flmch2")String flmch2 ,
											Map map){
		logger.info("分类编号2-------------->"+flbh2);
		logger.info("分类名称2-------------->"+flmch2);
		List<Object_T_Mall_Attr> attrList = attrServiceImpl.getProductAttrInfo(flbh2);
		
		map.put("attrList", attrList);
		map.put("flbh2", flbh2);
		map.put("flmch2",flmch2);
		return "bg_system/bg_product_attr_info_inner_list";
	}
	
	*/
	
	//使用easyUI的datagrid控件，返回json集合数据，异步显示二级分类商品属性信息到页面中指定的div元素
	@ResponseBody
	@RequestMapping("/bg_product_attr_info_show_json_data")
	public List<Object_T_Mall_Attr> bg_product_attr_info_show_json_data(
						@RequestParam("flbh2")int flbh2 ){
		logger.info("分类编号2-------------->"+flbh2);
		List<Object_T_Mall_Attr> attrList = attrServiceImpl.getProductAttrInfo(flbh2);
		return attrList;
	}
}
