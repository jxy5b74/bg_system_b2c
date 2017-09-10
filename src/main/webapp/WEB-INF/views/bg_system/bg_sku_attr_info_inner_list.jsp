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
<script type="text/javascript">
	
	$(function(){
		
	});
	
	function sku_show_or_hide(attr){
		/* alert(attr); */
		 var flag = attr.checked;
		/* alert(flag); */
		var checkbox_id = $(attr).attr("id");
	 	if(flag == true){
		//当属性被选中时显示属性值名称和属性值选项
			/* alert(checkbox_id); */
			$("."+checkbox_id).show();
		}else{
			$("."+checkbox_id).hide();
		}
	}
	
	function bg_sku_check_radio_status(radio){
		var flag = radio.checked;
		if(flag == true){
			$(radio).attr("checked","");
		}
		if(flag == false){
			$(radio).attr("checked","checked");
		}
	}
	
</script>
	<h2>请选择商品二级分类的属性信息</h2>
	
		<c:forEach items="${sku_attr_list }" var="sku_attr" varStatus="index">
			<input name="sku_attr_value_list[${index.index }].shxm_id" value="${sku_attr.id }" type="checkbox" id="sku_attr_${index.index}" onclick="sku_show_or_hide(this)" /> ${sku_attr.shxm_mch }:
		</c:forEach>
		<hr>
		<c:forEach items="${sku_attr_list }" var="sku_attr" varStatus="index">
			<c:forEach items="${sku_attr.valueList }" var="sku_attr_value">
				<div class="sku_attr_${index.index }" style="display: none;float: left">
					<input type="radio" name="sku_attr_value_list[${index.index }].shxzh_id" value="${sku_attr_value.id }" class="sku_attr_radio_${index.index }" onchange="bg_sku_check_radio_status(this)"/>${sku_attr_value.shxzh }/${sku_attr_value.shxzh_mch }
				</div>
			</c:forEach>
			<br>
		</c:forEach>
 
<!-- 		
		<button onclick="bg_save_sku_info_submit_btn()">提交</button> 
				不能使用button做为表单提交的按钮
-->

</body>
</html>

