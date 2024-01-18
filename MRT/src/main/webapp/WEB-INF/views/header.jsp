<%--
  Created by Eclipse.
  User: BBUGGE
  Date: 2023-12-28
  Time: 오전 10:09
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="CTX" value="${pageContext.request.contextPath}"/>
<c:set var="REQURI" value="${requestScope['javax.servlet.forward.request_uri']}"/>
<c:set var="ABSURL" value="${pageContext.request.scheme}://${pageContext.request.serverName}:${pageContext.request.serverPort}${pageContext.request.contextPath}"/>
<head>
    <meta charset="utf-8">
    <META HTTP-EQUIV="Pragma" CONTENT="no-cache">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="format-detection" content="telephone=no">
    

    <title>BBUGGE</title>
    <!-- Chrome, Safari, IE -->
    <link rel="shortcut icon" href="${CTX}/resources/image/favicon.ico">
    <!-- Firefox, Opera (Chrome and Safari say thanks but no thanks) -->
    <link rel="icon" href="${CTX}/resources/image/favico.png">

	<!-- jQuery -->
    <script src="${CTX}/resources/js/jquery-3.5.0.min.js"></script>
    <script src="${CTX}/resources/js/jquery-serialize-object.js"></script>
    <script src="${CTX}/resources/js/jquery-1.4.1.cookie.js"></script>
    <script src="${CTX}/resources/js/jquery-ui.min.js"></script>
    <script src="${CTX}/resources/js/feather.min.js"></script>
    <script src="${CTX}/resources/js/jquery-0.9.1.modal.min.js"></script>
	
	<!-- chart.js -->
	<script src="${CTX}/resources/js/chart.js"></script>
	
    <script src="${CTX}/resources/js/common_util.js?ver=1"></script>


    <link rel="stylesheet" href="${CTX}/resources/css/style.css?ver=1"></link>
    <link rel="stylesheet" href="${CTX}/resources/css/fonts.css?ver=1"></link>
    <%--<link rel="stylesheet" href="${CTX}/resources/css/jquery-0.9.1.modal.min.css?ver=1"></link>--%>
    <link rel="stylesheet" href="${CTX}/resources/css/addrlink.css?ver=1"></link>


</head>