<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2023/7/7
  Time: 23:22
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set value="${pageContext.request.contextPath}" var="path"></c:set>
<>
<html>
<head>
    <title>等待支付</title>
</head>
<body>
<form action="${path}/userCenter/orders/toPay">
    <c:forEach items="${requestScope.shoppingCarList}" var="shopping">
        <input type="hidden" value="${shopping.id}" name="shoppingCarId">
    </c:forEach>

    <input type="hidden" value="${requestScope.ordersNo}" name="ordersNo">
    <input type="submit" value="支付" class="pay">

    <a href="${path}/userCenter/index">用户中心</a>
</form>

</body>
</html>
<script src="${path}/webConfig/js/jquery-3.6.4.min.js"></script>
<script>
    $(function (){
        $(".pay").click(function (){
            var price = ${requestScope.total};
            var balance = ${sessionScope.user.balance};

            if(price>balance){
                alert("余额不足，请充值");
                return false;
            }
        })
    })
</script>