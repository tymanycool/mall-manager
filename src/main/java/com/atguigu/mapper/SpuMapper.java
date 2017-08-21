package com.atguigu.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.atguigu.bean.T_MALL_PRODUCT;

public interface SpuMapper {

	void insert_spu(T_MALL_PRODUCT spu);

	void insert_spu_images(@Param("id") int id, @Param("upload_images") List<String> upload_images);

	List<T_MALL_PRODUCT> select_all_product();

	T_MALL_PRODUCT select_product_by_id(Integer id);

}
