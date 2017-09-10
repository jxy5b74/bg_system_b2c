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
				 $("#bg_show_product_attr_info_class_1_select").append("<option value="+json.id+">"+json.flmch1+"</optinn>");
			 });
		});
	});
	
	function bg_show_product_attr_info_get_class_2_by_class_1_id(class_1_id){
		//传统做法不传this
		//class_1_id = $("#bg_add_product_info_class_1_select option:selected").val();
		//传this直接在方法入参处将一级分类id传过了
		$("#bg_show_product_attr_info_class_2_select").empty();
		$("#bg_show_product_attr_info_class_2_select").append("<option selected>请选择</option>");
		$.getJSON("jquery/json/class_fl_2_"+class_1_id+".js", function(data){
			 $(data).each(function(i,json){
				 $("#bg_show_product_attr_info_class_2_select").append("<option value="+json.id+">"+json.flmch2+"</option>");
			 });
		});
	}
/* 	
	//Ajax异步请求，向后台请求二级分类下商品属性信息
	function bg_show_product_attr_info_by_ajax_request(class_2_id){
		
		// 获取二级分类名称 
		var class_2_name = $("#bg_show_product_attr_info_class_2_select :selected").html();//text()也可以实现功能
		
		$.post("${pageContext.request.contextPath }/bg_product_attr_info_show.do",{"flbh2":class_2_id,"flmch2":class_2_name},function(data){// data及输出的HTML 
			$("#bg_show_product_attr_info_adhere").html(data);
		});
	}
 */	
 	function bg_show_product_attr_info_by_ajax_request_return_json(class_2_id){
	// 获取二级分类名称 
	var class_2_name = $("#bg_show_product_attr_info_class_2_select :selected").html();//text()也可以实现功能
	
	$("#bg_show_product_attr_info_adhere").attr("title",class_2_name+"类商品————属性详细信息列表");
	 $('#bg_show_product_attr_info_adhere').datagrid({    
		    url:'bg_product_attr_info_show_json_data.do',
		    queryParams:{"flbh2":class_2_id},
		    columns:[[    
		        {field:'shxm_mch',title:'属性名',width:100},    
		        {field:'chjshj',title:'创建时间',width:100,
		        	formatter: function(value){
		        		var d = new Date(value);
		        		return d.toLocaleString();
					}
	
		        },    
		        {field:'valueList',title:'属性分类列表',width:100,align:'left',
		        	formatter: function(attr_info,row,index){
		        		var attr_list = "";
			        		$(attr_info).each(function(i,json){
			        			attr_list += (json.shxzh+"-"+json.shxzh_mch+"/");
			        		});
		        		return attr_list;
					}
		        }    
		    ]]    
		}); 
	 	$("#bg_add_attr_info_btn").show();
	}		
	
	$("#bg_add_attr_info_btn").click(function(){
		/* bg_product_maintain_attr_info_page.do?flbh2=${flbh2 }&flmch2=${flmch2 } */
		var url = "bg_product_maintain_attr_info_page.do";
		var flbh2 = $("#bg_show_product_attr_info_class_2_select :selected").val();
		var flmch2 = $("#bg_show_product_attr_info_class_2_select :selected").html();
		/* alert(flmch2); */
		window.location.href = url+"?flbh2="+flbh2+"&flmch2="+flmch2;
	});
</script>
	${success}
<div class="easyui-layout" data-options="fit:true">	
	<div data-options="region:'west',split:true" title="商品分类：" style="width:200px;"><br>
		<select name="flbh1" id="bg_show_product_attr_info_class_1_select" onchange="bg_show_product_attr_info_get_class_2_by_class_1_id(this.value)">
			<option >未选择</option>
		</select><br><br>
		<!-- <select name="flbh2" id="bg_show_product_attr_info_class_2_select" onchange="bg_show_product_attr_info_by_ajax_request(this.value)"> -->
		<select name="flbh2" id="bg_show_product_attr_info_class_2_select" onchange="bg_show_product_attr_info_by_ajax_request_return_json(this.value)">
			<!-- <option >未选择</option> -->
		</select><br/>
	</div>
	<div data-options="region:'center',iconCls:'icon-ok'" title="商品属性详细：">
		<div id="bg_show_product_attr_info_adhere" title=""></div>
		<button id="bg_add_attr_info_btn" style="display: none">为商品添加二级分类属性信息</button>
	</div>	
	
</div>
<!-- 
	<div class="easyui-layout" style="width:700px;height:350px;">
		<div data-options="region:'north'" style="height:50px"></div>
		<div data-options="region:'south',split:true" style="height:50px;"></div>
		<div data-options="region:'east',split:true" title="East" style="width:180px;"></div>
		<div data-options="region:'west',split:true" title="West" style="width:100px;"></div>
		<div data-options="region:'center',iconCls:'icon-ok'" title="Center">
			<div class="easyui-layout" data-options="fit:true">
				<div data-options="region:'north',split:true,border:false" style="height:50px"></div>
				<div data-options="region:'west',split:true,border:false" style="width:100px"></div>
				<div data-options="region:'center',border:false"></div>
			</div>
		</div>
	</div>
		
-->

<!-- 使用Datagrid数据表格 -->

<!-- 

$('#dg').datagrid({    
    url:'datagrid_data.json',    
    columns:[[    
        {field:'code',title:'Code',width:100},    
        {field:'name',title:'Name',width:100},    
        {field:'price',title:'Price',width:100,align:'right'}    
    ]]    
}); 
	
 -->
</body>
</html>

