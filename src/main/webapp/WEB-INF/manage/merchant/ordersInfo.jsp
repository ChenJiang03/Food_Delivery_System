<%@ page import="com.example.uglytuan.vo.ProductType" %><%--
  Created by IntelliJ IDEA.
  User: Nancy
  Date: 2023/6/18
  Time: 21:32
  To change this template use File | Settings | File Templates.
--%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"></c:set>
<c:set var="orders" value="${requestScope.orders}"></c:set>
<c:set var="orderDetails" value="${requestScope.orderDetails}"></c:set>
<html>
<head>
    <meta charset="UTF-8">
    <title>订单详情</title>
    <style type="text/css">
        span
        {
            font-size: 13px;
        }
    </style>
</head>
<body>
<jsp:include page="/manageConfig/inc/top.jsp"></jsp:include>
<div class="container clearfix">
    <jsp:include page="/manageConfig/inc/left.jsp"></jsp:include>
    <!--/sidebar-->
    <div class="main-wrap">

        <div class="crumb-wrap">
            <div class="crumb-list"><i class="icon-font"></i><a href="${path}/manage/merchant/list">首页</a><span class="crumb-step">&gt;</span><a class="crumb-name" href="${path}/manage/merchant/list">商家管理</a><span class="crumb-step">&gt;</span><span>修改商家</span></div>
        </div>
        <div class="result-wrap">
            <div class="result-content">

                <form action="" method="post" id="myform" name="myform" enctype="multipart/form-data">
                    <%--                    <input type="hidden" name="id" id="id" value="${p.id}">--%>
                    <table class="insert-tab" width="100%">
                        <tbody>
                        <tr>
                            <th>
                                <i class="require-red">*</i>订单id：
                            </th>
                            <td>
                                <span>${orders.id}</span>
                            </td>
                        </tr>
                        <tr>
                            <th><i class="require-red">*</i>订单号：</th>
                            <td>
                                <span>${orders.complicatedId}</span>
                            </td>
                        </tr>
                        <tr>
                            <th><i class="require-red">*</i>下单时间：</th>
                            <td>
                                <span>${orders.regTime}</span>
                            </td>
                        </tr>
                        <tr>
                            <th><i class="require-red">*</i>下单用户：</th>
                            <td>
                                <span>用户id：${orders.user.id}</span><br>
                                <span>用户名：${orders.user.username}</span><br>
                                <span>名字：${orders.user.name}</span><br>
                                <span>用户电话：${orders.user.phone}</span><br>
                                <span>用户地址：${orders.userProvince.name} ${orders.userCity.name} ${orders.userDistrict.name}</span><br>
                                <span>${orders.userAddressDetail}</span>
                            </td>
                        </tr>
                        <tr>
                            <th><i class="require-red">*</i>接单商家：</th>
                            <td>
                                <span>商家id：${orders.merchant.id}</span><br>
                                <span>商家用户名：${orders.merchant.username}</span><br>
                                <span>商家名称：${orders.merchant.name}</span><br>
                                <span>商家电话：${orders.merchant.phone}</span><br>
                                <span>商家地址：${orders.merchantProvince.name} ${orders.merchantCity.name} ${orders.merchantDistrict.name}</span><br>
                                <span>${orders.merchantAddressDetail}</span>
                            </td>
                        </tr>
                        <tr>
                            <th><i class="require-red">*</i>骑手信息：</th>
                            <td>
                                <span>骑手id：${orders.rider.id}</span><br>
                                <span>骑手用户名：${orders.rider.username}</span><br>
                                <span>骑手姓名：${orders.rider.name}</span><br>
                                <span>骑手手机号：${orders.rider.phone}</span><br>
                            </td>
                        </tr>
                        <tr>
                            <th><i class="require-red">*</i>订单详情：</th>
                            <td>
                                <c:forEach items="${orderDetails}" var="orderDetail">
                                    <span>名称：${orderDetail.product.title}  数量：${orderDetail.amount}  单价：￥${orderDetail.price}  单品总价：￥${orderDetail.price * orderDetail.amount}</span><br>
                                </c:forEach>
                                <span>订单总金额：${orders.totalPrice}</span>
                            </td>
                        </tr>
                        <tr>
                            <th><i class="require-red">*</i>订单状态：</th>
                            <td>
                                <span style="font-weight: bold">${orders.orderStatus eq 0?"未完成":""}${orders.orderStatus eq 1?"已完成":""}${orders.orderStatus eq 2?"已取消":""}</span><br>
                                <c:if test="${orders.orderStatus eq 0}">
                                    <span>${orders.userFlag eq 1?"用户已下单✔":"用户未下单×"}</span><br>
                                    <span>${orders.merchantFlag eq 1?"商家已接单✔":"等待商家接单×"}</span><br>
                                    <span>${orders.riderFlag eq 1?"骑手已接单✔":"骑手未接单×"}</span>
                                </c:if>
                            </td>
                        </tr>
                        <tr>
                            <th><i class="require-red">*</i>订单评分：</th>
                            <td>
                                <span>${orders.rating}</span>
                            </td>
                        </tr>
                        <tr>
                            <th><i class="require-red">*</i>订单具体评价：</th>
                            <td>
                                <span>${order.ratingDescription}</span>
                            </td>
                        </tr>
                        <tr>
                            <th></th>
                            <td>
                                <input class="btn btn6" onclick="history.go(-1)" value="返回" type="button">
                            </td>
                        </tr>
                        </tbody></table>
                </form>
            </div>
        </div>

    </div>
    <!--/main-->
</div>
</body>
</html>
<script type="text/javascript" src="${path}/js/jquery-3.6.4.min.js" ></script>

<script type="text/javascript" src="${path}/webConfig/ueditor/ueditor.config.js" charset="utf-8"></script>
<script type="text/javascript" src="${path}/webConfig/ueditor/ueditor.all.js" charset="utf-8"></script>
<script type="text/javascript" charset="utf-8" src="${path}/webConfig/ueditor/lang/zh-cn/zh-cn.js" ></script>
