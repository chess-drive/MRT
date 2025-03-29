<%--
  Created by Eclipse.
  User: BBUGGE
  Date: 2023-12-29
  Time: ì¤ì  10:09
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<%@include file="/WEB-INF/views/header.jsp"%>
<script type="text/javascript">
	var absoluteUrl = '${ABSURL}';
	var init_bool = true;
	var g_term = isNullReturn("${paramMap.term}",5);
	var repl_chk_bool = isNullReturn(${replChkMap.REPL_CHK},0);
	
	var win_lock_detail = "";
	var win_gc_detail = "";
	var win_stmt_detail = "";
	
	var memChart = null;
	var gcChart = null;
	var sessChart = null;
	var stmtmChart = null;
	var lockChart = null;
	
	
	$(function(){
		$('#term').val(g_term);
		
		// Update data every second
 		setChartDataInterval();
	});
	
	function setChartDataInterval(){
		setInterval(function () {
			monitorAjax();
		}, g_term*1000)
	}
	
	
	function changeTerm(){
		l_term=$('#term').val();
		if (isNull(l_term)){
			alert("몇 초 간격으로 모니터링 할 것인지 입력해주세요.");
			return;
		} else {
			if (l_term < 3){
				alert("최소주기는 3초 간격입니다.");
				$('#term').focus();
				return;
			}
		}

		if (!isNull(win_lock_detail.name)){
 			win_lock_detail.location.href = "${CTX}/lockDetail?term="+l_term;
		}
		if (!isNull(win_gc_detail.name)){
 			win_gc_detail.location.href = "${CTX}/gcDetail?term="+l_term;
		}
		if (!isNull(win_stmt_detail.name)){
			win_stmt_detail.location.href = "${CTX}/stmtDetail?term="+l_term;
		}
		
		location.href = "${CTX}/?term="+l_term;
	}
	function monitorAjax(){
		var param = [];
		$.ajax({
	        type:"GET",
// 	        data:param,
	        url:"/monitorAjax",
	        cache:"false",
	        //dataType:"data",
	        success: function(d){
	        	$('#now').html(d.now);
	        	console.log("Ajax Success");
	        	
	        	if(init_bool){
	        		try {
	        			// Memory (ColumnChart)
	        			memChart = new chartjs("chartdiv0","bar",[d.memList].length);
		        		// GC
		        		gcChart = new chartjs("chartdiv1","line",d.gcGapList.length);
		        		gcChart.setMinMax(0,1000);
		        		// Active Session Count
		        		sessChart = new chartjs("chartdiv2","line",[d.actSessMap].length);
		        		sessChart.setMinMax(0,50);
		        		// Active Statement Count
		        		stmtChart = new chartjs("chartdiv3","line",[d.actStmtMap].length);
		        		stmtChart.setMinMax(0,2048);
		        		// Lock
		        		lockChart = new chartjs("chartdiv4","line",[d.lockMap].length);
		        		lockChart.setMinMax(0,10);
		        		// Replication
		        		if(repl_chk_bool){
		        			replChart = new chartjs("chartdiv5","line",d.replGapList.length);
			        		replChart.setMinMax(0,1000);	
		        		}
		        		init_bool = false;
	        		}catch(e){
	        			init_bool = true;
	        			alert(e.name + ", " + e.message);
	        		}
	        		
	        	}
	        	if(!(memChart.getGraphCount() == [d.memList].length &&
	        			gcChart.getGraphCount() == d.gcGapList.length &&
	        			sessChart.getGraphCount() == [d.actSessMap].length &&
	        			stmtChart.getGraphCount() == [d.actStmtMap].length &&
	        			lockChart.getGraphCount() == [d.lockMap].length)){
	        		// 그래프 갯수 다르게 들어올 때 끊기지 않게  만들것.
	        		if(repl_chk_bool){
	        			if(!(replChart.getGraphCount() == d.replGapList.length)){
	        				location.reload();	        				
	        			}
	        		}else {
	        			location.reload();	
	        		}
	        	}
	        		
	        	memChart.removeDataFromChart();
	        	memChart.addDataToChart(["${dbInfo.DB_NAME}"],[d.memList]);
	        	memChart.updateChart();
				gcChart.addDataToChart(d.now.substring(11,19),d.gcGapList);
				gcChart.removeDataFromChart();
	        	gcChart.updateChart();
	        	sessChart.addDataToChart(d.now.substring(11,19),[d.actSessMap]);
	        	sessChart.removeDataFromChart();
	        	sessChart.updateChart();
	        	stmtChart.addDataToChart(d.now.substring(11,19),[d.actStmtMap]);
	        	stmtChart.removeDataFromChart();
	        	stmtChart.updateChart();
	        	lockChart.addDataToChart(d.now.substring(11,19),[d.lockMap]);
	        	lockChart.removeDataFromChart();
	        	lockChart.updateChart();
	        	if(repl_chk_bool){
	        		replChart.addDataToChart(d.now.substring(11,19),d.replGapList);
		        	replChart.removeDataFromChart();
		        	replChart.updateChart();
	        	}
	        	//tableHighlight(target, beforeNum, afterNum, speed)  beforeNum > afterNum
	        	
	        	// alert Warn
	        	var max_client = isNullReturn(${propMap.MAX_CLIENT},1);
	        	tableHighlight($('#chartTd0'),Math.floor(d.memList[2].VALUE / d.memList[0].VALUE * 100),90,1000); // Warnning Memory Usage Over 90
	        	tableHighlight($('#chartTd2'),Math.floor(d.actSessMap.VALUE / max_client * 100),90,1000); // Warnning Session Client Over 90
	        	tableHighlight($('#chartTd4'),d.lockMap.VALUE,0,1000);
	        	if(repl_chk_bool){
		        	for(var i = 0; i < d.replGapList.length; i++){
		        		tableHighlight($('#chartTd5'),d.replGapList[i].VALUE,50000,1000);   // Warnning Replication Gap Over 100000
		        	}
	        	}
	        	$('#sessStmtTableContent').html(refreshSessStmtTableHtml(d.sessStmtList));
	        	
	        }, error: function (request,status,error) {
	            //showAjaxError(request,status,error);
	        }
		});
	}
	
	function lockDetail(){
		var options = "toolbar=no,scrollbars=yes,resizable=yes,status=no,menubar=no,width=1200, height=400, top=0,left=0";
		win_lock_detail = window.open(absoluteUrl + "/lockDetail","lockDetail",options);
	}
	
	function gcDetail(){
		var options = "toolbar=no,scrollbars=yes,resizable=yes,status=no,menubar=no,width=1200, height=400, top=0,left=0";
		win_gc_detail = window.open(absoluteUrl + "/gcDetail","gcDetail",options);
	}
	
	function stmtDetail(){
		var options = "toolbar=no,scrollbars=yes,resizable=yes,status=no,menubar=no,width=1200, height=400, top=0,left=0";
		win_stmt_detail = window.open(absoluteUrl + "/stmtDetail","stmtDetail",options);
	}
	
	function replDetail(){
		var options = "toolbar=no,scrollbars=yes,resizable=yes,status=no,menubar=no,width=1200, height=400, top=0,left=0";
		win_stmt_detail = window.open(absoluteUrl + "/replDetail","replDetail",options);
	}
	
	function openTablespaceUsageModal(){
        var data = {};
        data.modalNum = 1;
        data.width = 1000;
        data.url = '/modal/tbsUsgModal';
        openModal(data);
    }
	
	function openSessionStatementModal(){
		var data = {};
        data.modalNum = 1;
        data.width = 1000;
        data.url = '/modal/sessStmtModal';
        openModal(data);
	}
