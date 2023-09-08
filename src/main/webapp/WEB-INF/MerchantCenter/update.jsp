
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"></c:set>
<html>
<head>
    <meta charset="utf-8" />
    <meta name="author" content="order by dede58.com"/>
    <title>修改商家信息</title>
    <meta name="keywords" content="DeathGhost,DeathGhost.cn,web前端设,移动WebApp开发" />
    <meta name="description" content="DeathGhost.cn::H5 WEB前端设计开发!" />
    <meta name="author" content="DeathGhost"/>
    <link href="${path}/webConfig/style/style.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="${path}/webConfig/js/public.js"></script>
    <script type="text/javascript" src="${path}/webConfig/js/jquery.js"></script>
    <script type="text/javascript" src="${path}/webConfig/js/jqpublic.js"></script>
    <script type="text/javascript" src="${path}/webConfig/js/jquery-3.6.4.min.js"></script>
    <script type="text/javascript">
        function getCity(){
            $("#city").html("");
            var id=$("#province").val();
            $.get("${path}/Merchant/getSysArea",{id:id},function (data){
                for(var i=0;i<data.length;i++){
                    var option=$("<option>");
                    option.val(data[i].id);
                    option.html(data[i].name);
                    if(data[i].id=="${sessionScope.merchant.cityId}"){
                        option.attr("selected","");
                    }
                    $("#city").append(option);
                }
                getDistrict();
            });
        }

        function getDistrict(){
            $("#district").html("");
            var id=$("#city").val();
            $.get("${path}/Merchant/getSysArea",{id:id},function (data){
                for(var i=0;i<data.length;i++){
                    var option=$("<option>");
                    option.val(data[i].id);
                    option.html(data[i].name);
                    if(data[i].id=="${sessionScope.merchant.districtId}"){
                        option.attr("selected","");
                    }
                    $("#district").append(option);
                }
            });
        }

        $(function (){
            var add=false;
            var ph=false;
            var na=false;
            var bossP=false;
            var co=false;

            console.log(11)
            $("#province").change(getCity);
            $("#city").change(getDistrict);
            getCity();

            //地址验证
            $("#address").blur(function (){
                var val1=/^[\w\W]{5,100}$/;
                var val2=$(this).val();
                if (!val1.test(val2)){
                    $("#address1").html("请输入5-20位地址");
                    add=false;
                }
                else {
                    $("#address1").html("✔")
                    add=true;
                }
            });

            //商家电话
            $("#phone").blur(function (){
               var val1=/^[0-9]{7,11}$/;
               var val2=$(this).val();
               if(!val1.test(val2)){
                   $("#phone1").html("请输入正确的电话号码")
                   ph=false;
               }
               else {
                   $("#phone1").html("✔")
                   ph=true;
               }
            });

            //店铺名
            $("#name").blur(function (){
                var val1=/^[\w\W]{5,20}$/;
                var val2=$(this).val();
                if(!val1.test(val2)){
                    $("#name1").html("请输入5-20位店铺名")
                    na=false;
                }
                else {
                    $("#name1").html("✔")
                    na=true;
                }
            });

            //老板电话
            $("#bossPhone").blur(function (){
                var val1=/^[0-9]{7,11}$/;
                var val2=$(this).val();
                if(!val1.test(val2)){
                    $("#bossPhone1").html("请输入正确的电话号码")
                    bossP=false;
                }
                else {
                    $("#bossPhone1").html("✔")
                    bossP=true;
                }
            });

            //验证码
            $("#code").blur(function (){
               var code=$(this).val();
                $.ajax({
                    url:"${path}/Code/checkCode",
                    type:"post",
                    data:{code:code},
                    success:function (data) {
                        if(data=="ok"){
                            $("#code1").html("√");
                            co=true;
                        }
                        else{
                            $("#code1").html("验证码错误");
                            co=false;
                        }
                    }
                })
            });

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

            $("#tijiao").click(function (){
                if (add==false||ph==false||na==false||bossP==false||co==false){
                    return false;
                }
            });




        });
    </script>
