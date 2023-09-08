<%@ page import="java.util.List" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="path" value="${pageContext.request.contextPath}"></c:set>
<html>
<head>
    <meta charset="UTF-8">
    <title>订单列表</title>
</head>
<body>
<jsp:include page="/manageConfig/inc/top.jsp"></jsp:include>
<div class="container clearfix">
    <jsp:include page="/manageConfig/inc/left.jsp"></jsp:include>
    <!--/sidebar-->
    <div class="main-wrap">
        <div class="crumb-wrap">
            <div class="crumb-list"><i class="icon-font"></i><a href="${path}/manage/manager/index">首页</a><span class="crumb-step">&gt;</span><span class="crumb-name">产品明细</span></div>
        </div>
        <div class="search-wrap">
            <div class="search-content">
                <form action="${path}/manage/orderDetail/search" method="get">
                    <table class="search-tab">
                        <tr>
                            <th width="70">产品名:</th>
                            <td><input class="common-text" placeholder="关键字" name="keywords" value="${param.keywords}" id="keywords" type="text"></td>
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

                    </div>
                </div>
                <div class="result-content">
                    <table class="result-tab" width="100%">
                        <tr>
                            <th class="tc" width="5%"><input class="allChoose" name="" type="checkbox"></th>
                            <th>订单号</th>
                            <th>购买产品</th>
                            <th>产品单价</th>
                            <th>数量</th>
                            <th>操作</th>
                        </tr>
                        <c:forEach items="${requestScope.orderDetail}" var="orderDetail">
                            <tr id = ${orderDetail.id}>
                                <td class="tc"><input name="id[]" value="59"  type="checkbox" class="check" data-id="${orderDetail.id}"></td>
                                <td>${orderDetail.order.complicatedId}</td>
                                <td>${orderDetail.productId}</td>
                                <td>${orderDetail.price}</td>
                                <td>${orderDetail.amount}</td>
                                <td>
                                    <a class="link-del" href="" data-id="${orderDetail.id}" data-type="orderDetail" data-path="${path}">删除</a>
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
                                    <a href="${path}/manage/orderDetail/list?pageNum=${stat.count}" class="${stat.count eq page.pageNum?'current':''}">${stat.count}</a>
                                </c:forEach>
                            </c:if>
                            <c:if test="${not flag}">
                                <c:forEach begin="0" end="${page.pageCount-1}" varStatus="stat">
                                    <a href="${path}/manage/orderDetail/search?pageNum=${stat.count}&keywords=${param.keywords}" class="${stat.count eq page.pageNum?'current':''}">${stat.count}</a>
                                </c:forEach>
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


<%--<script type="text/javascript">--%>
<%--    $(function (){--%>

<%--        $(".link-del").click(function (){--%>
<%--            //data-xxx data("xxx")--%>
<%--            //确认对话框 如果点击确认返回true，否则返回false--%>
<%--            if(confirm("是否确认删除?")){--%>
<%--                var id=$(this).data("id");--%>
<%--                location.href="${path}/manage/user/delete?id="+id;--%>
<%--            }--%>
<%--            return false;  //阻止a标签跳转链接--%>
<%--        });--%>
<%--    });--%>
<%--</script>--%>