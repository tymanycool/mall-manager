<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> 
<%@page isELIgnored="false" %> 
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%> 
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%> 
<%String basePath=request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/";%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

</head>

<body>
	<table align="center" width="500px" border="1">
		<c:forEach items="${products}" var="product">
			<tr>
				<td><img src="image/ccc.jpg" width="50px"></td>
				<td>${product.shp_mch }</td>
				<td>${product.shp_msh }</td>
				<td><a href="/product_query_befor_update.do?id=${product.id }">更新</a></td>
				<td><a href="#">删除</a></a></td>
			</tr>
		</c:forEach>
	</table>

</body>
</html>