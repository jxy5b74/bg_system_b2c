package com.atguigu.mall.service;

import java.util.List;

import com.atguigu.mall.bean.T_Mall_Product;

public interface SpuService {

	public void saveSpuInfo(T_Mall_Product spu, List<String> upLoad_images);
	
}
