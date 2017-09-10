package com.atguigu.mall.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.atguigu.mall.bean.OBJECT_T_MALL_SKU;
import com.atguigu.mall.bean.Object_T_Mall_Attr;
import com.atguigu.mall.bean.T_Mall_Value;
import com.atguigu.mall.mapper.SkuRedisMapper;
import com.atguigu.mall.service.SkuRedisService;

@Service
public class SkuRedisServiceImpl implements SkuRedisService{

	@Autowired
	private SkuRedisMapper skuRedisMapper;
	
	@Override
	public List<Object_T_Mall_Attr> getProductAttrInfo(int flbh2) {
		return skuRedisMapper.selectProductAttrInfo(flbh2);
	}

	@Override
	public List<OBJECT_T_MALL_SKU> get_products_info_by_class_2_id(int class_2_id,String order_condition) {
		return skuRedisMapper.select_products_info_by_class_2_id(class_2_id,order_condition);
	}

	@Override
	public List<OBJECT_T_MALL_SKU> get_products_info_by_class_2_id_attr_id_attr_value_id(
				int class_2_id, int attr_id, int value_id) {
		
		Map paramMap = new HashMap();
		paramMap.put("class_2_id", class_2_id);
		paramMap.put("attr_id", attr_id);
		paramMap.put("value_id", value_id);

		List<OBJECT_T_MALL_SKU> sku_list = skuRedisMapper.select_products_info_by_class_2_id_attr_id_attr_value_id(paramMap);
		
		return sku_list;
	}

	

	
	
}
