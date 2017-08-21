package com.atguigu.controller;

import java.util.HashMap;
import java.util.List;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.atguigu.bean.MODEL_OBJECT_T_MALL_ATTR;
import com.atguigu.bean.OBJECT_T_MALL_ATTR;
import com.atguigu.service.AttrServiceImpl;

@Controller
public class AttrController {
	/**
	* Logger for this class
	*/
	@Autowired
	AttrServiceImpl attrServiceImpl;
	
	private static final Logger logger = Logger.getLogger(AttrController.class);
	
	@RequestMapping("/goto_attr")
	public String goto_attr(){
		return "manager_attr";
	}
	@RequestMapping("/goto_add_attr")
	public String goto_add_attr(String class_2_id,String class_2_name,ModelMap map ){
		map.put("class_2_id", class_2_id);
		map.put("class_2_name", class_2_name);
		
		return "manager_attr_add";
	}
	
	@RequestMapping("/attr_get_attr_by_class_2_id")
	public String attr_get_attr_by_class_2_id(String class_2_id,String class_2_name,ModelMap map){
		List<OBJECT_T_MALL_ATTR> list_attr = attrServiceImpl.get_attr_by_class_2_id(class_2_id);
		map.put("list_attr", list_attr);
		map.put("class_2_name", class_2_name);
		map.put("class_2_id", class_2_id);
		
		return "manager_attr_inner";
	}
	
	@ResponseBody
	@RequestMapping("/attr_get_attr_by_class_2_id_json")
	public List<OBJECT_T_MALL_ATTR> attr_get_attr_by_class_2_id_json(String class_2_id,String class_2_name,ModelMap map){
		List<OBJECT_T_MALL_ATTR> list_attr = attrServiceImpl.get_attr_by_class_2_id(class_2_id);
		map.put("list_attr", list_attr);
		map.put("class_2_name", class_2_name);
		map.put("class_2_id", class_2_id);
		
		return list_attr;
	}
	
	@RequestMapping("/add_attr")
	public ModelAndView add_attr(MODEL_OBJECT_T_MALL_ATTR list_attr,String class_2_id,String class_2_name){
		for (OBJECT_T_MALL_ATTR attr : list_attr.getList_attr()) {
			//设置是否启用
			attr.setShfqy("1");
			//设置集合的二级分类编号
			attr.setFlbh2(Integer.parseInt(class_2_id));
		}
		//调用业务方法
		attrServiceImpl.add_attr(list_attr.getList_attr());
		
		//ModelAndView mav = new ModelAndView("redirect:/goto_add_attr.do");
		ModelAndView mav = new ModelAndView("redirect:/index.jsp");
		mav.addObject("class_2_id",class_2_id);
		mav.addObject("class_2_name",class_2_name);
		mav.addObject("success","添加成功~~~");
		
		return mav;
	}
	@ResponseBody
	@RequestMapping("/add_attr_json")
	public Object add_attr_json(MODEL_OBJECT_T_MALL_ATTR list_attr,String class_2_id,String class_2_name){
		for (OBJECT_T_MALL_ATTR attr : list_attr.getList_attr()) {
			//设置是否启用
			attr.setShfqy("1");
			//设置集合的二级分类编号
			attr.setFlbh2(Integer.parseInt(class_2_id));
		}
		//调用业务方法
		attrServiceImpl.add_attr(list_attr.getList_attr());
		
		
		HashMap<String, Object> map = new HashMap<String,Object>();
		map.put("class_2_id",class_2_id);
		map.put("class_2_name",class_2_name);
		map.put("success","**************添加成功***************");
		
		return map;
	}
	
}
