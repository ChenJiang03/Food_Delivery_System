<%@ page import="java.util.List" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="path" value="${pageContext.request.contextPath}"></c:set>
<html>
<head>
    <meta charset="UTF-8">
    <title>用户列表</title>
    <style>
        img{
            width: 50px;
            height: 50px;
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
            <div class="crumb-list"><i class="icon-font"></i><a href="${path}/manage/manager/index">首页</a><span class="crumb-step">&gt;</span><span class="crumb-name">用户管理</span></div>
        </div>
<%--        <div class="search-wrap">--%>
<%--            <div class="search-content">--%>
<%--                <form action="${path}/manage/user/search" method="get">--%>
<%--                    <table class="search-tab">--%>
<%--                        <tr>--%>
<%--                            <th width="70">关键字:</th>--%>
<%--                            <td><input class="common-text" placeholder="关键字" name="keywords" value="${param.keywords}" id="keywords" type="text"></td>--%>
<%--                            <td><input class="btn btn-primary btn2" name="sub" value="查询" type="submit"></td>--%>
<%--                        </tr>--%>
<%--                    </table>--%>
<%--                </form>--%>
<%--            </div>--%>
<%--        </div>--%>
        <div class="result-wrap">
            <form name="myform" id="myform" method="post">
                <div class="result-title">
                    <div class="result-list">
                        <a id="batchDel" href="javascript:void(0)" data-type="address" data-path="${path}"><i class="icon-font" ></i>批量删除</a>
                    </div>
                </div>
                <div class="result-content">
                    <table class="result-tab" width="100%">
                        <tr>
                            <th class="tc" width="5%"><input class="allChoose" name="" type="checkbox"></th>
                            <th>用户名</th>
                            <th>订单号</th>
                            <th>商家</th>
                            <th>送单骑手</th>
                            <th>订单状态</th>
                            <th>下单时间</th>
                            <th>操作</th>
                        </tr>

                        <c:forEach items="${requestScope.ordersList}" var="orders">
                            <tr id ="tr_${orders.id}">
                                <td class="tc"><input name="id[]" value="59"  type="checkbox" class="check" data-id="${orders.id}"></td>
                                <td>${orders.user.username}</td>
                                <td>${orders.complicatedId}</td>
                                <td>${orders.merchant.username}</td>
                                <td>${orders.rider.name}</td>
                                <c:choose>
                                    <c:when test="${order.orderStatus eq 0}"><td>未完成</td></c:when>
                                    <c:when test="${order.orderStatus eq 1}"><td>已完成</td></c:when>
                                    <c:when test="${order.orderStatus eq 2}"><td>已取消</td></c:when>
                                </c:choose>
                                <td>${orders.regTime}</td>
                                <td>
                                    <a class="link-del" href="" data-id="${address.id}" data-type="user" data-path="${path}">删除</a>
                                </td>
                            </tr>
                        </c:forEach>
                    </table>
                    <div class="list-page">
                        <c:set var="page" value="${requestScope.pageUtils}"></c:set>
                        ${page.pageNum}/${page.pageCount}页 ${page.dataCount}条
                        <c:if test="${page.dataCount != 0}">
                            <c:if test="${empty param.keywords}" var="flag">
                                <c:forEach begin="0" end="${page.pageCount-1}" varStatus="stat">
                                    <a href="${path}/manage/user/userOrders?pageNum=${stat.count}" class="${stat.count eq page.pageNum?'current':''}">${stat.count}</a>
                                </c:forEach>
                            </c:if>
                            <c:if test="${not flag}">
                                <c:forEach begin="0" end="${page.pageCount-1}" varStatus="stat">
                                    <a href="${path}/manage/user/search?pageNum=${stat.count}&keywords=${param.keywords}" class="${stat.count eq page.pageNum?'current':''}">${stat.count}</a>
                                </c:forEach>
                            </c:if>
                        </c:if>
                        <input class="btn btn6" onclick="history.go(-1)" value="返回" type="button">
                    </div>
                </div>
            </form>
        </div>
    </div>
    <!--/main-->
</div>
</body>
</html>


