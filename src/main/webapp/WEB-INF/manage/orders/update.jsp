<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<c:set var="path" value="${pageContext.request.contextPath}"></c:set>
<html>
<head>
    <meta charset="UTF-8">
    <title>修改订单信息</title>
</head>
<body>
<jsp:include page="/manageConfig/inc/top.jsp"></jsp:include>
<div class="container clearfix">
    <jsp:include page="/manageConfig/inc/left.jsp"></jsp:include>
    <!--/sidebar-->
    <div class="main-wrap">

        <div class="crumb-wrap">
            <div class="crumb-list"><i class="icon-font"></i><a href="${path}/manage/manager/index">首页</a><span class="crumb-step">&gt;</span><a class="crumb-name" href="${path}/manage/orders/list">订单列表</a><span class="crumb-step">&gt;</span><span>修改订单</span></div>
        </div>
        <div class="result-wrap">
            <c:set var="order" value="${requestScope.order}"></c:set>
            <div class="result-content">
                <form action="${path}/manage/orders/update" method="post" id="myform" name="myform" enctype="multipart/form-data" >
                    <input type="hidden" value="${order.id}" name="id">
                    <table class="insert-tab" width="100%">
                        <tbody>
                        <tr>
                            <th><i class="require-red">*</i>用户名:</th>
                            <td>
                                <input class="common-text required" id="username" name="order.user.username" size="50" value="${order.user.username}" type="text" disabled>

                            </td>

                        </tr>
                        <tr>
                            <th><i class="require-red">*</i>骑手姓名:</th>
                            <td>
                                <input class="common-text required" id="password" name="order.rider.username" size="50" value="${order.rider.username}" type="text" disabled>

                            </td>

                        </tr>
                        <tr>
                            <th><i class="require-red">*</i>店铺名:</th>
                            <td>
                                <input class="common-text required" id="name" name="order.merchant.name" size="50" value="${order.merchant.name}" type="text" disabled>
                            </td>

                        </tr>
                        <tr>
                            <th> 用户地址:</th>
                            <td><textarea name="address" class="common-textarea" id="order.user.address" cols="25" style="width: 80%;" value="${order.user.address}" rows="5"></textarea></td>
                        </tr>
                        <tr>
                            <th><i class="require-red">*</i>联系方式:</th>
                            <td>
                                <input class="common-text required" id="phone" name="order.user.phone" size="50" value="${order.user.phone}" type="text"disabled>
                            </td>
                        </tr>
                        <tr>
                            <th><i class="require-red">*</i>订单状态:</th>
                            <td>
                                <select name="orderStatus">
                                    <c:if test="${order.orderStatus eq 0}" var="flag">
                                        <option value=0 selected>未完成</option>
                                    </c:if>
                                    <c:if test="${not flag}">
                                        <option value=0>未完成</option>
                                    </c:if>
                                    <c:if test="${order.orderStatus eq 1}" var="flaga">
                                        <option value=1 selected>已完成</option>
                                    </c:if>
                                    <c:if test="${not flaga}">
                                        <option value=1>已完成</option>
                                    </c:if>
                                    <c:if test="${order.orderStatus eq 2}" var="flagb">
                                        <option value=2 selected>已取消</option>
                                    </c:if>
                                    <c:if test="${not flagb}">
                                        <option value=2>已取消</option>
                                    </c:if>

                                </select>
<%--                                <input class="common-text required" id="orderStatus" name="orderStatus" size="50" value="${order.orderStatus}" type="text">--%>
                            </td>
                        </tr>
                        <tr>
                            <th></th>
                            <td>
                                <input class="btn btn-primary btn6 mr10" value="提交" type="submit" id="btn">
                                <input class="btn btn6" onclick="history.go(-1)" value="返回" type="button">
                            </td>
                        </tr>
                        </tbody>
                    </table>
                </form>
            </div>
        </div>

    </div>
    <!--/main-->
</div>
</body>
</html>


