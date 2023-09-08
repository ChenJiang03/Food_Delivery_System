<%@ page import="java.util.List" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="path" value="${pageContext.request.contextPath}"></c:set>
<html>
<head>
    <meta charset="UTF-8">
    <title>管理员列表</title>
    <style>

    </style>
</head>
<body>
<jsp:include page="/manageConfig/inc/top.jsp"></jsp:include>
<div class="container clearfix">
    <jsp:include page="/manageConfig/inc/left.jsp"></jsp:include>
    <!--/sidebar-->
    <div class="main-wrap">
        <div class="crumb-wrap">
            <div class="crumb-list"><i class="icon-font"></i><a href="${path}/manage/manager/index">首页</a><span class="crumb-step">&gt;</span><span class="crumb-name">作品管理</span></div>
        </div>
        <div class="search-wrap">
            <div class="search-content">
                <form action="${path}/manage/manager/search" method="get">
                    <table class="search-tab">
                        <tr>
                            <th width="70">关键字:</th>
                            <td><input class="common-text" placeholder="${param.keywords==null?'关键字':param.keywords}" name="keywords" value="" id="keywords" type="text"></td>
                            <td><input class="btn btn-primary btn2" name="sub" value="查询" type="submit"></td>
                        </tr>
                    </table>
                </form>
            </div>
        </div>
        <div class="result-wrap">
            <form name="myform" id="myform" method="post">
                <div class="result-title">
                    <div class="result-list">
                        <a href="${path}/manage/manager/insert"><i class="icon-font"></i>新增用户信息</a>
                        <a id="batchDel" href="javascript:void(0)" data-type="manager" data-path="${path}"><i class="icon-font"></i>批量删除</a>
                        <a id="updateOrd" href="javascript:void(0)"><i class="icon-font"></i>更新排序</a>
                    </div>
                </div>
                <div class="result-content">
                    <table class="result-tab" width="100%">
                        <tr>
                            <th class="tc" width="5%"><input class="allChoose" name="" type="checkbox"></th>
                            <th>ID</th>
                            <th>用户名</th>
                            <th>密码</th>
                            <th>操作</th>
                        </tr>
                        <%--                        <tr>--%>
                        <%--                            <td>--%>
                        <%--                                <input name="ids[]" value="59" type="hidden">--%>
                        <%--                                <input class="common-input sort-input" name="ord[]" value="0" type="text">--%>
                        <%--                            </td>--%>
                        <%--                        </tr>--%>
                        <c:forEach items="${requestScope.managerList}" var="managerList">
                            <tr id="tr_${managerList.id}">
                                <td class="tc"><input name="id[]" value="59"  type="checkbox" class="check" data-id="${managerList.id}"></td>
                                <td>${managerList.id}</td>
                                <td>${managerList.username}</td>
                                <td>${managerList.password}</td>
                                <td>
                                    <a class="link-update" href="${path}/manage/manager/update?id=${managerList.id}">修改</a>
                                    <a class="link-del" href="" data-id="${managerList.id}" data-type="manager" data-path="${path}">删除</a>
                                </td>
                            </tr>
                        </c:forEach>
                    </table>
                    <div class="list-page">
                        <c:set var="page" value="${requestScope.pageUtils}"></c:set>
                        ${page.pageNum}/${page.pageCount}页 ${page.dataCount}条
                        <c:if test="${page.dataCount != 0}">
                            <c:if test="${page.dataCount != 0}">
                                <c:if test="${empty param.keywords}" var="flag">
                                    <c:forEach begin="0" end="${page.pageCount-1}" varStatus="stat">
                                        <a href="${path}/manage/manager/list?pageNum=${stat.count}" class="${stat.count eq page.pageNum?'current':''}">${stat.count}</a>
                                    </c:forEach>
                                </c:if>
                                <c:if test="${not flag}">
                                    <c:forEach begin="0" end="${page.pageCount-1}" varStatus="stat">
                                        <a href="${path}/manage/manager/search?pageNum=${stat.count}&keywords=${param.keywords}" class="${stat.count eq page.pageNum?'current':''}">${stat.count}</a>
                                    </c:forEach>
                                </c:if>
                            </c:if>
                        </c:if>
                    </div>

                </div>
            </form>
        </div>
    </div>
    <!--/main-->
</div>
</body>
</html>

