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
<title>硅谷商城</title>
</head>
<body>
<script type="text/javascript">
	$(function(){
		$.getJSON("jquery/json/class_1.js", function(data){
			 $(data).each(function(i,json){
				 $("#bg_product_sku_info_class_1_select").append("<option value="+json.id+">"+json.flmch1+"</optinn>");
			 });
		});
	});
	
	//一级分类下拉选项发生变化的时候，通过一级分类的ID来进行二级分类的加载
	//并且同时加载一级分类下的商品的品牌信息
	function bg_product_sku_info_get_class_2_by_class_1_id(class_1_id){
		//传统做法不传this
		//class_1_id = $("#bg_add_product_info_class_1_select option:selected").val();
		//传this直接在方法入参处将一级分类id传过了
		$("#bg_product_sku_info_class_2_select").empty();
		$("#bg_product_sku_info_class_2_select").append("<option selected>请选择</option>");
		$.getJSON("jquery/json/class_fl_2_"+class_1_id+".js", function(data){
			 $(data).each(function(i,json){
				 $("#bg_product_sku_info_class_2_select").append("<option value="+json.id+">"+json.flmch2+"</option>");
			 });
		});
		//商标是在一级分类发生变化的情况下加载的
		bg_product_sku_info_brand_select(class_1_id)
	}
	
	function bg_product_sku_info_brand_select(class_1_id){
		$("#bg_product_sku_info_brand_select").empty();
		$("#bg_product_sku_info_brand_select").append("<option selected>请选择</option>");
		$.getJSON("jquery/json/class_1_"+class_1_id+"_trade_mark_list.js", function(data){
			 $(data).each(function(i,json){
				 $("#bg_product_sku_info_brand_select").append("<option value="+json.id+" >"+json.ppmch+"</option>");
			 });
		});
	}
	
	
	function bg_product_sku_get_spu_attr_info(){
		//将商品的分类编号2传向后台，通过异步请求获取商品的attr属性值集合作为json字符串返回到页面
		var flbh2 = $("#bg_product_sku_info_class_2_select").val();
		
		$.post("bg_product_sku_get_spu_attr_info.do", { "flbh2": flbh2 }, function(data){
			//alert("Data Loaded: " + data);
			//将内嵌页的内容加载到本页面中的某一个div元素中
			$("#bg_sku_attr_info_div").html(data);
		});
	} 
	
	function bg_product_sku_get_spu_info(){
		//每次添加完之后，清理下拉列选中的选项值，
		$("#bg_product_sku_info_product_select").empty();
		
		var flbh2 = $("#bg_product_sku_info_class_2_select").val();
		var pp_id = $("#bg_product_sku_info_brand_select").val();
		
		$.post("bg_product_get_product_spu_info.do", { "flbh2": flbh2 ,"pp_id":pp_id}, function(data){
			$(data).each(function(i,json){
				$("#bg_product_sku_info_product_select").append("<option value="+json.id+">"+json.shp_mch+"</option>");
			});
		});
	}
	
	//表单提交前验证
	function bg_save_sku_info_submit_btn (){
		var sku_stock = $("#bg_add_product_sku_stock_info").val();
		var sku_price = $("#bg_add_product_price_info").val();
		var sku_name = $("#bg_add_product_sku_name_info").val();
		var sku_stock_address = $("#bg_add_product_sku_stock_address_info").val();
		//商品库存非空验证
		if(sku_stock == ""){
			alert("请填写有效的商品库存");
			return false;
		}
		//商品价格非空验证
		if(sku_price == ""){
			alert("请填写有效的商品价格");
			return false;
		}
		//商品sku名称非空验证
		if(sku_name == ""){
			alert("请填写有效的商品库存名称");
			return false;
		}
		//商品sku库存地址非空验证
		if(sku_stock_address == ""){
			alert("请填写有效的商品库存地址");
			return false;
		}
		//数据长度校验
		//数据类型校验
		//正则表达式（略）
		
		//最后提交表单时还需要添加提示
		var flag = confirm("确定要提交库存信息吗?");
		if(flag){
			$("#bg_save_sku_info_form").submit();
		}
	}
	
</script>
	${success}
	<div class="easyui-layout" data-options="fit:true">
		<form id="bg_save_sku_info_form" action="bg_save_sku.do" method="post">
			<div data-options="region:'west',split:true,border:false" title="商品分类：" style="width:200px">
				<!-- 一级分类列选 -->
				<select name="flbh1" id="bg_product_sku_info_class_1_select" onchange="bg_product_sku_info_get_class_2_by_class_1_id(this.value)" style="margin-left: 20px;width: 100px">
					<option >请选择</option>
				</select><br/>
				<!-- 二级分类列选 -->
				<select name="flbh2" id="bg_product_sku_info_class_2_select" onchange="bg_product_sku_get_spu_attr_info()" style="margin-left: 20px;width: 100px">
				</select><br/>
				<!-- 品牌下拉列选 -->		<!-- 商标是在一级分类发生变化的时候加载 -->			<!-- 通过品牌下拉选框获取spu商品信息，异步加载json字符串到下拉列选 -->
				<select name="pp_id" id="bg_product_sku_info_brand_select" onchange="bg_product_sku_get_spu_info()" style="margin-left: 20px;width: 100px">
				</select><br/>
				<!-- 具体spu列选 -->
				<select name="shp_id" id="bg_product_sku_info_product_select" style="margin-left: 20px;width: 100px" >
				</select>
			</div>
			<div data-options="region:'south',split:true" style="height:200px;">
				商品库存<input name="kc" type="text" id="bg_add_product_sku_stock_info"/><br>
				商品价格<input name="jg" type="text" id="bg_add_product_price_info"/><br>
				库存名称<input name="sku_mch" type="text" id="bg_add_product_sku_name_info"/>	<br>
				库存地址<input name="kcdz" type="text" id="bg_add_product_sku_stock_address_info"/><br><br><br><br>	
				<input type="button" onclick="bg_save_sku_info_submit_btn()" value="提交"/>
			</div>
			<div data-options="region:'center',border:false" title="商品属性勾选">
					<div id="bg_sku_attr_info_div"><!-- 内嵌页信息 --></div>
			</div>
		</form>
	</div>
</body>
</html>