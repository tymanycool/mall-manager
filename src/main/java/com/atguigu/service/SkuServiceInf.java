package com.atguigu.service;

import java.util.List;

import com.atguigu.bean.OBJECT_T_MALL_ATTR;
import com.atguigu.bean.T_MALL_PRODUCT;
import com.atguigu.bean.T_MALL_SKU;
import com.atguigu.bean.T_MALL_SKU_ATTR_VALUE;

public interface SkuServiceInf {
	
	public List<OBJECT_T_MALL_ATTR> get_attr_by_class_2_id(String class_2_id);
	
	public List<T_MALL_PRODUCT> get_spu_by_class_2_tm_id(String class_2_id, String pp_id);
	
	public void save_sku(int spu_id, List<T_MALL_SKU_ATTR_VALUE> list_attr_value, T_MALL_SKU sku);
}
