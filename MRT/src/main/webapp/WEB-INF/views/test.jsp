<%--
  Created by Eclipse.
  User: BBUGGE
  Date: 2024-01-02
  Time: ì¤ì  10:09
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<%@include file="/WEB-INF/views/header.jsp"%>

<!-- Resources -->
<!-- chart.js -->
<!-- <script src="https://cdn.jsdelivr.net/npm/chart.js"></script> -->

<!-- Chart code -->
<script>
	
	
// 	const totalDuration = 10000;
// 	const delayBetweenPoints = totalDuration / data.length;
	var arr = [1,2];
	var arr_tmp = [11,12,13,14,15];
	var chart = null;

	
	var testChart = null;
	$(function(){
		testChart = new chartjstest('chartdiv1','line',1);
		arrayTest();
	});
	
	function arrayTest(){
		
		var now = null;
		setInterval(function(){
			now = new Date();
			testChart.removeDataFromChart();
			testChart.addDataToChart(dateToString(now).substring(11,19), [{KEY:"ARRAY",VALUE:Math.ceil(Math.random()*100)}]);
			testChart.updateChart();
		},3000);
		
	}
	function arrPush(arr,num){
		arr.push(arr_tmp[num%5]);	
	}
	function arrShift(arr){
		if(arr.length > 5){
			arr.shift()
		}
	}
	function chartjstest(div_id,chart_type,graph_cnt){
		//chart_type : bar , line
		
		var id = div_id.substring(div_id.length-1,div_id.length);
		var canvas = $('#'+div_id);
//		var term = v_map.get("term");
//		var graph_cnt = v_map.get("graph_cnt");
//		var previousY = (ctx) => ctx.index === 0 ? ctx.chart.scales.y.getPixelForValue(100) : ctx.chart.getDatasetMeta(ctx.datasetIndex).data[ctx.index - 1].getProps(['y'], true).y;
		
		var chart = [];
		var datasets = [];
		var y_scales = {};
		
		var d = new Date();
		var now = dateToString(d).substring(11,19);
		
		const animation = {
			x: {
				type: 'number',
				easing: 'linear',
				from: NaN
			}
		} ;
		
		for (var i = 0; i < graph_cnt; i++){
			var data = [];
//			var yAxisID = "y" + i;
//			eval("animation." + yAxisID + " = {type: 'number',easing: 'linear',from: previousY}");
//			eval("y_scales." + yAxisID + "= {min: 0, max: 1000, type: 'linear', display: true}");
			
			datasets.push({
				borderColor: NAMED_COLORS[(i + 4) % 7],
				backgroundColor: NAMED_COLORS[(i + 4) % 7],
				borderWidth: 1,
				radius: 1,
				data: data,
//				yAxisID: yAxisID
			});
		}
		
		const config = {
			type: chart_type,
			data: {
				datasets: datasets
			},
			options: {
//			animation,
				responsive: false,
				interaction: {
					intersect: false
				},
				plugins: {
					legend: false
				},
				scales: {
					y:{}
				}
			},
		};
		
		chart[id] = new Chart(canvas,config);
		
		if (chart_type == 'bar'){   // bar chart
			this.addDataToChart = function(label_arr,data_arr_list){
				for (var i = 0; i < data_arr_list.length; i++){
					var data_arr = data_arr_list[i];
					chart[id].data.datasets[i].label = label_arr[i];
					for ( var j = 0; j < data_arr.length; j++){
						if (i == 0){
							chart[id].data.labels.push(data_arr[j].KEY);
						}
//						chart[id].data.datasets[i].label = data_arr[j].KEY;
						chart[id].data.datasets[i].data.push(data_arr[j].VALUE);
					}
				}
			}
			this.removeDataFromChart = function(){
				chart[id].data.labels = [];
				chart[id].data.datasets.forEach((dataset) => {
					dataset.data = [];
				});
			}
		} else {  // line chart
			this.addDataToChart = function(label,data_arr){
				var cnt = 0;
				
				chart[id].data.labels.push(label);
				chart[id].data.datasets.forEach((dataset) => {
		//			console.log("x:"+label+",y:"+data_arr[cnt].VALUE+",label:"+data_arr[cnt].KEY)
					dataset.label = data_arr[cnt].KEY;
					dataset.data.push({x: label,y: data_arr[cnt].VALUE});
					console.log("###### AFTER ADD DATA labels : " + chart[id].data.labels, ", datasets.data :")
					console.log(dataset.data);
					cnt++;
				});
				
				
				
			}
			this.removeDataFromChart = function(){
				if(chart[id].data.labels.length > 0 && chart[id].data.datasets[0].data.length > 0){
					
				}
				if(chart[id].data.labels.length > (10 - 1)){
					var cnt = 0;
					if(div_id=="chartdiv1"){
//						debugger;
						//console.log("before shift : "+ chart[id].data.labels)
					}
					
// 					console.log("labels.length : " + chart[id].data.labels.length)
					chart[id].data.datasets.forEach((dataset) => {
						console.log("###### BEFORE REMOVE DATA labels : " + chart[id].data.labels, ", datasets.data :")
						console.log(dataset.data)
						dataset.data.shift();
// 						console.log("dataset.data.length : " + dataset.data.length)
						cnt++;
					});
					chart[id].data.labels.shift();
					if(div_id=="chartdiv1"){
//						debugger;
// 						console.log("after shift : "+ chart[id].data.labels)
					}
				}
			}
		}
		
		this.updateChart = function(){
			chart[id].update();
		}
		this.setMinMax = function(min,max){
			chart[id].config.options.scales.y.min = min;
			chart[id].config.options.scales.y.max = max;
		}
		this.getGraphLength = function(){
			return graph_cnt;
		}
		this.debug = function(){
			return chart[id];
		}
	}

</script>

<!-- HTML -->
<canvas class="chartChild" id="chartdiv1"></canvas>