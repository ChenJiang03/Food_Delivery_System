<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"></c:set>

<html>
<head>
    <title>菜单列表</title>
    <meta name="keywords" content="DeathGhost,DeathGhost.cn,web前端设,移动WebApp开发" />
    <meta name="description" content="DeathGhost.cn::H5 WEB前端设计开发!" />
    <meta name="author" content="DeathGhost"/>
    <link href="${path}/webConfig/style/style.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="${path}/webConfig/js/public.js"></script>
    <script type="text/javascript" src="${path}/webConfig/js/jquery.js"></script>
    <script type="text/javascript" src="${path}/webConfig/js/jqpublic.js"></script>
    <script type="text/javascript" src="${path}/webConfig/js/jquery-3.6.4.min.js"></script>
    <script type="text/javascript">
        $(function (){
            //删除
            $(".del").click(function (){
                if(confirm("是否确认删除?")){
                    var id=$(this).data("id");
                    var that=this;
                    $.ajax({
                        url:"${path}/MerchantCenter/product/delete",
                        type:"post",
                        data:{id:id},
                        success:function(data){
                            if(data=="yes"){
                                $(that).parents("tr").remove();

                            }
                        }
                    });
                }
            });
        });
    </script>
</head>
<body>
<jsp:include page="/webConfig/inc/merchantTop.jsp"></jsp:include>
<!--Start content-->
<section class="Psection MT20">
    <jsp:include page="/webConfig/inc/merchantLeft.jsp"></jsp:include>
    <article class="U-article Overflow">
        <!--user order list-->
        <a href="${path}/MerchantCenter/product/add">添加+</a>
        <section>
            <table class="Myorder">
                <th class="Font14 FontW">ID</th>
                <th class="Font14 FontW">产品名称</th>
                <th class="Font14 FontW">价格</th>
                <th class="Font14 FontW">库存状态</th>
                <th class="Font14 FontW">产品类型</th>
                <th class="Font14 FontW">操作</th>
                <c:forEach var="pl" items="${requestScope.productList}">
                    <tr>
                        <td class="FontW">${pl.id}</td>
                        <td>${pl.title}</td>
                        <td>${pl.price}</td>
                        <td>${pl.stock?"有货":"无货"}</td>
                        <td>
                            <c:forEach var="pt" items="${requestScope.productTypeList}">
                            <c:if test="${pt.id eq pl.productTypeId}" var="flag">
                                ${pt.title}
                            </c:if>
                        </c:forEach></td>
                        <td><a href="${path}/MerchantCenter/product/update?id=${pl.id}">修改</a> | <a class="del" data-id="${pl.id}">删除</a></td>
                    </tr>

                </c:forEach>
            </table>
<%--            <div class="TurnPage">--%>
<%--                <a href="#">--%>
<%--                    <span class="Prev"><i></i>首页</span>--%>
<%--                </a>--%>
<%--                <a href="#"><span class="PNumber">1</span></a>--%>
<%--                <a href="#"><span class="PNumber">2</span></a>--%>
<%--                <a href="#">--%>
<%--                    <span class="Next">最后一页<i></i></span>--%>
<%--                </a>--%>
<%--            </div>--%>
        </section>
    </article>
</section>
<!--End content-->
<div class="F-link">
    <span>友情链接：</span>
</div>
<jsp:include page="/webConfig/inc/merchantFoot.jsp"></jsp:include>
</body>
</html>
