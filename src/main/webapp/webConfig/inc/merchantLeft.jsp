<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"></c:set>

<nav class="U-nav Font14 FontW">
    <ul>
        <li><i></i><a href="${path}/MerchantCenter/index">商家中心首页</a></li>
        <li><i></i><a href="${path}/MerchantCenter/orders/list">我的订单</a></li>
        <li><i></i><a href="${path}/MerchantCenter/update">修改商家信息</a></li>
        <li><i></i><a href="${path}/MerchantCenter/updatePass">修改密码</a></li>
        <li><i></i><a href="${path}/MerchantCenter/product/list?id=${sessionScope.merchant.id}">菜单管理</a></li>
        <li><i></i><a href="${path}/MerchantCenter/recharge">账户充值</a></li>
        <li><i></i><a href="${path}/MerchantCenter/exit">安全退出</a></li>
    </ul>
</nav>