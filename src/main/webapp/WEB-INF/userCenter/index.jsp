<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2023/6/24
  Time: 0:51
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"></c:set>
<html>
<head>
    <meta charset="utf-8" />
    <meta name="author" content="order by dede58.com"/>
    <title>用户中心</title>
    <meta name="keywords" content="DeathGhost,DeathGhost.cn,web前端设,移动WebApp开发" />
    <meta name="description" content="DeathGhost.cn::H5 WEB前端设计开发!" />
    <meta name="author" content="DeathGhost"/>
    <link href="${path}/webConfig/style/style.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="${path}/webConfig/js/public.js"></script>
    <script type="text/javascript" src="${path}/webConfig/js/jquery.js"></script>
    <script type="text/javascript" src="${path}/webConfig/js/jqpublic.js"></script>
    <!--
    Author: DeathGhost
    Author URI: http://www.deathghost.cn
    -->
</head>
<body>
<jsp:include page="/webConfig/inc/userTop.jsp"></jsp:include>
<!--Start content-->
<section class="Psection MT20">
    <jsp:include page="/webConfig/inc/userLeft.jsp"></jsp:include>
    <article class="U-article Overflow">
        <!--"引用“user_page/user_index.html”"-->
        <section class="usercenter">
            <span class="Weltitle Block Font16 CorRed FontW Lineheight35">Welcome欢迎光临！</span>
            <div class="U-header MT20 Overflow">
                <img src="${path}${sessionScope.user.picture}">
                <p class="Font14 FontW">DeathGhost 欢迎您回到 用户中心！</p>
                <p class="Font12 CorRed FontW">我的余额：${sessionScope.user.balance}</p>
            </div>
<%--            <ul class="s-States Overflow FontW" id="Lbn">--%>
<%--                <li class="Font14 FontW">幸福业务在线提醒：</li>--%>
<%--                <li><a href="#">待付款( 0 )</a></li>--%>
<%--                <li><a href="#">待发货( 0 )</a></li>--%>
<%--                <li><a href="#">待收货( 0 )</a></li>--%>
<%--                <li><a href="#">待评价( 0 )</a></li>--%>
<%--            </ul>--%>
        </section>
    </article>
</section>
<!--End content-->
<div class="F-link">
    <span>友情链接：</span>
</div>
<jsp:include page="/webConfig/inc/userFoot.jsp"></jsp:include>
</body>
</html>

