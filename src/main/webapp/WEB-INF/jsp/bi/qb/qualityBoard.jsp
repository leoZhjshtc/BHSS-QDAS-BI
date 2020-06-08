<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../../base/meta.jsp"%>
<html>
  <head>
  <title>质量看板</title>
  <link rel="shortcut icon" href="<%=basePath%>resources/images/favicon.ico" type="image/x-icon">
  <link href="<%=basePath %>resources/blueThemes/css/bi.css" rel="stylesheet" type="text/css" />
  <script type="text/javascript" src="<%=basePath%>resources/js/loading.js"></script>
  	<script type="text/javascript">
		var productLineRealTimeInterval;
		var teilRealTimeInterval;
		var merkmalRealTimeInterval;
		var panelNum=0;
  		$(function(){
  			/* $('#qbAcc').accordion({
  				multiple:false,
  				fit:true,
			    animate:false,
			    onSelect:function(title,index){
			    	if(index==1){
			    		teilRealTimeInterval=setInterval(qbTeilRealTime, 10000);
			    	}else if(index==0){
			    		productLineRealTimeInterval=setInterval(qbProductLineRealTime, 10000);
			    	}else if(index==2){
			    		merkmalRealTimeInterval=setInterval(qbMerkmalRealTime, 10000);
			    	}
			    },
			    onUnselect:function(title,index){
			    	if(index==1){
			    			clearInterval(teilRealTimeInterval);
			    	}else if(index==0){
			    		clearInterval(productLineRealTimeInterval);
			    	}else if(index==2){
			    		clearInterval(merkmalRealTimeInterval);
			    	}
			    }
			}); */
			$('#plCenterbox').panel({
				href:'<%=basePath%>qb/getProductLineData?factoryName='+$('#qbFactoryName').val()+'&workShopName='+$('#qbWorkShopName').val()+'&workShopDrawingStr='+$('#qbWorkShopDrawing').val()
			});
			productLineRealTimeInterval=setInterval(qbProductLineRealTime, 10000);
			$('#qbDig').dialog({
				title:'质量看板',
				height:$(window).height()-100,
   				width:$(window).width()-100,
				resizable:true,
				maximizable:true,
				modal:true,
				closed:true,
				onClose:function(){
					clearInterval(auto);
					/* var p = $('#qbAcc').accordion('getSelected');
					if (p){
						var index = $('#qbAcc').accordion('getPanelIndex', p);
						if(index==2){
				    		teilRealTimeInterval=setInterval(qbTeilRealTime, 10000);
				    	}else if(index==1){
				    		productLineRealTimeInterval=setInterval(qbProductLineRealTime, 10000);
				    	}else if(index==3){
				    		merkmalRealTimeInterval=setInterval(qbMerkmalRealTime, 10000);
				    	}
					} */
					if(panelNum==0){
						productLineRealTimeInterval=setInterval(qbProductLineRealTime, 10000);
					}else if(panelNum==1){
						teilRealTimeInterval=setInterval(qbTeilRealTime, 10000);
					}else if(panelNum==2){
						merkmalRealTimeInterval=setInterval(qbMerkmalRealTime, 10000);
					}
				},
				onBeforeOpen:function(){
			    	clearInterval(teilRealTimeInterval);
			    	clearInterval(productLineRealTimeInterval);
			    	clearInterval(merkmalRealTimeInterval);
				}
			})
			$('#openQb').click(function(){
				$('#qbDig').panel({
							href:'<%=basePath%>qb/initQbShow?index='+'1'
						});
				$('#qbDig').dialog('open');
			});
			$('#timecc').combobox({
				editable:false
			})
			$('#qbStartTime').datetimebox({
				disabled:true,
				onChange: function(newValue,oldValue){
					<%-- if($('#qbEndTime').datetimebox('getValue')!=''&$('#qbEndTime').datetimebox('getValue')<$('#c').datetimebox('getValue')){
						$.messager.alert('提示信息','结束时间必须大于起始时间!','info');
						return false;
					}else{
						$('#plCenterbox').panel('refresh','<%=basePath%>qb/getProductLineData?startTime='+$('#qbStartTime').datetimebox('getValue')+'&endTime='+$('#qbEndTime').datetimebox('getValue'));
					} --%>
				}
			})
			$('#qbEndTime').datetimebox({
				disabled:true,
				onChange: function(newValue,oldValue){
					<%-- if($('#qbStartTime').datetimebox('getValue')!=''&$('#qbEndTime').datetimebox('getValue')<$('#qbStartTime').datetimebox('getValue')){
						$.messager.alert('提示信息','结束时间必须大于起始时间!','info');
						return false;
					}else{
						$('#plCenterbox').panel('refresh','<%=basePath%>qb/getProductLineData?startTime='+$('#qbStartTime').datetimebox('getValue')+'&endTime='+$('#qbEndTime').datetimebox('getValue'));
					} --%>
				}
			})
			$('#qbSearchTimeType1').radiobutton({
				onChange:function(checked){
					if(checked==true){
						$('#timecc').combobox('disable');
						$('#qbEndTime').datetimebox('enable');
						$('#qbStartTime').datetimebox('enable');
					}
				}
			})
			$('#qbSearchTimeType2').radiobutton({
				checked:true,
				onChange:function(checked){
					if(checked==true){
						$('#timecc').combobox('enable');
						$('#qbEndTime').datetimebox('clear').datetimebox('disable');
						$('#qbStartTime').datetimebox('clear').datetimebox('disable');
					}
				}
			})
			$('#qbSearchTimeType3').radiobutton({
				checked:false,
				label:'查询最后125条数据',
				labelWidth:150,
				labelPosition:'after',
				onChange:function(checked){
					if(checked==true){
						$('#timecc').combobox('disable');
						$('#qbEndTime').datetimebox('clear').datetimebox('disable');
						$('#qbStartTime').datetimebox('clear').datetimebox('disable');
					}
				}
			})
	        $('#qbMainSearchBtn').click(function(){
	        	if($('#qbSearchTimeType1').radiobutton('options').checked==true){
	        		if($('#qbStartTime').datetimebox('getValue')==''|$('#qbEndTime').datetimebox('getValue')==''|$('#qbEndTime').datetimebox('getValue')<$('#qbStartTime').datetimebox('getValue')){
						$.messager.alert('提示信息','时间不能为空，结束时间必须大于起始时间!','info');
						return false;
					}else{
						$('#plCenterbox').panel('refresh','<%=basePath%>qb/getProductLineData?startTime='+$('#qbStartTime').datetimebox('getValue')+'&endTime='+$('#qbEndTime').datetimebox('getValue')+'&factoryName='+$('#factoryName').val()+'&workShopDrawingStr='+$('#workShopDrawing').val()+'&workShopName='+$('#workShopName').val());
					}
	        	}else if($('#qbSearchTimeType2').radiobutton('options').checked==true){
	        		var mainSearchTime=searchTimeInterval($('#timecc').combobox('getValue'));
	        		$('#plCenterbox').panel('refresh','<%=basePath%>qb/getProductLineData?startTime='+mainSearchTime.startTime+'&endTime='+mainSearchTime.endTime+'&factoryName='+$('#factoryName').val()+'&workShopDrawingStr='+$('#workShopDrawing').val()+'&workShopName='+$('#workShopName').val());
	        	}else{
	        		$('#plCenterbox').panel('refresh','<%=basePath%>qb/getProductLineData?showDataCount='+125+'&factoryName='+$('#factoryName').val()+'&workShopDrawingStr='+$('#workShopDrawing').val()+'&workShopName='+$('#workShopName').val());
	        	}
	        })
	     })   
	        
		function qbProductLineRealTime(){
			productLineRealTime();
		}
		function qbTeilRealTime(){
			teilRealTime();
		}
		function qbMerkmalRealTime(){
			merkmalRealTime();
		}
		/* function hidePanelTitle(panelId,btt,accIndex){
			$('#qbAcc').accordion('select',accIndex);
			if($(btt).attr('class')=='icon-iconZuidahua'){
				$('#qbAcc').find('.accordion-header').each(function(index,element){
					if(!$(element).hasClass('accordion-header-selected')){
						$(element).hide();
					}
				})
				var panelHeight=$('#'+panelId).height();
				$('#'+panelId).panel('resize',{height:panelHeight+93});
				$(btt).removeClass('icon-iconZuidahua');
				$(btt).addClass('icon-iconHuanyuan');
				return;
			}else if($(btt).attr('class')=='icon-iconHuanyuan'){
				$('#qbAcc').find('.accordion-header').each(function(index,element){
					if(!$(element).hasClass('accordion-header-selected')){
						$(element).show();
					}
				})
				var panelHeight=$('#'+panelId).height();
				$('#'+panelId).panel('resize',{height:panelHeight-31});
				$(btt).removeClass('icon-iconHuanyuan');
				$(btt).addClass('icon-iconZuidahua');
				return;
			}
		} */
  	</script>
  </head>
  
