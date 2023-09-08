<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"></c:set>
<html>
<head>
    <title>新增商家</title>
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
                        option.attr("selected","");
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
                        option.attr("selected","");
                    }
                    $("#district").append(option);
                }
            });
        }

        $(function (){
            $("#province").change(getCity);
            $("#city").change(getDistrict);
            getCity();

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

            $("#file2").change(function (){
                var formData=new FormData($("#myform")[0]);
                formData.append("file2",$("#file2")[0]);
                $.ajax({
                    url:"${path}/manage/merchant/uploadPic2",
                    type:"post",
                    data:formData,
                    contentType:false,
                    processData:false,
                    success:function (data){
                        if(data=="fail"){
                            alert("请选择图片");
                            return;
                        }
                        $("#img2").attr("src","${path}"+data);
                        $("#certificate").val(data);
                    }
                });
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
            <div class="crumb-list"><i class="icon-font"></i><a href="${path}/manage">首页</a><span class="crumb-step">&gt;</span><a class="crumb-name" href="${path}/manage/product?action=list">产品管理</a><span class="crumb-step">&gt;</span><span>修改产品类型</span></div>
        </div>
        <div class="result-wrap">
            <div class="result-content">
                <form action="${path}/manage/merchant/add" method="post" id="myform" name="myform" enctype="multipart/form-data">
                    <input type="hidden" name="id" value="${merchant.id}">
                    <table class="insert-tab" width="100%">
                        <tbody>
                        <tr>
                            <th><i class="require-red">*</i>分类：</th>
                            <td>
                                <select name="merchantTypeId" id="">
                                    <c:forEach var="mt" items="${requestScope.merchantTypeList}">
                                            <option value="${mt.id}">${mt.type}</option>
                                    </c:forEach>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <th><i class="require-red">*</i>用户名：</th>
                            <td>
                                <input class="common-text required" id="username" name="username" size="50" value="" type="text">
                            </td>
                        </tr>
                        <tr>
                            <th><i class="require-red">*</i>登陆密码：</th>
                            <td>
                                <input class="common-text required" id="password" name="password" size="50" value="" type="text">
                            </td>
                        </tr>
                        <tr>
                            <th><i class="require-red">*</i>省市区：</th>
                            <td>
                                <select name="provinceId" id="province">
                                    <c:forEach items="${requestScope.sysAreaList}" var="sa">
                                        <option value="${sa.id}">${sa.name}</option>
                                    </c:forEach>
                                </select>
                                <select name="cityId" id="city"></select>
                                <select name="districtId" id="district"></select>
                            </td>
                        <tr>
                            <th><i class="require-red">*</i>商家地址：</th>
                            <td>
                                <input class="common-text required" id="address" name="address" size="50" value="" type="text">
                            </td>
                        </tr>
                        <tr>
                            <th><i class="require-red">*</i>商家电话：</th>
                            <td>
                                <input class="common-text required" id="phone" name="phone" size="50" value="" type="text">
                            </td>
                        </tr>
                        <tr>
                            <th><i class="require-red">*</i>商家姓名：</th>
                            <td>
                                <input class="common-text required" id="name" name="name" size="50" value="" type="text">
                            </td>
                        </tr>
                        <tr>
                            <th><i class="require-red">*</i>老板姓名：</th>
                            <td>
                                <input class="common-text required" id="bossName" name="bossName" size="50" value="" type="text">
                            </td>
                        </tr>
                        <tr>
                            <th><i class="require-red">*</i>老板电话：</th>
                            <td>
                                <input class="common-text required" id="bossPhone" name="bossPhone" size="50" value="" type="text">
                            </td>
                        </tr>
                        <tr>
                            <th><i class="require-red">*</i>老板身份证号：</th>
                            <td>
                                <input class="common-text required" id="bossId" name="bossId" size="50" value="" type="text">
                            </td>
                        </tr>
                        <tr>
                            <th><i class="require-red">*</i>营业执照照片：</th>
                            <td>
                                <p id="cimg">
                                    <input type="hidden" value="" name="certificate" id="certificate" style="width: 100px;height:100px">
                                    <img src="" alt="" style="width: 100px;height: 100px;display: ${empty merchant.picture?'none':''}" id="img2">
                                </p>
                                <input type="file" name="file2" id="file2">
                            </td>
                        </tr>
                        <tr>
                            <th><i class="require-red">*</i>商家照片：</th>
                            <td>
                                <p id="pimg">
                                    <input type="hidden" value="" name="picture" id="picture" style="width: 100px;height:100px">
                                    <img src="" alt="" style="width: 100px;height: 100px;display: ${empty merchant.picture?'none':''}" id="img">
                                </p>
                                <input type="file" name="file" id="file">
                            </td>
                        </tr>
                        <tr>
                            <th>店铺简介：</th>
                            <td><textarea name="description" class="common-textarea" id="description" cols="30" style="width: 98%;" rows="10"></textarea></td>
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
