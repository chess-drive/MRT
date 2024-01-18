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
			
			stmtDetailMonitorAjax();
		}, g_term*1000)
	}
	function stmtDetailMonitorAjax(){
		var param = [];
		$.ajax({
	        type:"GET",
// 	        data:{},
	        url:"/stmtDetailAjax",
	        cache:"false",
	        //dataType:"data",
	        success: function(d){
	        	$('#now').html(d.now);
	        	$('#stmtDetailTableContent').html(refreshstmtDetailTableHtml(d.stmtDetailList));
	        }, error: function (request,status,error) {
	            //showAjaxError(request,status,error);
	        }
		});
	}
	function refreshstmtDetailTableHtml(list){
		var html = '';
		if (list.length > 0){
			for (var i = 0; i < list.length; i++){
				html += '<tr>';
				html += '<td class="txt-cnt">' + isNullReturn(list[i].SESSION_ID) +'</td>';   
				html += '<td class="txt-cnt">' + isNullReturn(list[i].STMT_ID) +'</td>';
				html += '<td class="txt-cnt">' + isNullReturn(list[i].TX_ID) +'</td>';
				html += '<td class="txt-cnt">' + isNullReturn(list[i].DB_USERNAME) +'</td>';
				html += '<td class="txt-cnt">' + isNullReturn(list[i].MODULE) +'</td>';
				html += '<td class="txt-cnt">' + isNullReturn(list[i].APP_INFO) +'</td>';
				html += '<td class="txt-cnt">' + isNullReturn(list[i].COMM_NAME) +'</td>';
				html += '<td>' + isNullReturn(list[i].QUERY) +'</td>';
				html += '<td class="txt-cnt">' + isNullReturn(list[i].PREPARE_TIME) +'</td>';
				html += '<td class="txt-cnt">' + isNullReturn(list[i].FETCH_TIME) +'</td>';
				html += '<td class="txt-cnt">' + isNullReturn(list[i].EXECUTE_TIME) +'</td>';
				html += '<td class="txt-cnt">' + isNullReturn(list[i].TOTAL_TIME) +'</td>';
				html += '<td class="txt-cnt">' + isNullReturn(list[i].LAST_START_TIME) +'</td>';
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
		<div class="stmt-detail">
			<table class="mg-top20">
				<tr>
					<th id="now" colspan="13" align="right">${now}</th>
				</tr>
				<tr>
					<th>SESSION_ID</th>
					<th>STMT_ID</th>
					<th>TX_ID</th>
					<th>USERNAME</th>
					<th>MODULE</th>
					<th>APP_INFO</th>
					<th>COMM_NAME</th>
					<th>QUERY</th>
					<th>PREPARE_TIME</th>
					<th>FETCH_TIME</th>
					<th>EXECUTE_TIME</th>
					<th>TOTAL_TIME</th>
					<th>LAST_START_TIME</th>
				</tr>
				<tbody id="stmtDetailTableContent">
					<c:choose>
						<c:when test="${fn:length(slowQueryList) > 0}">
							<c:forEach var="l" items="${slowQueryList}">
								<tr>
									<td class="txt-cnt">${l.SESSION_ID}</td>
									<td class="txt-cnt">${l.STMT_ID}</td>
									<td class="txt-cnt">${l.TX_ID}</td>
									<td class="txt-cnt">${l.DB_USERNAME}</td>
									<td class="txt-cnt">${l.MODULE}</td>
									<td class="txt-cnt">${l.APP_INFO}</td>
									<td class="txt-cnt">${l.COMM_NAME}</td>
									<td aria-label="${l.QUERY}"><span>${l.QUERY}</span></td>
									<td class="txt-cnt">${l.PREPARE_TIME}</td>
									<td class="txt-cnt">${l.FETCH_TIME}</td>
									<td class="txt-cnt">${l.EXECUTE_TIME}</td>
									<td class="txt-cnt">${l.TOTAL_TIME}</td>
									<td class="txt-cnt">${l.LAST_START_TIME}</td>
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
