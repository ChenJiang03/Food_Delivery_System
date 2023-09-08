
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set value="${pageContext.request.contextPath}" var="path"></c:set>
<html>
<head>
    <meta charset="utf-8" />
    <meta name="author" content="order by dede58.com"/>
    <title>DeathGhost-用户中心</title>
    <meta name="keywords" content="DeathGhost,DeathGhost.cn,web前端设,移动WebApp开发" />
    <meta name="description" content="DeathGhost.cn::H5 WEB前端设计开发!" />
    <meta name="author" content="DeathGhost"/>
    <link href="${path}/webConfig/style/style.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="${path}/webConfig/js/public.js"></script>
    <script type="text/javascript" src="${path}/webConfig/js/jquery.js"></script>
    <script type="text/javascript" src="${path}/webConfig/js/jqpublic.js"></script>
    <!--
    Author: DeathGhost
    Author URI: http://www.deathghost.cn
    -->
</head>
<body>
<jsp:include page="/webConfig/inc/userTop.jsp"></jsp:include>
<!--Start content-->
<section class="Psection MT20">
    <jsp:include page="/webConfig/inc/userLeft.jsp"></jsp:include>
    <article class="U-article Overflow">
        <!--user Address-->
        <section class="Myaddress Overflow">


            <!--add new address-->
            <form action="${path}/userCenter/address/add" method="post">
                <table style="margin-top:10px;">
                    <tr>
                        <td width="30%" class="Font14 FontW Lineheight35" align="right">选择所在地：</td>
                        <td>
                            <select name="province.id" id="province">
                                <c:forEach items="${requestScope.sysAreaList}" var="sa">
                                    <option value="${sa.id}">${sa.name}</option>
                                </c:forEach>
                            </select>
                            <select name="city.id" id="city"></select>
                            <select name="district.id" id="district"></select>
                        </td>
                    </tr>
                    <tr>
                        <td width="30%" class="Font14 FontW Lineheight35" align="right">收货人姓名：</td>
                        <td><input type="text" name="name" required  class="input_name"></td>
                    </tr>
                    <tr>
                        <td width="30%" class="Font14 FontW Lineheight35" align="right">详细地址：</td>
                        <td><input type="text"  class="input_zipcode" name="address"></td>
                    </tr>
                    <tr>
                        <td width="30%" class="Font14 FontW Lineheight35" align="right">手机号码：</td>
                        <td><input type="text" name="phone" class="input_tel" placeholder="请输入11位手机号"><span id="phone"></span></td></td>
                    </tr>
                    <tr>
                        <td width="30%" class="Font14 FontW Lineheight35" align="right">是否默认：</td>
                        <td><input type="checkbox" name="isDefault" value="1">是</td>
                    </tr>
                    <tr>
                        <td width="30%" class="Font14 FontW Lineheight35" align="right"></td>
                        <td class="Font14 Font Lineheight35"><input name="" type="submit" value="新增收货地址"  class="Submit"></td>
                    </tr>
                </table>
            </form>
        </section>
    </article>
</section>
<!--End content-->
<div class="F-link">
    <span>友情链接：</span>
</div>
<jsp:include page="/webConfig/inc/userFoot.jsp"></jsp:include>
</body>
</html>
<script type="text/javascript" src="${path}/webConfig/js/jquery-3.6.4.min.js"></script>
<script type="text/javascript">
    var phoneFlag = true;
    function getDistrict(){
        $("#district").empty();
        var id=$("#city").val();
        $.get("${path}/userCenter/address/getSysArea",{id:id},function (data){
            for(var i=0;i<data.length;i++){
                var option=$("<option>");
                option.val(data[i].id);
                option.html(data[i].name);
                $("#district").append(option);
            }
        });
    }

    function getCity(){
        $("#city").empty();
        var id=$("#province").val();
        $.get("${path}/userCenter/address/getSysArea",{id:id},function (data){
            for(var i=0;i<data.length;i++){
                var option=$("<option>");
                option.val(data[i].id);
                option.html(data[i].name);
                $("#city").append(option);
            }
            getDistrict();
        });
    }

    function checkPhone() {
        var phone = $(".input_tel").val();
        var phoneExp = /^1[3-9]\d{9}$/;
        if (!phoneExp.test(phone)) {
            $("#phone").html("手机号码不符合规定，请输入合法的手机号");
            $("#phone").css("color", "red");
            phoneFlag = false;
        } else {
            $("#phone").html("√");
            $("#phone").css("color", "green");
            phoneFlag = true;
        }
    }

    $(function (){
        $("#province").change(getCity);
        $("#city").change(getDistrict);
        getCity();
        $(".input_tel").blur(checkPhone);

        $(".Submit").click(function (){
            checkPhone();
            if(!phoneFlag){
                return false;
            }
        })

    });
</script>