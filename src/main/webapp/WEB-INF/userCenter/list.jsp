<%--
  Created by IntelliJ IDEA.
  User: lbp
  Date: 2023/6/28
  Time: 14:52
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"></c:set>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8" />
    <meta name="author" content="order by dede58.com"/>
    <title>商家列表</title>
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

    <style type="text/css">
        .selectArea{
            text-align: center;
            color: black;
            border: 0;
            position: relative;
            font-size: 10px;
        }

        #btn{
            background-color: white;
            cursor: pointer;
            color: black;

        }

    </style>
</head>
<body>
<jsp:include page="/webConfig/inc/userTop.jsp"></jsp:include>
<!--Start content-->
<section class="Psection">
    <section class="fslist_navtree">
        <form action="" method="post">
            <ul class="select">
                <li class="select-list">
                    <dl id="select1">
                        <dt>分类：</dt>
                        <select name="merchantType.id" class="selectArea" id="merchantTypeId">
                            <option value="0">全部</option>
                            <c:forEach items="${requestScope.merchantTypeList}" var="mt">
                                <option value="${mt.id}">${mt.type}</option>
                            </c:forEach>
                        </select>
                        <%--                        <dd class="select-all selected"><a href="javascript:">全部</a></dd>--%>
                        <%--                        <c:forEach items="${requestScope.merchantList}" var="merchantList">--%>
                        <%--                            <dd><a href="javascript:" data-id="${merchantList.merchantType.id}" class="merchantType">${merchantList.merchantType.type}</a></dd>--%>
                        <%--                        </c:forEach>--%>
                    </dl>
                </li>
                <li class="select-list">
                    <dl id="select2">
                        <dt>位置：</dt>
                        <%--                    <dd class="select-all selected"><a href="javascript:">全部</a></dd>--%>
                        <select name="provinceId" id="province" class="selectArea">
                            <option value="0">请选择：</option>
                            <c:forEach items="${requestScope.sysAreaList}" var="sa">

                                <option value="${sa.id}">${sa.name}</option>
                            </c:forEach>
                        </select>
                        <select name="cityId" id="city" class="selectArea"></select>
                        <select name="districtId" id="district" class="selectArea"></select>
                    </dl>
                </li>
<%--                <li class="select-list">--%>
<%--                    <dl id="select4">--%>
<%--                        <dt>价位区间：</dt>--%>
<%--                        <dd class="select-all selected"><a href="javascript:">全部</a></dd>--%>
<%--                        <dd><a href="javascript:">20元以下</a></dd>--%>
<%--                        <dd><a href="javascript:">20-40元</a></dd>--%>
<%--                        <dd><a href="javascript:">40-60元</a></dd>--%>
<%--                        <dd><a href="javascript:">60-80元</a></dd>--%>
<%--                        <dd><a href="javascript:">80-100元</a></dd>--%>
<%--                    </dl>--%>
<%--                </li>--%>
                <li class="select-result">
                    <input type="button" value="查询" id="btn">
                </li>
            </ul>

        </form>

    </section>
    <section class="Fslmenu">
        <a href="#" title="默认排序" class="default">
          <span>
          <span>默认排序</span>
          <span></span>
          </span>
        </a>
<%--        <a href="#" title="评价">--%>
<%--          <span>--%>
<%--          <span>评价</span>--%>
<%--          <span class="s-up"></span>--%>
<%--          </span>--%>
<%--        </a>--%>
<%--        <a href="#" title="销量">--%>
<%--          <span>--%>
<%--          <span>销量</span>--%>
<%--          <span class="s-up"></span>--%>
<%--          </span>--%>
<%--        </a>--%>
<%--        <a href="#" title="价格排序">--%>
<%--          <span>--%>
<%--          <span>价格</span>--%>
<%--          <span class="s-down"></span>--%>
<%--          </span>--%>
<%--        </a>--%>
        <a href="#" title="发布时间排序" class="releaseTime">
          <span>
          <span>发布时间</span>
          <span class="s-up"></span>
          </span>
        </a>
    </section>
    <section class="Fsl">
        <ul>
            <c:forEach items="${requestScope.merchantList}" var="merchant">
                <li>
                    <a href="${path}/userCenter/shop?id=${merchant.id}" target="_blank"><img src="${path}${merchant.picture}"></a>
                    <hgroup>
                        <h3>${merchant.name}</h3>
                        <h4></h4>
                    </hgroup>
                    <p data-type="${merchant.merchantType.type}">类型：${merchant.merchantType.type}</p>
                    <p>地址:${merchant.address}</p>
                    <p>人均：20~50元</p>
                    <p>
    <span class="Score-l">
    <img src="${path}/webConfig/images/star-on.png">
    <img src="${path}/webConfig/images/star-on.png">
    <img src="${path}/webConfig/images/star-on.png">
    <img src="${path}/webConfig/images/star-on.png">
    <img src="${path}/webConfig/images/star-off.png">
    <span class="Score-v">4.8</span>
    </span>
                        <span class="DSBUTTON"><a href="${path}/userCenter/shop?id=${merchant.id}" target="_blank" class="Fontfff">点外卖</a></span>
                    </p>
                </li>
            </c:forEach>
        </ul>
