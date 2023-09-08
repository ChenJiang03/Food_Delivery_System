<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set value="${pageContext.request.contextPath}" var="path"></c:set>
<html>
<head>
    <meta charset="utf-8" />
    <meta name="author" content="order by dede58.com"/>
    <title>确认订单</title>
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
    <style>
        *{
            padding: 0;
            margin: 0;
        }
        .addressList{
            width: 1200px;
            overflow: hidden;
        }
        .addressList .cur{
            border-color: #f40 !important;
        }
        .addressList .address{
            float: left;
            width:260px;
            height: 100px;
            margin: 10px;
            padding: 10px;
            border: #ccc solid 2px;
            cursor: pointer;
        }
        .addressList .address .detail{
            height: 40px;
        }
    </style>
</head>
<body>

<jsp:include page="/webConfig/inc/userTop.jsp"></jsp:include>
<!--Start content-->
<section class="Psection MT20" id="Cflow">
    <!--如果用户未添加收货地址，则显示如下-->
    <div class="confirm_addr_f">
        <span class="flow_title">收货地址：</span><a class="flow_title" href="${path}/userCenter/address/add">新增地址</a>
        <!--如果未添加地址，则显示此表单-->
<%--        <form class="add_address" action="#" style="display:none;">--%>
<%--            <p><i>收件人姓名：</i><input type="text" name="" required></p>--%>
<%--            <p>--%>
<%--                <i>选择所在地：</i>--%>
<%--                <select name="">--%>
<%--                    <option>陕西省</option>--%>
<%--                </select>--%>
<%--                <select name="">--%>
<%--                    <option>西安市</option>--%>
<%--                </select>--%>
<%--                <select name="">--%>
<%--                    <option>莲湖区</option>--%>
<%--                </select>--%>
<%--            </p>--%>
<%--            <p><i>街道地址：</i><input type="text" required size="50"></p>--%>
<%--            <p><i>邮政编码：</i><input type="text" required size="10" pattern="[0-9]{6}"></p>--%>
<%--            <p><i>手机号码：</i><input type="text" name="" required pattern="[0-9]{11}"></p>--%>
<%--            <p><i></i><input name="" type="submit" value="确定"></p>--%>
<%--        </form>--%>
        <!--已保存的地址列表-->
        <form action="${path}/userCenter/orders/submitOrders">
            <div class="addressList">
                <c:forEach items="${requestScope.addressList}" var="a">
                    <c:if test="${a.isDefault}">
                        <input type="hidden" value="${a.id}" name="addressId" id="addressId">
                    </c:if>
                    <div class="address ${a.isDefault?"cur":""}" data-id="${a.id}" data-district="${a.district.id}">
                        <div class="name">
                                ${a.province.name}${a.city.name} ${a.name}收
                        </div>
                        <hr>
                        <div class="detail">
                                ${a.district.name}${a.address}${a.phone}
                        </div>
                        <div class="update">
                            <a href="${path}/userCenter/address/update?id=${a.id}">修改</a>
                        </div>
                    </div>
                </c:forEach>
            </div>
        <!--add new address-->


<%--        <form action="#">--%>
<%--            <div id="light" class="O-L-content">--%>
<%--                <ul>--%>
<%--                    <li><span><label>选择所在地：</label></span><p><em>*</em><select name=""><option>陕西省</option></select> <select name=""><option>西安市</option></select> <select name=""><option>雁塔区</option></select></p></li>--%>
<%--                    <li><span><label>邮政编码：</label></span><p><em>*</em><input name="" type="text"  class="Y_N"  pattern="[0-9]{6}" required></p></li>--%>
<%--                    <li><span><label>街道地址：</label></span><p><em>*</em><textarea name="" cols="80" rows="5"></textarea></p></li>--%>
<%--                    <li><span><label>收件人姓名：</label></span><p><em>*</em><input name="" type="text"></p></li>--%>
<%--                    <li><span><label>手机号码：</label></span><p><em>*</em><input name="" type="text" pattern="[0-9]{11}" required></p></li>--%>
<%--                    <div class="button-a"><input type="button" value="确 定" class="C-button" /><a href = "javascript:void(0)" onclick = "document.getElementById('light').style.display='none';document.getElementById('fade').style.display='none'"><input name="" type="button" value="取 消"  class="Cancel-b"/></a></div>--%>

