<%@ page import="com.example.uglytuan.vo.ShoppingCar" %>
<%@ page import="java.util.List" %><%--
  Created by IntelliJ IDEA.
  User: Nancy
  Date: 2023/6/18
  Time: 21:31
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"></c:set>
<html>
<head>
    <meta charset="utf-8" />
    <meta name="author" content="order by dede58.com"/>
    <title>我的购物车</title>
    <meta name="keywords" content="DeathGhost,DeathGhost.cn,web前端设,移动WebApp开发" />
    <meta name="description" content="DeathGhost.cn::H5 WEB前端设计开发!" />
    <meta name="author" content="DeathGhost"/>
    <link href="${path}/webConfig/style/style.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="${path}/webConfig/js/public.js"></script>
    <script type="text/javascript" src="${path}/webConfig/js/jquery.js"></script>
    <script type="text/javascript" src="${path}/webConfig/js/jqpublic.js"></script>
    <script type="text/javascript" src="${path}/webConfig/js/cart.js"></script>
    <!--
    Author: DeathGhost
    Author URI: http://www.deathghost.cn
    -->
</head>
<body>
<jsp:include page="/webConfig/inc/userTop.jsp"></jsp:include>
<!--Start content-->
<form action="#">
    <div class="gwc" style=" margin:auto;">
        <table cellpadding="0" cellspacing="0" class="gwc_tb1">
            <tr>
                <td class="tb1_td1"><input id="Checkbox1" type="checkbox"  class="allselect"/></td>
                <td class="tb1_td1">全选</td>
                <td class="tb1_td3">商品</td>
                <td class="tb1_td4">单价</td>
                <td class="tb1_td5">数量</td>
                <td class="tb1_td6">总价</td>
                <td class="tb1_td7">操作</td>
            </tr>
        </table>
        <table cellpadding="0" cellspacing="0" class="gwc_tb2" id="table1">
            <tr>
                <td colspan="7" class="shopname Font14 FontW">店铺：${requestScope.merchant.name}</td>
            </tr>
            <c:forEach items="${requestScope.shoppingCarList}" var="shoppingCar">
            <tr>
                <td class="tb2_td1"><input type="checkbox" value="1" name="newslist" id="newslist-1" data-id="${shoppingCar.product.id}" data-shopping="${shoppingCar.id}"></td>
                <td class="tb2_td2"><a href="${path}/userCenter/product/details?id=${shoppingCar.product.id}" target="_blank"><img src="${path}${shoppingCar.product.picture}"/></a></td>
                <td class="tb2_td3"><a href="${path}/userCenter/product/details?id=${shoppingCar.product.id}" target="_blank">${shoppingCar.product.title}</a></td>
                <td class="tb1_td4"><span>￥<span class="singlePrice">${shoppingCar.product.price}</span></span></td>
                <td class="tb1_td5"><input class="subNum" id="min1" name=""  style="width:30px; height:30px;border:1px solid #ccc;" type="button" value="-" />
                    <input id="text_box1" name="" type="text" value="${shoppingCar.amount}" style=" width:40px;height:28px; text-align:center; border:1px solid #ccc;" />
                    <input class="addNum" id="add1" name="" style="width:30px; height:30px;border:1px solid #ccc;" type="button" value="+" />
                </td>
                <td class="tb1_td4"><span>￥<span class="totalPrice">${shoppingCar.product.price*shoppingCar.amount}</span></span></td>
                <td class="tb1_td7"><a href="#" class="delcart1" data-id="${shoppingCar.id}">删除</a></td>
            </tr>
            </c:forEach>
        </table>
        <table cellpadding="0" cellspacing="0" class="gwc_tb3">
            <tr>
                <td class="tb3_td1"><input id="invert" type="checkbox" />
                    反选
                </td>
                <td class="tb3_td2 GoBack_Buy Font14"><a href="${path}/userCenter/shop?id=${requestScope.merchant.id}" target="_blank">继续购物</a></td>
                <td class="tb3_td2">已选商品
                    <label id="shuliang" style="color:#ff5500;font-size:14px; font-weight:bold;">0</label>
                    件</td>
                <td class="tb3_td3">合计(不含运费):<span>￥</span><span style=" color:#ff5500;">
        <label id="zong1" style="color:#ff5500;font-size:14px; font-weight:bold;">0.00</label>
        </span></td>
                <td class="tb3_td4"><span id="jz1">结算</span><a href="#" style=" display:none;"  class="jz2" id="jz2">结算</a></td>
            </tr>
        </table>
    </div>
