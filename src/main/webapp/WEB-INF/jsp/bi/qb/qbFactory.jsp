<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../../base/meta.jsp"%>
<html>
  <head>
	
  </head>
  
  <body>
    <div class="easyui-layout" fit="true" style="width: 100%;height: 100%">
    	<div data-options="region:'center'" style="">
    		<table id="factoryTable">
			    <thead>
			        <tr>
			            <th data-options="field:'factoryIcon',width:100"></th>
			            <th data-options="field:'factory_name',width:40"></th>
			           <!--  <th data-options="field:'workShopIcon',width:60"></th> -->
			            <th data-options="field:'workShop_name',width:60"></th>
			        </tr>
			    </thead>
			</table>
    	</div>
    </div>
    <style type="text/css">
    	.datagrid-header{position: absolute;visibility: hidden;}
    </style>
    <script type="text/javascript">
    	$(function(){
    		$('#factoryTable').datagrid({
    			url:'<%=basePath%>qb/getAllFactory',
    			border : false,
				pagination : false,
				fit : true,
				rownumbers : false,
				fitColumns : true,
				singleSelect : true,
				/* rowStyler: function(index,row){
					return 'height:50px';
				}, */
				onClickRow:function(rowIndex,rowData){
					$('#qbAcc').accordion('select',1); 
					$('#plCenterbox').panel('refresh','<%=basePath%>qb/getProductLineData?workShopName='+rowData.workShop_name+'&workShopDrawingStr='+rowData.workShop_drawing+'&factoryName='+rowData.factory_name);
					var accSelected = $('#qbAcc').accordion('getPanel',0);
					accSelected.panel('setTitle', '工厂(工厂名：'+rowData.factory_name+' / 车间名：'+rowData.workShop_name+')');
				},
				onLoadSuccess:function(data){
					var rows=data.rows;
					var indexObj=new Object();
					indexObj['factory_name']='index';
					rows.push(indexObj);
					var factoryName=rows[0].factory_name;
					var mergeArr=new Array();
					var index=0;
					var rowspan=0;
					for(var i=0;i<rows.length;i++){
						if(factoryName===rows[i].factory_name){
							rowspan+=1
						}else{
							var map=new Object();
							map.index=index;
							map.rowspan=rowspan;
							map.fname=factoryName;
							mergeArr.push(map);
							factoryName=rows[i].factory_name;
							index+=rowspan;
							rowspan=0;
							i=i-1;
						}
					
					}
					 for(var i=0; i<mergeArr.length; i++){
		                $(this).datagrid('mergeCells',{
		                    index: mergeArr[i].index,
		                    field: 'factoryIcon',
		                    rowspan: mergeArr[i].rowspan
		                });
		                $(this).datagrid('mergeCells',{
		                    index: mergeArr[i].index,
		                    field: 'factory_name',
		                    rowspan: mergeArr[i].rowspan
		                });
		            }
				}
    		})
    		
    	
    	
    	})
    
    
    
    </script>
  </body>
</html>
