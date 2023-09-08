
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"></c:set>
<html>
<head>
    <title>注册审核列表</title>
    <script type="/manageConfig/js/chooseAllAndDelete.js"></script>
    <style type="text/css" >
        .img{
            width: 70px;
            height: 70px;
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
            <div class="crumb-list"><i class="icon-font"></i><a href="${path}/manage">首页</a><span class="crumb-step">&gt;</span><span class="crumb-name">作品管理</span></div>
        </div>

        <div class="result-wrap">
            <form name="myform" id="myform" method="post">
                <div class="result-title">
                    <div class="result-list">
                        <a href="${path}/manage/merchant/list">返回</a>
                    </div>
                </div>
                <div class="result-content">
                    <table class="result-tab" width="100%">
                        <tr>
                            <th class="tc" width="5%"><input class="allChoose" name="" type="checkbox"></th>
                            <th>ID</th>
                            <th>用户名</th>
                            <th>商家照片</th>
                            <th>商家名称</th>
                            <th>商家类型</th>
                            <th>商家电话</th>
                            <th>商家评分</th>
                            <th>注册时间</th>
                            <th>账户余额</th>
                            <th>操作</th>
                        </tr>



                        <c:forEach var="m" items="${requestScope.merchantList}">
                            <tr id="tr_${m.id}">
                                <td class="tc"><input name="id[]" data-id="${m.id}" class="check" value="59" type="checkbox"></td>
                                <td>${m.id}</td>
                                <td>${m.username}</td>
                                <td><img src="${path}${m.picture}" alt="" class="img"></td>
                                <td>${m.name}</td>
                                <td>
                                    <c:forEach var="mt" items="${requestScope.merchantTypeList}">
                                        <c:if test="${mt.id eq m.merchantTypeId}" var="flag">
                                            ${mt.type}
                                        </c:if>
                                    </c:forEach>
                                </td>
                                <td>${m.phone}</td>
                                <td>${m.score}</td>
                                <td>${m.regTime}</td>
                                <td>${m.balance}</td>
                                <td>
                                    <a href="${path}/manage/merchant/audit?id=${m.id}">审核</a>
                                    <a class="link-del" data-id="${m.id}" data-type="merchant" data-path="${path}">删除</a>
                                </td>
                            </tr>

                        </c:forEach>

                    </table>

                    <div class="list-page">
                        <c:set var="page" value="${requestScope.pageUtils}"></c:set>
                        ${page.pageNum}/${page.pageCount}页 ${page.dataCount}条
                        <c:forEach begin="0" end="${page.pageCount-1<0?0:page.pageCount-1}" varStatus="stat">
                            <a href="${path}/manage/merchant/auditList?pageNum=${stat.count}&merchantTypeId=${param.merchantTypeId}&keywords=${param.keywords}" class="${stat.count eq page.pageNum?'current':''}">${stat.count}</a>
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
