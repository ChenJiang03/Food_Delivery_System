<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set value="${pageContext.request.contextPath}" var="path"></c:set>
<html>
<head>
    <meta charset="utf-8" />
    <meta name="author" content="order by dede58.com"/>
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
    <title>我的地址</title>
    <style type="text/css">
        table{
            border-collapse: collapse;
            border-spacing: 0;
            border:#CCC solid 1px;
        }
        table tr td{
            padding: 10px 20px;
        }
        table tr th{
            padding: 10px 20px;
            background: #ebecf0;
            border: 1px solid #dcdee3;
        }
        .default{
            width: 80px;
            height: 30px;
            border: 1px solid #ff5000;
            border-radius: 3px;
            background: #ffd6cc;
            color: #f30;
            display: block;
            text-align: center;
            line-height: 30px;
        }

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
<!--Start content-->
<section class="Psection MT20">
    <jsp:include page="/webConfig/inc/userLeft.jsp"></jsp:include>
    <article class="U-article Overflow">
        <!--user Address-->
        <section class="Myaddress Overflow">
            <span class="MDtitle Font14 FontW Block Lineheight35">收货人信息</span>
            <a href="${path}/userCenter/address/add">新增地址</a>
            <table border="1">
                <tr>
                    <th>姓名</th>
                    <th>所在地区</th>
                    <th>详细地址</th>
                    <th>手机</th>
                    <th>操作</th>
                    <th>默认地址</th>
                </tr>
                <c:forEach items="${requestScope.addressList}" var="a">
                    <tr>
                        <td>${a.name}</td>
                        <td>${a.province.name} ${a.city.name} ${a.district.name}</td>
                        <td>${a.address}</td>
                        <td>${a.phone}</td>
                        <td>
                            <a href="${path}/userCenter/address/update?id=${a.id}">修改</a> | <a class="link-del" href="" data-id="${a.id}">删除</a>
                        </td>
                        <td>
                            <c:if test="${a.isDefault}" var="flag">
                                <span class="default">默认地址</span>
                            </c:if>
                            <c:if test="${not flag}">
                                <a href="${path}/userCenter/address/setDefaultAddress?id=${a.id}">设置默认</a>
                            </c:if>

                        </td>
                    </tr>
                </c:forEach>

            </table>

            <div class="list-page">
                <c:set var="page" value="${requestScope.pageUtils}"></c:set>
                ${page.pageNum}/${page.pageCount}页 ${page.dataCount}条

                    <c:forEach begin="0" end="${page.pageCount-1}" varStatus="stat">
                        <a href="${path}/userCenter/address/list?pageNum=${stat.count}" class="${stat.count eq page.pageNum?'current':''}">${stat.count}</a>
                    </c:forEach>
            </div>
        </section>
    </article>
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
<script type="text/javascript" src="${path}/webConfig/js/jquery-3.6.4.min.js"></script>
<script type="text/javascript">
    $(function (){
        $(".link-del").click(function (){
            if(confirm("是否确认删除？")){
                var id = $(this).data("id");
                $.ajax({
                    url:"${path}/userCenter/address/delete",
                    type:"post",
                    data:{id:id},
                    success:function (data){
                        if(data=="success"){
                            $(this).parents("tr").remove();
                        }
                        else if(data=="fail"){
                            alert("删除失败");
                        }
                    }.bind(this)
                })
            }
            return false;
        })
    })
</script>