<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2023/7/5
  Time: 11:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"></c:set>
<html>
<head>
    <meta charset="utf-8" />
    <meta name="author" content="order by dede58.com"/>
    <title>店铺信息</title>
    <meta name="keywords" content="DeathGhost,DeathGhost.cn,web前端设,移动WebApp开发" />
    <meta name="description" content="DeathGhost.cn::H5 WEB前端设计开发!" />
    <meta name="author" content="DeathGhost"/>
    <link href="${path}/webConfig/style/style.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="${path}/webConfig/js/public.js"></script>
    <script type="text/javascript" src="${path}/webConfig/js/jquery.js"></script>
    <script type="text/javascript" src="${path}/webConfig/js/jqpublic.js"></script>
    <script type="text/javascript" src="${path}/webConfig/js/cart.js"></script>
    <script type="text/javascript" src="${path}/webConfig/js/jquery.easyui.min.js"></script>
    <script>
        $(function(){
            $('.title-list li').click(function(){
                var liindex = $('.title-list li').index(this);
                $(this).addClass('on').siblings().removeClass('on');
                $('.menutab-wrap div.menutab').eq(liindex).fadeIn(150).siblings('div.menutab').hide();
                var liWidth = $('.title-list li').width();
                $('.shopcontent .title-list p').stop(false,true).animate({'left' : liindex * liWidth + 'px'},300);
            });

            $('.menutab-wrap .menutab li').hover(function(){
                $(this).css("border-color","#ff6600");
                $(this).find('p > a').css('color','#ff6600');
            },function(){
                $(this).css("border-color","#fafafa");
                $(this).find('p > a').css('color','#666666');
            });
        });
        var mt = 0;
        window.onload = function () {
            var Topcart = document.getElementById("Topcart");
            var mt = Topcart.offsetTop;
            window.onscroll = function () {
                var t = document.documentElement.scrollTop || document.body.scrollTop;
                if (t > mt) {
                    Topcart.style.position = "fixed";
                    Topcart.style.margin = "";
                    Topcart.style.top = "200px";
                    Topcart.style.right = "191px";
                    Topcart.style.boxShadow ="0px 0px 20px 5px #cccccc";
                    Topcart.style.top="0";
                    Topcart.style.border="1px #636363 solid";
                }
                else {
                    Topcart.style.position = "static";
                    Topcart.style.boxShadow ="none";
                    Topcart.style.border="";
                }
            }
        }
    </script>
    <!--
    Author: DeathGhost
    Author URI: http://www.deathghost.cn
    -->
    <style>
        .list-page{
            margin-top: 10px;
            text-align: center;
            position: absolute;
            top: 330px;
            left: 660px;
            font-size: 12px;
        }

        .list-page .current {
            margin: 0 5px;
            padding: 2px 7px;
            background: #f60;
            border: 1px solid #fe8101;
            color: #fff;
        }
    </style>
