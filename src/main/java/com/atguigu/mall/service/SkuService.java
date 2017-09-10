package com.atguigu.mall.service;

import java.util.List;

import com.atguigu.mall.bean.Model_T_Mall_Sku_Attr_Value;
import com.atguigu.mall.bean.Object_T_Mall_Attr;
import com.atguigu.mall.bean.T_Mall_Product;
import com.atguigu.mall.bean.T_Mall_Sku;

public interface SkuService {

	List<Object_T_Mall_Attr> getProductAttrInfo(int flbh2);

	List<T_Mall_Product> get_product_spu_info(int flbh2, int pp_id);

	int add_new_product_sku_related_info(T_Mall_Sku sku, Model_T_Mall_Sku_Attr_Value attr_value);

}
