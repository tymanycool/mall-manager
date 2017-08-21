package com.atguigu.mapper;

import java.util.List;

import com.atguigu.bean.OBJECT_T_MALL_ATTR;
import com.atguigu.bean.T_MALL_ATTR;
import com.atguigu.bean.T_MALL_VALUE;

public interface AttrMapper {

	List<OBJECT_T_MALL_ATTR> select_attr_by_class_2_id(String class_2_id);

	void insert_attr(OBJECT_T_MALL_ATTR list_attr);

	void insert_attr_value(List<T_MALL_VALUE> list_value);

}
