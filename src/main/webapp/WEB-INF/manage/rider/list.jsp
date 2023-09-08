<%@ page import="java.util.List" %>
<%--Created by IntelliJ IDEA.
User: Administrator
Date: 2023/6/5
Time: 20:23
To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="path" value="${pageContext.request.contextPath}"></c:set>
<html>
<head>
    <meta charset="UTF-8">
    <title>用户列表</title>
</head>
<body>
<jsp:include page="/manageConfig/inc/top.jsp"></jsp:include>
<div class="container clearfix">
    <jsp:include page="/manageConfig/inc/left.jsp"></jsp:include>
    <!--/sidebar-->
    <div class="main-wrap">
        <div class="crumb-wrap">
            <div class="crumb-list"><i class="icon-font"></i><a href="${path}/manage/rider/list">首页</a><span class="crumb-step">&gt;</span><span class="crumb-name">骑手管理</span></div>
        </div>
        <div class="search-wrap">
            <div class="search-content">
                <form action="${path}/manage/rider/showList" method="get">
                    <table class="search-tab">
                        <tr>
                            <th width="120">根据地址分类:</th>
                            <td>
                                <select name="province.id" id="province">
                                    <option value="" selected>请选择</option>
                                    <c:forEach items="${requestScope.sysAreaList}" var="sa">
                                        <option value="${sa.id}" ${sa.id eq requestScope.rider.province.id?"selected":""}>${sa.name}</option>
                                    </c:forEach>
                                </select>
                                <select name="city.id" id="city"></select>
                                <select name="district.id" id="district"></select>
                            </td>
                            <th width="70">关键字:</th>
                            <td><input class="common-text" placeholder="关键字" name="keywords" value="${requestScope.keywords}" id="keywords" type="text"></td>
                            <td><input class="btn btn-primary btn2" name="sub" value="查询" type="submit"></td>
                        </tr>
                        <tr>
                            <th style="width: 150px; padding-left: 20px">骑手是否可以工作：</th>
                            <td>
                                <input type="radio" name="available" value="0" ${ (not empty(requestScope.rider.available) && !requestScope.rider.available)?'checked':""}>否 <input type="radio" name="available" value="1" ${requestScope.rider.available?'checked':""}>是
                            </td>
                        </tr>
                    </table>
                </form>
            </div>
        </div>
        <div class="result-wrap">
            <form name="myform" id="myform" method="post">
                <div class="result-title">
                    <div class="result-list">
                        <a href="${path}/manage/rider/add"><i class="icon-font"></i>新增骑手</a>
                        <a id="batchDel" href="javascript:void(0)" data-path="${path}" data-type="rider"><i class="icon-font"></i>批量删除</a>
                    </div>
                </div>
                <div class="result-content">
                    <table class="result-tab" width="100%">
                        <tr>
                            <th class="tc" width="5%"><input class="allChoose" name="" type="checkbox"></th>
                            <th>ID</th>
                            <th>头像</th>
                            <th>用户名</th>
                            <th>姓名</th>
                            <th>手机号</th>
                            <th>身份证号</th>
                            <th>评分</th>
                            <th>可否工作</th>
                            <th>注册时间</th>
                            <th>操作</th>
                        </tr>
                        <c:forEach items="${requestScope.riderList}" var="riderList">
                            <tr id = "tr_${riderList.id}">
                                <td class="tc"><input name="id[]" value="59"  type="checkbox" class="check" data-id="${riderList.id}"></td>
                                <td>${riderList.id}</td>
                                <td><img src="${path}${riderList.picture.split(",")[0]}"></td>
                                <td>${riderList.username}</td>
                                <td>${riderList.name}</td>
                                <td>${riderList.phone}</td>
                                <td>${riderList.identification}</td>
                                <td>${riderList.score}</td>
                                <td>${riderList.available?"是":"否"}</td>
                                <td>${riderList.regTime}</td>
                                <td>
                                    <a class="link-update" href="${path}/manage/rider/update?id=${riderList.id}" target="_blank">修改</a>
                                    <a class="link-del" href="" data-id="${riderList.id}" data-type="rider" data-path="${path}">删除</a>
                                    <a class="link-order" href="${path}/manage/rider/orders?id=${riderList.id}">订单</a>
                                </td>
                            </tr>
                        </c:forEach>
                    </table>
                    <div class="list-page">
                        <c:set var="page" value="${requestScope.pageUtils}"></c:set>
                        ${page.pageNum}/${page.pageCount}页 ${page.dataCount}条
                        <c:forEach begin="1" end="${page.pageCount}" var="i">
                            <a href="${path}/manage/rider/showList?pageNum=${i}&available=${requestScope.rider.available}&keywords=${requestScope.keywords}&province.id=${requestScope.rider.province.id}&city.id=${requestScope.rider.city.id}&district.id=${requestScope.rider.district.id}" class="${i eq page.pageNum?'current':''}">${i}</a>
                        </c:forEach>
                    </div>
                    <span>${param.province.id}</span>
                </div>
            </form>
        </div>
    </div>
    <!--/main-->
</div>
</body>
</html>
<style>
    img{
        width: 50px;
        height: 50px;
    }
</style>
<script type="/manageConfig/js/chooseAllAndDelete.js"></script>
<script type="${path}/js/jquery-3.6.4.min.js"></script>
<script type="text/javascript">
    function getDistrict(){
        $("#district").html("<option value=\"\" selected>请选择</option>");
        var id=$("#city").val();

        $.get("${path}/manage/rider/getSysArea",{id:id},function (data){
            for(var i=0;i<data.length;i++){
                var option=$("<option>");
                option.val(data[i].id);
                option.html(data[i].name);
                $("#district").append(option);
                if(data[i].id=="${requestScope.rider.district.id}"){
                    $(option).attr("selected","selected");
                }
            }
        });

    }

    function getCity(){

        $("#city").html("<option value=\"\" selected>请选择</option>");
        var id=$("#province").val();
        var selectDefaultSelected = $("#city option").val();
        $.get("${path}/manage/rider/getSysArea",{id:id},function (data){
            for(var i=0;i<data.length;i++){
                var option=$("<option>");
                option.val(data[i].id);
                option.html(data[i].name);
                $("#city").append(option);
                if(data[i].id=="${requestScope.rider.city.id}"){
                    $(option).attr("selected","selected");
                }
            }
            getDistrict();
        });

    }

    $(function (){
        $("#province").change(getCity);
        $("#city").change(getDistrict);
        getCity();
    });
</script>
