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
				//alert(json[0]);
				$("#spu_class_1_select").append("<option value="+json.id+">"+json.flmch1+"</option>");
			});
			spu_get_tm_by_class_1_id(data[0].id);
			spu_get_class_2_by_class_1_id(data[0].id);
		}); */
		$("#spu_class_1_select,#spu_class_2_select,#spu_tm_select").combobox({
			width:100,
			value:"请选择"
		});
		$('#spu_class_1_select').combobox({    
		    url:'json/class_1.js',    
		    valueField:'id',    
		    textField:'flmch1',
		    onSelect:function(){
		    	var class_1_id = $(this).combobox('getValue');
		    	//alert(class_1_id);
		    	//加载二级分类
		    	$("#spu_class_2_select").combobox({
		    		url:"json/class_2_"+class_1_id+".js",
		    		valueField:"id",
		    		textField:"flmch2"
		    	});
		    	//加载品牌分类
		    	$("#spu_tm_select").combobox({
		    		url:"json/tm_class_1_"+class_1_id+".js",
		    		valueField:"id",
		    		textField:"ppmch"
		    	});
		    	
		    }
		}); 
		//发布spu信息
		$("#spu_submit_input").click(function(){
			//alert("submit...");
			//index_redirect_tabs_title_array.push("商品spu信息管理(发布)");
			//index_redirect_tabs_url_array.push("/goto_spu.htm");
			$("#spu_redirect_tabs_title_input").val(index_redirect_tabs_title_array);
			$("#spu_redirect_tabs_url_input").val(index_redirect_tabs_url_array);
			$("#spu_redirect_tabs_current_title_input").val(index_redirect_tabs_current_title);
			//alert(index_redirect_tabs_title_array);
			//alert(index_redirect_tabs_url_array);
			//return false;
		});
	});
	/* 
	function spu_get_class_2_by_class_1_id(class_1_id){
		//var class_1_id = $("#spu_class_1_select option:selected").val();
		$.getJSON("json/class_2_"+class_1_id+".js",function(data){
			$("#spu_class_2_select").empty();
			$(data).each(function(i,json){
				$("#spu_class_2_select").append("<option value="+json.id+">"+json.flmch2+"</option>");
			});
		});
		
		spu_get_tm_by_class_1_id(class_1_id);
	}
	 */
	/* 
	function spu_get_tm_by_class_1_id(class_1_id){
		//var class_1_id = $("#spu_class_1_select option:selected").val();
		$.getJSON("json/tm_class_1_"+class_1_id+".js",function(data){
			$("#spu_tm_select").empty();
			$(data).each(function(i,json){
				$("#spu_tm_select").append("<option value="+json.id+">"+json.ppmch+"</option>");
			});
		});
	} */
	function spu_click_image(index){
		// 调用file对象的点击事件
		$("#spu_file_" + index).click();
		
	}
	
	function spu_get_image(index){
		var files = $("#spu_file_"+index)[0].files[0];
		var src = window.URL.createObjectURL(files);
		$("#spu_image_"+index).attr("src",src);
		
		var len = $("#spu_pic_div :input:file").length;
		//alert(len);
		if(len < 5 &&  len==(index+1)){
			spu_add_image(index+1);
		}
		
	}
	
	function spu_add_image(index){
		var content = "&nbsp;&nbsp;";
		content+='<img id="spu_image_'+index+'" style="width:70px;cursor:pointer;" src="image/upload_hover.png" onclick="spu_click_image('+index+')">';
		content+='<input type="file" id="spu_file_'+index+'" name="files" onChange="spu_get_image('+index+')" style="display:none"/>';
		$("#spu_pic_div").append(content);
	}
	
</script>
<title>suser-test</title>
</head>
<body>
	<div class="easyui-layout" data-options="fit:true">
		商品spu信息管理
		<hr>
		<form action="/save_spu.do" method="post" enctype="multipart/form-data">
			<div data-options="region:'west'" style="width:180px">
				<br>
				一级分类：<select  class="easyui-combobox" name="flbh1"  id="spu_class_1_select" onChange="spu_get_class_2_by_class_1_id(this.value)"></select><br><br>
				二级分类：<select class="easyui-combobox" name="flbh2" id="spu_class_2_select"></select><br><br>
				选择品牌：<select class="easyui-combobox" name="pp_id" id="spu_tm_select"></select><br><br>
			
			</div>   
	        <div data-options="region:'center'">
				<hr>
				<input id="spu_redirect_tabs_title_input" type="hidden" name="index_redirect_tabs_title_array" value="">
				<input id="spu_redirect_tabs_url_input" type="hidden" name="index_redirect_tabs_url_array" value="">
				<input id="spu_redirect_tabs_current_title_input" type="hidden" name="index_redirect_tabs_current_title" value="">
				商品名称：<input name="shp_mch" type="text" /><br><br>
				商品描述：<input name="shp_msh" type="text" /><br>
				<hr>
				商品图片：
				<div id="spu_pic_div">
					<img id="spu_image_0" style="width:70px;cursor:pointer;" src="image/upload_hover.png" onclick="spu_click_image(0)">
					<input type="file" id="spu_file_0" name="files" onChange="spu_get_image(0)" style="display:none"/>
				</div>
				<hr>
				<input id="spu_submit_input" type="submit"  value="发布该商品"/>
				<%-- <span>${param.success }</span> --%>
				
			</div>   
		</form>
	</div>
</body>
</html>
