<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"></c:set>
<html>
<head>
    <meta charset="utf-8" />
    <meta name="author" content="order by dede58.com"/>
    <title>账户充值</title>
    <meta name="keywords" content="DeathGhost,DeathGhost.cn,web前端设,移动WebApp开发" />
    <meta name="description" content="DeathGhost.cn::H5 WEB前端设计开发!" />
    <meta name="author" content="DeathGhost"/>
    <link href="${path}/webConfig/style/style.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="${path}/webConfig/js/public.js"></script>
    <script type="text/javascript" src="${path}/webConfig/js/jquery.js"></script>
    <script type="text/javascript" src="${path}/webConfig/js/jqpublic.js"></script>
    <script type="text/javascript" src="${path}/webConfig/js/jquery-3.6.4.min.js"></script>
    <script type="text/javascript">
        $(function (){
            var re=true;
            $("#balance").change(function (){
                var val1=/^[0-9]{1,6}$/;
                var val2=$(this).val();
                if(!val1.test(val2)){
                    $("#balance1").html("请输入1-6位的金额(整数)")
                    re=false;
                }
                else {
                    $("#balance1").html("✔")
                    re=true;
                }
            });

            $("#tijiao").click(function (){
                if (re==false){
                    return false;
                }
            });

        })
    </script>
</head>
<body>
<jsp:include page="/webConfig/inc/merchantTop.jsp"></jsp:include>
<!--Start content-->
<section class="Psection MT20">
    <jsp:include page="/webConfig/inc/merchantLeft.jsp"></jsp:include>
    <article class="U-article Overflow">
        <!--"引用“user_page/user_index.html”"-->
        <section class="usercenter">
            <form action="${path}/MerchantCenter/recharge" id="myform" method="post">
                <input type="hidden" value="${sessionScope.merchant.id}" name="id">
                <table class="Register">
                    <tr>
                        <td>请输入充值金额:<input type="text"  name="balance" id="balance"><span id="balance1"></span></td>
                    </tr>
                    <tr>
                        <td><input type="submit" value="确认" id="tijiao"></td>
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
<jsp:include page="/webConfig/inc/merchantFoot.jsp"></jsp:include>
</body>
</html>
