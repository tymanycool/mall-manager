package com.atguigu.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.atguigu.bean.MODEL_T_MALL_SKU_ATTR_VALUE;
import com.atguigu.bean.OBJECT_T_MALL_ATTR;
import com.atguigu.bean.T_MALL_PRODUCT;
import com.atguigu.bean.T_MALL_SKU;
import com.atguigu.service.SkuServiceImpl;
import com.atguigu.util.MyAjaxUtil;

@Controller
public class SkuController {
	
	@Autowired
	SkuServiceImpl skuServiceImpl;
	@RequestMapping("/goto_sku")
	public String goto_sku(){
		return "manager_sku";
	}
	
	@RequestMapping("/sku_get_attr_by_class_2_id")
	public Object sku_get_attr_by_class_2_id(String class_2_id,String class_2_name,ModelMap map){
		List<OBJECT_T_MALL_ATTR> list_attr = skuServiceImpl.get_attr_by_class_2_id(class_2_id);
		
		map.put("list_attr", list_attr);
		map.put("class_2_name", class_2_name);
		map.put("class_2_id", class_2_id);
		
		return "manager_sku_attr_inner";
	}
	
	@ResponseBody
	@RequestMapping("/sku_get_spu_by_class_2_tm_id")
	public List<T_MALL_PRODUCT> sku_get_spu_by_class_2_tm_id(String class_2_id,String pp_id){
		List<T_MALL_PRODUCT> spu_list = skuServiceImpl.get_spu_by_class_2_tm_id(class_2_id,pp_id);
		return spu_list;
	}
	
	@RequestMapping("/sku_save_sku")
	public String sku_save_sku(int spu_id, MODEL_T_MALL_SKU_ATTR_VALUE list_attr_value, T_MALL_SKU sku, ModelMap map) {

		skuServiceImpl.save_sku(spu_id, list_attr_value.getList_attr_value(), sku);
		return "manager_sku";
	}
	@ResponseBody
	@RequestMapping("/sku_save_sku_ajax")
	public Object sku_save_sku_ajax(int spu_id, MODEL_T_MALL_SKU_ATTR_VALUE list_attr_value, T_MALL_SKU sku) {
		Map<String, Object> map = MyAjaxUtil.getMap();
		try{
			skuServiceImpl.save_sku(spu_id, list_attr_value.getList_attr_value(), sku);
			map.put("success", "sku发布成功");
		}catch(Exception e){
			e.printStackTrace();
			map.put("success", "sku发布失败");
		}
		return map;
	}
}
