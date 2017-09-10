package com.atguigu.mall.service.impl;

import org.apache.log4j.Logger;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.atguigu.mall.bean.T_Mall_Product;
import com.atguigu.mall.mapper.SpuMapper;
import com.atguigu.mall.service.SpuService;

@Service
public class SpuServiceImpl implements SpuService {
	/**
	* Logger for this class
	*/
	private static final Logger logger = Logger.getLogger(SpuServiceImpl.class);

	
	
	@Autowired
	private SpuMapper spuMapper;
	
	
	@Override
	public void saveSpuInfo(T_Mall_Product spu, List<String> upLoad_images) {
		// 保存spu信息到t_mall_product;返回主键
		spuMapper.insert_new_product_spu_info(spu);
		
		//批量保存图片url到数据库t_mall_product_image
		int affectRows = spuMapper.insert_product_image_url(spu.getId(),upLoad_images);
		
		logger.info("执行插入语句返回主键为：------>"+spu.getId());
		
	}


}
