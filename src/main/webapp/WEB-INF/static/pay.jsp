<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2023/6/19
  Time: 19:22
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"></c:set>

<html>
<head>
    <meta charset="utf-8" />
    <meta name="author" content="order by dede58.com"/>
    <title>DeathGhost-登录</title>
    <meta name="keywords" content="DeathGhost,DeathGhost.cn,web前端设,移动WebApp开发" />
    <meta name="description" content="DeathGhost.cn::H5 WEB前端设计开发!" />
    <meta name="author" content="DeathGhost"/>
    <link rel="stylesheet" href="${path}/webConfig/style/slidercaptcha.css" type="text/css"/>
    <link href="${path}/webConfig/style/style.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="${path}/webConfig/js/public.js"></script>
    <script type="text/javascript" src="${path}/webConfig/js/jquery.js"></script>
    <script type="text/javascript" src="${path}/webConfig/js/jqpublic.js"></script>
    <script type="text/javascript" src="${path}/webConfig/js/longbow.slidercaptcha.js"></script>
    <!--
    Author: DeathGhost
    Author URI: http://www.deathghost.cn
    -->
</head>
<body>
<jsp:include page="/webConfig/inc/userTop.jsp"></jsp:include>
<!--Start content-->
<section class="Psection MT20">
    <article class="A-left Overflow">
        <h1 class="Font16 FontW classtitle">支付方式</h1>
        <div class="A-read">
            <select>
                <option>微信支付</option>
                <option>支付宝</option>
                <option>银联支付</option>
            </select>
        </div>
    </article>
    <aside class="A-right Overflow">
        <div class="AAlist">
            <ul>
                <li><a href="#" target="_blank" title="这里是推荐某分类文章">这里是推荐某分类文章...</a></li>
            </ul>
        </div>
        <!--广告位-->
        <div style="margin:8px 0;">
            <a href="#" target="_blank"><img src="${path}/webConfig/upload/ggw.jpg"></a>
        </div>
    </aside>
</section>
<!--End content-->
<div class="F-link">
    <span>友情链接：</span>
</div>
<jsp:include page="/webConfig/inc/userFoot.jsp"></jsp:include>
</body>
</html>
<style>
    .sliderContainer{
        height: 40px !important;
    }
</style>
<script type="text/javascript" src="${path}/webConfig/js/jquery-3.6.4.min.js"></script>
<script>

</script>
