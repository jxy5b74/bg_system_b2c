package com.atguigu.mall.service.impl;

import org.apache.log4j.Logger;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.atguigu.mall.bean.Object_T_Mall_Attr;
import com.atguigu.mall.bean.T_Mall_Attr;
import com.atguigu.mall.bean.T_Mall_Value;
import com.atguigu.mall.mapper.AttrMapper;
import com.atguigu.mall.service.AttrService;


@Service
public class AttrServiceImpl implements AttrService {
	/**
	* Logger for this class
	*/
	private static final Logger logger = Logger.getLogger(AttrServiceImpl.class);

	@Autowired
	private AttrMapper attrMapper;
	
	@Override
	public List<Object_T_Mall_Attr> getProductAttrInfo(int flbh2) {
		return attrMapper.selectProductAttrInfo(flbh2);
	}

	@Override
	public int multi_add_product_attr_info(List<Object_T_Mall_Attr> attrList, int flbh2) {
		Iterator<Object_T_Mall_Attr> iterator = attrList.iterator();
		
		int affectRows_count = 0;
		//Map<String,String> map = new HashMap<>();
		
		/*List<String> attr_name_list = new ArrayList();*/
		
		while(iterator.hasNext()){
			Object_T_Mall_Attr otma = iterator.next();
			/*attr_name_list.add(otma.getShxm_mch());*/
			//遍历所有的新增属性，每遍历出一个向t_mall_attr表中插入一条数据，并返回主键
			
			otma.setFlbh2(flbh2);

			int affectRows = attrMapper.insert_new_attr_into_t_mall_attr(otma);
			
			logger.info("向t_mall_attr表中插入新的商品属性，返回受影响的行数(正确的话应该是1)："+affectRows);
			
			List<T_Mall_Value> valueList = otma.getValueList();
			
			int shxm_id = otma.getId();
			
			logger.info("每遍历一个 Object_T_Mall_Attr对象 插入 t_mall_attr表中shxm_mch所返回的主键id：--->"+shxm_id);
			
			List<T_Mall_Value> attr_info_list = new ArrayList<>();
			
			Iterator<T_Mall_Value> iterator2 = valueList.iterator();
			while(iterator2.hasNext()){
				
				T_Mall_Value next = iterator2.next();
				
				next.setShxm_id(shxm_id);
				
				attr_info_list.add(next);
				
			}
			
			int affectRows2 = attrMapper.insert_into_t_mall_value(attr_info_list);
			affectRows_count += affectRows2;
		}
		
		logger.info("向t_mall_value表中插入数据，最终返回受影响的行数为："+affectRows_count);
		
		return affectRows_count;
	}

}
