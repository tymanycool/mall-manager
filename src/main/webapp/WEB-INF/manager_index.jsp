<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page isELIgnored="false"  %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/";%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<base href="<%=basePath %>">

<script type="text/javascript" src="jquery/jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="jquery/jquery-form/jquery-form.min.js"></script>
<script type="text/javascript" src="easyui/jquery.easyui.min.js"></script>

<link rel="stylesheet" type="text/css" href="easyui/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="easyui/themes/icon.css">

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript">
	//保存重定向回首页的选项卡title
	var index_redirect_tabs_title_array = new Array();
	//保存重定向回首页的选项卡url
	var index_redirect_tabs_url_array = new Array();
	//保存当前页
	var index_redirect_tabs_current_title = "";
	var index_redirect_tabs_current_title_redirect = "";
	var index_tabs_count=0;//选项卡每选中一次加1
	//当执行完所有的选项卡再选中,'当前选项卡' $('#index_tabs').tabs('select',index_redirect_tabs_current_title_redirect);
	var index_tabs_count_length=0;//打开的总的选项卡的个数在$(function(){})中初始化;
	
	$(function(){
		var titles_string = "${param.index_redirect_tabs_title_array}";
		var urls_string = "${param.index_redirect_tabs_url_array}";
		var cur_title_string = "${param.index_redirect_tabs_current_title}";
		index_redirect_tabs_current_title_redirect=cur_title_string;
		//alert(titles_string);
		//alert(urls_string);
		//alert("${success}");

		if(titles_string != ""){
			var titles = titles_string.split(",");
			var urls = urls_string.split(",");
			index_tabs_count_length = titles.length;
			
			for(var i = 0;i<titles.length;i++){
				
				index_add_tabs(urls[i],titles[i]);
			}
			//index_add_tabs(cur_url_string,cur_title_string);
			//index_redirect_tabs_current_title=cur_title_string; 
			//$('#index_tabs').tabs('select',index_redirect_tabs_current_title);
		}
		
		
	});
	
	
	function index_add_tabs(url,title){
		//alert("ok");
		var b = $('#index_tabs').tabs('exists',title);
		if(!b){
			index_redirect_tabs_title_array.push(title);
			index_redirect_tabs_url_array.push(url);
			//alert(index_redirect_tabs_current_title);
			
			$.post(url,{},function(data){
				$("#index_tabs").tabs('add',{    
				    title:title,    
				    content:data,   
				    closable:true
				});  
				
			});
			//选项卡被选中时触发
			$('#index_tabs').tabs({    
			    border:false,
			    onSelect:function(title,index){    
			        //alert(title+' is selected'+index);   
				   	index_redirect_tabs_current_title=title;
				   	index_tabs_count++;
			        if(index_tabs_count==index_tabs_count_length){
			        	$('#index_tabs').tabs('select',index_redirect_tabs_current_title_redirect);
			        }
			      //  alert(index_redirect_tabs_current_title);
			    } 
			}); 
			$('#index_tabs').tabs({
				onBeforeClose: function(title){
					return confirm('您确认想要关闭 ' + title);
			  	}
			});

		}else{
			$('#index_tabs').tabs('select',title);
		}
		
	}
	


</script>
<title>硅谷商城后台</title>
</head>
<body class="easyui-layout">
	<div data-options="region:'north',border:false" style="height:80px;background:#B3DFDA;padding:10px">
		<h1>尚硅谷电商后台管理系统</h1>
	</div>
	<div data-options="region:'west',split:true,title:'商品后台管理'" style="width:240px;padding:10px;">
	
		<ul class="easyui-tree">
			<li>
				<span>商品后台管理</span>
				<ul>
					<li>
						<span>商品spu信息管理</span>
						<ul>
							<li><a href="javascript:;" onclick="index_add_tabs('/goto_spu.htm','商品spu信息管理(发布)')">发布</a></li>
							<li><a href="javascript:;" onclick="index_add_tabs('/product_list.htm','商品spu信息管理(修改)')">修改</a></li>
						</ul>
					</li>
					<li>
						<span>商品属性信息管理</span>
						<ul>
							<li><a href="javascript:;" onclick="index_add_tabs('/goto_attr.htm','商品属性信息管理')">属性管理</a></li>
						</ul>
					</li>
					<li>
						<span>商品库存信息管理</span>
						<ul>
							<li><a href="javascript:;" onclick="index_add_tabs('/goto_sku.htm','商品库存信息管理(发布)')">发布</a></li>
							<li>更新</li>
							<li>删除</li>
						</ul>
					</li>
					<li>
						<span>
							缓存信息管理
						</span>
						<ul>
							<li>用户缓存管理</li>
							<li><a href="javascript:;" onclick="index_add_tabs('/goto_search_redis.do','检索缓存管理')">检索缓存管理</a></li>
						</ul>
					</li>
				</ul>
			</li>
		</ul>
		
		
	
	</div>
	<div data-options="region:'east',split:true,collapsed:true,title:'East'" style="width:100px;padding:10px;">east region</div>
	<div data-options="region:'south',border:false" style="height:50px;background:#A9FACD;padding:10px;">south region</div>
	<div data-options="region:'center',title:'Center'">
		
		<div id="index_tabs"  class="easyui-tabs" style="height:490px">
			
		</div>
	</div>
</body>

</html>