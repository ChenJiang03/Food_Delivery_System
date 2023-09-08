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

                <c:if test="${empty(sessionScope.merchant)}" var="nologin">
                    <a href="${path}/User/register">注册</a>/<a href="${path}/User/login">登录</a>
                </c:if>
                <c:if test="${not nologin}">
                    <span>欢迎商家[${sessionScope.merchant.name}],生意兴隆！</span>
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
            <img src="${path}/webConfig/images/logo.jpg" title="DeathGhost" alt="模板"></a>
            <i></i>
            <span>${province.name} [${city.name}]|[${district.name}]</span>
        </div>
        <div class="Search">
            <form method="get" id="main_a_serach" onsubmit="return check_search(this)">
                <div class="Search_nav" id="selectsearch">
                    <a href="javascript:;" onClick="selectsearch(this,'restaurant_name')" class="choose">餐厅</a>
                    <a href="javascript:;" onClick="selectsearch(this,'food_name')">食物名</a>
                </div>
                <div class="Search_area">
                    <input type="search" id="fkeyword" name="keyword" placeholder="请输入您所需查找的餐厅名称或食物名称..." class="searchbox" />
                    <input type="submit" class="searchbutton" value="搜 索" />
                </div>
            </form>
            <p class="hotkeywords"><a href="#" title="酸辣土豆丝">酸辣土豆丝</a><a href="#" title="这里是产品名称">螃蟹炒年糕</a><a href="#" title="这里是产品名称">牛奶炖蛋</a><a href="#" title="这里是产品名称">芝麻酱凉面</a><a href="#" title="这里是产品名称">滑蛋虾仁</a><a href="#" title="这里是产品名称">蒜汁茄子</a></p>
        </div>
    </div>
    <nav class="menu_bg">
<%--        <ul class="menu">
            <li><a href="${path}/MerchantCenter/index">首页</a></li>
            <li><a href="list.html">我的订单</a></li>
            <li><a href="category.html">我的菜单</a></li>
            <li><a href="article_read.html">关于我们</a></li>
        </ul>--%>
    </nav>
</header>