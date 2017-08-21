package com.atguigu.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.atguigu.bean.T_MALL_PRODUCT;
import com.atguigu.mapper.SpuMapper;

@Service
public class SpuServiceImp implements SpuServiceInf {

	@Autowired
	SpuMapper spuMapper;

	public void save_spu(T_MALL_PRODUCT spu, List<String> upload_images) {
		
		// 设置头图
		spu.setShp_tp(upload_images.get(0));
		
		// 保存spu信息，返回主键
		spuMapper.insert_spu(spu);
		
		// 批量保存image数据
		spuMapper.insert_spu_images(spu.getId(), upload_images);
	}

	public List<T_MALL_PRODUCT> query_all_product() {
		return spuMapper.select_all_product();
	}

	public T_MALL_PRODUCT query_product_by_id(Integer id) {
		return spuMapper.select_product_by_id(id);
	}

}
