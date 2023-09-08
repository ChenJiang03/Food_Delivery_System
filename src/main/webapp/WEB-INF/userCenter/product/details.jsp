<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2023/7/4
  Time: 22:34
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"></c:set>
<c:set var="product" value="${requestScope.product}"></c:set>
<html>
<head>
    <meta charset="utf-8" />
    <meta name="author" content="order by dede58.com"/>
    <title>产品信息</title>
    <meta name="keywords" content="DeathGhost,DeathGhost.cn,web前端设,移动WebApp开发" />
    <meta name="description" content="DeathGhost.cn::H5 WEB前端设计开发!" />
    <meta name="author" content="DeathGhost"/>
    <link href="${path}/webConfig/style/style.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="${path}/webConfig/js/public.js"></script>
    <script type="text/javascript" src="${path}/webConfig/js/jquery.js"></script>
    <script type="text/javascript" src="${path}/webConfig/js/jqpublic.js"></script>
    <!--
    Author: DeathGhost
    Author URI: http://www.deathghost.cn
    -->
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
    </script>
</head>
<body>
<jsp:include page="/webConfig/inc/userTop.jsp"></jsp:include>
<!--Start content-->

<section class="slp">
    <section class="food-hd">
        <div class="foodpic">
            <img src="${path}${product.picture}" id="showimg">
        </div>
        <div class="foodtext">
            <div class="foodname_a">
                <h1>${product.title}</h1>
                <p>${product.merchant.address}</p>
            </div>
            <div class="price_a">
                <p class="price01">价格：￥<span>${product.price}</span></p>
            </div>
            <div class="Freight">

            </div>
            <ul class="Tran_infor">
                <li>
                    <p class="Numerical">3</p>
                    <p>月销量</p>
                </li>
                <li class="line">
                    <p class="Numerical">58</p>
                    <p>累计评价</p>
                </li>
                <li>
                    <p class="Numerical">59</p>
                    <p>送幸福积分</p>
                </li>
            </ul>
                <div class="BuyNo">
                    <span>我要买：<input type="number" name="Number" required autofocus min="1" value="1" id="number"/>份</span>
                    <span>库存：${product.stock==true?"有":"无"}</span>
                    <div class="Buybutton">
                        <input name="" type="button" value="加入购物车" class="BuyB" id="BuyB">
                        <a href="${path}/userCenter/shop?id=${product.merchantId}"><span class="Backhome">进入店铺首页</span></a>
                    </div>
                </div>
        </div>
<%--        <div class="viewhistory">--%>
<%--            <span class="VHtitle">看了又看</span>--%>
<%--            <ul class="Fsulist">--%>
<%--                <li>--%>
<%--                    <a href="detailsp.html" target="_blank" title="酱爆茄子"><img src="upload/03.jpg"></a>--%>
<%--                    <p>酱爆茄子</p>--%>
<%--                    <p>￥12.80</p>--%>
<%--                </li>--%>
<%--                <li>--%>
<%--                    <a href="detailsp.html" target="_blank" title="酱爆茄子"><img src="upload/02.jpg"></a>--%>
<%--                    <p>酱爆茄子</p>--%>
<%--                    <p>￥12.80</p>--%>
<%--                </li>--%>
<%--            </ul>--%>
<%--        </div>--%>
    </section>
    <!--bottom content-->
<%--    <section class="Bcontent">--%>
<%--        <article>--%>

<%--        </article>--%>
<%--        <!--ad&other infor-->--%>
<%--        <aside>--%>
<%--            <!--广告位或推荐位-->--%>
<%--            <a href="#" title="广告位占位图片" target="_blank"><img src="upload/2014912.jpg"></a>--%>
<%--        </aside>--%>
<%--    </section>--%>
</section>
<!--End content-->
<div class="F-link">
    <span>友情链接：</span>




</div>
<footer>
    <section class="Otherlink">
        <aside>
            <div class="ewm-left">
                <p>手机扫描二维码：</p>
                <img src="images/Android_ico_d.gif">
                <img src="images/iphone_ico_d.gif">
            </div>
            <div class="tips">
                <p>客服热线</p>
                <p><i>1830927**73</i></p>
                <p>配送时间</p>
                <p><time>09：00</time>~<time>22:00</time></p>
                <p>网站公告</p>
            </div>
        </aside>
        <section>
            <div>
                <span><i class="i1"></i>配送支付</span>
                <ul>
                    <li><a href="article_read.html" target="_blank" title="标题">支付方式</a></li>
                    <li><a href="article_read.html" target="_blank" title="标题">配送方式</a></li>
                    <li><a href="article_read.html" target="_blank" title="标题">配送效率</a></li>
                    <li><a href="article_read.html" target="_blank" title="标题">服务费用</a></li>
                </ul>
            </div>
            <div>
                <span><i class="i2"></i>关于我们</span>
                <ul>
                    <li><a href="article_read.html" target="_blank" title="标题">招贤纳士</a></li>
                    <li><a href="article_read.html" target="_blank" title="标题">网站介绍</a></li>
                    <li><a href="article_read.html" target="_blank" title="标题">配送效率</a></li>
                    <li><a href="article_read.html" target="_blank" title="标题">商家加盟</a></li>
                </ul>
            </div>
            <div>
                <span><i class="i3"></i>帮助中心</span>
                <ul>
                    <li><a href="article_read.html" target="_blank" title="标题">服务内容</a></li>
                    <li><a href="article_read.html" target="_blank" title="标题">服务介绍</a></li>
                    <li><a href="article_read.html" target="_blank" title="标题">常见问题</a></li>
                    <li><a href="article_read.html" target="_blank" title="标题">网站地图</a></li>
                </ul>
            </div>
        </section>
    </section>
    <div class="copyright">© 版权所有 2020</div>
</footer>
</body>
</html>
<script src="${path}/webConfig/js/jquery-3.6.4.min.js"></script>
<script>
    $(function (){
        $("#BuyB").click(function (){
            var number = $("#number").val();
            var productId = ${param.id};
            var merchantId = ${product.merchantId};
            $.get("${path}/userCenter/shoppingCar/add",{number:number,productId:productId,merchantId:merchantId},function (data){
                if(data=="notLogin"){
                    alert("请登陆后添加");
                    location.href="${path}/User/login";
                }
                else{
                    alert("添加成功");
                }
            });
        })
    })
</script>