package com.atguigu.mall.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.atguigu.mall.bean.OBJECT_T_MALL_SKU;
import com.atguigu.mall.bean.Object_T_Mall_Attr;

public interface SkuRedisMapper {

	List<Object_T_Mall_Attr> selectProductAttrInfo(int flbh2);

	List<OBJECT_T_MALL_SKU> select_products_info_by_class_2_id(@Param("class_2_id") int class_2_id,@Param("order_condition")String order_condition);

	List<OBJECT_T_MALL_SKU> select_products_info_by_class_2_id_attr_id_attr_value_id(Map paramMap);

}