<%--                    <div class="close-botton"><a href = "javascript:void(0)" onclick = "document.getElementById('light').style.display='none';document.getElementById('fade').style.display='none'"></a></div>--%>
<%--                </ul>--%>
<%--            </div>--%>
<%--            <div id="fade" class="overlay"></div>--%>


<%--            <!--End add new address-->--%>
<%--        </form>--%>
    </div>
    <!--配送方式及支付，则显示如下-->
    <!--check order or add other information-->

    <c:forEach items="${requestScope.shoppingCarList}" var="shoppingCar">
        <input type="hidden" value="${shoppingCar.id}" name="shoppingCar">
    </c:forEach>
        <div class="inforlist">
            <span class="flow_title">商品清单</span>

            <table>
                <th>名称</th>
                <th>数量</th>
                <th>价格</th>
                <th>小计</th>


                <c:forEach items="${requestScope.productList}" var="p" varStatus="status">
                    <input type="hidden" value="${p.id}" name="productId">
                    <tr>
                        <td>${p.title}</td>
                        <td><input style="width:60px;height:30px;text-align:center;" type="text" value="${requestScope.num[status.index]}" name="num" readonly></td>
                        <td>${p.price}</td>
                        <td>￥${p.price*requestScope.num[status.index]}</td>
                    </tr>
                </c:forEach>
            </table>
<%--            <div class="Order_M">--%>
<%--                <p><em>订单附言:</em><input name=""  type="text"></p>--%>
<%--                <p><em>优惠券:</em>--%>
<%--                    <select name="">--%>
<%--                        <option>￥10元优惠券</option>--%>
<%--                    </select>--%>
<%--                </p>--%>
<%--            </div>--%>
            <div class="Sum_infor">
<%--                <p class="p1">配送费用：￥0.00+商品费用：￥177.00-优惠券：￥10.00</p>--%>
<%--    <input type="hidden" value="${requestScope.merchantId}" name="merchantId" id="merchantId">--%>
    <input type="hidden" value="${requestScope.total}" name="total" id="total">
    <input type="hidden" value="${requestScope.merchant.id}" name="merchantId">
                <p class="p2">合计：￥<span class="need">${requestScope.total}</span></p>

                <input type="submit" value="提交订单" class="p3button" id="submitOrders">
            </div>
        </div>
    </form>
    </div>
</section>
<%--<script>--%>
<%--    //Test code,You can delete this script /2014-9-21DeathGhost/--%>
<%--    $(document).ready(function(){--%>
<%--        var submitorder =$.noConflict();--%>
<%--        submitorder(".p3button").click(function(){--%>
<%--            submitorder("#Cflow").hide();--%>
<%--            submitorder("#Aflow").show();--%>
<%--        });--%>
<%--    });--%>
<%--</script>--%>
<%--<section class="Psection MT20 Textcenter" style="display:none;" id="Aflow">--%>
<%--    <!-- 订单提交成功后则显示如下 -->--%>
<%--    <p class="Font14 Lineheight35 FontW">恭喜你！订单提交成功！</p>--%>
<%--    <p class="Font14 Lineheight35 FontW">您的订单编号为：<span class="CorRed">201409205134</span></p>--%>
<%--    <p class="Font14 Lineheight35 FontW">共计金额：<span class="CorRed">￥359</span></p>--%>
<%--    <p><button type="button" class="Lineheight35"><a href="#" target="_blank">支付宝立即支付</a></button><button type="button" class="Lineheight35"><a href="user_center.html">进入用户中心</a></button></p>--%>
<%--</section>--%>
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
        $(".address").click(function (){
            $(".address").removeClass("cur");
            $(this).addClass("cur");
            var id=$(this).data("id");
            $("#addressId").val(id);
        });

        $("#submitOrders").click(function(){
            var userDistrict = $(".cur").data("district");
            var merchantId = ${requestScope.merchant.districtId};
            if(userDistrict!=merchantId){
                alert("地区相隔太远，重新选择");
                return false;
            }


        })
    })

</script>