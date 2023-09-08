<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2023/6/19
  Time: 19:22
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"></c:set>

<html>
<head>
    <meta charset="utf-8" />
    <meta name="author" content="order by dede58.com"/>
    <title>DeathGhost-登录</title>
    <meta name="keywords" content="DeathGhost,DeathGhost.cn,web前端设,移动WebApp开发" />
    <meta name="description" content="DeathGhost.cn::H5 WEB前端设计开发!" />
    <meta name="author" content="DeathGhost"/>
    <link rel="stylesheet" href="${path}/webConfig/style/slidercaptcha.css" type="text/css"/>
    <link href="${path}/webConfig/style/style.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="${path}/webConfig/js/public.js"></script>
    <script type="text/javascript" src="${path}/webConfig/js/jquery.js"></script>
    <script type="text/javascript" src="${path}/webConfig/js/jqpublic.js"></script>
    <script type="text/javascript" src="${path}/webConfig/js/longbow.slidercaptcha.js"></script>
    <!--
    Author: DeathGhost
    Author URI: http://www.deathghost.cn
    -->
</head>
<body>
<jsp:include page="/webConfig/inc/userTop.jsp"></jsp:include>
<!--Start content-->
<section class="Psection MT20">
    <article class="A-left Overflow">
        <h1 class="Font16 FontW classtitle">网站介绍</h1>
        <div class="A-read">
            <h1>一、美团配送费（计算方法）</h1>
            <p>1、美团配送费—技术服务费。
                　　佣金比例：5.8％，保底：履约服务费。<br>
                　　2、美团配送费—履约服务费。
                　　履约服务费＝距离收费＋价格收费＋时段收费。<br>
                　　3、美团配送费—距离收费。
                　　0.0—3.0公里，收起步价。
                　　3.0公里以上，每0.1公里加收费用。<br>
                　　4、美团配送费—价格收费。
                　　收费基数＝商品小计－商家活动支出。<br>
                　　5、美团配送费—时段收费。
                　　夜间或者凌晨会加收配送费用。</p>
            <h1>二、美团为何会在不同时段涨配送费？</h1>
            <p>　严格来说，配送费上涨并不是根据午高峰来的，只是午高峰期间更容易触发涨价罢了。涨价的原因也很简单，作为外卖平台，需要充分考虑到客户的体验。<br>
                　　在运力有限，订单太多的情况下，与其让客户下单后无法准时送达，造成大量延迟、T诉、甚*取消订单，不如提前控制进单量，*配送时效和体验。<br>
                　　而通过价格杠杆控制进单量，无疑是相对*的方法之一。一般来说，美团的配送系统，会实时计算当前的运力状况，骑手负载，进单量等等因素，并做出预测判断。<br>
                　　如果发现单量增长过高，无法消化，*会触发爆单，通过涨配送费等方式，降低客户下单欲望，从而减轻配送压力。</p>
            <h1>三、美团外卖配送费说明</h1>
            <p>
                　　1.专送和快送主要服务于短距离。专车的配送质量更高，配送速度更快，骑手的服务态度也很好。快递质量中规中矩，发货速度中规中矩。<br>
                　　2.全市配送主要服务于长途，为用户提供货源稀缺、单价高、品类不同的商户配送服务，更好地满足用户的差异化需求。<br>
                　　3.此外，商家列表页面显示了专送，以及全市配送商家标识，方便用户更好地选择。<br>
                　　4.三种服务产品的配送费用均受配送距离、难度、时间段、天气、容量、商品（数量、价格）等因素影响。此外，不同城市还受当地经济建设水平、地理气候特征等因素的影响。影响送货费的因素也会有所不同。<br>
                　　5.商户主页及产品浏览页面显示的送货费仅为预计的送货费金额，以订单结算页面显示的送货费金额为准</p>
        </div>
    </article>
    <aside class="A-right Overflow">
        <div class="AAlist">
            <ul>
                <li><a href="#" target="_blank" title="这里是推荐某分类文章">这里是推荐某分类文章...</a></li>
            </ul>
        </div>
        <!--广告位-->
        <div style="margin:8px 0;">
            <a href="#" target="_blank"><img src="${path}/webConfig/upload/ggw.jpg"></a>
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
<style>
    .sliderContainer{
        height: 40px !important;
    }
</style>
<script type="text/javascript" src="${path}/webConfig/js/jquery-3.6.4.min.js"></script>
<script>

</script>
