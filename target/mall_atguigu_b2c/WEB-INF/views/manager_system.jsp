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
<script type="text/javascript" src="jquery/jquery-2.1.1.min.js"></script>
<script type="text/javascript" src="jquery/easyUI/jquery.easyui.min.js"></script>
<link rel="stylesheet" type="text/css" href="jquery/easyUI/themes/default/easyui.css"/>
<link rel="stylesheet" type="text/css" href="jquery/easyUI/themes/icon.css"/>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript">

	function bg_add_spu_info_tab(url){
		//alert("2!!");
		var requestURL = $(url).attr("id");
		var requestTitle = $(url).text();
		var validate_tab_exists = $("#bg_data_tabs").tabs('exists',requestTitle);
		/* alert(validate_tab_exists); */
		if(!validate_tab_exists){
			$.post(requestURL,function(data){
				$('#bg_data_tabs').tabs('add',{    
				    title:requestTitle,    
				    content:data,
				    closable:true  
				}); 
			});
		}else{
			$('#bg_data_tabs').tabs('select',requestTitle)
		}
	}	
	$(function(){
			
		/* alert("${param.call_back_page}"); *///spu
		var bg_tags = $("#bg_switch_tabs").val();
		$("#bg_switch_tabs").attr("value","");
		if(bg_tags == ""){
			return;
		}
		
		var document_node = null; 
		if(bg_tags == "spu"){
			document_node = document.getElementById("bg_system_add_product_spu_info.do");
		}
		if(bg_tags == "attr"){
			document_node = document.getElementById("bg_system_product_attr_info.do");
		}
		if(bg_tags == "sku"){
			document_node =document.getElementById("bg_system_add_product_sku_info.do");
		}
		
		/* alert(document_node); */
		
		bg_add_spu_info_tab(document_node);
		//alert("1!!");
	});
	
	
</script>
<title>硅谷商城</title>
</head>
<body class="easyui-layout">
<!-- data-options可以直接在元素上配置easyUI控件相关的一些 控件属性 -->
<!-- 我们一般配置控件属性的话一般是要调用jquery.easyui.min.js中的控件函数来设置
	 但是在元素本身上也可以通过data-options这个属性选项来控制-->
<div data-options="region:'north',border:false" style="height:60px;background:#B3DFDA;padding:10px;font-size: 30PX">硅谷商城后台管理系统</div>
	<input id="bg_switch_tabs" type="hidden" value="${param.call_back_page}"/>
	<div data-options="region:'west',split:true,title:'导航'" style="width:200px;padding:10px;">
	<ul class="easyui-tree">
		<li>
			<span>商品信息发布模块</span> 
			<ul>				
				<li><a href="javascript:;" id="bg_system_product_attr_info.do" onclick="bg_add_spu_info_tab(this)">商品分类属性attr管理</a></li>
				<li><a href="javascript:;" id="bg_system_add_product_spu_info.do" onclick="bg_add_spu_info_tab(this)">商品基本信息spu发布</a></li>
				<li><a href="javascript:;" id="bg_system_add_product_sku_info.do" onclick="bg_add_spu_info_tab(this)">商品库存信息sku发布</a></li>
				
				<li><a href="#">商品和库存维护</a></li>
				<li data-options="state:'closed'">
					<span>测试</span>
					<ul>
						<li>测试A</li>
						<li>测试B</li>
						<li>测试C</li>
					</ul>
				</li>
			</ul>
		</li>
	</ul>
	</div>
	<div data-options="region:'east',split:true,collapsed:true,title:'East'" style="width:100px;padding:10px;">east region</div>
	<div data-options="region:'south',border:false" style="height:50px;background:#A9FACD;padding:10px;">@Copyright 1993-2017 www.bgSys.easyUI.com</div>
	<div data-options="region:'center',title:'信息栏',iconCls:'icon-ok'">
		<!-- 直接去掉demo中原有的选项卡样式style="width:700px;height:250px"保持选项卡与中心区域大小一致 -->
		<div id="bg_data_tabs" class="easyui-tabs" style="height: 470px"><!-- 首先要保证先将选项卡样式加载进来再谈控件以及控件方法 -->
		</div>
	</div>

</body>
</html>