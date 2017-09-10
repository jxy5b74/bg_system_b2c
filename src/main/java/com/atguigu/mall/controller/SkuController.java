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

import com.atguigu.mall.bean.Object_T_Mall_Attr;
import com.atguigu.mall.bean.Model_T_Mall_Sku_Attr_Value;
import com.atguigu.mall.bean.T_Mall_Product;
import com.atguigu.mall.bean.T_Mall_Sku;
import com.atguigu.mall.service.SkuService;

@Controller
public class SkuController {
	/**
	* Logger for this class
	*/
	private static final Logger logger = Logger.getLogger(SkuController.class);

	@Autowired
	private SkuService skuServiceImpl;
	
	//form表单提交的sku商品信息
	@RequestMapping("bg_save_sku")
	public ModelAndView bg_save_sku(
			T_Mall_Sku sku,//封装t_mall_sku表的相关信息（shp_id/kc/jg/sku_mch/sku_xl/kcdz）
			Model_T_Mall_Sku_Attr_Value attr_value
			){
		//向数据库中插入一条sku信息
		//（包含t_mall_sku表中sku的基本信息和t_mall_sku_attr_value表中关联的具体商品的属性信息）
		int affectRows = skuServiceImpl.add_new_product_sku_related_info(sku,attr_value);
		
		logger.info("向t_mall_sku表中新增一条数据，返回受影响的行数------>"+affectRows);
		
		ModelAndView mav = new ModelAndView("redirect:/index_background_manager_system.do?call_back_page=sku");	
		return mav;
	}
	
	
	
	
	//跳转发布商品库存信息页面bg_system_add_product_sku_info
	@RequestMapping("/bg_system_add_product_sku_info")
	public String to_back_guound_add_product_sku_info_page(
				@RequestParam(value="success",required=false)String success,
				Map map){
		map.put("success", success);
		return "bg_system/bg_add_product_sku_info";
	}
	
	//异步加载商品attr属性信息集合———checkbox_radio，
	//将集合作为html页面输出到一个内嵌页，使用ajax+html内嵌页的方式不需要使用@ResponseBody注解标注
	//							     只有使用ajax+json的方式展示数据才需要使用@ResponseBody注解
//	@ResponseBody
	@RequestMapping("/bg_product_sku_get_spu_attr_info")
	public String bg_product_get_attr_info(
				@RequestParam("flbh2")int flbh2,
				@RequestParam(value="success",required=false)String success,
				Map map){
		
		logger.info(flbh2);
		
		List<Object_T_Mall_Attr> attrList = skuServiceImpl.getProductAttrInfo(flbh2);
		
		/*logger.error(attrList);*/
		
		map.put("sku_attr_list", attrList);
		
		return "bg_system/bg_sku_attr_info_inner_list";
	}
	

	
	//异步加载商品的spu信息到页面的下拉列选bg_product_get_product_spu_info
	@ResponseBody
	@RequestMapping("/bg_product_get_product_spu_info")
	public List<T_Mall_Product> bg_product_get_product_spu_info(
			@RequestParam("flbh2")int flbh2,
			@RequestParam("pp_id")int pp_id
			){
		
		List<T_Mall_Product> productList = skuServiceImpl.get_product_spu_info(flbh2,pp_id);
		
		return productList;
	}
	
}
