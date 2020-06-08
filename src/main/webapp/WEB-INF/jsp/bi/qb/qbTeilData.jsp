<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../../base/meta.jsp"%>
<html>
  <head>
  </head>
  <body>
  	<div class="easyui-layout" fit="true" style="width: 100%;height: 100%">
  		<input type="hidden" id="elTeilProductLineName" name="elTeilProductLineName" value="${paramMap.plId }">
  		<input type="hidden" id="TeilTotalrows" name="TeilTotalrows" value="${paramMap.totalRows }">
		<div id="teilbox" data-options="region:'center'" style="padding:5px;background:#eee;">
			<c:forEach items="${paramMap.teilList}" var="map">
				<c:choose>
					<c:when test="${map.qualityLevel==\"0\"}">
						<a id="teil${map.TETEIL }" class="easyui-linkbutton c1" data-options="size:'large'" style="width:300px;height: 100px;margin-top: 5px" onclick="getMerkmal('${map.TETEIL }','${map.TETEILNR }','${map.TEBEZEICH }');"><font size="4" style="line-height: 100%">${map.TETEILNR }<br>${map.TEBEZEICH }</font></a>
					</c:when>
					<c:when test="${map.qualityLevel==\"1\"}">
						<a id="teil${map.TETEIL }" class="easyui-linkbutton c7" data-options="size:'large'" style="width:300px;height: 100px;margin-top: 5px" onclick="getMerkmal('${map.TETEIL }','${map.TETEILNR }','${map.TEBEZEICH }');"><font size="4" style="line-height: 100%">${map.TETEILNR }<br>${map.TEBEZEICH }</font></a>
					</c:when>
					<c:when test="${map.qualityLevel==\"2\"}">
						<a id="teil${map.TETEIL }" class="easyui-linkbutton c5" data-options="size:'large'" style="width:300px;height: 100px;margin-top: 5px" onclick="getMerkmal('${map.TETEIL }','${map.TETEILNR }','${map.TEBEZEICH }');"><font size="4" style="line-height: 100%">${map.TETEILNR }<br>${map.TEBEZEICH }</font></a>
					</c:when>
					<c:when test="${map.qualityLevel==\"3\"}">
						<a id="teil${map.TETEIL }" class="easyui-linkbutton c6" data-options="size:'large'" style="width:300px;height: 100px;margin-top: 5px" onclick="getMerkmal('${map.TETEIL }','${map.TETEILNR }','${map.TEBEZEICH }');"><font size="4" style="line-height: 100%">${map.TETEILNR }<br>${map.TEBEZEICH }</font></a>
					</c:when>
				</c:choose>
			</c:forEach>						
		</div> 
	</div>
	<script type="text/javascript">
		function searchTeil(){
			if($('#qbSearchTimeType1').radiobutton('options').checked==true){
				$('#teilAcc').panel({
					href:'<%=basePath%>qb/initTeilData?productLineName='+$('#elTeilProductLineName').val()+'&teilNum='+$('#teilNum').textbox('getValue')+'&teilName='+$('#teilName').textbox('getValue')+'&startTime='+$('#qbStartTime').datetimebox('getValue')+'&endTime='+$('#qbEndTime').datetimebox('getValue')
				});
			}else if($('#qbSearchTimeType2').radiobutton('options').checked==true){
				var searchByTeilName=searchTimeInterval($('#timecc').combobox('getValue'));
				$('#teilAcc').panel({
					href:'<%=basePath%>qb/initTeilData?productLineName='+$('#elTeilProductLineName').val()+'&teilNum='+$('#teilNum').textbox('getValue')+'&teilName='+$('#teilName').textbox('getValue')+'&startTime='+searchByTeilName.startTime+'&endTime='+searchByTeilName.endTime
				});
			}else{
				$('#teilAcc').panel({
					href:'<%=basePath%>qb/initTeilData?productLineName='+$('#elTeilProductLineName').val()+'&teilNum='+$('#teilNum').textbox('getValue')+'&teilName='+$('#teilName').textbox('getValue')+'&showDataCount='+125
				});
			}
		}
		function getMerkmal(teilId,teilNum,teilName){
  			$('#teilbox > a').linkbutton({
			    iconCls:''
			});
			$('#teil'+teilId).linkbutton({
			    iconCls: 'icon-large-gou'
			});
			$('#qbTeilPanel').panel('close');
			$('#qbMerkmalPanel').panel('open');
			$('#qbMerkmalPanel').panel('setTitle','测量参数(零件号：'+teilNum+' / 零件名：'+teilName+')');
			panelNum=2;
			if($('#qbSearchTimeType1').radiobutton('options').checked==true){
				$('#qbMerkmalPanel').panel({
					href:'<%=basePath%>qb/initMerkmalData?teilId='+teilId+'&startTime='+$('#qbStartTime').datetimebox('getValue')+'&endTime='+$('#qbEndTime').datetimebox('getValue')
				});
			}else if($('#qbSearchTimeType2').radiobutton('options').checked==true){
				var searchTeilMerkmalRealTime=searchTimeInterval($('#timecc').combobox('getValue'));
				$('#qbMerkmalPanel').panel({
					href:'<%=basePath%>qb/initMerkmalData?teilId='+teilId+'&startTime='+searchTeilMerkmalRealTime.startTime+'&endTime='+searchTeilMerkmalRealTime.endTime
				});
			}else{
				$('#qbMerkmalPanel').panel({
					href:'<%=basePath%>qb/initMerkmalData?teilId='+teilId+'&showDataCount='+125
				});
			}
			clearInterval(teilRealTimeInterval);
			merkmalRealTimeInterval=setInterval(qbMerkmalRealTime, 10000);
			/* var accSelected = $('#qbAcc').accordion('getPanel',1);
			accSelected.panel('setTitle', '零件(零件号：'+teilNum+' / 零件名：'+teilName+')');
			$('#qbAcc').accordion('select',2);  */
  		}
  		$('#openTeilQb').click(function(){
  			$('#qbDig').panel({
							href:'<%=basePath%>qb/initQbShow?index='+'2&productLineName='+$('#elTeilProductLineName').val()
						});
				$('#qbDig').dialog('open');
  		})
  		function teilRealTime(){
  			var startTime,endTime,teilShowCount;
  			if($('#qbSearchTimeType1').radiobutton('options').checked==true){
  				startTime=$('#qbStartTime').datetimebox('getValue');
  				endTime=$('#qbEndTime').datetimebox('getValue');
  			}else if($('#qbSearchTimeType2').radiobutton('options').checked==true){
  				var searchTeilRealTime=searchTimeInterval($('#timecc').combobox('getValue'));
  				startTime=searchTeilRealTime.startTime;
  				endTime=searchTeilRealTime.endTime;
  			}else{
  				teilShowCount=125
  			}
  			$.ajax({
  				type:'post',
  				url:'<%=basePath%>qb/getTeilRealTime',
  				data:{
  					startTime:startTime,
  					endTime:endTime,
  					productLineName:$('#elTeilProductLineName').val(),
  					showDataCount:teilShowCount
  				},
  				success:function(data){
  					for(var i=0;i<data.length;i++){
  						switch(parseInt(data[i].qualityLevel)){
  							case 0:
						        $('#teil'+data[i].TETEIL).removeClass('c5 c6 c7').addClass('c1');
						        break;
						    case 1:
						        $('#teil'+data[i].TETEIL).removeClass('c5 c6 c1').addClass('c7');
						         break;
						    case 2:
						        $('#teil'+data[i].TETEIL).removeClass('c1 c6 c7').addClass('c5');
						         break;
						    case 3:
						        $('#teil'+data[i].TETEIL).removeClass('c5 c1 c7').addClass('c6');
						         break;
  						}
  					}
  				}
  			})
  		
  		}
	</script>
  </body>
</html>
