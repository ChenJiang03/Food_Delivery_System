<%@ page import="com.example.uglytuan.vo.Rider" %>
<%@ page import="com.example.uglytuan.vo.ProductType" %><%--
  Created by IntelliJ IDEA.
  User: Nancy
  Date: 2023/6/18
  Time: 21:32
  To change this template use File | Settings | File Templates.
--%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"></c:set>
<c:set var="p" value="${requestScope.rider}"></c:set>
<html>
<head>
    <meta charset="UTF-8">
    <title>修改产品</title>
    <style type="text/css">
        #pimg{
            overflow: hidden;
        }
        #pimg .img{
            float:left;
            text-align: center;
            margin-left: 10px;
        }
    </style>
</head>
<body>
<jsp:include page="/manageConfig/inc/top.jsp"></jsp:include>
<div class="container clearfix">
    <jsp:include page="/manageConfig/inc/left.jsp"></jsp:include>
    <!--/sidebar-->
    <div class="main-wrap">

        <div class="crumb-wrap">
            <div class="crumb-list"><i class="icon-font"></i><a href="${path}/manage/rider/list">首页</a><span class="crumb-step">&gt;</span><a class="crumb-name" href="${path}/manage/rider/list">骑手管理</a><span class="crumb-step">&gt;</span><span>修改骑手</span></div>
        </div>
        <div class="result-wrap">
            <div class="result-content">

                <form action="${path}/manage/rider/update" method="post" id="myform" name="myform" enctype="multipart/form-data">
                    <input type="hidden" name="id" id="id" value="${p.id}">
                    <table class="insert-tab" width="100%">
                        <tbody>
<%--                        <tr>--%>
<%--                            <th><i class="require-red">*</i>分类：</th>--%>
<%--                            <td>--%>
<%--                                <select name="productType.id" id="">--%>
<%--                                    <c:forEach var="pt" items="${requestScope.riderList}">--%>
<%--                                        <c:if test="${p.productType.id eq pt.id}" var="flag">--%>
<%--                                            <option value="${pt.id}" selected>${pt.title}</option>--%>
<%--                                        </c:if>--%>
<%--                                        <c:if test="${not flag}" var="flag">--%>
<%--                                            <option value="${pt.id}">${pt.title}</option>--%>
<%--                                        </c:if>--%>
<%--                                    </c:forEach>--%>

<%--                                </select>--%>
<%--                            </td>--%>
<%--                        </tr>--%>
                        <tr>
                            <th><i class="require-red">*</i>骑手用户名：</th>
                            <td>
                                <input class="common-text required" id="username" name="username" readonly size="50" value="${p.username}" type="text">
                                <span id="usernameMsg"></span>
                            </td>
                        </tr>
                        <tr>
                            <th><i class="require-red">*</i>骑手密码：</th>
                            <td>
                                <input class="common-text required" id="password" name="password" size="50" value="${p.password}" type="text">
                                <span id="passwordMsg"></span>
                            </td>
                        </tr>
                        <tr>
                            <th><i class="require-red">*</i>骑手手机号：</th>
                            <td>
                                <input class="common-text required" id="phone" name="phone" size="50" value="${p.phone}" type="text">
                                <span id="phoneMsg"></span>
                            </td>
                        </tr>
                        <tr>
                            <th><i class="require-red">*</i>骑手姓名：</th>
                            <td>
                                <input class="common-text required" id="name" name="name" size="50" value="${p.name}" type="text">
                                <span id="nameMsg"></span>
                            </td>
                        </tr>
                        <tr>
                            <th><i class="require-red">*</i>骑手余额：</th>
                            <td>
                                <input class="common-text required" id="balance" readonly name="balance" size="50" value="${p.balance}" type="text">
                            </td>
                        </tr>
                        <tr>
                            <th><i class="require-red">*</i>骑手身份证号：</th>
                            <td>
                                <input class="common-text required" id="identification" readonly name="identification" size="50" value="${p.identification}" type="text">
                                <span id="identificationMsg"></span>
                            </td>
                        </tr>
                        <tr>
                            <th><i class="require-red">*</i>骑手分数：</th>
                            <td>
                                <input class="common-text required" id="score" name="score" readonly size="50" value="${p.score}" type="text">
                            </td>
                        </tr>
                        <tr>
                            <th><i class="require-red">*</i>骑手是否可以工作：</th>
                            <td>
                                <input type="radio" name="available" value="0" ${p.available?"":"checked"} >否 <input type="radio" checked name="available" value="1" ${p.available?"checked":""}>是
                            </td>
                        </tr>
                        <tr>
                            <th><i class="require-red">*</i>选择送货范围：</th>
                            <td>
                                <select name="province.id" id="province" class="select_ssq" >
                                    <c:forEach items="${requestScope.sysAreaList}" var="sa">
                                        <option value="${sa.id}" ${(sa.id eq p.province.id)?'selected':''}>${sa.name}</option>
                                    </c:forEach>
                                </select>
                                <select name="city.id" id="city" class="select_ssq"></select>
                                <select name="district.id" id="district" class="select_ssq"></select>
                            </td>
                        </tr>
                        <tr>
                            <th><i class="require-red">*</i>骑手图片：</th>
                            <td>
                                <div id="pimg">
                                    <input type="hidden" accept="image/*" value="${p.picture}" name="picture" id="pic">
                                    <!--循环指定字符分割的字符串 也可以是多个字符分割的字符串-->
                                    <c:forTokens items="${p.picture}" delims="," var="pic">
                                        <div class="img">
                                            <p>
                                                <img src="${path}${pic}" alt="" style="width: 100px;height: 100px;display: ${empty p.picture?'none':''}" id="img">
                                            </p>
                                            <a href="" class="del" data-pic="${pic}">删除</a>
                                        </div>

                                    </c:forTokens>
                                </div>
                                <input type="file" name="file" id="file">
                            </td>
                        </tr>
                        <tr>
                            <th></th>
                            <td>
                                <input class="btn btn-primary btn6 mr10" id="btn" value="提交" type="submit">
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
<script type="text/javascript" src="${path}/js/jquery-3.6.4.min.js" ></script>