<body>
<input type="hidden" id="qbFactoryName" value="${qbFactoryName }">
<input type="hidden" id="qbWorkShopName" value="${qbWorkShopName }">
<input type="hidden" id="qbWorkShopDrawing" value="${qbWorkShopDrawing }">
	<div class="easyui-layout" fit="true" style="width: 100%;height: 100%">
		<%-- <div data-options="region:'north',split:false,collapsible:false,border:false" style="background-color: #2dc3e8;height: 60px" >
			<div style="float: left;margin-left: 20px;height: 100%"><small><a href="<%=basePath%>main/mainPage" > <img src="<%=basePath%>resources/images/qdas-logo.png" alt="" /></a></small></div>
		</div> --%>
	    <div data-options="region:'center',border:false" style="overflow: hidden;">
	    	<div id="qbProductLinePanel" class="easyui-panel" title="产线" data-options="fit:true" style="overflow:hidden;">
	    		<div class="easyui-layout" fit="true" style="width: 100%;height: 100%">
		        	<div data-options="region:'north',split:false,collapsible:false" style="height:42px;background:#eee;padding: 5px;overflow: hidden">
		        		<form>
		        			<input id="qbSearchTimeType1" name="qbSearchTimeType">
			        		&nbsp;<input id="qbStartTime" name="qbStartTime" style="width:180px" data-options="editable:false">
			        		至&nbsp;<input id="qbEndTime" name="qbEndTime" style="width:180px" data-options="editable:false">
			        		<input id="qbSearchTimeType2" name="qbSearchTimeType">
			        		<select id="timecc" name="searchDate" style="width:200px;">
			        						<!-- <option value="init">---选择时间---</option> -->
										    <option value="0">显示全部数据</option>
										    <option value="1h">显示最后一小时的数据</option>
										    <option value="1">显示最后一天的数据</option>
										    <option value="7">显示最后一周的数据</option>
										    <option value="30">显示最后一个月(30)的数据</option>
										</select >
							<input id="qbSearchTimeType3" name="qbSearchTimeType">
							<a id="qbMainSearchBtn" class="easyui-linkbutton" data-options="iconCls:'icon-search'">查询</a>
			        		<a id="openQb" class="easyui-linkbutton c3" data-options="iconCls:'icon-kanbanicon'" style="float: right">打开轮播看板</a>
		        		</form>
		        	</div>
					<div id="plCenterbox" data-options="region:'center'"> </div>
		        </div> 
	    	</div>
			<div id="qbTeilPanel" class="easyui-panel" title="零件" data-options="fit:true,closed:true,tools:[
																									{
																										iconCls:'icon-back',
																										handler:function(){
																											$('#qbTeilPanel').panel('close');
																											$('#qbProductLinePanel').panel('open');
																											clearInterval(teilRealTimeInterval);
																											productLineRealTimeInterval=setInterval(qbProductLineRealTime, 10000);
																											panelNum=0;
																										}}]" style="overflow:hidden;">
				<div class="easyui-layout" fit="true" style="width: 100%;height: 100%">
		        		<div data-options="region:'north',split:false,collapsible:false" style="height:42px;background:#eee;padding: 5px">
							零件号：<input id="teilNum" name="teilNum" class="easyui-textbox" data-options="" style="width:200px">
							零件名：<input id="teilName" name="teilName" class="easyui-textbox" data-options="" style="width:200px">
							<a id="teilSearchbtn" class="easyui-linkbutton" data-options="iconCls:'icon-search',disabled:true" onclick="searchTeil();">查询</a>
							<a id="openTeilQb" class="easyui-linkbutton c3" data-options="iconCls:'icon-kanbanicon',disabled:true" style="float: right">打开轮播看板</a>
						</div>
						<div id="teilAcc" data-options="region:'center'"></div>
		        	</div>
			  				
			</div>
			<div id="qbMerkmalPanel" class="easyui-panel" title="测量参数" data-options="fit:true,closed:true,tools:[
																									{
																										iconCls:'icon-back',
																										handler:function(){
																											$('#qbMerkmalPanel').panel('close');
																											$('#qbTeilPanel').panel('open');
																											clearInterval(merkmalRealTimeInterval);
																											teilRealTimeInterval=setInterval(qbTeilRealTime, 10000);
																											panelNum=1;
																										}}]" style="overflow:hidden;">
			 				
			 </div>
	    
	    
	    
	    	<!-- <div id="qbAcc" style="width:100%;height:100%;">
		        <div id="plAcc" title="产线" style="overflow:auto;" data-options="tools:[{
						iconCls:'icon-iconZuidahua',
						handler:function(){
							hidePanelTitle('plAcc',this,0);
						}
					}]">
		        	<div class="easyui-layout" fit="true" style="width: 100%;height: 100%">
		        		<div data-options="region:'north',split:false,collapsible:false" style="height:42px;background:#eee;padding: 5px;overflow: hidden">
		        			<form>
		        				<input id="qbSearchTimeType1" name="qbSearchTimeType">
			        			&nbsp;<input id="qbStartTime" name="qbStartTime" style="width:180px" data-options="editable:false">
			        			至&nbsp;<input id="qbEndTime" name="qbEndTime" style="width:180px" data-options="editable:false">
			        			<input id="qbSearchTimeType2" name="qbSearchTimeType">
			        			<select id="timecc" name="searchDate" style="width:200px;">
			        						<option value="init">---选择时间---</option>
										    <option value="0">显示全部数据</option>
										    <option value="1h">显示最后一小时的数据</option>
										    <option value="1">显示最后一天的数据</option>
										    <option value="7">显示最后一周的数据</option>
										    <option value="30">显示最后一个月(30)的数据</option>
										</select >
								<input id="qbSearchTimeType3" name="qbSearchTimeType">
								<a id="qbMainSearchBtn" class="easyui-linkbutton" data-options="iconCls:'icon-search'">查询</a>
			        			<a id="openQb" class="easyui-linkbutton c3" data-options="iconCls:'icon-kanbanicon'" style="float: right">打开轮播看板</a>
		        			</form>
		        		</div>
						<div id="plCenterbox" data-options="region:'center'"> </div>
		        	</div> 
		        </div>
		        <div id="teilAcc" title="零件" style="padding:0px;" data-options="tools:[{
						iconCls:'icon-iconZuidahua',
						handler:function(){
							hidePanelTitle('teilAcc',this,1);
						}
					}]">
		        	<div class="easyui-layout" fit="true" style="width: 100%;height: 100%">
		        		<div data-options="region:'north',split:false,collapsible:false" style="height:42px;background:#eee;padding: 5px">
							零件号：<input id="teilNum" name="teilNum" class="easyui-textbox" data-options="" style="width:200px">
							零件名：<input id="teilName" name="teilName" class="easyui-textbox" data-options="" style="width:200px">
							<a id="teilSearchbtn" class="easyui-linkbutton" data-options="iconCls:'icon-search',disabled:true" onclick="searchTeil();">查询</a>
							<a id="openTeilQb" class="easyui-linkbutton c3" data-options="iconCls:'icon-kanbanicon',disabled:true" style="float: right">打开轮播看板</a>
						</div>
						<div id="teilAcc" data-options="region:'center'"></div>
		        	</div>
		        </div>
		        <div id="merkmalAcc" title="测量参数" data-options="tools:[{
						iconCls:'icon-iconZuidahua',
						handler:function(){
							hidePanelTitle('merkmalAcc',this,2);
						}
					}]">
		        </div>
		    </div> -->
	    </div>
	</div>
	<div id="qbDig" ></div>
</body>
</html>