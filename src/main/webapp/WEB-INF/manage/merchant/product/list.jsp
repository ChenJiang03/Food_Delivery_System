
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"></c:set>
<html>
<head>
    <title>菜单列表</title>
    <script type="text/javascript" src="${path}/webConfig/js/jquery-3.6.4.min.js"></script>
    <script type="text/javascript">
        $(function (){
            //删除
            $(".del").click(function (){
                if(confirm("是否确认删除?")){
                    var id=$(this).data("id");
                    var that=this;
                    $.ajax({
                        url:"${path}/manage/merchant/product/delete",
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
<jsp:include page="/manageConfig/inc/top.jsp"></jsp:include>
<div class="container clearfix">
    <jsp:include page="/manageConfig/inc/left.jsp"></jsp:include>
    <!--/sidebar-->
    <div class="main-wrap">

        <div class="crumb-wrap">
            <div class="crumb-list"><i class="icon-font"></i><a href="${path}/manage">首页</a><span class="crumb-step">&gt;</span><span class="crumb-name">作品管理</span></div>
        </div>
        <div class="search-wrap">
        </div>
        <div class="result-wrap">
            <form name="myform" id="myform" method="post">
                <div class="result-title">
                    <div class="result-list">
                        <a href="${path}/manage/merchant/list">返回</a>
                        <a href="${path}/manage/merchant/product/add?id=${requestScope.sid}"><i class="icon-font"></i>新增菜单</a>
                        <a id="batchDel" href="javascript:void(0)" data-type="merchant" data-path="${path}"><i class="icon-font"></i>批量删除</a>
                        <a id="updateOrd" href="javascript:void(0)"><i class="icon-font"></i>更新排序</a>
                    </div>
                </div>
                <div class="result-content">
                    <table class="result-tab" width="100%">
                        <tr>
                            <th class="tc" width="5%"><input class="allChoose" name="" type="checkbox"></th>
                            <th>ID</th>
                            <th>产品图片</th>
                            <th>产品名称</th>
                            <th>价格</th>
                            <th>库存状态</th>
                            <th>产品类型</th>
                            <th>操作</th>
                        </tr>



                        <c:forEach var="pl" items="${requestScope.productList}">
                            <tr>
                                <td class="tc"><input name="id[]" data-id="${pl.id}" class="check" value="59" type="checkbox"></td>
                                <td class="FontW">${pl.id}</td>
                                <td><img src="${path}${pl.picture.split(",")[0]}"></td>
                                <td>${pl.title}</td>
                                <td>${pl.price}</td>
                                <td>${pl.stock?"有货":"无货"}</td>
                                <td>
                                    <c:forEach var="pt" items="${requestScope.productTypeList}">
                                        <c:if test="${pt.id eq pl.productTypeId}" var="flag">
                                            ${pt.title}
                                        </c:if>
                                    </c:forEach>
                                </td>
                                <td>
                                    <a class="link-update" href="${path}/manage/merchant/product/update?id=${pl.id}">修改</a>
                                    <a class="del" data-id="${pl.id}">删除</a>
                                </td>
                            </tr>

                        </c:forEach>

                    </table>
                    <div class="list-page">
                        <c:set var="page" value="${requestScope.pageUtils}"></c:set>
                        ${page.pageNum}/${page.pageCount}页 ${page.dataCount}条
                        <c:forEach begin="0" end="${page.pageCount-1<0?0:page.pageCount-1}" varStatus="stat">
                            <a href="${path}/manage/merchant/product/list?id=${requestScope.sid}&pageNum=${stat.count}" class="${stat.count eq page.pageNum?'current':''}">${stat.count}</a>
                        </c:forEach>
                    </div>
                </div>
            </form>
        </div>
    </div>
    <!--/main-->
</div>
<style>
    img{
        width: 80px;
        height: 80px;
    }
</style>
</body>
</html>
