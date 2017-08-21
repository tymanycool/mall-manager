package com.atguigu.service;

import java.util.List;

import com.atguigu.bean.T_MALL_PRODUCT;

public interface SpuServiceInf {

	public void save_spu(T_MALL_PRODUCT spu, List<String> upload_images);
	
	public List<T_MALL_PRODUCT> query_all_product();
	
	public T_MALL_PRODUCT query_product_by_id(Integer id) ;

}
