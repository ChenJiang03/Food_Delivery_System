<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"></c:set>
<c:set var="rider" value="${sessionScope.rider}"></c:set>
<!DOCTYPE html>
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
<jsp:include page="/webConfig/inc/riderTop.jsp"></jsp:include>
<!--Start content-->
<section class="Psection MT20">
    <jsp:include page="/webConfig/inc/riderLeft.jsp"></jsp:include>
    <article class="U-article Overflow">
        <!--user Address-->
        <section class="Myaddress Overflow">
            <span class="MDtitle Font14 FontW Block Lineheight35">送货地址信息</span>
            <!--add new address-->
            <form action="${path}/riderCenter/address/update" method="post">
                <table style="margin-top:10px;">
                    <tr>
                        <td width="30%" class="Font14 FontW Lineheight35" align="right">选择送货范围</td>
                        <br/>
                        <td>
                            <select name="province.id" id="province" class="select_ssq" >
                                <c:forEach items="${requestScope.sysAreaList}" var="sa">
                                    <option value="${sa.id}" ${(sa.id eq sessionScope.rider.province.id)?'selected':''}>${sa.name}</option>
                                </c:forEach>
                            </select>
                            <select name="city.id" id="city" class="select_ssq"></select>
                            <select name="district.id" id="district" class="select_ssq"></select>
                        </td>
                    </tr>
                    <tr>
                        <td width="30%" class="Font14 FontW Lineheight35" align="right"></td>
                        <td class="Font14 Font Lineheight35"><input name="" type="submit" value="修改收货地址"  class="Submit"></td>
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
<jsp:include page="/webConfig/inc/riderFoot.jsp"></jsp:include>
</body>
</html>
<script type="text/javascript">

    //json javascript的对象表示方法
    //对象

    function getDistrict(){
        $("#district").empty();
        var id=$("#city").val();
        $.get("${path}/riderCenter/address/getSysArea",{id:id},function (data){
            for(var i=0;i<data.length;i++){
                var option=$("<option>");
                option.val(data[i].id);
                option.html(data[i].name);
                if(data[i].id=="${rider.district.id}"){
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
        $.get("${path}/riderCenter/address/getSysArea",{id:id},function (data){
            for(var i=0;i<data.length;i++){
                var option=$("<option>");
                option.val(data[i].id);
                option.html(data[i].name);
                if(data[i].id=="${rider.city.id}"){
                   option.attr("selected","selected");
                   // option.prop("selected",true);
                }
                $("#city").append(option);
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
