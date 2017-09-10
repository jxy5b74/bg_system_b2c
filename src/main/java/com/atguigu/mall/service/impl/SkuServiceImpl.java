package com.atguigu.mall.service.impl;

import org.apache.log4j.Logger;

import java.util.Iterator;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.atguigu.mall.bean.Model_T_Mall_Sku_Attr_Value;
import com.atguigu.mall.bean.Object_T_Mall_Attr;
import com.atguigu.mall.bean.T_Mall_Product;
import com.atguigu.mall.bean.T_Mall_Sku;
import com.atguigu.mall.bean.T_Mall_Sku_Attr_Value;
import com.atguigu.mall.mapper.SkuMapper;
import com.atguigu.mall.service.SkuService;

@Service
public class SkuServiceImpl implements SkuService {
	/**
	* Logger for this class
	*/
	private static final Logger logger = Logger.getLogger(SkuServiceImpl.class);

	@Autowired
	private SkuMapper skuMapper;
	
	//为了与AttrService业务层解耦
	@Override
	public List<Object_T_Mall_Attr> getProductAttrInfo(int flbh2) {
		return skuMapper.selectProductAttrInfo(flbh2);
	}

	//异步加载分类编号2下的所有商品名称，到前台页面json格式
	@Override
	public List<T_Mall_Product> get_product_spu_info(int flbh2 ,int pp_id) {
		return skuMapper.selectProductSpuInfo(flbh2,pp_id);
	}

	@Override
	public int add_new_product_sku_related_info(T_Mall_Sku sku, Model_T_Mall_Sku_Attr_Value attr_value) {
		
		int affectRows = skuMapper.insert_sku_info_into_t_mall_sku(sku);
		
		logger.info("向t_mall_sku表中插入数据返回受影响的行数：不出意外应该是1---->"+affectRows);
		
		//插入数据库返回，利用数据库的主键返回功能获得sku_id
		int sku_id = sku.getId();
		int shp_id = sku.getShp_id();
		
		
		
		List<T_Mall_Sku_Attr_Value> sku_attr_value_list = attr_value.getSku_attr_value_list();
		
		Iterator<T_Mall_Sku_Attr_Value> iterator = sku_attr_value_list.iterator();
		
		while(iterator.hasNext()){
			T_Mall_Sku_Attr_Value sku_Attr_Value = iterator.next();
			//将获取到的返回的t_mall_sku表中的主键值sku_id赋予每个sku_attr_value对象
			sku_Attr_Value.setSku_id(sku_id);
			sku_Attr_Value.setShp_id(shp_id);
		}
		
		int affectRows2 = skuMapper.insert_sku_attr_value_info_into_t_mall_sku_attr_value(sku_attr_value_list);
		
		return affectRows2;
	}

}