</head>
<body>
<jsp:include page="/webConfig/inc/userTop.jsp"></jsp:include>
<c:set var="merchant" value="${requestScope.merchant}"></c:set>
<!--Start content-->
<section class="Shop-index">
    <article>

        <div class="shopinfor">
            <div class="title">
                <span>${merchant.name}</span>
                <span>
     <img src="${path}/webConfig/images/star-on.png">
     <img src="${path}/webConfig/images/star-on.png">
     <img src="${path}/webConfig/images/star-on.png">
     <img src="${path}/webConfig/images/star-on.png">
     <img src="${path}/webConfig/images/star-off.png">
    </span>
                <span>4.8</span>
            </div>
            <div class="imginfor">
                <div class="shopimg">
                    <img src="${path}${merchant.picture}" id="showimg">

                </div>
                <div class="shoptext">
                    <p><span>地址：</span>${merchant.address}</p>
                    <p><span>电话：</span>${merchant.phone}</p>
                    <p><span>优惠活动：</span>暂无信息</p>
                    <p><span>营业时间：</span>09:00~22:00</p>
                    <p><span>WIFI：</span>免费WIFI</p>
                    <div class="Button">
                        <a href="#ydwm"><span class="DCbutton">查看菜谱点菜</span></a>
                    </div>
                    <div class="otherinfor">
                        <a href="#" class="icoa" data-id="${merchant.id}"><img src="${path}/webConfig/images/collect.png">收藏店铺</a>
                        <script type="text/javascript" charset="utf-8" src="http://static.bshare.cn/b/buttonLite.js#style=-1&amp;uuid=&amp;pophcol=1&amp;lang=zh"></script><script type="text/javascript" charset="utf-8" src="http://static.bshare.cn/b/bshareC0.js"></script>
                    </div>
                </div>
            </div>
            <div class="shopcontent">
                <div class="title2 cf">
                    <ul class="title-list fr cf ">
                        <li class="on">菜谱</li>
                        <p><b></b></p>
                    </ul>
                </div>
                <div class="menutab-wrap">
                    <a name="ydwm">
                        <!--case1-->
                        <div class="menutab show">
                            <ul class="products">
                                <c:forEach items="${requestScope.productList}" var="product">
                                    <li>
                                        <a href="${path}/userCenter/product/details?id=${product.id}" target="_blank">
                                            <img src="${path}${product.picture}" class="foodsimgsize">
                                        </a>
                                        <a href="#" class="item">
                                            <div>
                                                <p>${product.title}</p>
                                                <p class="AButton">￥${product.price}</p>
                                            </div>
                                        </a>
                                    </li>
                                </c:forEach>

                                <div class="list-page">
                                    <c:set var="page" value="${requestScope.pageUtils}"></c:set>
                                    ${page.pageNum}/${page.pageCount}页 ${page.dataCount}条

                                    <c:forEach begin="0" end="${page.pageCount-1}" varStatus="stat">
                                        <a href="${path}/userCenter/shop?pageNum=${stat.count}&id=${param.id}" class="${stat.count eq page.pageNum?'current':''}">${stat.count}</a>
                                    </c:forEach>
                                </div>

                            </ul>

                        </div>
                    </a>
                    <!--case2-->
                    <div class="menutab">
                        <div class="shopcomment">
                            <div class="Spname">
                                <a href="#" target="_blank" title="酸辣土豆丝">酸辣土豆丝</a>
                            </div>
                            <div class="C-content">
                                <q>还不错，速度挺快,还不错，速度挺快还不错，速度挺快还不错，速度挺快还不错，速度挺快还不错，速度挺快还不错，速度挺快。。。</q>
                                <i>2014年09月17日 19:36 </i>
                            </div>
                            <div class="username">
                                DeatGhost
                            </div>
                        </div>
                    </div>
                    <!--case4-->
                    <div class="menutab">
                        <div class="shopdetails">
                            <div class="shopmaparea">
                                <img src="upload/testimg.jpg"><!--此处占位图调用动态地图后将其删除即可-->
                            </div>
                            <div class="shopdetailsT">
                                <p><span>店铺：外婆家</span></p>
                                <p><span>地址：</span>陕西省西安市雁塔区丈八北路***号</p>
                                <p><span>电话：</span>029-88888888</p>
                                <p><span>乘车路线：</span>300路、115路、14路、800路到西辛庄站下车往东100米</p>
                                <p><span>店铺介绍：</span>***于2005年3月28日开业，立于西安市碑林区***于2005年3月28日开业，立于西安市碑林区***于2005年3月28日开业，立于西安市碑林区***于2005年3月28日开业，立于西安市碑林区***</p>
                            </div>
                        </div>
                    </div>
                    <!--case5-->
                    <div class="menutab">
                        <span class="Ask"><i>DeathGhost</i>:这里是测试问答？</span>
                        <span class="Answer"><i>管理员回复</i>：这里是测试回答！</span>

                        <div class="TurnPage">
                            <a href="#">
                                <span class="Prev"><i></i>首页</span>
                            </a>
                            <a href="#"><span class="PNumber">1</span></a>
                            <a href="#"><span class="PNumber">2</span></a>
                            <a href="#">
                                <span class="Next">最后一页<i></i></span>
                            </a>
                        </div>

                        <form class="A-Message" action="#">
                            <p><i>姓名：</i><input name="usr_name" type="text" autofocus placeholder="张三" required></p>
                            <p><i>手机：</i><input name="" type="text" placeholder="15825518***" pattern="[0-9]{11}" required></p>
                            <p><i>邮件：</i><input type="email" name="email" autocomplete="off" placeholder="admin@admin.com" required/></p>
                            <p><i>问题补充：</i><textarea name="" cols="" rows="" required placeholder="详细说明您的问题..."></textarea></p>
                            <p><input type="submit" class="Abutt" /></p>
                        </form>
                    </div>
                </div>
            </div>
    </article>
    <aside>
        <div class="cart" id="Topcart">
            <span class="Ctitle Block FontW Font14"><a href="${path}/userCenter/shoppingCar/list?merchantId=${param.id}" target="_blank">我的购物车</a></span>
            <p class="Ptc"><span class="Cbutton"><a href="${path}/userCenter/shoppingCar/list?merchantId=${param.id}" target="进入购物车">进入购物车</a></span></p>
        </div>



    </aside>

</section>
<!--End content-->
<div class="F-link">
    <span>友情链接：</span>




</div>
<jsp:include page="/webConfig/inc/userFoot.jsp"></jsp:include>

</body>
</html>
<script src="${path}/webConfig/js/jquery-3.6.4.min.js"></script>
<script>
    $(function (){
        $(".icoa").click(function (){
            var merchantId = $(this).data("id");
            $.get("${path}/userCenter/favourite/exist",{merchantId:merchantId},function (data){
                if(data == "no"){
                    alert("已添加过该店铺");
                    return;
                }
                if(data == "ok"){
                    location.href="${path}/userCenter/favourite/add?merchantId="+merchantId;
                    $(".icoa").empty();
                    $(".icoa").html("已收藏该店铺")
                }
            })
        })
    })
</script>