</script>

<body>
<div class="wrap">
    <header class="header"><%@include file="/WEB-INF/views/comHeader.jsp"%></header>
    <div class="container">
        <div class="">
        </div>
        <div class="">
        <br/>
            <div class="chartdivWarp">
            	<table border="0">
	                <tr>
	                	<td colspan="3">
                			<label>${dbInfo.DB_NAME}</label>
                			<label> v.${dbVer.PRODUCT_VERSION}</label>
	                		<div class="fl-rt">
		                		<input type="text" id="term" name="term" value="" onkeyup="javascript:if(event.keyCode==13){changeTerm();}" style="width:50px;">
					       		<label>※ 모니터링 주기 설정 (단위:초)</label><br/>
		                		<label class="fl-rt" id="now">${now}</label>
	                		</div>
	                	</td>
	                </tr>
	            	<tr >
		            	<td id="chartTd0">
			            	<label>Memory</label>
			            	<button class="fl-rt btn-none" onclick="openTablespaceUsageModal();">TBS Usage</button>
			                <canvas class="chartChild" id="chartdiv0" width="450px; height: 250px; font-size:12;"></canvas>
		                </td>
		                <td id="chartTd1">
		                	<button class="btn-none" onclick="gcDetail();">GC</button>
			                <canvas class="chartChild" id="chartdiv1" width="450px; height: 250px;"></canvas>
						</td>
		                <td id="chartTd2">
			                <button>Active Session Count (MAX:${propMap.MAX_CLIENT})</button>
			                <canvas class="chartChild" id="chartdiv2" width="450px; height: 250px; font-size:12;"></canvas>
		                </td>
	                </tr>
	                <tr>
		                <td id="chartTd3">
			                <button class="btn-none" onclick="stmtDetail();">Active Statement Count (MAX:${propMap.MAX_CLIENT*propMap.MAX_STMT_PER_SESS})</button> <!-- slowquery -->
	                		<canvas class="chartChild" id="chartdiv3" width="450px; height: 250px; font-size:12;"></canvas>
		                </td>
		                <td id="chartTd4">
		                	<button class="btn-none" onclick="lockDetail();">Lock</button>
                			<canvas class="chartChild" id="chartdiv4" width="450px; height: 250px; font-size:12;"></canvas>
		                </td>
		                <td id="chartTd5">
			                <c:if test="${replChkMap.REPL_CHK == 1}">
			                	<button class="btn-none" onclick="replDetail();">Repl Gap</button>
			                	<canvas class="chartChild" id="chartdiv5" width="450px; height: 250px; font-size:12;"></canvas>
		                	</c:if>
		                </td>
	                </tr>
                </table>
            </div>
            <div class="push"></div>
        </div>
            
    </div>
			<div class="tabledivWarp" >
		    	<table id="sessStmtTable">
		    		<thead>
			    		<tr>
				    		<th>SID</th>
							<th>USERNAME</th>
							<th>MODULE</th>
							<th>APP_INFO</th>
							<th>COMM_NM</th>
							<th>ACTION</th>
							<th>EVENT</th>
							<th>TX_ID</th>
							<th>ACTIVE</th>
							<th>STATE</th>
							<th>QRY</th>
							<th>COST</th>
							<th>QRY_STRT</th>
							<th>MEM</th>
							<th>READ</th> <!-- tooltip page -->
							<th>WRITE</th> <!-- tooltip page -->
							<th>GET</th> <!-- tooltip page -->
							<th>CREATE</th> <!-- tooltip page -->
				<!-- 			<th>UNDO_READ_PAGE</th> -->
				<!-- 			<th>UNDO_WRITE_PAGE</th> -->
				<!-- 			<th>UNDO_GET_PAGE</th> -->
				<!-- 			<th>UNDO_CREATE_PAGE</th> -->
							<th>IDLE</th>
							<th>LAST_QRY</th>
							<th>LOGIN</th>
			    		</tr>
		    		</thead>
		    		<tbody id="sessStmtTableContent">
		    			<c:choose>
		    				<c:when test="${fn:length(sessStmtList)>0}">
			    				<c:forEach var="s" items="${sessStmtList}" varStatus="status">
						    		<tr class="btn-none" onclick="">
						    			<td class="txt-rt">${s.SESSION_ID}</td>
										<td class="txt-cnt">${s.DB_USERNAME}</td>
										<td class="txt-cnt">${s.MODULE}</td>
										<td class="txt-cnt">${s.CLIENT_APP_INFO}</td>
										<td class="txt-cnt">${s.COMM_NAME}</td>
										<td class="txt-cnt">${s.ACTION}</td>
										<td class="txt-cnt">${s.EVENT}</td>
										<td class="txt-rt">${s.TX_ID}</td>
										<td class="txt-cnt">${s.ACTIVE}</td>
										<td class="txt-cnt">${s.STATE}</td>
										<td <c:if test="${not empty s.QUERY}">
												aria-label="${s.QUERY}"
											</c:if>
										>
											<span>${fn:substring(s.QUERY,0,30)}</span>
										</td>  <!-- # tooltip -->
										<td class="txt-rt">${s.COST}</td>
										<td class="txt-cnt" 
											<c:if test="${not empty s.QUERY_START_TIME}">
												aria-label="${s.QUERY_START_TIME}"
											</c:if>
										>
											${fn:substring(s.QUERY_START_TIME,11,19)}
										</td>
										<td class="txt-rt">${s.USED_MEMORY}</td>
										<td class="txt-rt">${s.READ_PAGE}</td>
										<td class="txt-rt">${s.WRITE_PAGE}</td>
										<td class="txt-rt">${s.GET_PAGE}</td>
										<td class="txt-rt">${s.CREATE_PAGE}</td>
		<%-- 								<td>${s.UNDO_READ_PAGE}</td> --%>
		<%-- 								<td>${s.UNDO_WRITE_PAGE}</td> --%>
		<%-- 								<td>${s.UNDO_GET_PAGE}</td> --%>
		<%-- 								<td>${s.UNDO_CREATE_PAGE}</td> --%>
										<td class="txt-cnt" 
											<c:if test="${not empty s.IDLE_START_TIME}">
												aria-label="${s.IDLE_START_TIME}"
											</c:if>
										>
											${fn:substring(s.IDLE_START_TIME,11,19)}
										</td>
										<td class="txt-cnt" 
											<c:if test="${not empty s.LAST_QUERY_START_TIME}">
												aria-label="${s.LAST_QUERY_START_TIME}"
											</c:if>
										>
											${fn:substring(s.LAST_QUERY_START_TIME,11,19)}
										</td>
										<td class="txt-cnt" 
											<c:if test="${not empty s.LOGIN_TIME}">
												aria-label="${s.LOGIN_TIME}"
											</c:if>
										>
											${fn:substring(s.LOGIN_TIME,11,19)}
										</td>
						    		</tr>
					    		</c:forEach>
		    				</c:when>
		    				<c:otherwise>
		    					<tr>
		    						<td colspan="21" align="left">no rows selected.</td>
		    					</tr>
		    				</c:otherwise>
			    		</c:choose>
		    		</tbody>
		    	</table>
		    </div>
    <footer class="footer">
        <%@include file="/WEB-INF/views/comFooter.jsp"%>
    </footer>
</div>
</body>
</html>
