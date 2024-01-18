<%--
  Created by IntelliJ IDEA.
  User: User
  Date: 2020-04-15
  Time: 오후 4:32
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<script>
    $(function(){
    })
</script>

<div class="modal-con">
    <div class="prd-detail-wrap">
        <div class="prd-detail-head">
            <label>※ </label>
            <div class="btn-wrap row">
                <div class="col-6">
                </div>
                <div class="col-6 txt-rt">
<%--                     <button type="button" class="btn-modify" onclick="openProductUpdModal('${prodInfo.PROD_NO}');">수정</button> --%>
<%--                     <button type="button" class="btn-delete" onclick="openProductRemove('${prodInfo.PROD_NO}')">삭제</button> --%>
                </div>
            </div>
        </div>
        <div class="prd-info-wrap">
        	<table class="mg-top20">
        		<tr>
        			<th width="2%">TBS_ID</th>
        			<th width="*">TBS_TYPE</th>
        			<th width="*">TBS_NAME</th>
        			<th width="10%">MAX</th>
        			<th width="10%">TOTAL</th>
        			<th width="10%">ALLOC</th>
        			<th width="10%">USED</th>
        			<th width="10%">USAGE</th>
        			<th width="5%">STATE</th>
        			<th width="7%">AUTO_EXT</th>
        		</tr>
        		<tr>
        			<th colspan="10">MEMORY TABLESPACE</th>
        		</tr>
        		<tbody>
        			<c:choose>
        				<c:when test="${fn:length(memTbsList) > 0}">
	        				<c:forEach var="l" items="${memTbsList}">
		        				<tr>
		        					<td class="txt-rt">${l.TBS_ID}</td>
		        					<td class="txt-cnt">${l.TBS_TYPE}</td>
		        					<td class="txt-cnt">${l.TBS_NAME}</td>
		        					<td class="txt-rt">${l.MAX} ${l.UNIT}</td>
		        					<td class="txt-rt">${l.TOTAL} ${l.UNIT}</td>
		        					<td class="txt-rt">${l.ALLOC} ${l.UNIT}</td>
		        					<td class="txt-rt">${l.USED} ${l.UNIT}</td>
		        					<td class="txt-rt">${l.USAGE}%</td>
		        					<td class="txt-cnt">${l.STATE}</td>
		        					<td class="txt-cnt">${l.AUTOEXTEND}</td>
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
        		<tr>
        			<th colspan="10">DISK TABLESPACE</th>
        		</tr>
        		<tbody>
        			<c:choose>
        				<c:when test="${fn:length(dskTbsList) > 0}">
	        				<c:forEach var="k" items="${dskTbsList}">
		        				<tr>
		        					<td class="txt-rt">${k.TBS_ID}</td>
		        					<td class="txt-cnt">${k.TBS_TYPE}</td>
		        					<td class="txt-cnt">${k.TBS_NAME}</td>
		        					<td class="txt-rt">${k.MAX} ${k.UNIT}</td>
		        					<td class="txt-rt">${k.TOTAL} ${k.UNIT}</td>
		        					<td class="txt-rt">${k.ALLOC} ${k.UNIT}</td>
		        					<td class="txt-rt">${k.USED} ${k.UNIT}</td>
		        					<td class="txt-rt">${k.USAGE}%</td>
		        					<td class="txt-cnt">${k.STATE}</td>
		        					<td class="txt-cnt">${k.AUTOEXTEND}</td>
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
        		
<!--             <li class="prd-img-big"> -->
<%--                 <img src="${prodInfo.MAIN_IMAGE_PATH}" alt="${prodInfo.PROD_NAME}_1" onerror="imgError(this,'${CTX}')"> --%>
<!--             </li> -->
<!--             <li class="prd-info"> -->
<!--                 <dl> -->
<!--                     <dt class="prd-name"> -->
<%--                         <div aria-label="${prodInfo.PROD_NAME}"><span>${prodInfo.PROD_NAME}</span></div> --%>
<!--                     </dt> -->
<!--                     <dd> -->
<!--                         <div class="prd-txt price"> -->
<!--                             <label>가격</label> -->
<%--                             <span>${prodInfo.FORMAT_PROD_PRICE}</span> --%>
<!--                         </div> -->
<!--                         <div class="prd-txt price-point"> -->
<!--                             <label>토큰가격</label> -->
<!--                             <span> -->
<%--                                 <c:choose> --%>
<%--                                     <c:when test="${prodInfo.PROD_TOKEN != null}"> --%>
<%--                                         ${prodInfo.PROD_TOKEN} --%>
<%--                                     </c:when> --%>
<%--                                     <c:otherwise> --%>
<!--                                         - -->
<%--                                     </c:otherwise> --%>
<%--                                 </c:choose> --%>
<!--                             </span> -->
<!--                         </div> -->
<!--                         <div class="prd-txt color"> -->
<!--                             <label>색상 및 사이즈</label> -->
<%--                             <c:forEach var="colorList" items="${colorList}" varStatus="status"> --%>
<%--                                 <span class="view-color" onclick="showSize('${status.index}');"> --%>
<%--                                     <span class="color">${colorList.COLOR_NAME}</span> --%>
<%--                                     <c:forEach var="supplyList" items="${supplyList}"> --%>
<%--                                         <c:if test="${colorList.COLOR_NO == supplyList.PROD_COLOR_NO}"> --%>
<%--                                             <span class="view-size" name="p_size-${status.index}">${supplyList.SIZE_NAME} (수량 : ${supplyList.PROD_SUPPLY_NUM}) --%>
<%--                                                 <c:if test="${supplyList.PROD_SUPPLY_NUM > 0}"> --%>
<%--                                                     <button type="button" class="btn-offline" id="btn_offline-${status.index}" onclick="openProductOffLineSale('${supplyList.PROD_NO}','${supplyList.PROD_COLOR_NO}','${supplyList.PROD_SIZE_NO}')">오프라인 판매</button> --%>
<%--                                                 </c:if> --%>
<!--                                             </span> -->
<%--                                         </c:if> --%>
<%--                                     </c:forEach> --%>
<!--                                 </span> -->
<%--                             </c:forEach> --%>
<!--                         </div> -->
<!--                     </dd> -->
<!--                 </dl> -->
<!--             </li> -->
        </div>
        <div class="prd-detail-con">
            ${prodInfo.PROD_EXPLAN}
        </div>
    </div>
</div>


<a class="button_none pointer right" rel="modal:close"></a>