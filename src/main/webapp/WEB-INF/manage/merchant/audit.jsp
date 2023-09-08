<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"></c:set>
<c:set var="merchant" value="${requestScope.merchant}"></c:set>
<html>
<head>
    <title>审核</title>
    <script type="text/javascript" src="${path}/webConfig/js/jquery-3.6.4.min.js"></script>
    <script type="text/javascript">
        function getCity(){
            console.log(${merchant.cityId});
            $("#city").html("");
            var id=$("#province").val();
            $.get("${path}/Merchant/getSysArea",{id:id},function (data){
                for(var i=0;i<data.length;i++){
                    if(data[i].id=="${merchant.cityId}"){
                        var option=$("<option>");
                        option.val(data[i].id);
                        option.html(data[i].name);
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
                    if(data[i].id=="${merchant.districtId}"){
                        var option=$("<option>");
                        option.val(data[i].id);
                        option.html(data[i].name);
                        option.attr("selected","selected");
                    }
                    $("#district").append(option);
                }
            });
        }

        $(function (){
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
                                    </c:forEach>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <th><i class="require-red">*</i>用户名：</th>
                            <td>
                                <input class="common-text required" disabled id="username" name="username" size="50" value="${merchant.username}" type="text">
                            </td>
                        </tr>
                        <tr>
                            <th><i class="require-red">*</i>登陆密码：</th>
                            <td>
                                <input class="common-text required" disabled id="password" name="password" size="50" value="${merchant.password}" type="text">
                            </td>
                        </tr>
                        <tr>
                            <th><i class="require-red">*</i>省市区：</th>
                            <td>
                                <select name="provinceId" id="province">
                                    <c:forEach items="${requestScope.sysAreaList}" var="sa">
                                        <c:if test="${merchant.provinceId eq sa.id}" var="flag">
                                            <option value="${sa.id}" >${sa.name}</option>
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
                                <input class="common-text required" disabled id="address" name="address" size="50" value="${merchant.address}" type="text">
                            </td>
                        </tr>
                        <tr>
                            <th><i class="require-red">*</i>商家电话：</th>
                            <td>
                                <input class="common-text required" disabled id="phone" name="phone" size="50" value="${merchant.phone}" type="text">
                            </td>
                        </tr>
                        <tr>
                            <th><i class="require-red">*</i>商家姓名：</th>
                            <td>
                                <input class="common-text required" disabled id="name" name="name" size="50" value="${merchant.name}" type="text">
                            </td>
                        </tr>
                        <tr>
                            <th><i class="require-red">*</i>注册时间：</th>
                            <td>
                                <input class="common-text required" disabled id="regTime" name="regTime" size="50" value="${merchant.regTime}" type="text">
                            </td>
                        </tr>
                        <tr>
                            <th><i class="require-red">*</i>老板姓名：</th>
                            <td>
                                <input class="common-text required" disabled id="bossName" name="bossName" size="50" value="${merchant.bossName}" type="text">
                            </td>
                        </tr>
                        <tr>
                            <th><i class="require-red">*</i>老板电话：</th>
                            <td>
                                <input class="common-text required" disabled id="bossPhone" name="bossPhone" size="50" value="${merchant.bossPhone}" type="text">
                            </td>
                        </tr>
                        <tr>
                            <th><i class="require-red">*</i>老板身份证：</th>
                            <td>
                                <input class="common-text required" disabled id="bossId" name="bossId" size="50" value="${merchant.bossId}" type="text">
                            </td>
                        </tr>
                        <tr>
                            <th><i class="require-red">*</i>营业执照：</th>
                            <td>
                                <p>
                                    <img src="${path}${merchant.certificate}" alt="" style="width: 100px;height: 100px;display: ${empty merchant.picture?'none':''}">
                                </p>
                            </td>
                        </tr>
                        <tr>
                            <th><i class="require-red">*</i>商家照片：</th>
                            <td>
                                <p>
                                    <img src="${path}${merchant.picture}" alt="" style="width: 100px;height: 100px;display: ${empty merchant.picture?'none':''}" id="img">
                                </p>
                            </td>
                        </tr>
                        <tr>
                            <th>店铺简介：</th>
                            <td><textarea name="description" disabled class="common-textarea" id="description" cols="30" style="width: 98%;" rows="10">${merchant.description}</textarea></td>
                        </tr>
                        <tr>
                            <th></th>
                            <td>
                                <a href="${path}/manage/merchant/auditOk?id=${merchant.id}">审核通过</a>
                                <a href="${path}/manage/merchant/auditNo?id=${merchant.id}">审核未通过</a>
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
