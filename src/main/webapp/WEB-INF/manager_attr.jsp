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
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript">
	$(function(){
		/* $.getJSON("json/class_1.js",function(data){
			$(data).each(function(i,json){
				$("#attr_class_1_select").append("<option value="+json.id+">"+json.flmch1+"</option>");
			});
			attr_get_class_2_by_class_1_id(data[0].id);
		}); */
		
		$("#attr_class_1_select,#attr_class_2_select").combobox({
			width:100,
			value:"请选择"
		});
		$('#attr_class_1_select').combobox({    
		    url:'json/class_1.js',    
		    valueField:'id',    
		    textField:'flmch1',
		    onSelect:function(){
		    	//通过$().val()获取不到
		    	var class_1_id = $(this).combobox('getValue');
		    	//alert(class_1_id);
		    	//加载二级分类
		    	$("#attr_class_2_select").combobox({
		    		url:"json/class_2_"+class_1_id+".js",
		    		valueField:"id",
		    		textField:"flmch2",
		    		onSelect:function(){
		    			var text = $(this).combobox('getText');
		    			attr_get_attr_by_class_2_id($(this).combobox('getValue'));
		    			$("#attr_class_2_name").text("添加"+text+"属性");
		    		}
		    	});
		    	
		    }
		});  
		
		
		$("#attr_add_attr_btn").click(function(){
			if($("#attr_add_attr_btn").text()=="添加属性"){
				alert("请选择合适的二级分类");
				//href="goto_add_attr.do?class_2_id=${class_2_id}&class_2_name=${class_2_name}"
				return false;
			};
			//二级分类的值
			var value = $("#attr_class_2_select").combobox("getValue");
			//二级分类的文本
			var text = $("#attr_class_2_select").combobox("getText");
			$.post("/goto_add_attr.do",{
				"class_2_id":value,
				"class_2_name":text
			},function(data){
				var b = $('#index_tabs').tabs('exists',"商品属性信息管理(添加)");
					if(!b){
					$("#index_tabs").tabs('add',{    
					    title:"商品属性信息管理(添加)",    
					    content:data,   
					    closable:true   
					});  
				}else{
					$('#index_tabs').tabs('select',"商品属性信息管理(添加)");
				}
				//alert(data);
			})
		})
	});
	/* function attr_get_class_2_by_class_1_id(class_1_id){
		//var class_1_id = $("#attr_class_1_select option:selected").val();
		$.getJSON("json/class_2_"+class_1_id+".js",function(data){
			$("#attr_class_2_select").empty();
			$(data).each(function(i,json){
				$("#attr_class_2_select").append("<option value="+json.id+">"+json.flmch2+"</option>");
			});
			attr_get_attr_by_class_2_id(data[0].id);
		});
	} */
	
	function attr_get_attr_by_class_2_id(class_2_id){
		var class_2_name = $("#attr_class_2_select option:selected").text();
		/* $.post("attr_get_attr_by_class_2_id.do",{class_2_id:class_2_id,class_2_name:class_2_name},function(data){
			 $("#attr_list_area").html(data); 
		}); */
		//二级分类的值
		var value = $("#attr_class_2_select").combobox("getValue");
		//二级分类的文本
		var text = $("#attr_class_2_select").combobox("getText");
		$('#attr_table_attr_list').datagrid({    
		    url:'/attr_get_attr_by_class_2_id_json.do', 
		    queryParams:{"class_2_id":value,"class_2_name":text},
		    columns:[[    
		        {field:'shxm_mch',title:'属性名称',width:100},    
		        {field:'chjshj',title:'创建时间',width:150,formatter:function(value,row,index){
		        	//alert("row:"+row);
		        	//alert("index:"+index);
		        	var date = new Date(value);
		        	return date.toLocaleString();
		        }},    
		        {field:'list_value',title:'属性值',width:450,formatter:function(value,row){
		        	var name = ""; 
	   				$(value).each(function(i,json){
	   					name+=" "+json.shxzh+json.shxzh_mch;
	   				});
	   				
	   				return name;
		        }}    
		    ]]    
		});  
	}
	
	
	
</script>
<title>suser-test</title>
</head>
<body>
	<div class="easyui-layout" data-options="fit:true">   
		商品分类属性信息维护<br>
		<!-- <form id="sku_inner_form" action="save_sku.do" method="post"> -->
	        <div data-options="region:'west'" style="width:180px">
	        	<br><br>
		      	  一级分类：<select class="easyui-combobox" name="flbh1" id="attr_class_1_select" onChange="attr_get_class_2_by_class_1_id(this.value)"></select><br><br>
				  二级分类：<select class="easyui-combobox" name="flbh2" id="attr_class_2_select" onChange="attr_get_attr_by_class_2_id(this.value)"></select><br><br>
				<center>
					<a id="attr_add_attr_btn"  class="easyui-linkbutton" data-options="iconCls:'icon-add'"><span id="attr_class_2_name">添加属性</span></a><br>
	        	</center>
	        </div>   
	        <div data-options="region:'center',fit:true">
	        	<center>
	        		<!-- <div id="attr_list_area"></div> -->
	        		<table id="attr_table_attr_list">
	        			
	        		</table>
	        	</center>
			</div>
		<!-- </form> -->
   </div>   
	
</body>
</html>
