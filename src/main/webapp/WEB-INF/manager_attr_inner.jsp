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
	
	function test(){
		
	}
</script>
<title>suser-test</title>
</head>
<body>
	<%-- <h4>属性列表</h4><a href="goto_add_attr.do?class_2_id=${class_2_id}&class_2_name=${class_2_name}">添加${class_2_name}属性</a><br> --%>
	<%-- ${param.class_2_id}  --%>
	<%-- ${list_attr}  --%>
	<c:forEach items="${list_attr}" var="attr">
		${attr.shxm_mch}:<br>
		<table border="1" cellpadding="10" cellspacing="0">
			<tr>
				<td>属性值</td>
				<td>属性值名称(单位)</td>
				<td>修改</td>
				<td>删除</td>
			</tr>
			<c:forEach items="${attr.list_value}" var="val">
				<tr>
					<td>${val.shxzh}</td>
					<td>${val.shxzh_mch}</td>
					<td><a href="#">修改</a></td>
					<td><a href="#">删除</a></td>
				</tr>
			</c:forEach>
		</table>
		<br>
	</c:forEach>
	
	
	
</body>
</html>
