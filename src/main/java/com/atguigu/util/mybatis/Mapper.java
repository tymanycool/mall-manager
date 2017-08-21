package com.atguigu.util.mybatis;

import java.util.List;

public interface Mapper {
	//查询一级分类
	List<Object> query();
	//查询一级分类对应的二级分类
	List<Object> queryById(int id);
	//查询一级分类对应的商标
	List<Object> queryById1(int id);
}
