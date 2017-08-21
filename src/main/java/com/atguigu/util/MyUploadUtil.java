package com.atguigu.util;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

public class MyUploadUtil {

	public static List<String> upload_images(MultipartFile[] files) {
		List<String> list_images = new ArrayList<String>();

		// 循环插入图片
		String property = MyPropertyUtil.getProperty("uploadPath.properties","windows_path");

		for (int i = 0; i < files.length; i++) {
			//防止上传垃圾数据
			if(files[i].getSize()==0)
				continue;
			// UUID randomUUID = UUID.randomUUID();
			String originalFilename = System.currentTimeMillis() + "_" + files[i].getOriginalFilename();

			File file = new File(property + "\\" + originalFilename);
			list_images.add(originalFilename);
			try {
				files[i].transferTo(file);
			} catch (IllegalStateException | IOException e) {
				e.printStackTrace();
			}
		}
		
		return list_images;
	}

}
