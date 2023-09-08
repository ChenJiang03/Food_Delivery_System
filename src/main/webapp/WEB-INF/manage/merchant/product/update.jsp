
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"></c:set>
<html>
<head>
    <title>修改菜单</title>
    <script type="text/javascript" src="${path}/webConfig/js/jquery-3.6.4.min.js"></script>
    <script type="text/javascript">
        $(function (){
            //图片上传
            $("#file").change(function (){
                var formData=new FormData($("#myform")[0]);
                formData.append("file",$("#file")[0]);
                $.ajax({
                    url:"${path}/manage/merchant/uploadPic",
                    type:"post",
                    data:formData,
                    contentType:false,
                    processData:false,
                    success:function (data){
                        if(data=="fail"){
                            alert("请选择图片");
                            return;
                        }
                        $("#img").attr("src","${path}"+data);
                        $("#picture").val(data);
                    }
                });
            });
        })

    </script>
</head>
<body>
<jsp:include page="/manageConfig/inc/top.jsp"></jsp:include>
<div class="container clearfix">
    <jsp:include page="/manageConfig/inc/left.jsp"></jsp:include>
    <!--/sidebar-->
    <div class="main-wrap">

        <div class="crumb-wrap">
            <div class="crumb-list"><i class="icon-font"></i><a href="${path}/manage">首页</a><span class="crumb-step">&gt;</span><a class="crumb-name" href="${path}/manage/product?action=list">产品管理</a><span class="crumb-step">&gt;</span><span>修改产品类型</span></div>
        </div>
        <div class="result-wrap">
            <div class="result-content">
                <form action="${path}/manage/merchant/product/update" method="post" id="myform" name="myform" enctype="multipart/form-data">
                    <input type="hidden" name="id" value="${requestScope.product.id}">
                    <input type="hidden" name="merchantId" value="${requestScope.product.merchantId}">
                    <table class="insert-tab" width="100%">
                        <tbody>
                        <tr>
                            <th><i class="require-red">*</i>产品分类：</th>
                            <td>
                                <select name="productTypeId" id="">
                                    <c:forEach var="pt" items="${requestScope.productTypeList}">
                                        <c:if test="${requestScope.product.productTypeId eq pt.id}" var="flag">
                                            <option value="${pt.id}" selected>${pt.title}</option>
                                        </c:if>

                                        <c:if test="${not flag}">
                                            <option value="${pt.id}">${pt.title}</option>
                                        </c:if>

                                    </c:forEach>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <th><i class="require-red">*</i>标题：</th>
                            <td>
                                <input class="common-text required" id="title" name="title" size="50" value="${requestScope.product.title}" type="text">
                            </td>
                        </tr>
                        <tr>
                            <th><i class="require-red">*</i>价格：</th>
                            <td>
                                <input class="common-text required" id="price" name="price" size="50" value="${requestScope.product.price}" type="text">
                            </td>
                        </tr>
                        <tr>
                            <th><i class="require-red">*</i>库存状态：</th>
                            <td>
                                <input type="radio" name="stock" value="1" ${requestScope.product.stock?"checked":""}>有货  <input type="radio" name="stock" value="0" ${requestScope.product.stock?"":"checked"}>无货
                            </td>
                        </tr>

                            <th><i class="require-red">*</i>商品照片：</th>
                            <td>
                                <p id="pimg">
                                    <input type="hidden" value="${requestScope.product.picture}" name="picture" id="picture">
                                    <img src="${path}${requestScope.product.picture}"  style="width: 100px;height: 100px;display: ${empty requestScope.product.picture?'none':''}" alt="" id="img">
                                </p>
                                <input type="file" name="file" id="file">
                            </td>
                        </tr>
                        <tr>
                            <th>简介：</th>
                            <td><textarea name="description" class="common-textarea" id="description" cols="30" style="width: 98%;" rows="10">${requestScope.product.description}</textarea></td>
                        </tr>
                        <tr>
                            <th></th>
                            <td>
                                <input class="btn btn-primary btn6 mr10" value="提交" type="submit">
                                <input class="btn btn6" onclick="history.go(-1)" value="返回" type="button">
                            </td>
                        </tr>
                        </tbody></table>
                </form>
            </div>
        </div>

    </div>
    <!--/main-->
</div>

</body>
</html>
