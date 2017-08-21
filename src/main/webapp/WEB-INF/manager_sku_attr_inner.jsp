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
		
	});
	function sku_inner_submit(){
		//alert("ok");
		var sku_mch = $("#sku_mch").val();
		var sku_jg = $("#sku_jg").val();
		var sku_kc = $("#sku_kc").val();
		var sku_kcdz = $("#sku_kcdz").val();
		// 是否为空
		if(sku_mch==""){
			alert("名称不能为空");
			return;
		}
		if(sku_jg==""){
			alert("价格不能为空");
			return;
		}
		if(sku_kc==""){
			alert("库存不能为空");
			return;
		}
		if(sku_kcdz==""){
			alert("库存地址不能为空");
			return;
		}
		
		// 填写长度
		
		// 数据类型
		
		
		if(confirm("是否确定提交库存")){
			$("#sku_inner_form").ajaxSubmit({
				success:function(data){
					$("#sku_submit_status_span").text(data.success);
				}
			});	
		}
	}
</script>
<title>suser-test</title>
</head>
<body>
	<%-- ${param.class_2_id}  --%>
	<%-- ${list_attr}  --%>
	<hr>
	<table border="1" cellpadding="10" cellspacing="0">
		<tr>
			<td>属性：</td>
			<td>
				<c:forEach items="${list_attr}" var="attr" varStatus="status">
					<input type="checkbox" checked="checked" value="${attr.id}" name="list_attr_value[${status.index}].shxm_id">${attr.shxm_mch}
				</c:forEach>
			</td>
		</tr>
		<c:forEach items="${list_attr}" var="attr" varStatus="status">
			<tr>
				<td>${attr.shxm_mch}:</td>
				<td>
					<c:forEach items="${attr.list_value}" var="val" >
						<input type="radio" value="${val.id }" name="list_attr_value[${status.index}].shxzh_id">${val.shxzh}${val.shxzh_mch}&nbsp;&nbsp;&nbsp;&nbsp;
					</c:forEach>
				</td>
			</tr>
		</c:forEach>
	</table>
	<hr>
	商品库存名:<input id="sku_mch" type="text" name="sku_mch"><br>
	商品价格:<input id="sku_jg" type="text" name="jg"><br>
	商品库存:<input id="sku_kc" type="text" name="kc"><br>
	库存地址:<input id="sku_kcdz" type="text" name="kcdz"><br>
	<input type="button" value="发布商品库存" onclick="sku_inner_submit()"/><span id="sku_submit_status_span"></span>
</body>
</html>
