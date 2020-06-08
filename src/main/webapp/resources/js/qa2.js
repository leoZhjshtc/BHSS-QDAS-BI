function initQaChart(ele,xValueArr,successArr,warnArr,failArr,url){
	var dom = document.getElementById(ele);
	var myChart = echarts.init(dom);
	option = null;
	option = {
			grid: {
                left: '3%',
                right: '90',
                bottom: '0',
                top:'10%',
                containLabel: true
            },
	    tooltip : {
	        trigger: 'axis',
	        formatter: '{b}<br />{a0}: {c0}%<br />{a1}: {c1}%<br />{a2}: {c2}%'
	    },
	    legend: {
	        data: ['合格', '超警戒','不合格'],
	        orient:'vertical',
	        x:'right',
	        y:'center'
	    },
	    xAxis: {
	        data: xValueArr,
	        axisTick: {show: false},
	        axisLabel: {  
	           interval:0,  
	           rotate:10  
	        } 
	    },
	    yAxis: {
	        splitLine: {show: false},
	        axisLabel: {
	            show: true,
	            textStyle: {
	                color: 'black',
	                fontSize: '120%',
	            },
	            interval: 0,
	            showMinLabel: true,
	            formatter: '{value} %'
	        }
	    },
	   
	    series: [
	        {
	            name: '合格',
	            type: 'bar',
	            barMaxWidth:200,
	            stack: '产线',
	            label: {
	                    show: true,
	                    rotate:0,
	                    position: 'insideBottom',
	                    color:'black',
	                    formatter:'{a}: {c}%'
	            },
	            itemStyle:{
	                color:'#61C840'
	            },
	            data: successArr
	        }, {
	            name: '超警戒',
	            type: 'bar',
	            stack: '产线',
	            label: {
	                    show: true,
	                    position: 'insideTop',
	                    color:'black',
	                    formatter:'{a}: {c}%'
	            },
	            itemStyle:{
	                color:'#FFE361'
	            },
	            data: warnArr
	        }, {
	            name: '不合格',
	            type: 'bar',
	            stack: '产线',
	            label: {
	                    show: true,
	                    position: 'top',
	                    color:'black',
	                    formatter:'{a}: {c}%'
	            },
	            itemStyle:{
	                color:'#F73F49'
	            },
	            data: failArr
	        }]
	};
	if (option && typeof option === "object") {
	    myChart.setOption(option, true);
	    myChart.resize();
	    myChart.off('click');
	    myChart.on('click',function (params) {
	    	$('#qaMachineAbility').panel('close');
	    	$('#qaTeilAbility').panel('open');
			$('#qaTeilAbility').panel('refresh',url+'&machineName='+params.name+'&processNum='+params.data.TEAUFTRAGSTR);
			$('#qaTeilAbility').panel('resize');
			$('#qaMachineLi').html("&gt;&nbsp;&nbsp;"+params.name);
			panelIndex=2;
	    })
	}
	return myChart;
}
function initQaCPKChart(ele,xValueArr,successArr,warnArr,failArr,url){
	var dom = document.getElementById(ele);
	var myChart = echarts.init(dom);
	option = null;
	option = {
			grid: {
                left: '3%',
                right: '90',
                bottom: '0',
                top:'10%',
                containLabel: true
            },
	    tooltip : {
	        trigger: 'axis',
	        formatter: '{b}<br />{a0}: {c0}%<br />{a1}: {c1}%<br />{a2}: {c2}%'
	    },
	    legend: {
	        data: ['cpk>1.67', '1.33<cpk<1.67','cpk<1.33'],
	        orient:'vertical',
	        x:'right',
	        y:'center'
	    },
	    xAxis: {
	        data: xValueArr,
	        axisTick: {show: false},
	        axisLabel: {  
	           interval:0,  
	           rotate:10  
	        } 
	    },
	    yAxis: {
	        splitLine: {show: false},
	        axisLabel: {
	            show: true,
	            textStyle: {
	                color: 'black',
	                fontSize: '120%',
	            },
	            interval: 0,
	            showMinLabel: true,
	            formatter: '{value} %'
	        }
	    },
	   
	    series: [
	        {
	            name: 'cpk>1.67',
	            type: 'bar',
	            barMaxWidth:200,
	            stack: '产线',
	            label: {
	                    show: true,
	                    rotate:0,
	                    position: 'insideBottom',
	                    color:'black',
	                    formatter:'{a}: {c}%'
	            },
	            itemStyle:{
	                color:'#61C840'
	            },
	            data: successArr
	        }, {
	            name: '1.33<cpk<1.67',
	            type: 'bar',
	            stack: '产线',
	            label: {
	                    show: true,
	                    position: 'insideTop',
	                    color:'black',
	                    formatter:'{a}: {c}%'
	            },
	            itemStyle:{
	                color:'#FFE361'
	            },
	            data: warnArr
	        }, {
	            name: 'cpk<1.33',
	            type: 'bar',
	            stack: '产线',
	            label: {
	                    show: true,
	                    position: 'top',
	                    color:'black',
	                    formatter:'{a}: {c}%'
	            },
	            itemStyle:{
	                color:'#F73F49'
	            },
	            data: failArr
	        }]
	};
	if (option && typeof option === "object") {
	    myChart.setOption(option, true);
	    myChart.resize();
	    myChart.off('click');
	    myChart.on('click',function (params) {
	    	$('#qaMachineAbility').panel('close');
	    	$('#qaTeilAbility').panel('open');
			$('#qaTeilAbility').panel('refresh',url+'&machineName='+params.name+'&processNum='+params.data.TEAUFTRAGSTR);
			$('#qaTeilAbility').panel('resize');
			$('#qaMachineLi').html("&gt;&nbsp;&nbsp;"+params.name);
			panelIndex=2;
	    })
	}
	return myChart;
}
function initQaLhChart(ele,xValueArr,successArr,failArr,url){
	var dom = document.getElementById(ele);
	var myChart = echarts.init(dom);
	option = null;
	option = {
			grid: {
                left: '3%',
                right: '90',
                bottom: '0',
                top:'10%',
                containLabel: true
            },
	    tooltip : {
	        trigger: 'axis',
	        formatter: '{b}<br />{a0}: {c0}%<br />{a1}: {c1}%'
	    },
	    legend: {
	        data: ['定量参数','定性参数'],
	        orient:'vertical',
	        x:'right',
	        y:'center'
	    },
	    xAxis: {
	        data: xValueArr,
	        axisTick: {show: false},
	        axisLabel: {  
	           interval:0,  
	           rotate:10  
	        } 
	    },
	    yAxis: {
	        splitLine: {show: false},
	        axisLabel: {
	            show: true,
	            textStyle: {
	                color: 'black',
	                fontSize: '120%',
	            },
	            interval: 0,
	            showMinLabel: true,
	            formatter: '{value} %'
	        }
	    },
	   
	    series: [
	        {
	            name: '定量参数',
	            type: 'bar',
	            barMaxWidth:200,
	            stack: '产线',
	            label: {
	                    show: true,
	                    position: 'inside',
	                    rotate:0,
	                    color:'black',
	                    formatter:'{a}: {c}%'
	            },
	            itemStyle:{
	                color:'#1C86EE'
	            },
	            data: successArr
	        }, {
	            name: '定性参数',
	            type: 'bar',
	            stack: '产线',
	            label: {
	                    show: true,
	                    position: 'top',
	                    color:'black',
	                    formatter:'{a}: {c}%'
	            },
	            itemStyle:{
	                color:'#CD00CD'
	            },
	            data: failArr
	        }]
	};
	if (option && typeof option === "object") {
	    myChart.setOption(option, true);
	    myChart.resize();
	    myChart.off('click');
	    myChart.on('click',function (params) {
	    	$('#qaMachineAbility').panel('close');
	    	$('#qaTeilAbility').panel('open');
			$('#qaTeilAbility').panel('refresh',url+'&machineName='+params.name+'&processNum='+params.data.TEAUFTRAGSTR);
			$('#qaTeilAbility').panel('resize');
			$('#qaMachineLi').html("&gt;&nbsp;&nbsp;"+params.name);
			panelIndex=2;
	    })
	}
	return myChart;
}
function initQaLhPie(divId,pieData,titleData,url){
	var chart=echarts.init(document.getElementById(divId));
	var seriesArr=new Array();
	var pieRow=Math.ceil(pieData.length/10)
	var pieRadius=[40/pieRow+'%',70/pieRow+'%'];
	var rowPos=new Array();
	var addIndex=1;
	for(var i=1;i<=pieRow;i++){
		rowPos.push(100/(pieRow*2)*addIndex);
		addIndex+=2;
	}
	var pieLengthIndex;
	if(pieData.length>10){
		pieLengthIndex=10;
		
	}else{
		pieLengthIndex=pieData.length;
		
	}
	for(var i=0;i<pieData.length;i++){
		var rowIndex=Math.ceil((i+1)/10);
		var columnIndex;
		if(i<10){
			columnIndex=(i+0.5)*(100/pieLengthIndex);
		}else{
			columnIndex=(parseInt(i.toString().substr(1))+0.5)*(100/pieLengthIndex);
		}
		var seriesData={       
	    		name:'比例',
	            type: 'pie',
	            label: {
                    formatter: '{d}%',
                    fontSize:15
                },
	            radius : pieRadius,
//	            center: [(i+0.5)*((100/pieData.length).toFixed(2))+'%', rowPos[rowIndex-1]],
	            center: [columnIndex+'%', rowPos[rowIndex-1]+'%'],
	           label: {
                    //formatter: "{b} : {d}%"
	        	   show:false
                },
	            data:pieData[i],
	            itemStyle: {
	                emphasis: {
	                    shadowBlur: 10,
	                    shadowOffsetX: 0,
	                    shadowColor: 'rgba(0, 0, 0, 0.5)'
	                }
	            }
	        } 
		seriesArr.push(seriesData);
	}
	var titleArr=new Array();
	for(var i=0;i<titleData.length;i++){
		var rowIndex=Math.ceil((i+1)/10);
		var columnIndex;
		if(i<10){
			columnIndex=(i+0.5)*(100/pieLengthIndex);
		}else{
			columnIndex=(parseInt(i.toString().substr(1))+0.5)*(100/pieLengthIndex);
		}
		var titleInfo={
		        text: titleData[i],
		       // x: (i+0.5)*((100/titleData.length).toFixed(2))+'%',
		        x: columnIndex+'%',
		       // y: '45%',
		        y: rowPos[rowIndex-1]-5+'%',
		        textAlign: 'center',
		        textStyle:{
		        	color:'black',
		        	fontStyle:'oblique',
		        	fontWeight:'bold',
		        	fontSize:13
		        }
		    }
		titleArr.push(titleInfo);
	}
	option = {
			 legend: {
			        //data: ['定量参数', '定性参数'],
				 /*formatter: function (name) {
					    return '';
					},
			        orient:'vertical',
			        x:'right',
			        y:'center'*/
				 right:'10px'
			    },
			color:['#1C86EE','#CD00CD'],
		     grid: [{
		    	 left: '3%',
	             right: '3%',
	             bottom: '3%',
	             top:'3%',
	             containLabel: true
		    }],
		   title:titleArr,
		   tooltip:{
		    	trigger: 'item',
		        formatter: "{a} <br/>{b} : {d}%"},
		    series:seriesArr
		};
	if (option && typeof option === "object") {
		chart.setOption(option, true);
		chart.resize();
		chart.off('click');
		chart.on('click',function (params) {
			$('#qaTeilAbility').panel('close');
	    	$('#qaMerkmalAbility').panel('open');
			$('#qaMerkmalAbility').panel('refresh',url+'&teilNum='+params.data.K1001);
			$('#qaMerkmalAbility').panel('resize');
			$('#qaTeilLi').html("&gt;&nbsp;&nbsp;"+params.data.K1001);
	    })
	}
		return chart;
	
}
function initQaPassRatePie(divId,pieData,titleData,url){
	var chart=echarts.init(document.getElementById(divId));
	var seriesArr=new Array();
	var pieRow=Math.ceil(pieData.length/10)
	var pieRadius=[40/pieRow+'%',70/pieRow+'%'];
	var rowPos=new Array();
	var addIndex=1;
	for(var i=1;i<=pieRow;i++){
		rowPos.push(100/(pieRow*2)*addIndex);
		addIndex+=2;
	}
	var pieLengthIndex;
	if(pieData.length>10){
		pieLengthIndex=10;
		
	}else{
		pieLengthIndex=pieData.length;
		
	}
	for(var i=0;i<pieData.length;i++){
		var rowIndex=Math.ceil((i+1)/10);
		var columnIndex;
		if(i<10){
			columnIndex=(i+0.5)*(100/pieLengthIndex);
		}else{
			columnIndex=(parseInt(i.toString().substr(1))+0.5)*(100/pieLengthIndex);
		}
		var seriesData={       
	    		name:'比例',
	            type: 'pie',
	            label: {
                    formatter: '{d}%',
                    fontSize:15
                },
//	            radius : ['40%', '60%'],
//	            center: [(i+0.5)*((100/pieData.length).toFixed(2))+'%', '50%'],
                radius : pieRadius,
	            center: [columnIndex+'%', rowPos[rowIndex-1]+'%'],
	            label: {
                   // formatter: "{b} : {d}%"
	            	show:false
                },
	            data:pieData[i],
	            itemStyle: {
	                emphasis: {
	                    shadowBlur: 10,
	                    shadowOffsetX: 0,
	                    shadowColor: 'rgba(0, 0, 0, 0.5)'
	                }
	            }
	        } 
		seriesArr.push(seriesData);
	}
	var titleArr=new Array();
	for(var i=0;i<titleData.length;i++){
		var rowIndex=Math.ceil((i+1)/10);
		var columnIndex;
		if(i<10){
			columnIndex=(i+0.5)*(100/pieLengthIndex);
		}else{
			columnIndex=(parseInt(i.toString().substr(1))+0.5)*(100/pieLengthIndex);
		}
		var titleInfo={
		        text: titleData[i],
//		        x: (i+0.5)*((100/titleData.length).toFixed(2))+'%',
//		        y: '45%',
		        x: columnIndex+'%',
			    y: rowPos[rowIndex-1]-5+'%',
		        textAlign: 'center',
		        textStyle:{
		        	color:'#1C86EE',
		        	fontStyle:'oblique',
		        	fontWeight:'bold',
		        	fontSize:13
		        }
		    }
		titleArr.push(titleInfo);
	}
	option = {
			legend: {
		        //data: ['定量参数', '定性参数'],
			 /*formatter: function (name) {
				    return '';
				},
		        orient:'vertical',
		        x:'right',
		        y:'center'*/
				right:'10px'
		    },
			color:['#61C840','#FFE361','#F73F49'],
		     grid: [{
		    	 left: '3%',
	             right: '3%',
	             bottom: '3%',
	             top:'3%',
	             containLabel: true
		    }],
		   title:titleArr,
		   tooltip:{
		    	trigger: 'item',
		        formatter: "{a} <br/>{b} : {d}%"},
		    series:seriesArr
		};
	if (option && typeof option === "object") {
		chart.setOption(option, true);
		chart.resize();
		chart.off('click');
		chart.on('click',function (params) {
			$('#qaTeilAbility').panel('close');
	    	$('#qaMerkmalAbility').panel('open');
			$('#qaMerkmalAbility').panel('refresh',url+'&teilNum='+params.data.K1001);
			$('#qaMerkmalAbility').panel('resize');
			$('#qaTeilLi').html("&gt;&nbsp;&nbsp;"+params.data.K1001);
	    })
	}
		return chart;
	
}
function initQaCPKPie(divId,pieData,titleData,url){
	var chart=echarts.init(document.getElementById(divId));
	var seriesArr=new Array();
	var pieRow=Math.ceil(pieData.length/10)
	var pieRadius=[40/pieRow+'%',70/pieRow+'%'];
	var rowPos=new Array();
	var addIndex=1;
	for(var i=1;i<=pieRow;i++){
		rowPos.push(100/(pieRow*2)*addIndex);
		addIndex+=2;
	}
	var pieLengthIndex;
	if(pieData.length>10){
		pieLengthIndex=10;
		
	}else{
		pieLengthIndex=pieData.length;
		
	}
	for(var i=0;i<pieData.length;i++){
		var rowIndex=Math.ceil((i+1)/10);
		var columnIndex;
		if(i<10){
			columnIndex=(i+0.5)*(100/pieLengthIndex);
		}else{
			columnIndex=(parseInt(i.toString().substr(1))+0.5)*(100/pieLengthIndex);
		}
		var seriesData={       
	    		name:'比例',
	            type: 'pie',
//	            radius : ['40%', '60%'],
//	            center: [(i+0.5)*((100/pieData.length).toFixed(2))+'%', '50%'],
                radius : pieRadius,
	            center: [columnIndex+'%', rowPos[rowIndex-1]+'%'],
	            label: {
                   // formatter: "{b} : {d}%"
	            	show:false
                },
	            data:pieData[i],
	            itemStyle: {
	                emphasis: {
	                    shadowBlur: 10,
	                    shadowOffsetX: 0,
	                    shadowColor: 'rgba(0, 0, 0, 0.5)'
	                }
	            }
	        } 
		seriesArr.push(seriesData);
	}
	var titleArr=new Array();
	for(var i=0;i<titleData.length;i++){
		var rowIndex=Math.ceil((i+1)/10);
		var columnIndex;
		if(i<10){
			columnIndex=(i+0.5)*(100/pieLengthIndex);
		}else{
			columnIndex=(parseInt(i.toString().substr(1))+0.5)*(100/pieLengthIndex);
		}
		var titleInfo={
		        text: titleData[i],
//		        x: (i+0.5)*((100/titleData.length).toFixed(2))+'%',
//		        y: '45%',
		        x: columnIndex+'%',
			    y: rowPos[rowIndex-1]-5+'%',
		        textAlign: 'center',
		        textStyle:{
		        	color:'#1C86EE',
		        	fontStyle:'oblique',
		        	fontWeight:'bold',
		        	fontSize:13
		        }
		    }
		titleArr.push(titleInfo);
	}
	option = {
			legend: {
		        /*data: ['定量参数', '定性参数'],
			 formatter: function (name) {
				    return '';
				},
		        orient:'vertical',
		        x:'top',
		        y:'center'*/
				right:'10px'
		    },
			color:['#61C840','#FFE361','#F73F49'],
		     grid: [{
		    	 left: '3%',
	             right: '3%',
	             bottom: '3%',
	             top:'3%',
	             containLabel: true
		    }],
		   title:titleArr,
		   tooltip:{
		    	trigger: 'item',
		        formatter: "{a} <br/>{b} : {d}%"},
		    series:seriesArr
		};
	if (option && typeof option === "object") {
		chart.setOption(option, true);
		chart.resize();
		chart.off('click');
		chart.on('click',function (params) {
			$('#qaTeilAbility').panel('close');
	    	$('#qaMerkmalAbility').panel('open');
			$('#qaMerkmalAbility').panel('refresh',url+'&teilNum='+params.data.K1001);
			$('#qaMerkmalAbility').panel('resize');
			$('#qaTeilLi').html("&gt;&nbsp;&nbsp;"+params.data.K1001);
	    })
	}
		return chart;
	
}
function initMonthRepotLineChart(divId,dimensions,source){
	var dom = document.getElementById(divId);
	var myChart = echarts.init(dom);
	var seriesArr=new Array();
	for(var i=1;i<dimensions.length;i++){
		seriesArr.push({type: 'line'});
		
	}
	    option = {
	        legend: {
	        	type: 'scroll',
	            orient: 'vertical',
	            right: 10,
	            top: 20,
	            bottom: 20,
	        },
	       /* toolbox: {
		        show: true,
		        feature: {
		            dataZoom: {
		                yAxisIndex: 'none'
		            },
		            dataView: {readOnly: false},
		            magicType: {type: ['line','bar']},
		            restore: {},
		            saveAsImage: {}
		        }
		    },*/
	        grid: {
                left: '3%',
                right: '8%',
                bottom: '10%',
                containLabel: true
            },
            dataZoom: [
                {
                	type: 'slider',
                    show: true,
                    realtime: true,
                }
            ],
	        tooltip: {
	            trigger: 'axis',
	            position: [10, 10],
				formatter:function(params){
					var res='<div><p>'+params[0].axisValue+'</p>'
					for(var i=0;i<params.length;i++){
						var clumn=dimensions[i+1];
						if(params[0].value[clumn]!=undefined&params[0].value[clumn]!=null&params[0].value[clumn]!=''){
							res=res+'<p>'+params[i].marker+clumn+' : '+params[0].value[clumn]+'%</p>';
						}
					}
					return res+'</div>';
				}
	        },
			/*dataset: {
				dimensions: ['productLine', 'Dp Rack Line', 'DP Rack Line', 'ER-PP-3', 'ER-PP-1'],
	            source: [
	                {productLine:'2019年8月', 'Dp Rack Line':41.1, 'DP Rack Line':30.4, 'ER-PP-3':65.1, 'ER-PP-1':53.3},
	                {productLine:'2019年9月', 'Dp Rack Line':86.5, 'DP Rack Line':92.1, 'ER-PP-3':85.7, 'ER-PP-1':83.1},
	                {productLine:'2019年10月', 'Dp Rack Line':24.1, 'DP Rack Line':67.2, 'ER-PP-3':79.5, 'ER-PP-1':86.4}
	            ]
	        },*/
	       dataset:{
	        	dimensions:dimensions,
	        	source:source
	        },
	        xAxis: {
					type: 'category',
					axisTick: {show: false},
					axisLabel: {  
					   interval:0,  
					   rotate:10  
					} 
				},
	        yAxis: {
				splitLine: {show: true},
		        axisLabel: {
		            show: true,
		            textStyle: {
		                color: 'black',
		                fontSize: '120%',
		            },
		            interval: 0,
		            showMinLabel: false,
		            formatter: '{value} %'
		        },
		        min: function(value) {
		            return value.min-10;
		        }
			},
	        series: seriesArr
	    };
	if (option && typeof option === "object") {
	    myChart.setOption(option, true);
	    myChart.resize();
	}
	return myChart;
	
}