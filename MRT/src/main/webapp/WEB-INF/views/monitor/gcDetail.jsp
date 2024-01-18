<%--
  Created by Eclipse.
  User: BBUGGE
  Date: 2023-12-28
  Time: ì¤ì  10:09
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<%@include file="/WEB-INF/views/header.jsp" %>
<script type="text/javascript">
	var g_term = isNullReturn("${paramMap.term}",5);
	$(function(){
		setChartDataInterval();
	})
	function setChartDataInterval(){
		setInterval(function () {
			
			gcDetailMonitorAjax();
		}, g_term*1000)
	}
	function gcDetailMonitorAjax(){
		var param = [];
		$.ajax({
	        type:"GET",
// 	        data:{},
	        url:"/gcDetailAjax",
	        cache:"false",
	        //dataType:"data",
	        success: function(d){
	        	$('#now').html(d.now);
	        	$('#gcDetailTableContent1').html(refreshGCDetailTableHtml1(d.gcDetailList));
	        	$('#gcDetailTableContent2').html(refreshGCDetailTableHtml2(d.gcQueryList));
	        }, error: function (request,status,error) {
	            //showAjaxError(request,status,error);
	        }
		});
	}
	function refreshGCDetailTableHtml1(list){
		if (isNull(list)){
			return;
		}
		
		var html = '';
		if (list.length > 0){
			for (var i = 0; i < list.length; i++){
				html += '<tr>';
				html += '<td class="txt-cnt">' + isNullReturn(list[i].GC_NAME) +'</td>';  
				html += '<td class="txt-cnt">' + isNullReturn(list[i].SCNOFTAIL) +'</td>';
				html += '<td class="txt-cnt">' + isNullReturn(list[i].MINMEMSCNINTXS) +'</td>';
				html += '<td class="txt-cnt">' + isNullReturn(list[i].GC_GAP) +'</td>';
				html += '</tr>';
			}
		} else {
			html += '<tr><td colspan="4">no rows selected.</td></tr>';
		}
		return html;
	}
	
	function refreshGCDetailTableHtml2(list){
		var html = '';
		if (list.length > 0){
			for (var i = 0; i < list.length; i++){
				html += '<tr>';
				html += '<td class="txt-cnt">' + isNullReturn(list[i].SESSION_ID) +'</td>';  
				html += '<td class="txt-cnt">' + isNullReturn(list[i].DB_USERNAME) +'</td>';
				html += '<td class="txt-cnt">' + isNullReturn(list[i].MODULE) +'</td>';
				html += '<td class="txt-cnt">' + isNullReturn(list[i].APP_INFO) +'</td>';  
				html += '<td class="txt-cnt">' + isNullReturn(list[i].COMM_NAME) +'</td>';
				html += '<td class="txt-cnt">' + isNullReturn(list[i].TASK_STATE) +'</td>';
				html += '<td>' + isNullReturn(list[i].QUERY) +'</td>';  
				html += '<td class="txt-cnt">' + isNullReturn(list[i].EXECUTE_TIME) +'</td>';
				html += '<td class="txt-cnt">' + isNullReturn(list[i].TOTAL_TIME) +'</td>';
				html += '<td class="txt-cnt">' + isNullReturn(list[i].TX_ID) +'</td>';
				html += '</tr>';
			}
		} else {
			html += '<tr><td colspan="10">no rows selected.</td></tr>';
		}
		return html;
	}
</script>

<body>
	<div class="wrap">
		<div class="gc-detail">
			<table class="mg-top20 width750">
				<tr>
					<th id="now" colspan="4" align="right">${now}</th>
				</tr>
				<tr>
					<th width="25%">GC_NAME</th>
					<th width="25%">SCNOFTAIL</th>
					<th width="25%">MINMEMSCNINTXS</th>
					<th width="25%">GC_GAP</th>
				</tr>
				<tbody id="gcDetailTableContent1">
					<c:choose>
						<c:when test="${fn:length(gcDetailList) > 0}">
							<c:forEach var="l" items="${gcDetailList}">
								<tr>
									<td class="txt-cnt">${l.GC_NAME}</td>
									<td class="txt-cnt">${l.SCNOFTAIL}</td>
									<td class="txt-cnt">${l.MINMEMSCNINTXS}</td>
									<td class="txt-cnt">${l.GC_GAP}</td>
								</tr>
							</c:forEach>
						</c:when>
						<c:otherwise>
							<tr>
								<td colspan="4">no rows selected.</td>
							</tr>
						</c:otherwise>
					</c:choose>
				</tbody>
			</table>
			<table class="mg-top20">
				<tr>
					<th>SESSION_ID</th>
					<th>USERNAME</th>
					<th>MODULE</th>
					<th>APP_INFO</th>
					<th>COMM_NAME</th>
					<th>TASK_STATE</th>
					<th>QUERY</th>
					<th>EXECUTE_TIME</th>
					<th>TOTAL_TIME</th>
					<th>TX_ID</th>
				</tr>
				<tbody id="gcDetailTableContent2">
					<c:choose>
						<c:when test="${fn:length(gcQueryList) > 0}">
							<c:forEach var="l" items="${gcQueryList}">
								<tr>
									<td class="txt-cnt">${l.SESSION_ID}</td>
									<td class="txt-cnt">${l.DB_USERNAME}</td>
									<td class="txt-cnt">${l.MODULE}</td>
									<td class="txt-cnt">${l.APP_INFO}</td>
									<td class="txt-cnt">${l.COMM_NAME}</td>
									<td class="txt-cnt">${l.TASK_STATE}</td>
									<td aria-label="${l.QUERY}"><span>${fn:substring(l.QUERY,0,30)}</span></td>
									<td class="txt-cnt">${l.EXECUTE_TIME}</td>
									<td class="txt-cnt">${l.TOTAL_TIME}</td>
									<td class="txt-cnt">${l.TX_ID}</td>
								</tr>
							</c:forEach>
						</c:when>
						<c:otherwise>
							<tr>
								<td colspan="10">no rows selected.</td>
							</tr>
						</c:otherwise>
					</c:choose>
				</tbody>
			</table>
		</div>
	</div>
	<script src="${CTX}/resources/js/common_util.js?ver=1"></script>
</body>
</html>