<%--        <aside>--%>
<%--            <div class="title">热门商家</div>--%>
<%--            <div class="C-list">--%>
<%--                <a href="shop.html" target="_blank" title="店铺名称"><img src="${path}/webConfig/upload/cc.jpg"></a>--%>
<%--                <p><a href="shop.html" target="_blank">[大雁塔]店铺名称</a></p>--%>
<%--                <p>--%>
<%--                    <span>人均：20~50元</span>--%>
<%--                    <span style=" float:right">--%>
<%--                    <img src="${path}/webConfig/images/star-on.png">--%>
<%--                    <img src="${path}/webConfig/images/star-on.png">--%>
<%--                    <img src="${path}/webConfig/images/star-on.png">--%>
<%--                    <img src="${path}/webConfig/images/star-on.png">--%>
<%--                    <img src="${path}/webConfig/images/star-off.png">--%>
<%--                    <span class="ALscore">4.8</span>--%>
<%--                   </span>--%>
<%--                </p>--%>
<%--            </div>--%>
<%--            <div class="C-list">--%>
<%--                <a href="shop.html" target="_blank" title="店铺名称"><img src="upload/cc.jpg"></a>--%>
<%--                <p><a href="shop.html" target="_blank">[大雁塔]店铺名称</a></p>--%>
<%--                <p>--%>
<%--                    <span>人均：20~50元</span>--%>
<%--                    <span style=" float:right">--%>
<%--    <img src="images/star-on.png">--%>
<%--    <img src="images/star-on.png">--%>
<%--    <img src="images/star-on.png">--%>
<%--    <img src="images/star-on.png">--%>
<%--    <img src="images/star-off.png">--%>
<%--    <span class="ALscore">4.8</span>--%>
<%--   </span>--%>
<%--                </p>--%>
<%--            </div>--%>
<%--        </aside>--%>
        <%--        <div class="TurnPage">--%>
        <%--                <c:set var="page" value="${requestScope.pageUtils}"></c:set>--%>
        <%--                ${page.pageNum}/${page.pageCount}页 ${page.dataCount}条--%>
        <%--                <c:if test="${empty param.keywords}" var="flag">--%>
        <%--                    <c:forEach begin="0" end="${page.pageCount-1}" varStatus="stat">--%>
        <%--                        <a href="${path}/manage/user/list?pageNum=${stat.count}" class="${stat.count eq page.pageNum?'pageNum':''}">${stat.count}</a>--%>
        <%--                    </c:forEach>--%>
        <%--                </c:if>--%>
        <%--                <c:if test="${not flag}">--%>
        <%--                    <c:forEach begin="0" end="${page.pageCount-1}" varStatus="stat">--%>
        <%--                        <a href="${path}/manage/user/search?pageNum=${stat.count}&keywords=${param.keywords}" class="${stat.count eq page.pageNum?'pageNum':''}">${stat.count}</a>--%>
        <%--                    </c:forEach>--%>
        <%--                </c:if>--%>
        <%--        </div>--%>
    </section>
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
                <img src="${path}/webConfig/images/Android_ico_d.gif">
                <img src="${path}/webConfig/images/iphone_ico_d.gif">
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

        $("#province").change(getCity);
        $("#city").change(getDistrict);
        getCity();

        var pageNum=1;
        var flag=true;
        var clickflag = true;
        //当窗口滚动的时候触发
        $(window).scroll(function (){
            //页面卷起的高度
            var scrollTop=document.documentElement.scrollTop;
            //当前页面高度
            var clientHeight=document.documentElement.clientHeight;
            //页面总高度
            var scrollHeight=document.documentElement.scrollHeight;

            //判断页面是否滚动到底部
            if(scrollHeight-(scrollTop+clientHeight)<1&&flag&&clickflag){
                pageNum++;
                $.ajax({
                    url:"${path}/userCenter/list/getList",
                    data:{pageNum:pageNum},
                    success:function (data){
                        console.log(data);
                        if(data.length==0){
                            flag=false;
                        }
                        //es6
                        //foreach
                        for(var merchant of data){
                            var li = $("<li>");
                            var a = $("<a>");
                            a.attr("href","${path}/userCenter/shop?id="+merchant.id);
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

                            span2.html("4.8");
                            var img1 = $("<img>");
                            img1.attr("src","${path}/webConfig/images/star-on.png");
                            var img2 = $("<img>");
                            img2.attr("src","${path}/webConfig/images/star-on.png");
                            var img3 = $("<img>");
                            img3.attr("src","${path}/webConfig/images/star-on.png");
                            var img4 = $("<img>");
                            img4.attr("src","${path}/webConfig/images/star-on.png");
                            var img5 = $("<img>");
                            img5.attr("src","${path}/webConfig/images/star-off.png");
                            span1.append(img1);
                            span1.append(img2);
                            span1.append(img3);
                            span1.append(img4);
                            span1.append(img5);

                            span1.append(span2);
                            var a1 = $("<a>");
                            a1.attr("href","${path}/userCenter/shop?id="+merchant.id);
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
                });
            }
        });


        $("#btn").click(function (){
            var districtId = $("#district").val();
            var merchantTypeId = $("#merchantTypeId").val();

            $.ajax({
                url:"${path}/userCenter/list/search",
                type:"get",
                data:{districtId:districtId,merchantTypeId:merchantTypeId},
                success:function (data){
                    $(".Fsl ul").empty();
                    if(data.length!=0){
                        for(var merchant of data){
                            var li = $("<li>");
                            var a = $("<a>");
                            a.attr("href","${path}/userCenter/shop?id="+merchant.id);
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

                            span2.html("4.8");
                            var img1 = $("<img>");
                            img1.attr("src","${path}/webConfig/images/star-on.png");
                            var img2 = $("<img>");
                            img2.attr("src","${path}/webConfig/images/star-on.png");
                            var img3 = $("<img>");
                            img3.attr("src","${path}/webConfig/images/star-on.png");
                            var img4 = $("<img>");
                            img4.attr("src","${path}/webConfig/images/star-on.png");
                            var img5 = $("<img>");
                            img5.attr("src","${path}/webConfig/images/star-off.png");
                            span1.append(img1);
                            span1.append(img2);
                            span1.append(img3);
                            span1.append(img4);
                            span1.append(img5);
                            span1.append(span2);
                            var a1 = $("<a>");
                            a1.attr("href","${path}/userCenter/shop?id="+merchant.id);
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
                        clickflag=false;
                    }

                }
            })
        })

        $(".releaseTime").click(function (){
            clickflag=false;
            $.ajax({

                url:"${path}/userCenter/list/searchByTime",
                type:"get",
                success:function (data){
                    $(".Fsl ul").empty();
                    if(data.length!=0){
                        for(var merchant of data){
                            var li = $("<li>");
                            var a = $("<a>");
                            a.attr("href","${path}/userCenter/shop?id="+merchant.id);
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
                            span2.html("4.8");
                            var img1 = $("<img>");
                            img1.attr("src","${path}/webConfig/images/star-on.png");
                            var img2 = $("<img>");
                            img2.attr("src","${path}/webConfig/images/star-on.png");
                            var img3 = $("<img>");
                            img3.attr("src","${path}/webConfig/images/star-on.png");
                            var img4 = $("<img>");
                            img4.attr("src","${path}/webConfig/images/star-on.png");
                            var img5 = $("<img>");
                            img5.attr("src","${path}/webConfig/images/star-off.png");
                            span1.append(img1);
                            span1.append(img2);
                            span1.append(img3);
                            span1.append(img4);
                            span1.append(img5);
                            span1.append(span2);
                            var a1 = $("<a>");
                            a1.attr("href","${path}/userCenter/shop?id="+merchant.id);
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

        $(".default").click(function (){
            clickflag=true;
            $.ajax({
                url:"${path}/userCenter/list/searchByDefault",
                type:"get",
                success:function (data){
                    $(".Fsl ul").empty();
                    if(data.length!=0){
                        for(var merchant of data){
                            var li = $("<li>");
                            var a = $("<a>");
                            a.attr("href","${path}/userCenter/shop?id="+merchant.id);
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

                            span2.html("4.8");
                            var img1 = $("<img>");
                            img1.attr("src","${path}/webConfig/images/star-on.png");
                            var img2 = $("<img>");
                            img2.attr("src","${path}/webConfig/images/star-on.png");
                            var img3 = $("<img>");
                            img3.attr("src","${path}/webConfig/images/star-on.png");
                            var img4 = $("<img>");
                            img4.attr("src","${path}/webConfig/images/star-on.png");
                            var img5 = $("<img>");
                            img5.attr("src","${path}/webConfig/images/star-off.png");
                            span1.append(img1);
                            span1.append(img2);
                            span1.append(img3);
                            span1.append(img4);
                            span1.append(img5);
                            span1.append(span2);
                            var a1 = $("<a>");
                            a1.attr("href","${path}/userCenter/shop?id="+merchant.id);
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
    function getDistrict(){
        $("#district").empty();
        var id=$("#city").val();
        $.get("${path}/userCenter/address/getSysArea",{id:id},function (data){
            var option1=$("<option>");
            option1.val(0);
            option1.html("请选择：");
            $("#district").append(option1);
            for(var i=0;i<data.length;i++){
                var option=$("<option>");
                option.val(data[i].id);
                option.html(data[i].name);
                option.addClass("location");
                $("#district").append(option);
            }
        });
    }

    function getCity(){
        $("#city").empty();
        var id=$("#province").val();
        $.get("${path}/userCenter/address/getSysArea",{id:id},function (data){
            var option1=$("<option>");
            option1.val(0);
            option1.html("请选择：");
            $("#city").append(option1);
            for(var i=0;i<data.length;i++){
                var option=$("<option>");
                option.val(data[i].id);
                option.html(data[i].name);
                $("#city").append(option);
            }
            getDistrict();
        });
    }

</script>




