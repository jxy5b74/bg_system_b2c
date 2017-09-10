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
/* 	$(function(){
		$.getJSON("jquery/json/class_1.js", function(data){
			 $(data).each(function(i,json){
				 $("#bg_add_product_info_class_1_select").append("<option value="+json.id+">"+json.flmch1+"</optinn>");
			 });
		});
	}); */
	
	/* 使用combobox的获取下拉列选数据值的方法取代上面的jQuery+Ajax+json的方式 下面注解是demo，demo下面是实例*/
/* 		$('#cc').combobox({    
		    url:'combobox_data.json',    
		    valueField:'id',    
		    textField:'text'   
		}); 
*/
	$("#bg_add_product_info_class_1_select").combobox({
		url:'jquery/json/class_1.js',
		valueField:'id', 
		textField:'flmch1',
		/* 添加触发事件事件 */
		onSelect:function bg_add_product_info_get_class_2_and_brand_option(){
			var class_1_id = $("#bg_add_product_info_class_1_select").combobox('getValue');
			//或者使用this关键字var class_1_id = $(this).combobox('getValue');
			$("#bg_add_product_info_class_2_select").combobox({
				url:'jquery/json/class_fl_2_'+class_1_id+'.js',
				valueField:'id', 
				textField:'flmch2',
				value:"请选择"
			}),
			$("#bg_add_product_info_brand_select").combobox({
				url:'jquery/json/class_1_'+class_1_id+'_trade_mark_list.js',
				valueField:'id', 
				textField:'ppmch',
				value:"请选择"
			})
		},
		value:"请选择"
	});
	
	
/* 	
	function bg_add_product_info_get_class_2_by_class_1_id(class_1_id){
		//传统做法不传this
		//class_1_id = $("#bg_add_product_info_class_1_select option:selected").val();
		//传this直接在方法入参处将一级分类id传过了
		$("#bg_add_product_info_class_2_select").empty();
		$.getJSON("jquery/json/class_fl_2_"+class_1_id+".js", function(data){
			 $(data).each(function(i,json){
				 $("#bg_add_product_info_class_2_select").append("<option value="+json.id+">"+json.flmch2+"</option>");
			 });
		});
		//商标是在一级分类发生变化的情况下加载的
		bg_add_product_info_brand_select(class_1_id)
	}
	
 */
/*  
 	function bg_add_product_info_brand_select(class_1_id){
		$("#bg_add_product_info_brand_select").empty();
		$.getJSON("jquery/json/class_1_"+class_1_id+"_trade_mark_list.js", function(data){
			 $(data).each(function(i,json){
				 $("#bg_add_product_info_brand_select").append("<option value="+json.id+">"+json.ppmch+"</option>");
			 });
		});
	}
	
 */	
 
 	function open_file_upload_dialog_box (index){
		/* alert(sum); */

		$("#file_upload_index_"+index+"_").click();
		
	}
	
	function dynamic_append_div (index) {
		var sum = $(".file_upload_input").length;
		
		var files = $("#file_upload_index_"+index+"_")[0].files[0];
		
		var img_src = window.URL.createObjectURL(files);
		
		$("#file_image_index_"+index+"_").attr("src",img_src);
		
		if(index == (sum-1) && index < 4){
			
			var a = "<img id='file_image_index_"+(index+1)+"_' style='cursor: pointer;width: 100px;float: left;' alt='显示缩略图' src='page_image/upload_hover.png' onclick='open_file_upload_dialog_box("+(index+1)+")'>";
			var b = "<input id='file_upload_index_"+(index+1)+"_' class='file_upload_input' style='display: none' type='file' name='files' onchange='dynamic_append_div("+(index+1)+")'/>"
			$("#file_upload_div").append(a+b);
			
		}
	}
	
	
</script>
<!-- <h2>商品SPU信息发布</h2> -->
	${success}
	<!-- <hr> -->
	<div class="easyui-layout" data-options="fit:true">
		<form action="save_spu.do" method="post" enctype="multipart/form-data">
			<div data-options="region:'west',split:true,border:false,title:'商品分类：',minWidth:'250'" style="width:100px">
				<!-- <select name="flbh1" id="bg_add_product_info_class_1_select" onchange="bg_add_product_info_get_class_2_by_class_1_id(this.value)"></select><br/> -->
				<select class="easyui-combobox" name="flbh1" id="bg_add_product_info_class_1_select" style="width: 150px"></select><br/>
				<!-- <select name="flbh2" id="bg_add_product_info_class_2_select"></select><br/> -->
				<select class="easyui-combobox" name="flbh2" id="bg_add_product_info_class_2_select" style="width: 150px"></select><br/>
				<!-- 商标是在一级分类发生变化的时候加载 -->
				<!-- <select name="pp_id" id="bg_add_product_info_brand_select"></select><br/> -->
				<select class="easyui-combobox" name="pp_id" id="bg_add_product_info_brand_select" style="width: 150px"></select><br/>
			</div>
			<!-- <hr> -->
			<div data-options="region:'north',split:true,border:false,title:'商品图片：',minHeight:'150'" style="height:50px">
				<div id="file_upload_div">
					<img id="file_image_index_0_" style="cursor: pointer;width: 100px;float: left;" alt="显示缩略图" src="page_image/upload_hover.png" onclick="open_file_upload_dialog_box(0)">
					<input id="file_upload_index_0_" class="file_upload_input" style="display: none" type="file" name="files" onChange="dynamic_append_div(0)"/>
				</div>
			</div>
			<!-- <hr> -->
			<div data-options="region:'center',border:false,title:'商品详情：'">
				商品名称<input name="shp_mch" type="text" id="bg_add_product_info_name"/>
				<br>
				商品描述<input name="shp_msh" type="text" id="bg_add_product_info_desc"/>
				<br>
				<br>
				<br>
				<input style="margin-left: 300px" type="submit" value="提交"/>
			</div>
			<!-- <hr> -->
			
		</form>
	</div>
	<!-- 
	
			<div class="easyui-layout" data-options="fit:true">
				<div data-options="region:'north',split:true,border:false" style="height:50px"></div>
				<div data-options="region:'west',split:true,border:false" style="width:100px"></div>
				<div data-options="region:'center',border:false"></div>
			</div>
	
	
	 -->
	
</body>
</html>