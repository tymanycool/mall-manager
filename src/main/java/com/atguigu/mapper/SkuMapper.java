package com.atguigu.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.atguigu.bean.OBJECT_T_MALL_ATTR;
import com.atguigu.bean.T_MALL_PRODUCT;
import com.atguigu.bean.T_MALL_SKU;

public interface SkuMapper {

	List<OBJECT_T_MALL_ATTR> select_attr_by_class_2_id(String class_2_id);

	List<T_MALL_PRODUCT> select_spu_by_class_2_tm_id(@Param("class_2_id") String class_2_id,@Param("pp_id") String pp_id);

	void insert_sku(T_MALL_SKU sku);

	void insert_attr_value(HashMap<String, Object> hashMap);

}