</head>
<body>
<jsp:include page="/webConfig/inc/merchantTop.jsp"></jsp:include>
<!--Start content-->
<section class="Psection MT20">
    <form action="${path}/MerchantCenter/update" id="myform" method="post" enctype="multipart/form-data">
        <input type="hidden" value="${sessionScope.merchant.id}" name="id">
        <table class="Register">
            <tr>
                <td width="40%" align="right" class="FontW">*用户名：</td>
                <td><input type="text" name="username" id="username" disabled value="${sessionScope.merchant.username}"><span id="username1"></span></td>
            </tr>
            <tr>
                <td width="40%" align="right" class="FontW">*省市区：</td>
                <td>
                    <select name="provinceId" id="province">
                        <c:forEach items="${requestScope.sysAreaList}" var="sa">
                            <c:if test="${sessionScope.merchant.provinceId eq sa.id}" var="flag">
                                <option value="${sa.id}" selected>${sa.name}</option>
                            </c:if>
                            <c:if test="${not flag}">
                                <option value="${sa.id}">${sa.name}</option>
                            </c:if>
                        </c:forEach>
                    </select>
                    <select name="cityId" id="city"></select>
                    <select name="districtId" id="district"></select>
                </td>
            </tr>
            <tr>
                <td width="40%" align="right" class="FontW">*商家地址：</td>
                <td><input type="text" name="address" id="address" value="${sessionScope.merchant.address}"><span id="address1"></span></td>
            </tr>
            <tr>
                <td width="40%" align="right" class="FontW">*商家电话：</td>
                <td><input type="text" name="phone" id="phone" value="${sessionScope.merchant.phone}"><span id="phone1"></span></td>
            </tr>
            <tr>
                <td width="40%" align="right" class="FontW">*商家名称：</td>
                <td><input type="text" name="name" id="name" value="${sessionScope.merchant.name}"><span id="name1"></span></td>
            </tr>
            <tr>
                <td width="40%" align="right" class="FontW">*店铺类型：</td>
                <td>
                    <select name="merchantTypeId">
                        <c:forEach var="mt" items="${requestScope.merchantTypeList}">
                            <c:if test="${sessionScope.merchant.merchantTypeId eq mt.id}" var="flag">
                                <option value="${mt.id}" selected>${mt.type}</option>
                            </c:if>

                            <c:if test="${not flag}">
                                <option value="${mt.id}">${mt.type}</option>
                            </c:if>
                        </c:forEach>
                    </select>
                </td>
            </tr>
            <tr>
                <td width="40%" align="right" class="FontW">*注册人姓名：</td>
                <td><input type="text" name="bossName" id="bossName" disabled value="${sessionScope.merchant.bossName}"><span id="bossName1"></span></td>
            </tr>
            <tr>
                <td width="40%" align="right" class="FontW">*注册人电话：</td>
                <td><input type="text" name="bossPhone" id="bossPhone" value="${sessionScope.merchant.bossPhone}"><span id="bossPhone1"></span></td>
            </tr>
            <tr>
                <td width="40%" align="right" class="FontW">*注册人身份证号：</td>
                <td><input type="text" name="bossId" id="bossId" disabled value="${sessionScope.merchant.bossId}"><span id="bossId1"></span></td>
            </tr>
            <tr>
                <td width="40%" align="right" class="FontW">*店铺照片：</td>
                <td>
                    <input type="hidden" value="${sessionScope.merchant.picture}" name="picture" id="picture">
                    <img src="${path}${sessionScope.merchant.picture}"  style="width: 100px;height: 100px;display: ${empty sessionScope.merchant.picture?'none':''}" alt="" id="img">
                    <input type=file name="file" id="file">
                </td>
            </tr>
            <tr>
                <td width="40%" align="right" class="FontW">*验证码：</td>
                <td><input type="text" name="code" id="code" required><img src="${path}/Code/getCode" style="margin-left:8px; vertical-align:bottom" width="83" height="36"><span id="code1"></span></td>
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
