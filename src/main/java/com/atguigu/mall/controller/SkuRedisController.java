package com.atguigu.mall.controller;

import org.apache.log4j.Logger;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.atguigu.mall.bean.Object_T_Mall_Attr;
import com.atguigu.mall.bean.T_Mall_Value;
import com.atguigu.mall.service.SkuRedisService;
import com.atguigu.mall.utils.MyJedisPoolUtils;
import com.atguigu.mall.utils.MyJsonUtil;

import redis.clients.jedis.Jedis;

import com.atguigu.mall.bean.OBJECT_T_MALL_SKU;

@Controller
public class SkuRedisController {
	/**
	* Logger for this class
	*/
	private static final Logger logger = Logger.getLogger(SkuRedisController.class);
	
	@Autowired
	private SkuRedisService skuRedisServiceImpl;
	
	
	
	@RequestMapping("bg_system_adjust_spu_redis_cache_info")
	public String bg_system_adjust_spu_redis_cache_page(
				Map map){
		
		return "bg_system/bg_adjust_spu_redis_cache";
	}
	
	
	//将细分到分类属性值的商品集合刷新到缓存
	@ResponseBody
	@RequestMapping("spu_flush_spu_info_to_redis_by_class_2_id_attr_id_attr_value_id")
	public int spu_flush_spu_info_to_redis_by_class_2_id_attr_id_attr_value_id(
				@RequestParam("attr_ids[]") int[] attr_ids,
				int class_2_id,
				String order_condition) {
		int sum = 0;
		Jedis jedis = MyJedisPoolUtils.getJedis();
		//先根据二级分类的id,以及分类属性的id，属性值的id 将集合数据刷入redis中
		//先根据二级分类的id,查询该二级分类下的属性id集合
		List<Object_T_Mall_Attr> productAttrInfo = skuRedisServiceImpl.getProductAttrInfo(class_2_id);
		for(int i = 0;i<productAttrInfo.size() ;i++) {
			for(int j =0;j<attr_ids.length;j++) {
				if(productAttrInfo.get(i).getId() == attr_ids[j]) {
					List<T_Mall_Value> valueList = productAttrInfo.get(i).getValueList();
					
					for(int k = 0;k<valueList.size();k++) {
						List<OBJECT_T_MALL_SKU> sku_list = skuRedisServiceImpl.get_products_info_by_class_2_id_attr_id_attr_value_id(class_2_id,attr_ids[j],valueList.get(k).getId());
						
						logger.info("二级分类"+class_2_id+"下，属性id为："+attr_ids[j]+"属性值id为："+valueList.get(k).getId()+"的商品集合为："+sku_list+"/t商品集合大小（该class_id_"+class_2_id+"_attr_id_"+attr_ids[j]+"_value_id"+valueList.get(k).getId()+"的商品数量为）为:"+sku_list.size());
							for(int m = 0; m<sku_list.size();m++) {//这里遍历的是按照二级分类的id以及属性id以及属性值id查询出来的商品集合
								//将细分到属性值ID的商品集合刷新到缓存中
								String attr_sku_list_json = MyJsonUtil.list_to_json(sku_list.get(m));
								//将List<OBJECT_T_MALL_SKU>集合中的每个元素，拿出来遍历，然后每个OBJECT_T_MALL_SKU对象又通过成了一个MyJsonUtil.list_to_json();又成了一个json集合————只有一个元素的json集合
								//这里应该用MyJsonUtil工具类中的obj_to_json
								//既然这样写了，那前台交易系统中com.protal.sale.controller.SearchByAttrValueController的第77行就得遍历取出OBJECT_T_MALL_SKU对象用MyJsonUtil.list_to_json();还原一下
								try {
									attr_sku_list_json = URLEncoder.encode(attr_sku_list_json,"utf-8");
								} catch (UnsupportedEncodingException e) {
									e.printStackTrace();
								}
								if(" order by jg ".equals("")) {
									jedis.zadd("class_2_"+class_2_id+"_"+attr_ids[j]+"_"+valueList.get(k).getId(),m, attr_sku_list_json);
								}
								if(" order by jg ".equals(order_condition)) {
									jedis.zadd("class_2_"+class_2_id+"_"+attr_ids[j]+"_"+valueList.get(k).getId()+"_ob_jg",sku_list.get(m).getJg(), attr_sku_list_json);
								}
								if(" order by kc ".equals(order_condition)) {
									jedis.zadd("class_2_"+class_2_id+"_"+attr_ids[j]+"_"+valueList.get(k).getId()+"_ob_kc",sku_list.get(m).getKc(), attr_sku_list_json);
								}
							}
						sum += 1;
					}
				}
			}
		}
		
		return sum;
	}
	
	
	@ResponseBody
	@RequestMapping("bg_spu_redis_cache_adjust_attr_info_json_data")
	public List<Object_T_Mall_Attr> bg_spu_redis_cache_adjust_attr_info_json_data(
			@RequestParam("flbh2")int flbh2 ){
		logger.info("前台传值分类编号2的值为："+flbh2);
		List<Object_T_Mall_Attr> attrList = skuRedisServiceImpl.getProductAttrInfo(flbh2);
		return attrList;
	}


	//跳转发布商品库存信息页面bg_system_add_product_sku_info
	@ResponseBody
	@RequestMapping("flush_spu_info_to_redis_by_class_2_id")
	public int flush_spu_info_to_redis_by_class_2_id(
				@RequestParam("flbh2")int class_2_id,
				@RequestParam("order_condition")String order_condition){

		List<OBJECT_T_MALL_SKU> sku_list = skuRedisServiceImpl.get_products_info_by_class_2_id(class_2_id,order_condition);
		
		Jedis jedis = MyJedisPoolUtils.getJedis();
		
		if(" order by jg ".equals(order_condition)) {
			for(int i = 0;i<sku_list.size();i++) {
				String obj_to_json = MyJsonUtil.obj_to_json(sku_list.get(i));
				jedis.zadd("class_2_"+class_2_id, sku_list.get(i).getJg(), obj_to_json);
			}
		}
		if(" order by kc ".equals(order_condition)) {
			for(int i = 0;i<sku_list.size();i++) {
				String obj_to_json = MyJsonUtil.obj_to_json(sku_list.get(i));
				jedis.zadd("class_2_"+class_2_id+"_ob_kc", sku_list.get(i).getKc() , obj_to_json);
			}
		}
		return sku_list.size();
	}
	
}
