<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../../base/meta.jsp"%>
<html>
  <head>
	
  </head>
  
  <body>
  					<div class="easyui-layout" fit="true" style="width: 100%;height: 100%">
						<div id="centerbox" data-options="region:'center'" style="background-image: url(<%=basePath%>resources/images/drawing/${workShopDrawing });background-repeat: no-repeat;background-size:100% 100%;">
							<input id="factoryName" name="factoryName" type="hidden" value="${factoryName }">
							<input id="workShopDrawing" name="workShopDrawing" type="hidden" value="${workShopDrawing }">
							<input id="workShopName" name="workShopName" type="hidden" value="${workShopName }">
							<%-- <c:forEach items="${paramMap.plList}" var="prodectLine">
								<c:choose>
									<c:when test="${prodectLine.qualityLevel==\"0\"}">
										<a id="${prodectLine.buttonId}" class="easyui-linkbutton c1" data-options="size:'large'" style="width:19%;height: 15.5%;margin-top: 5px" onclick="getTeil('${prodectLine.buttonId}','${prodectLine.TEKOSTST }');"><font size="5">${prodectLine.TEKOSTST  }</font></a>
									</c:when>
									<c:when test="${prodectLine.qualityLevel==\"1\"}">
										<a id="${prodectLine.buttonId}" class="easyui-linkbutton c7" data-options="size:'large'" style="width:19%;height: 15.5%;margin-top: 5px" onclick="getTeil('${prodectLine.buttonId}','${prodectLine.TEKOSTST }');"><font size="5">${prodectLine.TEKOSTST  }</font></a>
									</c:when>
									<c:when test="${prodectLine.qualityLevel==\"2\"}">
										<a id="${prodectLine.buttonId}" class="easyui-linkbutton c5" data-options="size:'large'" style="width:19%;height: 15.5%;margin-top: 5px" onclick="getTeil('${prodectLine.buttonId}','${prodectLine.TEKOSTST }');"><font size="5">${prodectLine.TEKOSTST  }</font></a>
									</c:when>
									<c:when test="${prodectLine.qualityLevel==\"3\"}">
										<a id="${prodectLine.buttonId}" class="easyui-linkbutton c6" data-options="size:'large'" style="width:19%;height: 15.5%;margin-top: 5px" onclick="getTeil('${prodectLine.buttonId}','${prodectLine.TEKOSTST }');"><font size="5">${prodectLine.TEKOSTST }</font></a>
									</c:when>
								</c:choose>
							</c:forEach> --%>
							<c:forEach items="${paramMap.plList}" var="prodectLine">
								<c:choose>
									<c:when test="${prodectLine.qualityLevel==\"0\"}">
										<a id="${prodectLine.buttonId}" class="easyui-linkbutton c1" data-options="size:'large'" style="width:100px;height: 100px;position: absolute;top: ${prodectLine.productLine_topPosition};left: ${prodectLine.productLine_leftPosition}" onclick="getTeil('${prodectLine.buttonId}','${prodectLine.TEKOSTST }');"><font size="4">${prodectLine.TEKOSTST  }</font></a>
										<img id="img${prodectLine.buttonId}" src="<%=basePath%>resources/images/lvyuan.png" style="position: absolute;top: ${prodectLine.point_topPosition};left: ${prodectLine.point_leftPosition};"/>
									</c:when>
									<c:when test="${prodectLine.qualityLevel==\"1\"}">
										<a id="${prodectLine.buttonId}" class="easyui-linkbutton c7" data-options="size:'large'" style="width:100px;height: 100px;position: absolute;top: ${prodectLine.productLine_topPosition};left: ${prodectLine.productLine_leftPosition}" onclick="getTeil('${prodectLine.buttonId}','${prodectLine.TEKOSTST }');"><font size="4">${prodectLine.TEKOSTST  }</font></a>
										<img id="img${prodectLine.buttonId}" src="<%=basePath%>resources/images/huangyuan.png" style="position: absolute;top: ${prodectLine.point_topPosition};left: ${prodectLine.point_leftPosition};"/>
									</c:when>
									<c:when test="${prodectLine.qualityLevel==\"2\"}">
										<a id="${prodectLine.buttonId}" class="easyui-linkbutton c5" data-options="size:'large'" style="width:100px;height: 100px;position: absolute;top: ${prodectLine.productLine_topPosition};left: ${prodectLine.productLine_leftPosition}" onclick="getTeil('${prodectLine.buttonId}','${prodectLine.TEKOSTST }');"><font size="4">${prodectLine.TEKOSTST  }</font></a>
										<img id="img${prodectLine.buttonId}" src="<%=basePath%>resources/images/hongyuan.png" style="position: absolute;top: ${prodectLine.point_topPosition};left: ${prodectLine.point_leftPosition};"/>
									</c:when>
									<c:when test="${prodectLine.qualityLevel==\"3\"}">
										<a id="${prodectLine.buttonId}" class="easyui-linkbutton c6" data-options="size:'large'" style="width:100px;height: 100px;position: absolute;top: ${prodectLine.productLine_topPosition};left: ${prodectLine.productLine_leftPosition}" onclick="getTeil('${prodectLine.buttonId}','${prodectLine.TEKOSTST }');"><font size="4">${prodectLine.TEKOSTST  }</font></a>
										<img id="img${prodectLine.buttonId}" src="<%=basePath%>resources/images/lanyuan.png" style="position: absolute;top: ${prodectLine.point_topPosition};left: ${prodectLine.point_leftPosition};"/>
									</c:when>
								</c:choose>
							</c:forEach>
						</div>
		        	</div>
	<script type="text/javascript">
	function getTeil(plId,plName){
  			$('#centerbox > a').linkbutton({
			    iconCls:''
			});
  			$('#'+plId).linkbutton({
			    iconCls: 'icon-large-gou'
			});
			$('#teilSearchbtn').linkbutton('enable');
			$('#openTeilQb').linkbutton('enable');
			//var searchProductLineTeilRealTime=searchTimeInterval($('#timecc').combobox('getValue'));
			//$('#qbAcc').accordion('select',1); 
			$('#qbProductLinePanel').panel('close');
			$('#qbTeilPanel').panel('open');
			$('#qbTeilPanel').panel('setTitle','零件   (产线名：'+plName+')');
			panelNum=1;
			if($('#qbSearchTimeType1').radiobutton('options').checked==true){
  				$('#teilAcc').panel('refresh','<%=basePath%>qb/initTeilData?productLineName='+plName+'&startTime='+$('#qbStartTime').datetimebox('getValue')+'&endTime='+$('#qbEndTime').datetimebox('getValue'));
  			}else if($('#qbSearchTimeType2').radiobutton('options').checked==true){
  				var searchByTeilName=searchTimeInterval($('#timecc').combobox('getValue'));
  				$('#teilAcc').panel('refresh','<%=basePath%>qb/initTeilData?productLineName='+plName+'&startTime='+searchByTeilName.startTime+'&endTime='+searchByTeilName.endTime);
  			}else{
  				$('#teilAcc').panel('refresh','<%=basePath%>qb/initTeilData?productLineName='+plName+'&showDataCount='+125);
  			}
			//var accSelected = $('#qbAcc').accordion('getPanel',0);
			//accSelected.panel('setTitle', '产线(产线名：'+plName+')');
			clearInterval(productLineRealTimeInterval);
			teilRealTimeInterval=setInterval(qbTeilRealTime, 10000);
  		}
  		//var productLineRealTimeInterval=setInterval(productLineRealTime, 10000);
  	 	function productLineRealTime(){
  			var startTime,endTime,plShowCount;
  			if($('#qbSearchTimeType1').radiobutton('options').checked==true){
  				startTime=$('#qbStartTime').datetimebox('getValue');
  				endTime=$('#qbEndTime').datetimebox('getValue');
  			}else if($('#qbSearchTimeType2').radiobutton('options').checked==true){
  				var searchProductLineRealTime=searchTimeInterval($('#timecc').combobox('getValue'));
  				startTime=searchProductLineRealTime.startTime;
  				endTime=searchProductLineRealTime.endTime;
  			}else{
  				plShowCount=125
  			
  			}
  			$.ajax({
  				type:'post',
  				url:'<%=basePath%>qb/getProductLineRealTime',
  				data:{
  					startTime:startTime,
  					endTime:endTime,
  					showDataCount:plShowCount
  				},
  				success:function(data){
  					for(var i=0;i<data.length;i++){
  						switch(parseInt(data[i].qualityLevel)){
  							case 0:
						        $('#'+data[i].buttonId).removeClass('c5 c6 c7').addClass('c1');
						        $('#img'+data[i].buttonId).attr('src', '<%=basePath%>resources/images/lvyuan.png');
						        break;
						    case 1:
						        $('#'+data[i].buttonId).removeClass('c5 c6 c1').addClass('c7');
						         $('#img'+data[i].buttonId).attr('src', '<%=basePath%>resources/images/huangyuan.png');
						         break;
						    case 2:
						        $('#'+data[i].buttonId).removeClass('c1 c6 c7').addClass('c5');
						         $('#img'+data[i].buttonId).attr('src', '<%=basePath%>resources/images/hongyuan.png');
						         break;
						    case 3:
						        $('#'+data[i].buttonId).removeClass('c5 c1 c7').addClass('c6');
						         $('#img'+data[i].buttonId).attr('src', '<%=basePath%>resources/images/lanyuan.png');
						         break;
  						}
  					}
  				}
  			})
  		}
  		function workShopPageRealTime(){
  			var startTime,endTime,plShowCount;
  			if($('#qbSearchTimeType1').radiobutton('options').checked==true){
  				startTime=$('#qbStartTime').datetimebox('getValue');
  				endTime=$('#qbEndTime').datetimebox('getValue');
  			}else if($('#qbSearchTimeType2').radiobutton('options').checked==true){
  				var searchProductLineRealTime=searchTimeInterval($('#timecc').combobox('getValue'));
  				startTime=searchProductLineRealTime.startTime;
  				endTime=searchProductLineRealTime.endTime;
  			}else{
  				plShowCount=125
  			
  			}
  		}
	</script>
  </body>
</html>
