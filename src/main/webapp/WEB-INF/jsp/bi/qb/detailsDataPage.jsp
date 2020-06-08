<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="../../base/meta.jsp"%>
<html>
  <head>
  </head>
  
  <body>
  	<input type="hidden" id="detailsTeilId" value="${teilId }">
  	<input type="hidden" id="detailsMerkmalId" value="${merkmalId }">
    <table id="wertevarDetailsTable" style="width: 100%;height: 100%">
			<thead>
				<tr>
					<th data-options="field:'WVWERT',width:100,align:'center',sortable:true,formatter:clcellFormatter">测量值</th>
					<th data-options="field:'MENENNMAS',width:50,align:'center'">名义值</th>
					<th data-options="field:'MEUGW',width:50,align:'center'">上公差</th>
					<th data-options="field:'MEOGW',width:50,align:'center'">下公差</th>
					<th data-options="field:'PRVORNAME',width:50,align:'center'">测量人员</th>
					<th data-options="field:'PMNR',width:100,align:'center'">机台号</th>
					<th data-options="field:'PMBEZ',width:100,align:'center'">机台名</th>
					<th data-options="field:'WVDATZEIT',width:120,align:'center',sortable:true">测量日期</th>
				</tr>
			</thead>
		</table>
		<div id='wertevarTb' style="padding: 10px;width: 100%">
			<form>
				<input id="detailsSearchTimeType1" name="detailsSearchTimeType">
				&nbsp;<input id="detailsStartTime" name="detailsStartTime" style="width:180px" data-options="editable:false">
				 至&nbsp;<input id="detailsEndTime" name="detailsEndTime" style="width:180px" data-options="editable:false">
				<input id="detailsSearchTimeType2" name="detailsSearchTimeType">
				<select id="detailsTimecc" name="searchDate" style="width:200px;">
										    <option value="0">显示全部数据</option>
										    <option value="1h">显示最后一小时的数据</option>
										    <option value="1">显示最后一天的数据</option>
										    <option value="7">显示最后一周的数据</option>
										    <option value="30">显示最后一个月(30)的数据</option>
										</select >
								<a id="detailsSearchBtn" class="easyui-linkbutton" data-options="iconCls:'icon-search'">查询</a>			
			</form>    	
		</div>
		<script type="text/javascript">
			$('#wertevarDetailsTable').datagrid({
				url:'<%=basePath%>qb/getWertevarData',
				toolbar:'#wertevarTb',
				queryParams:{
					teilId:$('#detailsTeilId').val(),
					merkmalId:$('#detailsMerkmalId').val()
				},
				border : false,
				pagination : false,
				fit : true,
				rownumbers : true,
				fitColumns : true,
				singleSelect : true,
				checkOnSelect : true,
				selectOnCheck : true,
				pageSize : 20,
				pageList : [ 20, 40, 60, 80 ],
				dndRow : false,
				enableHeaderClickMenu : false,
				enableHeaderContextMenu : true,
				enableRowContextMenu : false,
				rowTooltip : false,
				rowStyler: function(index,row){
						if(row.ALARM_EW=='1'|row.ALARM_EW=='2'|row.ALARM_EW=='65536'){
							return 'background-color:#FF7256;color:#0000CD;';
						}else if(row.ALARM_EW=='16'|row.ALARM_EW=='32'){
							return 'background-color:#FFFF00;color:#0000CD;';
						}
					}
			})
			$('#detailsTimecc').combobox({
				editable:false
			})
			$('#detailsStartTime').datetimebox({
				disabled:true
			})
			$('#detailsEndTime').datetimebox({
				disabled:true
			})
			$('#detailsSearchTimeType1').radiobutton({
				onChange:function(checked){
					if(checked==true){
						$('#detailsTimecc').combobox('disable');
						$('#detailsEndTime').datetimebox('enable');
						$('#detailsStartTime').datetimebox('enable');
					}
				}
			})
			$('#detailsSearchTimeType2').radiobutton({
				checked:true,
				onChange:function(checked){
					if(checked==true){
						$('#detailsTimecc').combobox('enable');
						$('#detailsEndTime').datetimebox('clear').datetimebox('disable');
						$('#detailsStartTime').datetimebox('clear').datetimebox('disable');
					}
				}
			})
			
	        $('#detailsSearchBtn').click(function(){
	        	if($('#detailsSearchTimeType1').radiobutton('options').checked==true){
	        		if($('#detailsStartTime').datetimebox('getValue')==''|$('#detailsEndTime').datetimebox('getValue')==''|$('#detailsEndTime').datetimebox('getValue')<$('#detailsStartTime').datetimebox('getValue')){
						$.messager.alert('提示信息','时间不能为空，结束时间必须大于起始时间!','info');
						return false;
					}else{
						$('#wertevarDetailsTable').datagrid('reload',{
							teilId:$('#detailsTeilId').val(),
							merkmalId:$('#detailsMerkmalId').val(),
							startTime:$('#detailsStartTime').datetimebox('getValue'),
							endTime:$('#detailsEndTime').datetimebox('getValue')
						});
					}
	        	}else{
	        		var detailsSearchTime=searchTimeInterval($('#detailsTimecc').combobox('getValue'));
	        		$('#wertevarDetailsTable').datagrid('reload',{
							teilId:$('#detailsTeilId').val(),
							merkmalId:$('#detailsMerkmalId').val(),
							startTime:detailsSearchTime.startTime,
							endTime:detailsSearchTime.endTime
						});
	        	}
	        })
			function clcellFormatter(value,row,index){
				var strNum=value+'';
				var result=value;
				 if(row.MEMERKART=='1'){
					var integerNum=value+'';
					if(integerNum.indexOf('.')!=-1){
						integerNum=integerNum.substring(0, integerNum.indexOf('.'));
					}
					if(integerNum.length==4){
						if(value!=1000){
							result="不合格";
						}else{
							result="合格";
						}
					}else{
						if(strNum.indexOf('.')!=-1){
							var frontNum=parseInt(strNum.substring(0, strNum.indexOf('.')))/1000;
							var afterNum=parseFloat(strNum.substring(strNum.indexOf('.')-1))*1000000;
							result=frontNum+'个样本缺陷率：'+(parseFloat(afterNum/frontNum).toFixed(4))*100+'%';
						}else{
							result=integerNum/1000+'个样本缺陷率：0%'
						}
					}
				}
				return result;
			}
		
		</script>
  </body>
</html>
