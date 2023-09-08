<%@ page import="java.util.List" %>
<%--Created by IntelliJ IDEA.
User: Administrator
Date: 2023/6/5
Time: 20:23
To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"></c:set>
<c:set var="ordersList" value="${requestScope.ordersList}"></c:set>
<script type="/manageConfig/js/chooseAllAndDelete.js"></script>
<script type="${path}/js/jquery-3.6.4.min.js"></script>
<html>
<head>
    <meta charset="UTF-8">
    <title>用户列表</title>
</head>
<body>
<jsp:include page="/manageConfig/inc/top.jsp"></jsp:include>
<div class="container clearfix">
    <jsp:include page="/manageConfig/inc/left.jsp"></jsp:include>
    <!--/sidebar-->
    <div class="main-wrap">
        <div class="crumb-wrap">
            <div class="crumb-list"><i class="icon-font"></i><a href="${path}/manage/rider/list">首页</a><span class="crumb-step">&gt;</span><span class="crumb-name">骑手管理</span></div>
        </div>
        <div class="search-wrap">
            <div class="search-content">
                <form action="${path}/manage/rider/list" method="post">
<%--                    <table class="search-tab">--%>
<%--                        <tr>--%>
<%--                            <th width="120">根据地址分类:</th>--%>
<%--                            <td>--%>
<%--                                <select name="province.id" id="province">--%>
<%--                                    <option value="" selected>请选择</option>--%>
<%--                                    <c:forEach items="${requestScope.sysAreaList}" var="sa">--%>
<%--                                        <option value="${sa.id}">${sa.name}</option>--%>
<%--                                    </c:forEach>--%>
<%--                                </select>--%>
<%--                                <select name="city.id" id="city"></select>--%>
<%--                                <select name="district.id" id="district"></select>--%>
<%--                            </td>--%>
<%--                            <th width="70">关键字:</th>--%>
<%--                            <td><input class="common-text" placeholder="关键字" name="keywords" value="" id="keywords" type="text"></td>--%>
<%--                            <td><input class="btn btn-primary btn2" name="sub" value="查询" type="submit"></td>--%>
<%--                        </tr>--%>
<%--                        <tr>--%>
<%--                            <th style="width: 150px; padding-left: 20px">订单状态：</th>--%>
<%--                            <td>--%>
<%--                                <input type="radio" name="available" value="0">否 <input type="radio" name="available" value="1">是--%>
<%--                            </td>--%>
<%--                        </tr>--%>
<%--                    </table>--%>
                </form>
            </div>
        </div>
        <div class="result-wrap">
            <form name="myform" id="myform" method="post">
                <div class="result-title">
                    <div class="result-list">
                        <a id="batchDel" href="javascript:void(0)" data-path="${path}" data-type="orders"><i class="icon-font"></i>批量删除</a>
                    </div>
                </div>
                <div class="result-content">
                    <table class="result-tab" width="100%">
                        <tr>
                            <th class="tc" width="5%"><input class="allChoose" name="" type="checkbox"></th>
                            <th>订单号</th>
                            <th>用户姓名</th>
<%--                            <th>接单骑手</th>--%>
                            <th>店铺名</th>
<%--                            <th>订单总价</th>--%>
<%--                            <th>用户下单状态</th>--%>
<%--                            <th>商家接单状态</th>--%>
<%--                            <th>骑手接单状态</th>--%>
                            <th>下单时间</th>
                            <th>订单状态</th>
                            <th>订单详情</th>
                            <th>操作</th>
                        </tr>
                        <c:forEach items="${ordersList}" var="order">
                            <tr id = "tr_${order.id}" data-type="order" data-path="${path}">
                                <td class="tc"><input name="id[]" value="59"  type="checkbox" class="check" data-id="${order.id}"></td>

                                <td>${order.complicatedId}</td>
                                <td>${order.user.username}</td>
<%--                                <td>${order.rider.username}</td>--%>
                                <td>${order.merchant.name}</td>
<%--                                <td>${order.totalPrice}</td>--%>
<%--                                <c:choose>--%>
<%--                                    <c:when test="${order.userFlag eq 0}"><td>已付款</td></c:when>--%>
<%--                                    <c:when test="${order.userFlag eq 1}"><td>未付款</td></c:when>--%>
<%--                                </c:choose>--%>
<%--                                <c:choose>--%>
<%--                                    <c:when test="${order.merchantFlag eq 0}"><td>已接单</td></c:when>--%>
<%--                                    <c:when test="${order.merchantFlag eq 1}"><td>未接单</td></c:when>--%>
<%--                                </c:choose>--%>
<%--                                <c:choose>--%>
<%--                                    <c:when test="${order.riderFlag eq 0}"><td>已接单</td></c:when>--%>
<%--                                    <c:when test="${order.riderFlag eq 1}"><td>未接单</td></c:when>--%>
<%--                                </c:choose>--%>
                                <td>${order.regTime}</td>
                                <c:choose>
                                    <c:when test="${order.orderStatus eq 0}"><td>未完成</td></c:when>
                                    <c:when test="${order.orderStatus eq 1}"><td>已完成</td></c:when>
                                    <c:when test="${order.orderStatus eq 2}"><td>已取消</td></c:when>
                                </c:choose>
                                <td><a href="${path}/manage/rider/ordersInfo?id=${order.id}">查看</a></td>
                                <td>
                                    <a class="link-del" href="" data-id="${order.id}" data-type="orders" data-path="${path}">删除</a>
                                </td>
                            </tr>
                        </c:forEach>
                    </table>
                    <div class="list-page">
                        <c:set var="page" value="${requestScope.pageUtils}"></c:set>
                        ${page.pageNum}/${page.pageCount}页 ${page.dataCount}条
                        <c:forEach begin="1" end="${page.pageCount}" var="i">
                            <a href="${path}/manage/rider/orders?id=${requestScope.rider_id}&pageNum=${i}" class="${i eq page.pageNum?'current':''}">${i}</a>
                        </c:forEach>
                    </div>
                </div>
            </form>
        </div>
    </div>
    <!--/main-->
</div>
</body>
</html>