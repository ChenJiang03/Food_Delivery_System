<%--
  Created by IntelliJ IDEA.
  User: lbp
  Date: 2023/6/5
  Time: 10:56
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"></c:set>
<c:set var="manager" value="${sessionScope.manager}"></c:set>
<link rel="stylesheet" type="text/css" href="${path}/manageConfig/css/common.css"/>
<link rel="stylesheet" type="text/css" href="${path}/manageConfig/css/main.css"/>
<script type="text/javascript" src="${path}/manageConfig/js/libs/modernizr.min.js"></script>
<script type="text/javascript" src="${path}/manageConfig/js/chooseAllAndDelete.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<div class="topbar-wrap white">
    <div class="topbar-inner clearfix">
        <div class="topbar-logo-wrap clearfix">
            <h1 class="topbar-logo none"><a href="index.html" class="navbar-brand">后台管理</a></h1>
            <ul class="navbar-list clearfix">
                <li><a class="on" href="index.html">首页</a></li>
                <li><a href="http://www.mycodes.net/" target="_blank">网站首页</a></li>
            </ul>
        </div>
        <div class="top-info-wrap">
            <ul class="top-info-list clearfix">
                <li><a href="#">${manager.username}</a></li>
                <li><a href="${path}/manage/manager/managerLogin">超管登录</a></li>
                <li><a href="${path}/manage/manager/exit">退出</a></li>
            </ul>
        </div>
    </div>
</div>