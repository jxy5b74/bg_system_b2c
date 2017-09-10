package com.atguigu.mall.service;

import java.util.List;

import com.atguigu.mall.bean.Object_T_Mall_Attr;
import com.atguigu.mall.bean.T_Mall_Attr;

public interface AttrService {

	List<Object_T_Mall_Attr> getProductAttrInfo(int flbh2);

	int multi_add_product_attr_info(List<Object_T_Mall_Attr> attrList, int flbh2);

}
