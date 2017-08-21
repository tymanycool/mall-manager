package com.atguigu.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import com.atguigu.mapper.IndexMapper;
import com.atguigu.service.IndexServiceImpl;

@Controller
public class IndexController {
	
	@Autowired
	IndexServiceImpl indexServiceImpl;
	
	@RequestMapping("/test")
	public String test(){
		
		int test = indexServiceImpl.test();
		System.out.println(test);
		
		return "test";
	}
	
	@RequestMapping("/manager_index")
	public String manager_index(String success,ModelMap map){
		
		map.put("success", success);
		return "manager_index";
	}
	
	@RequestMapping("/manager_full")
	public String manager_full(){
		return "manager_full";
	}
	
}
