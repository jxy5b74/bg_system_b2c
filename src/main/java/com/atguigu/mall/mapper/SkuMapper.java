package com.atguigu.mall.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.atguigu.mall.bean.Object_T_Mall_Attr;
import com.atguigu.mall.bean.T_Mall_Product;
import com.atguigu.mall.bean.T_Mall_Sku;
import com.atguigu.mall.bean.T_Mall_Sku_Attr_Value;

public interface SkuMapper {

	List<Object_T_Mall_Attr> selectProductAttrInfo(int flbh2);

	List<T_Mall_Product> selectProductSpuInfo(@Param("flbh2")int flbh2, @Param("pp_id")int pp_id);

	//向SKU表中新增一条信息
	int insert_sku_info_into_t_mall_sku(T_Mall_Sku sku);

	//向T_MALL_SKU_ATTR_VALUE表中新增关联关系数据
	int insert_sku_attr_value_info_into_t_mall_sku_attr_value(@Param("sku_attr_value_list")List<T_Mall_Sku_Attr_Value> sku_attr_value_list);
	
}
