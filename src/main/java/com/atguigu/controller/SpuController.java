package com.atguigu.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.atguigu.bean.T_MALL_PRODUCT;
import com.atguigu.service.SpuServiceImp;
import com.atguigu.util.MyUploadUtil;

@Controller
public class SpuController {

	@Autowired
	SpuServiceImp spuServiceImp;

	@RequestMapping("/save_spu")
	public ModelAndView save_spu(T_MALL_PRODUCT spu, @RequestParam("files") MultipartFile[] files
			,String index_redirect_tabs_title_array,String index_redirect_tabs_url_array,
			String index_redirect_tabs_current_title) {

		// 上传图片，返回图片的url
		List<String> upload_images = MyUploadUtil.upload_images(files);

		// 调用业务层的保存spu的方法
		spuServiceImp.save_spu(spu, upload_images);
		ModelAndView mav = new ModelAndView("redirect:/manager_index.htm");
		mav.addObject("index_redirect_tabs_title_array",index_redirect_tabs_title_array);
		mav.addObject("index_redirect_tabs_url_array",index_redirect_tabs_url_array);
		mav.addObject("index_redirect_tabs_current_title",index_redirect_tabs_current_title);
		mav.addObject("success","spu发布成功~~~");
		//return "redirect:/goto_spu.do";
		return mav;
		//return "redirect:/index.jsp?index_redirect_tabs_title_array="+index_redirect_tabs_title_array;
	}
	
	@RequestMapping("/product_list")
	public String product_list(Model model){
		List<T_MALL_PRODUCT> list = spuServiceImp.query_all_product();
		model.addAttribute("products",list);
		return "product_list";
	}
	@RequestMapping("/product_query_befor_update")
	public String product_query_befor_update(Integer id,Model model){
		T_MALL_PRODUCT product =  spuServiceImp.query_product_by_id(id);
		model.addAttribute("product",product);
		return "product_update";
	}
	

	@RequestMapping("/goto_spu")
	public String goto_spu() {
		return "manager_spu";
	}

}
