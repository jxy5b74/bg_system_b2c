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
<script type="text/javascript">
	
</script>
<title>硅谷商城</title>
</head>
<body>
<script type="text/javascript">

	$("#bg_adjust_spu_redis_cache_class_1_select").combobox({
		url:'jquery/json/class_1.js',
		valueField:'id', 
		textField:'flmch1',
		/* 添加触发事件事件 */
		onSelect:function bg_add_product_info_get_class_2_and_brand_option(){
			var class_1_id = $("#bg_adjust_spu_redis_cache_class_1_select").combobox('getValue');
			//或者使用this关键字var class_1_id = $(this).combobox('getValue');
			$("#bg_adjust_spu_redis_cache_class_2_select").combobox({
				url:'jquery/json/class_fl_2_'+class_1_id+'.js',
				valueField:'id', 
				textField:'flmch2',
				onSelect:function bg_add_product_info_get_class_2_and_brand_option(){
					var class_2_id = $("#bg_adjust_spu_redis_cache_class_2_select").combobox('getValue');
					$('#spu_redis_cache_adjust_div').datagrid({    
					    url:'bg_spu_redis_cache_adjust_attr_info_json_data.do',   
					    queryParams:{"flbh2":class_2_id},
					    columns:[[ 
					    	{field:'id',title:'id',width:30,checkbox:'true'},
					        {field:'shxm_mch',title:'属性名',width:100},    
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
				},
				value:"请选择"
			})
		},
		value:"请选择"
	});

	function spu_flush_spu_info_to_redis_by_class_2_id(order_condition){
		//alert("查询条件"+order_condition); 
		var class_2_id = $("#bg_adjust_spu_redis_cache_class_2_select").combobox('getValue');
		$.post("flush_spu_info_to_redis_by_class_2_id.do",
				{"flbh2":class_2_id,"order_condition":order_condition},
				function(data){
				   alert("向redis中成功刷入该二级分类下:" + data+"条商品信息");
		});
	};
	
	function spu_flush_spu_info_to_redis_by_class_2_id_attr_id_attr_value_id(order_condition){
		var class_2_id = $("#bg_adjust_spu_redis_cache_class_2_select").combobox('getValue');
		var attr_id_list = $("#spu_redis_cache_adjust_div").datagrid('getChecked');
		var attr_ids = new Array();
		$(attr_id_list).each(function(i,json){
			attr_ids[i] = json.id;
		});
  		$.post("spu_flush_spu_info_to_redis_by_class_2_id_attr_id_attr_value_id.do",
				{"attr_ids":attr_ids,"class_2_id":class_2_id,"order_condition":order_condition},
				function(data){
				   alert("向redis中成功刷入该二级分类下:" + data+"条商品信息");
		}); 
	}
	
</script>

	<div class="easyui-layout" data-options="fit:true">
		<form action="save_spu.do" method="post" enctype="multipart/form-data">
			<div data-options="region:'north',split:true,border:false,title:'商品分类：',minWidth:'250'" style="height:100px;">
				商品一级分类：<select class="easyui-combobox" name="flbh1" id="bg_adjust_spu_redis_cache_class_1_select" style="width: 150px"></select><br>
				商品二级分类：<select class="easyui-combobox" name="flbh2" id="bg_adjust_spu_redis_cache_class_2_select" style="width: 150px"></select><br>
			</div>
			<hr>
			<!-- <hr> -->
			<div data-options="region:'center',border:false,title:'选择刷新Redis缓存'">
				<div id="spu_redis_cache_adjust_div">
					
				</div>
				<a href="javascript:spu_flush_spu_info_to_redis_by_class_2_id(' order by jg ');">按照价格刷新二级分类商品信息缓存</a><br>
				<a href="javascript:spu_flush_spu_info_to_redis_by_class_2_id(' order by kc ');">按照库存刷新二级分类商品信息缓存</a><br>
				<a href="javascript:spu_flush_spu_info_to_redis_by_class_2_id_attr_id_attr_value_id(' order by jg ');">按照价格刷新二级分类下商品属性检索缓存</a><br>
				<a href="javascript:spu_flush_spu_info_to_redis_by_class_2_id_attr_id_attr_value_id(' order by kc ');">按照库存刷新二级分类下商品属性检索缓存</a><br>
			</div>
			<!-- <hr> -->
		</form>
	</div>
	
</body>
</html>