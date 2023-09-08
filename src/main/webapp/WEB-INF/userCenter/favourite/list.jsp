<%--
  Created by IntelliJ IDEA.
  User: Nancy
  Date: 2023/6/18
  Time: 21:31
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set value="${pageContext.request.contextPath}" var="path"></c:set>
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
    <style>
        .delFavour{
            cursor: pointer;
        }
    </style>
</head>
<body>
<!--Start header-->
<jsp:include page="/webConfig/inc/userTop.jsp"></jsp:include>
<!--Start content-->
<section class="Psection MT20">
    <jsp:include page="/webConfig/inc/userLeft.jsp"></jsp:include>
    <article class="U-article Overflow">
        <!--user Favorites-->
        <section class="ShopFav Overflow">
            <span class="ShopFavtitle Block Font14 FontW Lineheight35">我的收藏</span>
            <c:forEach items="${requestScope.favouriteList}" var="f">
            <ul>
                <li class="favourite" data-id="${f.id}">
                    <a href="${path}/userCenter/shop?id=${f.merchant.id}" target="_blank" >
                            <img src="${path}${f.merchant.picture}">
                            <p>${f.merchant.name}</p>
                    </a>
                    <p class="delFavour">删除</p>
                </li>
            </ul>
            </c:forEach>
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
<script src="${path}/webConfig/js/jquery-3.6.4.min.js"></script>
<script>
    $(function (){

        $(".delFavour").click(function (){
            var id = $(this).parent(".favourite").data("id");
            $.get("${path}/userCenter/favourite/delete",{id:id},function (data){
                if("ok"==data){
                    location.reload();
                }
            })
        })
    })
</script>
