<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"></c:set>
<html>
<head>
    <title>菜单修改</title>
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
            //图片上传
            $("#file").change(function (){
                var formData=new FormData($("#myform")[0]);
                formData.append("file",$("#file")[0]);
                $.ajax({
                    url:"${path}/Merchant/uploadPic",
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
<jsp:include page="/webConfig/inc/merchantTop.jsp"></jsp:include>
<!--Start content-->
<section class="Psection MT20">
    <form action="${path}/MerchantCenter/product/update?sid=${sessionScope.merchant.id}" id="myform" method="post" enctype="multipart/form-data">
        <input type="hidden" value="${requestScope.product.id}" name="id">
        <table class="Register">
            <tr>
                <td width="40%" align="right" class="FontW">*标题：</td>
                <td><input type="text" name="title" id="title" value="${requestScope.product.title}"><span id="address1"></span></td>
            </tr>
            <tr>
                <td width="40%" align="right" class="FontW">*价格：</td>
                <td><input type="text" name="price" id="price" value="${requestScope.product.price}"><span id="phone1"></span></td>
            </tr>
            <tr>
                <td width="40%" align="right" class="FontW">*库存状态：</td>
                <td><input type="radio" name="stock" value="1" ${requestScope.product.stock?"checked":""} >有货  <input type="radio" name="stock" value="0" ${requestScope.product.stock?"":"checked"} >无货<span id="name1"></span></td>
            </tr>
            <tr>
                <td width="40%" align="right" class="FontW">*商品照片：</td>
                <td>
                    <input type="hidden" value="${requestScope.product.picture}" name="picture" id="picture">
                    <img src="${path}${requestScope.product.picture}"  style="width: 100px;height: 100px;display: ${empty requestScope.product.picture?'none':''}" alt="" id="img">
                    <input type=file name="file" id="file">
                </td>
            </tr>
            <tr>
                <td width="40%" align="right" class="FontW">*菜品类型：</td>
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
                <td width="40%" align="right" class="FontW">*简介：</td>
                <td><textarea name="description" cols="30" style="width: 50%;" rows="10">${requestScope.product.description}</textarea></td>
            </tr>
            <tr>
                <td width="40%" align="right"></td>
                <td><input type="submit" name="tijiao" id="tijiao" class="Submit_b" value="提交"></td>
            </tr>
        </table>
    </form>
</section>
<!--End content-->
<div class="F-link">
    <span>友情链接：</span>
</div>
<jsp:include page="/webConfig/inc/merchantFoot.jsp"></jsp:include>
</body>
</html>
