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
<!-- <script type="text/javascript" src="jquery/jquery-2.1.1.min.js"></script> -->
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>乐婴商城</title>
</head>
<body>
	<h2>商品二级分类属性信息列表</h2>
	<c:forEach items="${attrList }" var="attr">
		${attr.shxm_mch }:<br>
		<c:forEach items="${attr.valueList }" var="attr_value">
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			${attr_value.shxzh }/${attr_value.shxzh_mch }<br>
		</c:forEach>
	</c:forEach>
	<a href="bg_product_maintain_attr_info_page.do?flbh2=${flbh2 }&flmch2=${flmch2 }">添加二级分类${flmch2 }属性信息</a>
</body>
</html>

