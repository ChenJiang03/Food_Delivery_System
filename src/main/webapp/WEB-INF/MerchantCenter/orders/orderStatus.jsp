<%--
  Created by IntelliJ IDEA.
  User: Nancy
  Date: 2023/7/5
  Time: 13:52
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"></c:set>
<c:set var="ordersList" value="${requestScope.ordersList}"></c:set>
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
<jsp:include page="/webConfig/inc/merchantTop.jsp"></jsp:include>
<!--Start content-->
<section class="Psection MT20">
    <jsp:include page="/webConfig/inc/merchantLeft.jsp"></jsp:include>
    <article class="U-article Overflow">
        <!--user order list-->
        <section>
            <table class="Myorder">
                <th class="Font14 FontW"><a class="Font14 FontW" href="${path}/MerchantCenter/orders/newOrders">新的订单</a></th>
                <th class="Font14 FontW"><a class="Font14 FontW" href="${path}/MerchantCenter/orders/list">全部订单</a></th>
                <th class="Font14 FontW"><a class="Font14 FontW" href="${path}/MerchantCenter/orders/orderStatus?order_status=0">未送达订单</a></th>
                <th class="Font14 FontW"><a class="Font14 FontW" href="${path}/MerchantCenter/orders/orderStatus?order_status=1">已完成订单</a></th>
                <th class="Font14 FontW"><a class="Font14 FontW" href="${path}/MerchantCenter/orders/orderStatus?order_status=2">已取消订单</a></th>
            </table>
            <table class="Myorder">
                <th class="Font14 FontW">订单编号</th>
                <th class="Font14 FontW">下单时间</th>
                <th class="Font14 FontW">收件人</th>
                <th class="Font14 FontW">订单总金额</th>
                <th class="Font14 FontW">订单状态</th>
                <th class="Font14 FontW">操作</th>
                <c:forEach items="${ordersList}" var="order">
                    <tr>
                        <td class="FontW">${order.complicatedId}</td>
                        <td>${order.regTime}</td>
                        <td>${order.user.name}</td>
                        <td>${order.totalPrice}</td>
                        <td>${order.orderStatus eq 0? "未完成":""}${order.orderStatus eq 1? "已完成":""}${order.orderStatus eq 2? "已取消":""}</td>
                        <td><a href="${path}/MerchantCenter/orders/ordersInfo?id=${order.id}">订单详情</a> |<a href="${path}/MerchantCenter/orders/cancel?id=${order.id}">${order.orderStatus eq 0?"取消订单":""}</a></td>
                    </tr>
                </c:forEach>
            </table>
            <div class="list-page">
                <c:set var="page" value="${requestScope.pageUtils}"></c:set>
                ${page.pageNum}/${page.pageCount}页 ${page.dataCount}条
                <c:if test="${page.dataCount != 0}">
                    <c:forEach begin="0" end="${page.pageCount-1}" varStatus="stat">
                        <a href="${path}/MerchantCenter/orders/orderStatus?order_status=${requestScope.order_status}&pageNum=${stat.count}" class="${stat.count eq page.pageNum?'current':''}">${stat.count}</a>
                    </c:forEach>
                </c:if>
            </div>
        </section>
    </article>
</section>
<!--End content-->
<div class="F-link">
    <span>友情链接：</span>
</div>
<jsp:include page="/webConfig/inc/merchantFoot.jsp"></jsp:include>
</body>
</html>
