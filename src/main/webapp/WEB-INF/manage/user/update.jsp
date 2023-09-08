<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"></c:set>
<script type="/manageConfig/js/checkImageSize.js"></script>
<html>
<head>
  <meta charset="UTF-8">
  <title>修改用户信息</title>
</head>
<body>
<jsp:include page="/manageConfig/inc/top.jsp"></jsp:include>
<div class="container clearfix">
  <jsp:include page="/manageConfig/inc/left.jsp"></jsp:include>
  <!--/sidebar-->
  <div class="main-wrap">

    <div class="crumb-wrap">
      <div class="crumb-list"><i class="icon-font"></i><a href="${path}/manage/manager/index">首页</a><span class="crumb-step">&gt;</span><a class="crumb-name" href="${path}/manage/user/list">用户管理</a><span class="crumb-step">&gt;</span><span>修改用户</span></div>
    </div>
    <div class="result-wrap">
      <c:set var="user" value="${requestScope.user}"></c:set>
      <div class="result-content">
        <form action="${path}/manage/user/update" method="post" id="myform" name="myform" enctype="multipart/form-data" >
          <input type="hidden" value="${user.id}" name="id">
          <table class="insert-tab" width="100%">
            <tbody>
            <tr>
              <th>头像:</th>
              <td>
                <div id="pimg">
                  <input type="hidden" value="${user.picture}" name="picture" id="picture">
                  <img src="${path}${user.picture}" style="width: 100px;height: 100px;display: ${empty user.picture?'none':''}" id="img">
                </div>
                <input type="file" id="file" name="file">
              </td>

            </tr>
            <tr>
              <th><i class="require-red">*</i>用户名:</th>
              <td>
                <input class="common-text required" id="username" name="username" size="50" value="${user.username}" type="text">
                <span id="usernameMsg"></span>
              </td>

            </tr>
            <tr>
              <th><i class="require-red">*</i>密码:</th>
              <td>
                <input class="common-text required" id="password" name="password" size="50" value="${user.password}" type="text">
                <span id="passwordMsg"></span>
              </td>

            </tr>
            <tr>
              <th><i class="require-red">*</i>姓名:</th>
              <td>
                <input class="common-text required" id="name" name="name" size="50" value="${user.name}" type="text">
                <span id="nameMsg"></span>
              </td>

            </tr>
<%--            <tr>--%>
<%--              <th> 详细地址:</th>--%>
<%--              <td><textarea name="address" class="common-textarea" id="address" cols="25" style="width: 80%;" value="" rows="5">${user.address}</textarea></td>--%>
<%--            </tr>--%>
            <%--                        <tr>--%>
            <%--                            <th><i class="require-red">*</i>省市区:</th>--%>
            <%--                            <td>--%>
            <%--                                <select name="provinceId" id="province">--%>
            <%--                                        <c:forEach items="${requestScope.sysAreaList}" var="sa">--%>
            <%--                                            <c:if test="${user.provinceId eq sa.id}" var="flag">--%>
            <%--                                                <option value="${sa.id}" selected>${sa.name}</option>--%>
            <%--                                            </c:if>--%>
            <%--                                            <c:if test="${not flag}">--%>
            <%--                                                <option value="${sa.id}">${sa.name}</option>--%>
            <%--                                            </c:if>--%>
            <%--                                        </c:forEach>--%>
            <%--                                </select>--%>
            <%--                                <select name="cityId" id="city"></select>--%>
            <%--                                <select name="districtId" id="district"></select>--%>
            <%--                            </td>--%>
            <%--                        </tr>--%>
            <tr>
              <th><i class="require-red">*</i>联系方式:</th>
              <td>
                <input class="common-text required" id="phone" name="phone" size="50" value="${user.phone}" type="text">
                <span id="phoneMsg"></span>
              </td>

            </tr>
            <tr>
              <th></th>
              <td>
                <input class="btn btn-primary btn6 mr10" value="提交" type="submit" id="btn">
                <input class="btn btn6" onclick="history.go(-1)" value="返回" type="button">
              </td>
            </tr>
            </tbody>
          </table>
        </form>
      </div>
    </div>

  </div>
  <!--/main-->
