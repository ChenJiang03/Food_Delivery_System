<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"></c:set>

<nav class="U-nav Font14 FontW">
    <ul>
        <li><i></i><a href="${path}/riderCenter/index">骑手中心首页</a></li>
        <li><i></i><a href="${path}/riderCenter/update">修改骑手信息</a></li>
        <li><i></i><a href="${path}/riderCenter/updatePass">修改账号密码</a></li>
        <li><i></i><a href="${path}/riderCenter/orders/list">我的订单</a></li>
        <li><i></i><a href="${path}/riderCenter/address/update">送货地址</a></li>
        <li><i></i><a href="${path}/riderCenter/exit">安全退出</a></li>
    </ul>
</nav>