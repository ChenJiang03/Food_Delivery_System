<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"></c:set>
<nav class="U-nav Font14 FontW">
    <ul>
        <li style="height: 55px;line-height: 55px;"><i></i><a href="${path}/userCenter/index">用户中心首页</a></li>
        <li style="height: 55px;line-height: 55px;"><i></i><a href="${path}/userCenter/orders/list">我的订单</a></li>
        <li style="height: 55px;line-height: 55px;"><i></i><a href="${path}/userCenter/address/list">收货地址</a></li>
        <li style="height: 55px;line-height: 55px;"><i></i><a href="${path}/userCenter/favourite/list">我的收藏</a></li>
        <li style="height: 55px;line-height: 55px;"><i></i><a href="${path}/userCenter/recharge">账户充值</a></li>
        <li style="height: 55px;line-height: 55px;"><i></i><a href="${path}/userCenter/userManage/updateInfo">修改用户信息</a></li>
        <li style="height: 55px;line-height: 55px;"><i></i><a href="${path}/userCenter/exit">安全退出</a></li>
    </ul>
</nav>