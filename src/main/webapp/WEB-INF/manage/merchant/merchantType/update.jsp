<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"></c:set>
<html>
<head>
    <title>修改产品类型</title>
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
                <form action="${path}/manage/merchant/merchantType/update" method="post" id="myform" name="myform" enctype="multipart/form-data">
                    <input type="hidden" name="id" value="${requestScope.merchantType.id}">
                    <table class="insert-tab" width="100%">
                        <tbody>
                        <tr>
                            <th><i class="require-red">*</i>店铺类型名称：</th>
                            <td>
                                <input class="common-text required" id="type" name="type" size="50" value="${requestScope.merchantType.type}" type="text">
                            </td>
                        </tr>
                        <tr>
                            <th>简介：</th>
                            <td><textarea name="description" class="common-textarea" id="description" cols="30" style="width: 98%;" rows="10">${requestScope.merchantType.description}</textarea></td>
                        </tr>
                        <tr>
                            <th></th>
                            <td>
                                <input class="btn btn-primary btn6 mr10" value="提交" type="submit">
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
