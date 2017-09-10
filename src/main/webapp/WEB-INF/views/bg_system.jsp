<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page isELIgnored="false"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ request.getContextPath() + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<base href="<%=basePath%>">
<script type="text/javascript" src="js/jquery-1.7.2.min.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript">
	
</script>
<title>乐婴商城</title>
</head>
<body>

	<a href="${pageContext.request.contextPath }/bg_system_product_attr_info.do">分类属性管理</a>
	<a href="${pageContext.request.contextPath }/bg_system_add_product_spu_info.do">商品spu信息发布</a>
	<a href="${pageContext.request.contextPath }/bg_system_add_product_sku_info.do">库存信息发布</a>
	<a href="#">商品和库存维护</a>
	
</body>
</html>