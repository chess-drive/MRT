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
			
			replDetailMonitorAjax();
		}, g_term*1000)
	}
	function replDetailMonitorAjax(){
		var param = [];
		$.ajax({
	        type:"GET",
// 	        data:{},
	        url:"/stmtDetailAjax",
	        cache:"false",
	        //dataType:"data",
	        success: function(d){
	        	$('#now').html(d.now);
	        	$('#replDetailTableContent').html(refreshReplDetailTableHtml(d.replDetailList));
	        }, error: function (request,status,error) {
	            //showAjaxError(request,status,error);
	        }
		});
	}
	function refreshReplDetailTableHtml(list){
		var html = '';
		if (list.length > 0){
			for (var i = 0; i < list.length; i++){
				html += '<tr>';
				html += '<td class="txt-cnt">' + isNullReturn(list[i].REP_NAME) +'</td>';   // level marking
				html += '<td class="txt-cnt">' + isNullReturn(list[i].REMOTE_IP) +'</td>';
				html += '<td class="txt-cnt">' + isNullReturn(list[i].REP_GAP) +'</td>';
				html += '<td class="txt-cnt">' + isNullReturn(list[i].RESTART_XSN) +'</td>';
				html += '<td class="txt-cnt">' + isNullReturn(list[i].SENDER) +'</td>';
				html += '<td class="txt-cnt">' + isNullReturn(list[i].RECEIVER) +'</td>';
				html += '</tr>';
			}
		} else {
			html += '<tr><td colspan="6">no rows selected.</td></tr>';
		}
		return html;
	}
</script>

<body>
	<div class="wrap">
		<div class="repl-detail">
			<table class="mg-top20">
				<tr>
					<th id="now" colspan="6" align="right">${now}</th>
				</tr>
				<tr>
					<th>REP_NAME</th>
					<th>REMOTE_IP</th>
					<th>REP_GAP</th>
					<th>RESTART_XSN</th>
					<th>SENDER</th>
					<th>RECEIVER</th>
				</tr>
				<tbody id="replDetailTableContent">
					<c:choose>
						<c:when test="${fn:length(replDetailList) > 0}">
							<c:forEach var="l" items="${replDetailList}">
								<tr>
									<td class="txt-cnt">${l.REP_NAME}</td>
									<td class="txt-cnt">${l.REMOTE_IP}</td>
									<td class="txt-cnt">${l.REP_GAP}</td>
									<td class="txt-cnt">${l.RESTART_XSN}</td>
									<td class="txt-cnt">${l.SENDER}</td>
									<td class="txt-cnt">${l.RECEIVER}</td>
								</tr>
							</c:forEach>
						</c:when>
						<c:otherwise>
							<tr>
								<td colspan="6">no rows selected.</td>
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
