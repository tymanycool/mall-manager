package com.atguigu.util.mybatis;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

import com.google.gson.Gson;

public class MyStaticFileUtil {
	private static SqlSessionFactory factory = null;
	
	private static List<File> files = new ArrayList<File>();
	
	private static SqlSessionFactory getSqlSessionFactory() {
		if (factory == null) {
			synchronized (MyStaticFileUtil.class) {
				if (factory == null) {
					InputStream is = MyStaticFileUtil.class.getClassLoader()
							.getResourceAsStream("com/atguigu/util/mybatis/mybatis-config.xml");
					factory = new SqlSessionFactoryBuilder().build(is);
					return factory;
				}
			}
		}
		return factory;
	}
	
	public static void main(String[] args) throws Exception{
		generate();
	}

	public static void generate() throws IOException, FileNotFoundException {
		SqlSessionFactory factory = getSqlSessionFactory();
		SqlSession session = factory.openSession();
		Mapper mapper = session.getMapper(Mapper.class);
		List<Object> results = query(files,mapper);
		List<String> jsons = new ArrayList<String>();
		if(results!=null){
			for (Object result : results) {
				Gson gson = new Gson();
				jsons.add(gson.toJson(result));
			}
		}else{
			System.out.println("---没有查询的结果---");
			return;
		}
		if(files!=null){
			FileOutputStream fos = null;
			for(int i = 0;i<files.size();i++){
				File parent = files.get(i).getParentFile();
				//如果目录不在在则，创建
				if(!parent.exists()){
					parent.mkdirs();
				}
				files.get(i).createNewFile();
				fos = new FileOutputStream(files.get(i));
				fos.write(jsons.get(i).getBytes());
				fos.close();
			}
		}else{
			System.out.println("---没有指定生成文件的目录---");
			return;
		}
		System.out.println("---生成成功---");
	}
	//一个File对应一个查询结果
	public static List<Object> query(List<File> files,Mapper mapper) {
		List<Object> result = new ArrayList<Object>();
		//指定第一个文件
		files.add(new File("src/main/webapp/json/class_1.js"));
		//第一个文件对应的数据库的查询结果
		List<Object> query = mapper.query();
		result.add(query);
		
		//查询一级分类对应的二级分类
		for(int i=0;i<query.size();i++){
			Map map = (Map) query.get(i);
			//指定第一个文件
			files.add(new File("src/main/webapp/json/class_2_"+map.get("id")+".js"));
			//第一个文件对应的数据库的查询结果
			List<Object> queryById = mapper.queryById((Integer)map.get("id"));
			result.add(queryById);
		}
		//查询一级分类对应的商标
		for(int i=0;i<query.size();i++){
			Map map = (Map) query.get(i);
			//指定第一个文件
			files.add(new File("src/main/webapp/json/tm_class_1_"+map.get("id")+".js"));
			//第一个文件对应的数据库的查询结果
			List<Object> queryById = mapper.queryById1((Integer)map.get("id"));
			result.add(queryById);
		}
		
		return result;
	}
}