<script type="text/javascript" src="${path}/webConfig/ueditor/ueditor.config.js" charset="utf-8"></script>
<script type="text/javascript" src="${path}/webConfig/ueditor/ueditor.all.js" charset="utf-8"></script>
<script type="text/javascript" charset="utf-8" src="${path}/webConfig/ueditor/lang/zh-cn/zh-cn.js" ></script>
<script type="text/javascript">
    var usernameFlag=false,passwordFlag=false,nameFlag=false,phoneFlag=false,identificationFlag=false;
    $(function (){
        $("#username").blur(checkUsername);
        $("#password").blur(checkPassword);
        $("#name").blur(checkName);
        $("#phone").blur(checkPhone);
        $("#identification").blur(checkIdentification);
        $("#province").change(getCity);
        $("#city").change(getDistrict);
        getCity();

        var args={
            initialFrameHeight:300,
            initialFrameWidth:800,
            /*toolbars:[
                ["anchor","undo"],
                ["bold"]
            ]*/
        };

        $("#btn").click(function (){
            var pic=$("#pic").val();
            var arr=pic.split(",");
            if(arr.length>6){
                alert("请不要上传超过6张图片");
                return false;
            }
            checkUsername();
            checkPassword();
            checkName();
            checkPhone();
            checkIdentification();
            if(!usernameFlag||!passwordFlag||!nameFlag||!phoneFlag||!identificationFlag){
                console.log(usernameFlag);
                console.log(passwordFlag);
                console.log(nameFlag);
                console.log(phoneFlag);
                console.log(identificationFlag);
                console.log(1);
                //阻止表单提交
                return false;
            }
        });

        $(document).on("click",".img .del",function (){
            $(this).parent().remove();
            var src=$(this).data("pic");
            var pic=$("#pic").val();
            pic=pic.replace(src,"");
            var arr=pic.split(",");
            var newPic="";
            for(var i=0;i<arr.length;i++){
                if(arr[i]!=""){
                    newPic+=","+arr[i];
                }
            }
            newPic=newPic.substring(1);
            $("#pic").val(newPic);
            return false;
        });

        $("#file").change(function (){
            var pic=$("#pic").val();
            checkImageSize();

            var arr=pic.split(",");
            if(arr.length>=6){
                alert("请不要上传超过6张图片");
                return;
            }
            //通过ajax提交表单
            //html对象 document.getElementById()
            //jquery对象 $("")
            //html对象->jquery对象 $(html对象)
            //jquery对象->html对象 jquery对象[0]
            //构造一个表单对象
            var formData=new FormData($("#myform")[0]);
            //在表单对象里面添加一个file对象
            formData.append("file",$("#file")[0]);
            $.ajax({
                url:"${path}/manage/rider/uploadPic",
                type:"post",  //上传图片必须用post请求
                data:formData,
                contentType:false,  //不让ajax修改的上传的方式
                processData:false,  //不让ajax处理上传的数据
                success:function (data){
                    if(data=="fail"){
                        alert("请上传一个图片");
                        return;
                    }
                    var div=$("<div>");
                    div.addClass("img");
                    var p=$("<p>");
                    var img=$("<img>");
                    img.css({"width":"100px","height":"100px"});
                    // img.css("width","100px");
                    //img.css("height","100px");
                    img.attr("src","${path}"+data);
                    // $("#img").show();
                    p.append(img);
                    div.append(p);

                    var a=$("<a>");
                    a.html("删除");
                    a.addClass("del");
                    a.attr("data-pic",data);
                    a.attr("href","");
                    div.append(a);
                    $("#pimg").append(div);
                    var pic=$("#pic").val();
                    if(pic!=""){
                        $("#pic").val(pic+","+data);
                    }
                    else{
                        $("#pic").val(data);
                    }
                }
            });
        });
    });
    function checkImageSize() {
        var input = document.getElementById('file');
        console.log(input.files.length);
        if (input.files && input.files[0]) {
            var file = input.files[0];
            var fileSize = file.size; // 文件大小（字节）
            console.log(fileSize);
            var maxSizeInBytes = 1048576; // 1MB（根据您的需求设置最大文件大小）

            if (fileSize > maxSizeInBytes) {
                alert('图片文件太大，图片最大不能超过1MB');
                // 这里可以根据需要进行其他处理，例如清空文件上传框的内容：
                input.value = '';
            }
        }
    }
    function checkUsername()
    {
        var username = $("#username").val();
        var usernameExp = /^\w{5,20}$/;
        if (!usernameExp.test(username))
        {
            $("#usernameMsg").html("用户名格式错误，请输入5-20为字母数字下划线");
            $("#usernameMsg").css("color","red");
            usernameFlag=false;
        }
        else
        {
            if (username == "${p.username}")
            {
                $("#usernameMsg").html("√");
                $("#usernameMsg").css("color","green");
                usernameFlag=true;
            }
            else
            {
                $.ajax({
                    url:"${path}/manage/rider/existRider",
                    data:{username:username},
                    success:function (data)
                    {
                        console.log("-----------------")
                        console.log(data);
                        if (data=="ok")
                        {
                            $("#usernameMsg").html("√");
                            $("#usernameMsg").css("color","green");
                            usernameFlag=true;
                        }
                        else if (data=="no")
                        {
                            $("#usernameMsg").html("用户名已存在");
                            $("#usernameMsg").css("color","red");
                            usernameFlag=false;
                        }
                    }
                });
            }
        }
    }
    function checkPassword(){
        var password=$("#password").val();
        var passwordExp=/^.{5,20}$/;
        if(!passwordExp.test(password)){
            $("#passwordMsg").html("密码格式错误，请输入5到20位的任意字符");
            $("#passwordMsg").css("color","red");
            passwordFlag=false;
        }
        else{
            $("#passwordMsg").html("√");
            $("#passwordMsg").css("color","green");
            passwordFlag=true;
            console.log(passwordFlag);
        }
    }
    function checkName(){
        var name=$("#name").val();
        var nameExp = /^[\u4e00-\u9fa5a-zA-Z0-9]{1,6}$/;
        if(!nameExp.test(name)){
            $("#nameMsg").html("姓名不符合规定，请输入合法的姓名");
            $("#nameMsg").css("color","red");
            nameFlag=false;
        }
        else{
            $("#nameMsg").html("√");
            $("#nameMsg").css("color","green");
            nameFlag=true;
        }
    }
    function checkPhone(){
        var phone=$("#phone").val();
        var phoneExp = /^1[3-9]\d{9}$/;
        if(!phoneExp.test(phone)){
            $("#phoneMsg").html("手机号码不符合规定，请输入合法的手机号");
            $("#phoneMsg").css("color","red");
            phoneFlag=false;
        }
        else{
            $("#phoneMsg").html("√");
            $("#phoneMsg").css("color","green");
            phoneFlag=true;
        }
    }
    function checkIdentification(){
        var identification=$("#identification").val();
        var identificationExp = /^[1-9]\d{5}(19|20|21)\d{2}((0[1-9])|1[0-2])(([0-2][1-9])|10|20|30|31)\d{3}[0-9Xx]$/;
        if(!identificationExp.test(identification)){
            $("#identificationMsg").html("身份证号码不符合规定，请输入合法的身份证号");
            $("#identificationMsg").css("color","red");
            identificationFlag=false;
        }
        else{
            $("#identificationMsg").html("√");
            $("#identificationMsg").css("color","green");
            identificationFlag=true;
        }
    }
    function getDistrict(){
        $("#district").empty();
        var id=$("#city").val();
        $.get("${path}/manage/rider/getSysArea",{id:id},function (data){
            for(var i=0;i<data.length;i++){
                var option=$("<option>");
                option.val(data[i].id);
                option.html(data[i].name);
                if(data[i].id=="${p.district.id}"){
                    // 为什么这个地方在selected后面我不加selected就不好用，加了selected就好用了？
                    option.attr("selected","selected");
                    //option.prop("selected",true);
                }
                $("#district").append(option);
            }
        });
    }

    function getCity(){
        $("#city").empty();
        var id=$("#province").val();
        $.get("${path}/manage/rider/getSysArea",{id:id},function (data){
            for(var i=0;i<data.length;i++){
                var option=$("<option>");
                option.val(data[i].id);
                option.html(data[i].name);
                if(data[i].id=="${p.city.id}"){
                    option.attr("selected","selected");
                    // option.prop("selected",true);
                }
                $("#city").append(option);
            }
            getDistrict();
        });
    }

</script>
