<%--
  Created by IntelliJ IDEA.
  User: Nancy
  Date: 2023/6/28
  Time: 15:47
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"></c:set>
<c:set var="rider" value="${sessionScope.rider}"></c:set>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8" />
    <meta name="author" content="order by dede58.com"/>
    <title>DeathGhost-用户中心</title>
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
<jsp:include page="/webConfig/inc/riderTop.jsp"></jsp:include>
<!--Start content-->
<section class="Psection MT20">
    <jsp:include page="/webConfig/inc/riderLeft.jsp"></jsp:include>
    <article class="U-article Overflow">
        <!--"引用“user_page/user_index.html”"-->
        <section class="usercenter">
            <span class="Weltitle Block Font16 CorRed FontW Lineheight35">Welcome欢迎光临！</span>
            <div class="U-header MT20 Overflow">
                <img src="${path}${rider.picture.split(",")[0]}">
                <p class="Font14 FontW">${rider.name} 欢迎您回到 骑手中心！</p>
                <p class="Font12">丑团外卖，送啥都慢！咱干啥啥不行，毒奶第一名</p>
                <p class="Font12 CorRed FontW">我的评分（5.0）</p>
                <p class="Font12 CorRed FontW">账户余额${rider.balance}</p>
            </div>
        </section>
    </article>
</section>
<!--End content-->
<div class="F-link">
    <span>友情链接：</span>
</div>
<jsp:include page="/webConfig/inc/riderFoot.jsp"></jsp:include>
</body>
</html>

