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
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript">
	$(function(){
		$("jquery ok...");
	});
	function test(){
		
	}
</script>
<title>suser-test</title>
</head>
<body>
	<table align="center" width="500px" border="1">
			<tr><td>商品名</td><td><input type="text" value="${product.shp_mch }"/></td></tr>
			<tr><td>商品描述</td><td><textarea style="width:300px;height:100px;">${product.shp_msh }</textarea></td></tr>
			<tr><td>创建时间</td><td>${product.chjshj }</td></tr>
			<tr>
				<td>商品图片</td>
				<td>
					<img src="image/ccc.jpg" width="50px">
					<img src="image/ccc.jpg" width="50px">
					<img src="image/ccc.jpg" width="50px">
					<img src="image/ccc.jpg" width="50px">
					<img src="image/ccc.jpg" width="50px">
				</td>
			</tr>
			<tr><td>提交修改</td><td><input type="button" value="提交"></td></tr>
	</table>
</body>
</html>
