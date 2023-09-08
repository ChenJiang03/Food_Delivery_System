
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"></c:set>
<html>
<head>
    <meta charset="utf-8" />
    <meta name="author" content="order by dede58.com"/>
    <title>商家注册</title>
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
                    $("#district").append(option);
                }
            });
        }
        

        $(function (){
            var user=false;
            var pass=false;
            var confirmPass=false;
            var add=false;
            var ph=false;
            var na=false;
            var bossN=false;
            var bossP=false;
            var bossI=false;
            var co=false;

            $("#province").change(getCity);
            $("#city").change(getDistrict);
            getCity();

            //用户名验证
            $("#username").blur(function (){
                var val1=/^\w{5,20}$/;
                var val2=$("#username").val();
                if (!val1.test(val2)){
                    $("#username1").html("请输入5-20位数字、字母、下划线");
                    user=false;
                }

                else{
                    $("#username1").html("✔");
                    user=true;
                }
            });

            //密码验证
            $("#password").blur(function (){
                var val1=/^\w{5,20}$/;
                var val2=$("#password").val();
                if (!val1.test(val2)){
                    $("#password1").html("请输入5-20位数字、字母、下划线");
                    pass=false;
                }
                else{
                    $("#password1").html("✔");
                    pass=true;
                }
            });

            //确认密码
            $("#confirmPassword").blur(function (){
                var val1=$("#confirmPassword").val();
                var val2=$("#password").val();
                if (val1!=val2){
                    $("#confirmPassword1").html("两次密码不一致");
                    confirmPass=false;
                }
                else if(val2==""){
                    $("#confirmPassword1").html("请确认密码");
                    confirmPass=false;
                }
                else {
                    $("#confirmPassword1").html("✔");
                    confirmPass=true;
                }
            });

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

            //老板姓名
            $("#bossName").blur(function (){
               var val1=/^[\u4e00-\u9fa5]{2,5}$/;
               var val2=$(this).val();
               if(!val1.test(val2)){
                   $("#bossName1").html("请输入姓名");
                   bossN=false;
               }
               else {
                   $("#bossName1").html("✔");
                   bossN=true;
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

            //身份证验证
            $("#bossId").blur(function (){
               var val1=/^[1-9]\d{5}(18|19|20)\d{2}((0[1-9])|(q[0-2]))(([0-2][1-9])|10|20|30|31)\d{3}[0-9Xx]$/;
               var val2=$(this).val();
               if(!val1.test(val2)){
                   $("#bossId1").html("请输入正确的身份证号");
                   bossI=false;
               }
               else {
                   $("#bossId1").html("✔");
                   bossI=true;
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

            $("#tijiao").click(function (){
                if (user==false||pass==false||confirmPass==false||add==false||ph==false||na==false||bossN==false||bossP==false||bossI==false||co==false){
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
    <form action="${path}/Merchant/register" method="post" enctype="multipart/form-data">
        <table class="Register">
            <tr>
                <td width="40%" align="right" class="FontW">*用户名：</td>
                <td><input type="text" name="username" id="username"><span id="username1"></span></td>
            </tr>
            <tr>
                <td width="40%" align="right" class="FontW">*密码：</td>
                <td><input type="password" name="password" id="password"><span id="password1"></span></td>
            </tr>
            <tr>
                <td width="40%" align="right" class="FontW">*确认密码：</td>
                <td><input type="password" name="confirmPassword" id="confirmPassword"><span id="confirmPassword1"></span></td>
            </tr>
            <tr>
                <td width="40%" align="right" class="FontW">*省市区：</td>
                <td>
                    <select name="provinceId" id="province">
                        <c:forEach items="${requestScope.sysAreaList}" var="sa">
                            <option value="${sa.id}">${sa.name}</option>
                        </c:forEach>
                    </select>
                    <select name="cityId" id="city"></select>
                    <select name="districtId" id="district"></select>
                </td>
            </tr>
            <tr>
                <td width="40%" align="right" class="FontW">*商家地址：</td>
                <td><input type="text" name="address" id="address"><span id="address1"></span></td>
            </tr>
            <tr>
                <td width="40%" align="right" class="FontW">*商家电话：</td>
                <td><input type="text" name="phone" id="phone"><span id="phone1"></span></td>
            </tr>
            <tr>
                <td width="40%" align="right" class="FontW">*商家名称：</td>
                <td><input type="text" name="name" id="name"><span id="name1"></span></td>
            </tr>
            <tr>
                <td width="40%" align="right" class="FontW">*注册人姓名：</td>
                <td><input type="text" name="bossName" id="bossName"><span id="bossName1"></span></td>
            </tr>
            <tr>
                <td width="40%" align="right" class="FontW">*注册人电话：</td>
                <td><input type="text" name="bossPhone" id="bossPhone"><span id="bossPhone1"></span></td>
            </tr>
            <tr>
                <td width="40%" align="right" class="FontW">*注册人身份证号：</td>
                <td><input type="text" name="bossId" id="bossId"><span id="bossId1"></span></td>
            </tr>
            <tr>
                <td width="40%" align="right" class="FontW">*营业执照照片：</td>
                <td>
                    <input type=file name="file">
                </td>
            </tr>
            <tr>
                <td width="40%" align="right" class="FontW">*店铺照片：</td>
                <td>
                    <input type=file name="file">
                </td>
            </tr>
            <tr>
                <td width="40%" align="right" class="FontW">*店铺类型：</td>
                <td>
                    <select name="merchantTypeId" id="">
                        <c:forEach var="mt" items="${requestScope.merchantTypeList}">
                            <option value="${mt.id}">${mt.type}</option>
                        </c:forEach>
                    </select>
                </td>
            </tr>
            <tr>
                <td width="40%" align="right" class="FontW">*验证码：</td>
                <td><input type="text" name="code" id="code" required><img src="${path}/Code/getCode" style="margin-left:8px; vertical-align:bottom" width="83" height="36"><span id="code1"></span></td>
            </tr>
            <tr>
                <td width="40%" align="right"></td>
                <td><input type="submit" name="tijiao" id="tijiao" class="Submit_b" value="注 册">( 已经是会员，<a href="${path}/Merchant/login" class="BlueA">请登录</a> )</td>
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
