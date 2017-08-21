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
<!-- <script type="text/javascript" src="jquery/jquery-1.7.2.min.js"></script> -->
<!-- <script type="text/javascript" src="jquery/jquery-form/jquery-form.min.js"></script> -->
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript">

	//表格的初始化数据
	var attr_table_init_content = "";
	//用于控制表格添加的索引
	var attr_add_table_index = 0;
	$(function(){
		
		attr_table_init_content+='<table border="1" id="attr_add_table_0" cellpadding="0" cellspacing="0">';
		attr_table_init_content+='	<tr><td>属性名:<input type="text" name="list_attr[0].shxm_mch"/></td><td></td><td><a href="javascript:attr_add_table_tr(0);">添加属性值</a></td></tr>';
		attr_table_init_content+='	<tr><td>属性值:<input type="text" name="list_attr[0].list_value[0].shxzh"/></td><td>属性值名:<input type="text" name="list_attr[0].list_value[0].shxzh_mch"/></td><td><a href="#">删除</a></td></tr>';
		attr_table_init_content+='</table>';
		$("#attr_add_table_area").html(attr_table_init_content);
	});
	
	function attr_add_table(){
		var a = '<hr><table border="1" cellpadding="0" cellspacing="0" id="attr_add_table_'+(attr_add_table_index+1)+'">';
		var b = '<tr><td>属性名:<input type="text" name="list_attr['+(attr_add_table_index+1)+'].shxm_mch"/></td><td></td><td><a href="javascript:attr_add_table_tr('+(attr_add_table_index+1)+');">添加属性值</a></td></tr>';
		var c = '<tr><td>属性值:<input type="text" name="list_attr['+(attr_add_table_index+1)+'].list_value[0].shxzh"/></td><td>属性值名:<input type="text" name="list_attr['+(attr_add_table_index+1)+'].list_value[0].shxzh_mch"/></td><td><a href="#">删除</a></td></tr>';
		var d = '</table>';
		$("#attr_add_table_"+attr_add_table_index).after(a+b+c+d);
		attr_add_table_index++;
	}
	
	function attr_add_table_tr(table_index){
		// 控制属性值下标的index
		var tr_index = $("#attr_add_table_"+table_index+" tr").length - 1;
		var a = '<tr><td>属性值:<input type="text" name="list_attr['+table_index+'].list_value['+tr_index+'].shxzh"/></td><td>属性值名:<input type="text" name="list_attr['+table_index+'].list_value['+tr_index+'].shxzh_mch"/></td><td><a href="#">删除</a></td></tr>';
		$("#attr_add_table_"+table_index).append(a);
	}
	function attr_submit(){
		alert("submit");
		//return false;
		$("#attr_add_attr_form").ajaxSubmit({
			success:function(data){
				//alert(data);
				//alert("ok...");
				//alert(data);
				//$(document).html(data);attr_table_init_content
				$("#attr_add_table_area").html(attr_table_init_content);
				$("#attr_add_status").text(data.success);
				//更新索引
				attr_add_table_index=0;
			}
		});
	}
</script>
<title>硅谷商城后台</title>
</head>
<body>
		<div id="cc" class="easyui-layout" data-options="fit:true" >   
		    <div data-options="region:'south',title:'修改状态',split:true" style="height:55px;">
		    	<span id="attr_add_status"></span>
		    </div>   
		    <div data-options="region:'center',title:'center title'" style="padding:5px;background:#eee;">
			   <form id="attr_add_attr_form" action="/add_attr_json.do" method="post">
				  <%--  ${class_2_id} ${class_2_name}<br> --%>
					<input type="hidden" name="class_2_name" value="${class_2_name}"/>
					<input type="hidden" name="class_2_id"  value="${class_2_id}"/>
					<h3>添加${class_2_name}分类属性</h3>
					<a href="javascript:attr_add_table();">添加属性</a>
					<div id = "attr_add_table_area">
						
					</div>
					<br>
					<input type="button" onclick="attr_submit()" value="发布分类属性"/>
				</form>
		    </div>   
		</div>  

		
		
	   
	
</body>
</html>