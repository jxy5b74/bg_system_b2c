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
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>乐婴商城</title>
</head>
<body>
<script type="text/javascript">
	
	index = 0;
	
	function dynamic_add_attr (){
		
		var table_content = '';
		
		table_content +=' <hr>';
		table_content +=' <table id="bg_project_table_index_'+(index+1)+'" border="1">';
		table_content +=' 	<tr>';
		table_content +=' 		<td  colspan="2">商品属性名：<input type="text" name="attrList['+(index+1)+'].shxm_mch"/></td>';
		table_content +=' 		<td><a href="javascript:dynamic_add_attr_info('+(index+1)+');">添加属性值信息</a></td>';
		table_content +=' 	</tr>';
		table_content +=' </table>';
		
		$("#bg_project_table_index_"+index).after(table_content);
		
		index++;
		/* alert("aaa"); */
	};
	
	function dynamic_add_attr_info(index_2){
		/* alert("index_2-->"+index_2) */
		
		var attr_content = '';
		
		var tr_sum = $("#bg_project_table_index_"+index_2+" > tr").length;
		
		/* alert("tr_sum-->"+tr_sum); */
		
		attr_content+=' <tr>';
		attr_content+=' 	<td>属性值名称：<input type="text" name="attrList['+index_2+'].valueList['+tr_sum+'].shxzh_mch"/></td>';
		attr_content+=' 	<td>属性值：<input type="text" name="attrList['+index_2+'].valueList['+tr_sum+'].shxzh"/></td>';
		attr_content+=' 	<td><a href="#">删除</a></td>';
		attr_content+=' </tr>';
		
		$("#bg_project_table_index_"+index_2).append(attr_content);
	}
	
	/* bg_system_product_attr_info.do */
	/* bg_system/bg_product_attr_info.jsp */
	function bg_add_attr_info_back(){
		window.location.href="index_background_manager_system.do?call_back_page=attr";
	}
	
</script>
<h2>添加${flmch2 }的ATTR信息</h2>
	${success}
	<a href="javascript:dynamic_add_attr();">新增attr信息</a>
	<hr>
	<form action="bg_project_run_batch_insert_attr_info.do" method="post" >
	<!-- 增加两个隐藏域，后台插入数据库时使用 -->
		<input type="hidden" name="flbh2" value="${flbh2 }"/>
		<input type="hidden" name="flmch2" value="${flmch2 }"/>
		<table id="bg_project_table_index_0" border="1">
			<tr>
				<td colspan="2">商品属性名：<input type="text" name="attrList[0].shxm_mch"/></td>
				<td><a href="javascript:dynamic_add_attr_info(0);">添加属性值信息</a></td>
			</tr>
		</table>
	<hr>
		<input style="margin-right: 30px" type="submit" value="提交"/>
	</form>
	<button onclick="bg_add_attr_info_back()">返回</button>
	
</body>
</html>

