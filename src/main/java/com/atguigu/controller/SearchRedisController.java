package com.atguigu.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.atguigu.bean.OBJECT_T_MALL_SKU;
import com.atguigu.bean.T_MALL_SKU_ATTR_VALUE;
import com.atguigu.service.SearchServiceImp;
import com.atguigu.util.JedisPoolUtils;
import com.atguigu.util.MyJsonUtil;

import redis.clients.jedis.Jedis;

@Controller
public class SearchRedisController {

	@Autowired
	SearchServiceImp searchServiceImp;

	@RequestMapping("refresh_attr")
	@ResponseBody
	public long refresh_attr(int class_2_id, @RequestParam("attr_array[]") int[] attr_array) {

		Jedis jedis = JedisPoolUtils.getJedis();

		long sum = 0L;

		// 循环属性id，查询每个属性的对应的属性值集合
		for (int i = 0; i < attr_array.length; i++) {

			List<Integer> list_vid = searchServiceImp.get_value_by_attr_id(attr_array[i]);
			// 循环属性值集合，查询每个属性值对应的sku商品数据集合
			for (int j = 0; j < list_vid.size(); j++) {
				T_MALL_SKU_ATTR_VALUE t_MALL_SKU_ATTR_VALUE = new T_MALL_SKU_ATTR_VALUE();
				List<T_MALL_SKU_ATTR_VALUE> arrayList = new ArrayList<T_MALL_SKU_ATTR_VALUE>();
				t_MALL_SKU_ATTR_VALUE.setShxm_id(attr_array[i]);
				t_MALL_SKU_ATTR_VALUE.setShxzh_id(list_vid.get(j));
				arrayList.add(t_MALL_SKU_ATTR_VALUE);
				List<OBJECT_T_MALL_SKU> list_sku = searchServiceImp.get_sku_by_attr("", class_2_id, arrayList);

				String key = "av_" + class_2_id + "_" + attr_array[i] + "_" + list_vid.get(j);
				jedis.del(key);
				// 循环sku商品数据集合，添加到属性值生成zset中
				for (int k = 0; k < list_sku.size(); k++) {
					jedis.zadd(key, k, MyJsonUtil.get_json(list_sku.get(k)));
				}
				sum += list_sku.size();
			}
		}

		return sum;
	}

	@RequestMapping("goto_search_redis")
	public String goto_search_redis() {

		return "manager_search_redis";
	}

	@RequestMapping("refresh_class_2")
	@ResponseBody
	public int refresh_class_2(int class_2_id) {
		// redis
		Jedis jedis = JedisPoolUtils.getJedis();

		// 根据二级分类id查询sku集合
		List<OBJECT_T_MALL_SKU> list_sku = searchServiceImp.get_sku_by_class_2(class_2_id);

		// 循环sku集合，转成json放入redis的zset
		String key = "class_2_" + class_2_id;
		jedis.del(key);
		for (int i = 0; i < list_sku.size(); i++) {
			String get_json = MyJsonUtil.get_json(list_sku.get(i));
			jedis.zadd(key, i, get_json);
		}

		return list_sku.size();
	}

}
