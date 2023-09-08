<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"></c:set>
<header>
    <section class="Topmenubg">
        <div class="Topnav">
            <div class="LeftNav">
                <c:if test="${empty(sessionScope.user)}" var="nologin">

                <a href="${path}/User/register">注册</a>/<a href="${path}/User/login">登录</a>
                </c:if>
                <c:if test="${not nologin}">
                    <span>欢迎[${sessionScope.user.name}],请开心购物</span>
                </c:if>
            </div>
            <div class="RightNav">
                <a href="${path}/MerchantCenter/index">商家中心</a><a href="${path}/Merchant/register">商家入驻</a><a href="${path}/Merchant/login">商家登录</a> <a href="user_orderlist.html" target="_blank" title="我的订单">我的订单</a> <a href="${path}/riderCenter/register">想当骑手？点这里！</a><a href="${path}/riderCenter/login">骑手登录</a>
            </div>
        </div>
    </section>
    <div class="Logo_search">
        <div class="Logo">
            <a href="${path}/">
            <img src="${path}/webConfig/images/logo.jpg" title="DeathGhost" alt="模板">
            </a>
            <i></i>

        </div>
        <div class="Search">
            <form method="get" id="main_a_serach" action="${path}/userCenter/list">
                <div class="Search_nav" id="selectsearch">
                    <a href="javascript:;" onClick="selectsearch(this,'restaurant_name')" class="choose">餐厅</a>
<%--                    <a href="javascript:;" onClick="selectsearch(this,'food_name')">食物名</a>--%>
                </div>
                <div class="Search_area">
                    <input type="search" id="fkeyword" name="keywords" placeholder="请输入您所需查找的餐厅名称..." class="searchbox" />
                    <input type="button" class="searchbutton" value="搜 索" id="searchbutton" />
                </div>
            </form>
        </div>
    </div>
    <nav class="menu_bg">
        <ul class="menu">
            <li><a href="${path}/">首页</a></li>
            <li><a href="${path}/userCenter/list">开始点餐</a></li>
            <li><a href="${path}/userCenter/index">用户中心</a></li>
            <li><a href="article_read.html">关于我们</a></li>
        </ul>
    </nav>
</header>

<script src="${path}/webConfig/js/jquery-3.6.4.min.js"></script>
<script>
    $(function (){
        $("#searchbutton").click(function (){
            var keywords = $("#fkeyword").val();
            $.ajax({
                url:"${path}/userCenter/search",
                type:"get",
                data:{keywords:keywords},
                success:function (data){
                    $(".Fsl ul").empty();
                    if(data.length!=0){
                        for(var merchant of data){
                            var li = $("<li>");
                            var a = $("<a>");
                            a.attr("href","shop.html");
                            var img = $("<img>");
                            var hgroup = $("<hgroup>");
                            var h3 = $("<h3>");
                            var h4 = $("<h4>");
                            var span = $("<span>");
                            span.addClass("DSBUTTON");
                            var span1 = $("<span>")
                            var span2 = $("<span>")
                            span1.addClass("Score-l");
                            span2.addClass("Score-v");
                            span1.append(span2);
                            var a1 = $("<a>");
                            a1.attr("href","shop.html");
                            a1.attr("target","_blank");
                            a1.html("点外卖");
                            a1.addClass("Fontfff");
                            h3.html(merchant.name);
                            hgroup.append(h3);
                            hgroup.append(h4);
                            img.attr("src","${path}"+merchant.picture);
                            var pp = $("<p>")
                            pp.html("类型:"+merchant.merchantType.type)
                            var p = $("<p>")
                            p.html("地址:"+merchant.address)
                            var ppp = $("<p>");

                            span.append(a1);
                            ppp.append(span1);
                            ppp.append(span);
                            a.append(img);
                            li.append(a);
                            li.append(hgroup);
                            li.append(pp);
                            li.append(p);
                            li.append(ppp);
                            $(".Fsl ul").append(li);
                        }

                    }

                }
            })
        })
    })
</script>