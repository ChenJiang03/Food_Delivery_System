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
<c:set value="${requestScope.address}" var="address"></c:set>
<jsp:include page="/webConfig/inc/userTop.jsp"></jsp:include>
<!--Start content-->
<section class="Psection MT20">
    <jsp:include page="/webConfig/inc/userLeft.jsp"></jsp:include>
    <article class="U-article Overflow">
        <!--user Address-->
        <section class="Myaddress Overflow">
            <span class="MDtitle Font14 FontW Block Lineheight35">收货人信息</span>
            <form action="${path}/userCenter/address/update" method="post">
                <input type="hidden" value="${address.id}" name="id">
                <table>
                    <tr>
                        <td width="30%" class="Font14 FontW Lineheight35" align="right">选择所在地：</td>
                        <td>
                            <select name="province.id" id="province">
                                <c:forEach items="${requestScope.sysAreaList}" var="sa">
                                    <c:if test="${address.province.id eq sa.id}" var="flag">
                                        <option value="${sa.id}" selected="selected">${sa.name}</option>
                                    </c:if>
                                    <c:if test="${not flag}">
                                        <option value="${sa.id}">${sa.name}</option>
                                    </c:if>
                                </c:forEach>
                            </select>
                            <select name="city.id" id="city"></select>
                            <select name="district.id" id="district"></select>
                        </td>
                    </tr>
                    <tr>
                        <td width="30%" class="Font14 FontW Lineheight35" align="right">收货人姓名：</td>
                        <td><input type="text" name="name" required value="${address.name}" class="input_name"></td>
                    </tr>
                    <tr>
                        <td width="30%" class="Font14 FontW Lineheight35" align="right">详细地址：</td>
                        <td><input type="text" required size="50" value="${address.address}" class="input_addr" name="address"></td>
                    </tr>
                    <tr>
                        <td width="30%" class="Font14 FontW Lineheight35" align="right">手机号码：</td>
                        <td><input type="text" required size="10" value="${address.phone}" class="input_zipcode" name="phone"><span id="phone"></span></td></td>
                    </tr>
                    <tr>
                        <td width="30%" class="Font14 FontW Lineheight35" align="right">是否默认：</td>
                        <td><input type="checkbox" name="defaultAddress" value="1" ${address.isDefault?"checked":""}>是</td>
                    </tr>
                    <tr>
                        <td align="right"  width="30%" class="Font14 FontW Lineheight35"></td>
                        <td class="Lineheight35"><input name="" type="submit" value="确认修改" class="Submit"><input name="" type="submit" value="删除" class="Submit"></td>
                    </tr>
                </table>
            </form>
            <!--add new address-->

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
<script type="text/javascript" src="${path}/js/jquery-3.6.4.min.js"></script>
<script type="text/javascript">

    //json javascript的对象表示方法
    //对象
    var phoneFlag = true;
    function getDistrict(){
        $("#district").empty();
        var id=$("#city").val();
        $.get("${path}/userCenter/address/getSysArea",{id:id},function (data){
            for(var i=0;i<data.length;i++){
                var option=$("<option>");
                option.val(data[i].id);
                option.html(data[i].name);
                if(data[i].id=="${address.district.id}"){
                    option.attr("selected","");
                }
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
                if(data[i].id=="${address.city.id}"){
                    option.attr("selected","");
                }
                $("#city").append(option);
            }
            getDistrict();
        });
    }

    function checkPhone() {
        var phone = $(".input_zipcode").val();
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
        $(".input_zipcode").blur(checkPhone);
        $(".Submit").click(function (){
            checkPhone();
            if(!phoneFlag){
                return false;
            }
        })
    });
</script>

