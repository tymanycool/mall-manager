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
	/* $(function(){
		$.getJSON("json/class_1.js",function(data){
			$(data).each(function(i,json){
				//alert(json[0]);
				$("#sku_class_1_select").append("<option value="+json.id+">"+json.flmch1+"</option>");
			});
			
			// 加载二级分类
			sku_get_class_2_by_class_1_id(data[0].id);
			// 加载商标
			sku_get_tm_by_class_1_id(data[0].id);
			// 加载spu
			//alert(data[0].pp_id);
			//sku_get_spu_by_class_2_tm_id(data[0].pp_id);
		});
		
	}); */
	
	$(function(){
		$("#sku_class_1_select,#sku_class_2_select,#sku_tm_select,#sku_class_spu_select").combobox({
			width:100,
			value:"请选择"
		});
		$('#sku_class_1_select').combobox({    
		    url:'json/class_1.js',    
		    valueField:'id',    
		    textField:'flmch1',
		    onSelect:function(){
		    	//通过$().val()获取不到
		    	var class_1_id = $(this).combobox('getValue');
		    	//alert(class_1_id);
		    	//加载二级分类
		    	$("#sku_class_2_select").combobox({
		    		url:"json/class_2_"+class_1_id+".js",
		    		valueField:"id",
		    		textField:"flmch2",
		    		onSelect:function(){
		    			sku_get_spu();
		    		}
		    	});
		    	//加载品牌
		    	$("#sku_tm_select").combobox({
		    		url:"json/tm_class_1_"+class_1_id+".js",
		    		valueField:"id",
		    		textField:"ppmch",
		    		onSelect:function(){
		    			sku_get_spu();
		    		}
		    	});
		    	
		    	
		    }
		});
	});
	//根据class_2_id,pp_id获取商品的列表
	function sku_get_spu(){
		var class_2_id = $("#sku_class_2_select").combobox("getValue");
		var pp_id = $("#sku_tm_select").combobox("getValue");
		
		// 此方式没有测试通过 ？？？
		/* $.post("/sku_get_spu_by_class_2_tm_id.do",{class_2_id:class_2_id,pp_id:pp_id},function(data){
			$(data).each(function(i,json){
				$("#sku_class_spu_select").append("<option value='"+json.id+"'>"+json.shp_mch+"</option>");
			});
		}); */
		//alert(class_2_id);
		//alert(pp_id);
		//sku_get_spu_by_class_2_tm_id(pp_id,class_2_id);
		//
		// 通过url拼串的方式传参数 方式1
		/* $("#sku_class_spu_select").combobox({
    		url:"/sku_get_spu_by_class_2_tm_id.do?class_2_id="+class_2_id+"&pp_id="+pp_id,
    		valueField:"id",
    		textField:"shp_mch"
    	}); */
    	
    	// 在加载服务器数据之前改变http请求参数的值 方式2
    	$("#sku_class_spu_select").combobox({
    		url:"/sku_get_spu_by_class_2_tm_id.do",
    		valueField:"id",
    		textField:"shp_mch",
    		onBeforeLoad: function(param){
				param.class_2_id = class_2_id;
				param.pp_id = pp_id;
			},
    		onSelect:function(){
    			sku_get_attr_by_class_2_id(class_2_id);
    		},
    		onChange:function(){
    			var sku_text = $("#sku_class_spu_select").combobox("getText");
    			//alert(sku_text);
    			if(sku_text==""||sku_text=="请选择"){
    				$("#sku_attr_list_area").empty();
    			}
    		}
		}); 
		
	}
	
	
	
	function sku_get_class_2_by_class_1_id(class_1_id){
		//var class_1_id = $("#sku_class_1_select option:selected").val();
		$.getJSON("json/class_2_"+class_1_id+".js",function(data){
			$("#sku_class_2_select").empty();
			if(data.length!=0){
				$(data).each(function(i,json){
					$("#sku_class_2_select").append("<option value="+json.id+">"+json.flmch2+"</option>");
				});
				sku_get_attr_by_class_2_id(data[0].id);
			}else{
				alert("二级分类为空~~~")
			}
		});
		
		sku_get_tm_by_class_1_id(class_1_id);
		
	}
	
	
	function sku_get_tm_by_class_1_id(class_1_id){
		//var class_1_id = $("#sku_class_1_select option:selected").val();
		$.getJSON("json/tm_class_1_"+class_1_id+".js",function(data){
			$("#sku_tm_select").empty();
			if(data.length!=0){
				$(data).each(function(i,json){
					$("#sku_tm_select").append("<option value="+json.id+">"+json.ppmch+"</option>");
				});
				//alert(data[0].pp_id);
				
				//sku_get_spu_by_class_2_tm_id(6);
			}else{
				alert("商标分类为空");
			}
		});
	}
	
	function sku_get_attr_by_class_2_id(class_2_id){
		//alert("oooo");
		var class_2_name = $("#sku_class_2_select option:selected").text();
		$.post("sku_get_attr_by_class_2_id.do",{class_2_id:class_2_id,class_2_name:class_2_name},function(data){
			$("#sku_attr_list_area").html(data);
		});
	}
	
	//通过二级分类和品牌id查看商品名称
	function sku_get_spu_by_class_2_tm_id(pp_id){
		//alert(pp_id);
		var class_2_id = $("#sku_class_2_select").val();
		$.post("sku_get_spu_by_class_2_tm_id.do",{class_2_id:class_2_id,pp_id:pp_id},function(data){
			$("#sku_class_spu_select").empty();
			if(data.length!=0){
				$(data).each(function(i,json){
					$("#sku_class_spu_select").append("<option value='"+json.id+"'>"+json.shp_mch+"</option>");
				});
			}else{
				alert("spu列表为空");
			}
		});
	}

</script>
<title>suser-test</title>
</head>
<body>
	<div class="easyui-layout" data-options="fit:true">
		<form id="sku_inner_form" action="/sku_save_sku_ajax.do" method="post">
			<div data-options="region:'west'" style="width:180px">
					一级分类：<select name="flbh1" class="easyui-combobox" id="sku_class_1_select" onChange="sku_get_class_2_by_class_1_id(this.value)"></select><br><br>
					二级分类：<select name="flbh2" class="easyui-combobox" id="sku_class_2_select"  onChange="sku_get_attr_by_class_2_id(this.value)"></select><br><br>
					品牌分类：<select name="pp_id" class="easyui-combobox" id="sku_tm_select" onChange="sku_get_spu_by_class_2_tm_id(this.value)"></select><br><br>
					商品选择：<select name="spu_id" class="easyui-combobox" id="sku_class_spu_select" ></select><br><br><br>
			</div> 
			<div data-options="region:'center'">
				
				<div id="sku_attr_list_area">
					
				</div>
			</div>
	 	</form>
	 </div>
	
		
		
</body>
</html>
