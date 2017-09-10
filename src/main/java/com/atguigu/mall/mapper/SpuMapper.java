package com.atguigu.mall.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.atguigu.mall.bean.T_Mall_Product;

public interface SpuMapper {

	void insert_new_product_spu_info(T_Mall_Product spu);

	int insert_product_image_url(@Param("spu_id")int spu_id, @Param("urls")List<String> upLoad_images);

}
