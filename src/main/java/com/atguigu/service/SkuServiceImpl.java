package com.atguigu.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.atguigu.bean.OBJECT_T_MALL_ATTR;
import com.atguigu.bean.T_MALL_PRODUCT;
import com.atguigu.bean.T_MALL_SKU;
import com.atguigu.bean.T_MALL_SKU_ATTR_VALUE;
import com.atguigu.mapper.SkuMapper;

@Service
public class SkuServiceImpl implements SkuServiceInf{
	
	@Autowired
	SkuMapper skuMapper;

	public List<OBJECT_T_MALL_ATTR> get_attr_by_class_2_id(String class_2_id) {
		return skuMapper.select_attr_by_class_2_id(class_2_id);
	}
	
	public List<T_MALL_PRODUCT> get_spu_by_class_2_tm_id(String class_2_id, String pp_id) {
		
		return skuMapper.select_spu_by_class_2_tm_id(class_2_id,pp_id);
	}

	public void save_sku(int spu_id, List<T_MALL_SKU_ATTR_VALUE> list_attr_value, T_MALL_SKU sku) {
		// 插入库存信息，返回主键
		sku.setShp_id(spu_id);
		skuMapper.insert_sku(sku);
		// 批量插入sku属性关联信息
	
		HashMap<String, Object> hashMap = new HashMap<String, Object>();
		hashMap.put("list_attr_value", list_attr_value);
		hashMap.put("sku_id", sku.getId());
		hashMap.put("spu_id", spu_id);
		skuMapper.insert_attr_value(hashMap);

	}

}
