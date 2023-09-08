<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"></c:set>
<c:set var="province" value="${sessionScope.province}"></c:set>
<c:set var="city" value="${sessionScope.city}"></c:set>
<c:set var="district" value="${sessionScope.district}"></c:set>
<header>
    <section class="Topmenubg">
        <div class="Topnav">
            <div class="LeftNav">
                <c:if test="${empty(sessionScope.rider)}" var="nologin">
                    <a href="${path}/User/register">注册</a>/<a href="${path}/User/login">登录</a>
                </c:if>
                <c:if test="${not nologin}">
                    <span>欢迎骑手[${sessionScope.rider.name}],一路顺风！</span>
                </c:if>

            </div>
            <div class="RightNav">
                <a href="${path}/MerchantCenter/index">商家中心</a><a href="${path}/Merchant/register">商家入驻</a><a href="${path}/Merchant/login">商家登录</a> <a href="${path}/riderCenter/register">想当骑手？点这里！</a><a href="${path}/riderCenter/login">骑手登录</a>
            </div>
        </div>
    </section>
    <div class="Logo_search">
        <div class="Logo">
            <a href="${path}/">
            <img src="${path}/webConfig/images/logo.jpg" title="DeathGhost" alt="模板">
            </a>
            <i></i>
            <span>${province.name} [${city.name}]|[${district.name}]</span>
        </div>
    </div>
    <nav class="menu_bg">
        <ul class="menu">
            <li><a href="${path}/MerchantCenter/index">首页</a></li>
            <li><a href="">我的订单</a></li>
            <li><a href="">我的菜单</a></li>
            <li><a href="">关于我们</a></li>
        </ul>
    </nav>
</header>