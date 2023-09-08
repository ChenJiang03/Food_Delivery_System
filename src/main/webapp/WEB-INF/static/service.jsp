<%--
  Created by IntelliJ IDEA.
  User: lbp
  Date: 2023/7/11
  Time: 14:11
  To change this template use File | Settings | File Templates.
--%>
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
        <h1 class="Font16 FontW classtitle">服务内容</h1>
        <div class="A-read">
            丑团外卖提供了许多种服务，包括：1.在线下单：丑团外卖提供了电脑、手机APP、微信等多种下单方式，用户可以方便地在平台上选择食物、饮料、药品等，并支持丑团支付、微信支付、Applepay等多种支付方式。
            2.配送服务：丑团外卖支持美团专送、丑团跑腿、第三方配送等服务，用户可以根据自己的需求选择不同的配送方式。
            3.药品配送：丑团外卖还提供了送药上门的服务，用户可以在平台上选择购买药品，并支持美团支付、微信支付等多种支付方式。
            4.商家服务：丑团外卖提供了商家信息展示服务、交易服务、商服及客服服务等多种服务，帮助商家上线菜单、开发菜品、对接安装系统设备以及提供各种外卖交易服务。此外，丑团外卖还提供了许多增值服务，例如代购、拼单、帮送、评价等，用户可以根据自己的需求选择不同的服务。
            <br/>
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
