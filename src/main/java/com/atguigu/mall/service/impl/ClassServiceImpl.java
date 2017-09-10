package com.atguigu.mall.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.atguigu.mall.mapper.ClassMapper;
import com.atguigu.mall.service.ClassService;

@Service
public class ClassServiceImpl implements ClassService {

	@Autowired
	private ClassMapper classMapper;
	
	@Override
	public int getClass_1_num() {
		return classMapper.getClass_1_num();
	}

	
}