</div>
</body>
<script src="${path}/webConfig/js/jquery-3.6.4.min.js"></script>
<script type="text/javascript">
  var flag =true
  $(function(){
    console.log(111)
    $("#username").blur(function (){
      if($(this).val()!=${user.username}){
        checkUserName()
      }
    })
    $("#password").blur(function (){
      checkPassword()

    })
    $("#name").blur(function (){
      checkName()

    })
    $("#phone").blur(function (){
      checkPhone()
    })

    $("#btn").click(function (){
      if (!flag){
        return false;
      }

    })

    $("#file").change(function (){
      var formData = new FormData($("#myform")[0]);
      formData.append("file",$("#file")[0]);
      $.ajax({
        url: "${path}/manage/user/uploadPic",
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

  function checkPassword(){
    var password = $("#password").val();
    var passwordExp = /^[\w\W]{10,20}$/;
    if(!passwordExp.test(password)){
      $("#passwordMsg").html("密码格式错误");
      $("#passwordMsg").css("color","red");
      flag = false;
    }
    else{
      $("#passwordMsg").html("√");
      $("#passwordMsg").css("color","green");
      flag=true;
    }
  }

  function checkPhone(){
    var phone = $("#phone").val();
    var phoneExp = /^[0-9]{11}$/;
    if(!phoneExp.test(phone)){
      $("#phoneMsg").html("输入格式错误");
      $("#phoneMsg").css("color","red");
      flag = false;
    }
    else{
      $("#phoneMsg").html("√");
      $("#phoneMsg").css("color","green");
      flag=true;
    }
  }

  function checkUserName(){
    var username = $("#username").val();
    var usernameExp = /^\w{5,15}$/;
    $.ajax({
      url:"${path}/manage/user/existUser",
      type:"post",
      data:{username:username},
      success:function (data) {
        if(data=="yes"){
          $("#usernameMsg").html("用户名已存在！");
          $("#usernameMsg").css("color","red");
          flag = false;
        }else if(data=="no"){
          if(!usernameExp.test(username)){
            $("#usernameMsg").html("用户名格式错误");
            $("#usernameMsg").css("color","red");
            flag = false;
          }
          else{
            $("#usernameMsg").html("√");
            $("#usernameMsg").css("color","green");
            flag=true;
          }
        }

      }
    })
  }

  function checkName(){
    var name = $("#name").val();
    var nameExp =/^[\u4e00-\u9fa5]{2,7}$/;
    if(!nameExp.test(name)){
      $("#nameMsg").html("姓名格式错误");
      $("#nameMsg").css("color","red");
      flag = false;
    }else{
      $("#nameMsg").html("√");
      $("#nameMsg").css("color","green");
      flag=true;
    }

  }

  <%--function getCity(){--%>
  <%--  $("#city").html()--%>
  <%--  var id = $("#province").val()--%>
  <%--  $.get('${path}/manager/user/getSysArea',{id:id},function (data){--%>
  <%--    for(var i=0;i<data.length;i++){--%>
  <%--      var option = $("<option>")--%>
  <%--      option.val(data[i].id)--%>
  <%--      option.html(data[i].name)--%>
  <%--      if(data[i].id=="${user.cityId}"){--%>
  <%--        option.attr("selected","selected");--%>
  <%--      }--%>
  <%--      $("#city").append(option);--%>
  <%--    }--%>
  <%--    getDistrict();--%>
  <%--  })--%>
  <%--}--%>

  <%--function  getDistrict(){--%>
  <%--  $("#district").html()--%>
  <%--  var id = $("#city").val()--%>
  <%--  $.get("${path}/manage/user/getSysArea",{id:id},function(data){--%>
  <%--    for(var i=0;i<data.length;i++){--%>
  <%--      var option = $("<option>")--%>
  <%--      option.val(data[i].id)--%>
  <%--      option.html(data[i].name)--%>
  <%--      if(data[i].id=="${user.districtId}"){--%>
  <%--        option.attr("selected","selected");--%>
  <%--      }--%>
  <%--      $("#district").append(option);--%>
  <%--    }--%>
  <%--  })--%>

  <%--}--%>

</script>
</html>


