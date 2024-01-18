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
			
			lockDetailMonitorAjax();
		}, g_term*1000)
	}
	function lockDetailMonitorAjax(){
		var param = [];
		$.ajax({
	        type:"GET",
// 	        data:{},
	        url:"/lockDetailAjax",
	        cache:"false",
	        //dataType:"data",
	        success: function(d){
	        	$('#now').html(d.now);
	        	$('#lockDetailTableContent').html(refreshLockDetailTableHtml(d.lockDetailList));
	        }, error: function (request,status,error) {
	            //showAjaxError(request,status,error);
	        }
		});
	}
	function refreshLockDetailTableHtml(list){
		var html = '';
		if (list.length > 0){
			for (var i = 0; i < list.length; i++){
				html += '<tr>';
				html += '<td>';
				if (list[i].LEVEL > 1){
					html += '├';
					for (var j = 0; j < (list[i].LEVEL-1); j++){
						html += '-';
					}	
				}
				html += isNullReturn(list[i].TX_ID) +'</td>';
				html += '<td class="txt-cnt">' + isNullReturn(list[i].BLOCKED_TX_ID) +'</td>';
				html += '<td class="txt-cnt">' + isNullReturn(list[i].STATUS) +'</td>';
				html += '<td class="txt-cnt">' + isNullReturn(list[i].USER_NAME) +'</td>';
				html += '<td class="txt-cnt">' + isNullReturn(list[i].SESSION_ID) +'</td>';
				html += '<td class="txt-cnt">' + isNullReturn(list[i].CLIENT_IP) +'</td>';
				html += '<td class="txt-cnt">' + isNullReturn(list[i].AUTOCOMMIT) +'</td>';
				html += '<td class="txt-cnt">' + isNullReturn(list[i].LOCK_DESC) +'</td>';
				html += '<td class="txt-cnt">' + isNullReturn(list[i].FIRST_UPDATE_TIME) +'</td>';
				html += '<td class="txt-cnt">' + isNullReturn(list[i].TABLE_NAME) +'</td>';
				html += '<td class="txt-cnt">' + isNullReturn(list[i].CURRENT_QUERY) +'</td>';
				html += '<td class="txt-cnt">' + isNullReturn(list[i].DDL) +'</td>';
				html += '<td class="txt-cnt">' + isNullReturn(list[i].LOG_FILE) +'</td>';
				html += '</tr>';
			}
		} else {
			html += '<tr><td colspan="13">no rows selected.</td></tr>';
		}
		return html;
	}
</script>

<body>
	<div class="wrap">
		<div class="lock-detail">
			<table class="mg-top20">
				<tr>
					<th id="now" colspan="13" align="right">${now}</th>
				</tr>
				<tr>
					<th>TX_ID</th>
					<th>BLOCKED_TX_ID</th>
					<th>STATUS</th>
					<th>USER_NAME</th>
					<th>SESSION_ID</th>
					<th>CLIENT_IP</th>
					<th>AUTOCOMMIT</th>
					<th>LOCK_DESC</th>
					<th>FIRST_UPDATE_TIME</th>
					<th>TABLE_NAME</th>
					<th>CURRENT_QUERY</th>
					<th>DDL</th>
					<th>LOG_FILE</th>
				</tr>
				<tbody id="lockDetailTableContent">
					<c:choose>
						<c:when test="${fn:length(lockDetailList) > 0}">
							<c:forEach var="l" items="${lockDetailList}">
								<tr>
									<td>
										<c:if test="${l.LEVEL > 1}">
											├
											<c:forEach var="i" begin="0" end="${l.LEVEL-1}">
												-
											</c:forEach>
										</c:if>
										tx_id:${l.TX_ID}
									</td>
									<td class="txt-cnt">${l.BLOCKED_TX_ID}</td>
									<td class="txt-cnt">${l.STATUS}</td>
									<td class="txt-cnt">${l.USER_NAME}</td>
									<td class="txt-cnt">${l.SESSION_ID}</td>
									<td class="txt-cnt">${l.CLIENT_IP}</td>
									<td class="txt-cnt">${l.AUTOCOMMIT}</td>
									<td class="txt-cnt">${l.LOCK_DESC}</td>
									<td class="txt-cnt">${l.FIRST_UPDATE_TIME}</td>
									<td class="txt-cnt">${l.TABLE_NAME}</td>
									<td class="txt-cnt">${l.CURRENT_QUERY}</td>
									<td class="txt-cnt">${l.DDL}</td>
									<td class="txt-cnt">${l.LOG_FILE}</td>
								</tr>
							</c:forEach>
						</c:when>
						<c:otherwise>
							<tr>
								<td colspan="13">no rows selected.</td>
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