</form>
<!--End content-->
<div class="F-link">
    <span>友情链接：</span>




</div>
<jsp:include page="/webConfig/inc/userFoot.jsp"></jsp:include>
</body>
</html>


<script src="${path}/webConfig/js/jquery-3.6.4.min.js"></script>
<script>
    $(function (){

        $(".allselect").click(function () {
            $(".gwc_tb2 input[name=newslist]").each(function () {
                $(this).prop("checked", $(".allselect").prop("checked"));
            });
            GetCount();
        });

        $("#invert").click(function () {
            $(".gwc_tb2 input[name=newslist]").each(function () {
                if ($(this).prop("checked")) {
                    $(this).prop("checked",false);

                } else {
                    $(this).prop("checked",true);

                }
            });
            GetCount();
        });

        $(document).on("click",".addNum",function (){
            var num = $(this).prev().val();
            num++;
            var price = $(this).parent().prev().find(".singlePrice").html();
            var total = num*price;

            $(this).prev().val(num);
            $(this).parent().next().find(".totalPrice").html(total.toFixed(2));
            var finalPrice = 0;
            var count = 0;
            $(".gwc_tb2 input[name=newslist]").each(function () {
                if ($(this).prop("checked")) {
                    var price = $(this).parents("tr").find(".totalPrice").html();
                    finalPrice += parseFloat(price);
                    count++;
                }
            })
            $("#zong1").empty();
            $("#zong1").html(finalPrice.toFixed(2));
            $("#shuliang").html(count);
        })

        $(document).on("click",".subNum",function (){
            var num = $(this).next().val();
            if(num==1){
                alert("至少选择一件");
                return;
            }
            num--;
            var price = $(this).parent().prev().find(".singlePrice").html();
            var total = num*price;

            $(this).parent().next().find(".totalPrice").html(total.toFixed(2));
            $(this).next().val(num);
            var finalPrice = 0;
            var count = 0;
            $(".gwc_tb2 input[name=newslist]").each(function () {
                if ($(this).prop("checked")) {
                    var price = $(this).parents("tr").find(".totalPrice").html();
                    finalPrice += parseFloat(price);
                    count++;
                }
            })
            $("#zong1").empty();
            $("#zong1").html(finalPrice.toFixed(2));
            $("#shuliang").html(count);

        })

        $(document).on("click",".delcart1",function (){
            if(confirm("确认删除？")){
                var shoppingCarId = $(this).data("id");
                $.get("${path}/userCenter/shoppingCar/delete",{shoppingCarId:shoppingCarId},function (data){
                    if(data=="ok"){
                        $(this).parent().parent().remove();
                        location.reload();
                    }
                    else{
                        alert("删除失败");
                    }
                }).bind(this)
            }

        })


        $(document).on("click",".gwc_tb2 input[name=newslist]",function (){
            var finalPrice = 0;
            var count = 0;
            $(".gwc_tb2 input[name=newslist]").each(function () {
                if ($(this).prop("checked")) {
                    var price = $(this).parents("tr").find(".totalPrice").html();
                    finalPrice += parseFloat(price);
                    count++;
                }
            })
            $("#zong1").html(finalPrice.toFixed(2));
            $("#shuliang").html(count);
            $("#jz1").css("display", "none");
            $("#jz2").css("display", "block");

    })

        $("#jz2").click(function (){
            var merchantId = ${requestScope.merchant.id};
            var total = $("#zong1").html();
            var str = "&total="+total+"&merchantId="+merchantId;
            $(".gwc_tb2 input[name=newslist]").each(function (){
                if($(this).prop("checked")){
                    var productId = $(this).data("id");
                    var num = $(this).parents("tr").find("#text_box1").val();
                    var shoppingCar = $(this).data("shopping");
                    str+="&productId="+productId+"&num="+num+"&shoppingCar="+shoppingCar;
                }

            })
            location.href="${path}/userCenter/orders/confirmOrders?"+str;
        })



    })

    function GetCount() {
        var finalPrice = 0;
        var aa = 0;
        $(".gwc_tb2 input[name=newslist]").each(function () {
            if ($(this).prop("checked")) {
                var price = $(this).parents("tr").find(".totalPrice").html();
                console.log(price)
                finalPrice += parseFloat(price);
                aa++;
                }

        });
        $("#shuliang").html(aa);
        $("#zong1").html((finalPrice).toFixed(2));
        $("#jz1").css("display", "none");
        $("#jz2").css("display", "block");
    }


</script>