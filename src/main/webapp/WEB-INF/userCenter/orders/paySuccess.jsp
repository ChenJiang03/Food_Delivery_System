<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2023/7/9
  Time: 10:26
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set value="${pageContext.request.contextPath}" var="path"></c:set>
<html>
<head>
    <title>支付成功</title>
</head>
<body>
支付成功
<a href="${path}/userCenter/list">继续购物</a>
</body>
</html>
