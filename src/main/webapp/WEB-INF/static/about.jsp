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
            丑团企业版依托美团自身全场景本地生活供应链资源和科技实力，聚合美团的外卖、堂食、机酒等优势资源，将重复性高、易标准化规范的企业消费模块流程化再造。针对因公消费全流程节点，从“消费+控制+结算”实现集中管理，覆盖工作餐、宴请、差旅、用车等高频消费场景，提升员工和管理部门在使用和管控方面双向效率。

            其中围绕福利餐饮场景，员工可以根据个人需要点外卖和堂食，各类本地菜品、特色小吃等超过200种的菜系供员工自行挑选。此外，平台已拥有逾920万活跃商户，商户资源覆盖了我国超过2800个市县区，可为企业提供丰富的餐品选择、操作简便和合规率高达99%的员工就餐方案。

            在未采用系统化工具以前，从报销凭证审核查验、问题票据沟通、财务入账等多个环节，企业需要花费大量精力去人工维护报销流程。选择美团企业版后，员工在付款时符合规定的订单可直接由企业支付。相应地减少了因公消费的报销动作，释放了员工、管理层、行政、财务等多个角色的工作负担。通过数字手段来辅助企业消费的精细化管理，提升流程优化管理效能、进一步降低企业管理成本。

            某大型国有企业用餐项目负责人表示：通过计算，平均一个月可以节省2-3个小时。几万名员工就是2万-3万小时，这对企业和员工来讲都是一笔不小的时间投入。同时，员工不需要垫钱，内部吐槽大大减少，使用餐补用餐的人数显著提升。目前，美团企业版已获得招商银行、拜耳医药、理想汽车、元气森林、蜜雪冰城、快手等多行业企业的广泛认可，已成功助力近万家企业。让每一笔支出、每一步消费流程都更透明、合规，帮助企业平均节省30%消费成本和人力投入，为企业降本增效提供创新引擎！

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
