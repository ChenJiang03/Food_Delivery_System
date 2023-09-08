<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"></c:set>
<c:set var="merchant" value="${requestScope.merchant}"></c:set>
<script type="/manageConfig/js/checkImageSize.js"></script>
<html>
<head>
    <title>商家信息修改</title>
    <script type="text/javascript" src="${path}/webConfig/js/jquery-3.6.4.min.js"></script>
    <script type="text/javascript">

        function getCity(){
            console.log(${merchant.cityId});
            $("#city").html("");
            var id=$("#province").val();
            $.get("${path}/Merchant/getSysArea",{id:id},function (data){
                for(var i=0;i<data.length;i++){
                    var option=$("<option>");
                    option.val(data[i].id);
                    option.html(data[i].name);
                    if(data[i].id=="${merchant.cityId}"){
                        option.attr("selected","selected");
                    }
                    $("#city").append(option);
                }
                getDistrict();
            });
        }

        function getDistrict(){
            console.log(${merchant.districtId});
            $("#district").html("");
            var id=$("#city").val();
            $.get("${path}/Merchant/getSysArea",{id:id},function (data){
                for(var i=0;i<data.length;i++){
                    var option=$("<option>");
                    option.val(data[i].id);
                    option.html(data[i].name);
                    if(data[i].id=="${merchant.districtId}"){
                        option.attr("selected","selected");
                    }
                    $("#district").append(option);
                }
            });
        }

        $(function (){
            var pass=false;
            var add=false;
            var ph=false;
            var na=false;
            var bossP=false;

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

            $("#tijiao").click(function (){
                if (pass==false||add==false||ph==false||na==false||bossP==false){
                    return false;
                }
            });

            $("#province").change(getCity);
            $("#city").change(getDistrict);
            getCity();

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
            <div class="crumb-list"><i class="icon-font"></i><a href="${path}/manage">首页</a><span class="crumb-step">&gt;</span><a class="crumb-name" href="${path}/manage/product?action=list">产品管理</a><span class="crumb-step">&gt;</span><span>修改产品类型</span></div>
        </div>
        <div class="result-wrap">
            <div class="result-content">
                <form action="${path}/manage/merchant/update" method="post" id="myform" name="myform" enctype="multipart/form-data">
                    <input type="hidden" name="id" value="${merchant.id}">
                    <table class="insert-tab" width="100%">
                        <tbody>
                        <tr>
                            <th><i class="require-red">*</i>分类：</th>
                            <td>
                                <select name="merchantTypeId" id="">
                                    <c:forEach var="mt" items="${requestScope.merchantTypeList}">
                                        <c:if test="${merchant.merchantTypeId eq mt.id}" var="flag">
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
                            <th><i class="require-red">*</i>登陆密码：</th>
                            <td>
                                <input class="common-text required" id="password" name="password" size="50" value="${merchant.password}" type="text"><span id="password1"></span>
                            </td>
                        </tr>
                        <tr>
                            <th><i class="require-red">*</i>省市区：</th>
                            <td>
                                <select name="provinceId" id="province">
                                    <c:forEach items="${requestScope.sysAreaList}" var="sa">
                                        <c:if test="${merchant.provinceId eq sa.id}" var="flag">
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
                            <th><i class="require-red">*</i>商家地址：</th>
                            <td>
                                <input class="common-text required" id="address" name="address" size="50" value="${merchant.address}" type="text"><span id="address1"></span>
                            </td>
                        </tr>
                        <tr>
                            <th><i class="require-red">*</i>商家电话：</th>
                            <td>
                                <input class="common-text required" id="phone" name="phone" size="50" value="${merchant.phone}" type="text"><span id="phone1"></span>
                            </td>
                        </tr>
                        <tr>
                            <th><i class="require-red">*</i>商家名称：</th>
                            <td>
                                <input class="common-text required" id="name" name="name" size="50" value="${merchant.name}" type="text"><span id="name1"></span>
                            </td>
                        </tr>
                        <tr>
                            <th><i class="require-red">*</i>老板电话：</th>
                            <td>
                                <input class="common-text required" id="bossPhone" name="bossPhone" size="50" value="${merchant.bossPhone}" type="text"><span id="bossPhone1"></span>
                            </td>
                        </tr>
                        <tr>
                            <th><i class="require-red">*</i>商家照片：</th>
                            <td>
                                <p id="pimg">
                                    <input type="hidden" value="${merchant.picture}" name="picture" id="picture" style="width: 100px;height:100px">
                                    <img src="${path}${merchant.picture}" alt="" style="width: 100px;height: 100px;display: ${empty merchant.picture?'none':''}" id="img">
                                </p>

                                <input type="file" name="file" id="file">
                            </td>
                        </tr>
                        <tr>
                            <th>店铺简介：</th>
                            <td><textarea name="description" class="common-textarea" id="description" cols="30" style="width: 98%;" rows="10">${merchant.description}</textarea></td>
                        </tr>
                        <tr>
                            <th></th>
                            <td>
                                <input class="btn btn-primary btn6 mr10" id="tijiao" value="提交" type="submit">
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
