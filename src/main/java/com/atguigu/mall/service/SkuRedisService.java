package com.atguigu.mall.service;

import java.util.List;

import com.atguigu.mall.bean.Object_T_Mall_Attr;
import com.atguigu.mall.bean.T_Mall_Value;
import com.atguigu.mall.bean.OBJECT_T_MALL_SKU;

public interface SkuRedisService {
	
	List<Object_T_Mall_Attr> getProductAttrInfo(int flbh2);

	List<OBJECT_T_MALL_SKU> get_products_info_by_class_2_id(int class_2_id,String order_condition);

	List<OBJECT_T_MALL_SKU> get_products_info_by_class_2_id_attr_id_attr_value_id(int class_2_id, int i,
			int j);
}
