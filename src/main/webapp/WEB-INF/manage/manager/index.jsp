<%--
  Created by IntelliJ IDEA.
  User: lbp
  Date: 2023/6/5
  Time: 11:13
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"></c:set>


<c:if test="${'error' eq param.msg}">
    <script>window.alert('权限不够')</script>
</c:if>
<html>
<head>
    <meta charset="UTF-8">
    <title>后台管理系统</title>

</head>
<body>

<jsp:include page="/manageConfig/inc/top.jsp"></jsp:include>
<div class="container clearfix">
    <jsp:include page="/manageConfig/inc/left.jsp"></jsp:include>
    <!--/sidebar-->
    <div class="main-wrap">
        <div class="crumb-wrap">
            <div class="crumb-list"><i class="icon-font">&#xe06b;</i><span>欢迎使用『丑团』外卖管理平台。</span></div>
        </div>
        <div class="result-wrap">
            <div class="result-title">
                <h1>快捷操作</h1>
            </div>
            <div class="result-content">
                <div class="short-wrap">
                    <a href="${path}/manage/user/list"><i class="icon-font">&#xe001;</i>用户管理</a>
                    <a href="${path}/manage/merchant/list"><i class="icon-font">&#xe005;</i>商家管理</a>
                    <a href="${path}/static/weekEChart"><i class="icon-font">&#xe048;</i>查看周交易量</a>
                    <a href="${path}/static/monthEChart"><i class="icon-font">&#xe041;</i>查看当月日活度量</a>
                    <a href="${path}/manage/rider/list"><i class="icon-font">&#xe01e;</i>骑手管理</a>
                </div>
            </div>
        </div>
        <div class="result-wrap">
            <div class="result-title">
                <h1>系统基本信息</h1>
            </div>
            <div class="result-content">
                <ul class="sys-info-list">
                    <li>
                        <label class="res-lab">操作系统</label><span class="res-info">WINDOW-10</span>
                    </li>
                    <li>
                        <label class="res-lab">运行环境</label><span class="res-info">Apache/2.2.21 (Win64)</span>
                    </li>
                    <li>
                        <label class="res-lab">PHP运行方式</label><span class="res-info">apache2handler</span>
                    </li>
                    <li>
                        <label class="res-lab">静静设计-版本</label><span class="res-info">v-0.1</span>
                    </li>
                    <li>
                        <label class="res-lab">上传附件限制</label><span class="res-info">2M</span>
                    </li>
                    <li>
                        <label class="res-lab">北京时间</label><span class="res-info">2014年3月18日 21:08:24</span>
                    </li>
                    <li>
                        <label class="res-lab">服务器域名/IP</label><span class="res-info">localhost [ 127.0.0.1 ]</span>
                    </li>
                    <li>
                        <label class="res-lab">Host</label><span class="res-info">127.0.0.1</span>
                    </li>
                </ul>
            </div>
        </div>
    </div>
    <!--/main-->
</div>

</body>
</html>


