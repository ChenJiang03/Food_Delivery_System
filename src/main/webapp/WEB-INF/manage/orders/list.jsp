<%@ page import="java.util.List" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="path" value="${pageContext.request.contextPath}"></c:set>
<html>
<head>
    <meta charset="UTF-8">
    <title>订单详情</title>
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
                <form action="${path}/manage/orders/search" method="get">
                    <table class="search-tab">
                        <tr>
                            <th width="70">订单号:</th>
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
                        <a id="batchDel" href="javascript:void(0)" data-type="orders" data-path="${path}"><i class="icon-font"></i>批量删除</a>
                    </div>
                </div>
                <div class="result-content">
                    <table class="result-tab" width="100%">
                        <tr>
                            <th class="tc" width="5%"><input class="allChoose" name="" type="checkbox"></th>
                            <th>商品明细</th>
                            <th>订单号</th>
                            <th>用户姓名</th>
                            <th>接单骑手</th>
                            <th>店铺名</th>
                            <th>订单总价</th>
                            <th>下单时间</th>
                            <th>订单状态</th>
                            <th>操作</th>
                        </tr>
                        <c:forEach items="${requestScope.ordersList}" var="order">
                            <tr id = "tr_${order.id}" data-type="order" data-path="${path}">
                                <td class="tc"><input name="id[]" value="59"  type="checkbox" class="check" data-id="${order.id}"></td>
                                <td><a href="${path}/manage/orders/ordersInfo?id=${order.id}">查看</a></td>
                                <td>${order.complicatedId}</td>
                                <td>${order.user.username}</td>
                                <td>${order.rider.username}</td>
                                <td>${order.merchant.name}</td>
                                <td>${order.totalPrice}</td>
                                <td>${order.regTime}</td>
                                <c:choose>
                                    <c:when test="${order.orderStatus eq 0}"><td>未完成</td></c:when>
                                    <c:when test="${order.orderStatus eq 1}"><td>已完成</td></c:when>
                                    <c:when test="${order.orderStatus eq 2}"><td>已取消</td></c:when>
                                </c:choose>
                                <td>
                                    <a class="link-update" href="">修改</a>
                                    <a class="link-del" href="" data-id="${order.id}" data-type="orders" data-path="${path}">删除</a>
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
                                    <a href="${path}/manage/orders/list?pageNum=${stat.count}" class="${stat.count eq page.pageNum?'current':''}">${stat.count}</a>
                                </c:forEach>
                            </c:if>
                            <c:if test="${not flag}">
                                <c:forEach begin="0" end="${page.pageCount-1}" varStatus="stat">
                                    <a href="${path}/manage/orders/search?pageNum=${stat.count}&keywords=${param.keywords}" class="${stat.count eq page.pageNum?'current':''}">${stat.count}</a>
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

<script>
    $(function (){
        $(".link-update").click(function(){
            var orderId = $(this).next().data("id")
            console.log(orderId)
            $.ajax({
                url:"${path}/manage/orders/updateInit",
                data:{orderId:orderId},
                success:function (data){
                    if(data==0){
                        alert("骑手已接单，订单已锁定！")
                    }else{
                        location.href="${path}/manage/orders/update?orderId="+orderId
                        <%--top.location.href ="${path}/manage/orders/update?order="+orderId--%>
                    }

                }


            })

        })


    })



</script>

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