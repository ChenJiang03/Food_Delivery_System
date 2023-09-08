<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"></c:set>
<!doctype html>
<html>
<head>
    <meta charset="UTF-8">
    <title>『丑团』后台管理</title>
    <link href="${path}/manageConfig/css/admin_login.css" rel="stylesheet" type="text/css"/>
</head>
<body>
<div class="admin_login_wrap">
    <h1>『丑团』后台管理</h1>
    <div class="adming_login_border">
        <div class="admin_input">
            <form action="${path}/manage/manager/managerLogin" method="post">
                <ul class="admin_items">
                    <li>
                        <label for="user">账号:</label>
                        <input type="text" name="username" placeholder="admin" id="user" size="40" class="admin_input_style"/>
                    </li>
                    <li>
                        <label for="pwd">密码:</label>
                        <input type="password" name="password" placeholder="password" id="pwd" size="40" class="admin_input_style" />
                    </li>
                    <li>
                        <input type="submit" tabindex="3" value="提交" class="btn btn-primary" />
                    </li>
                </ul>
            </form>
            <c:if test="${'error' eq requestScope.error}" var="flag">
                <p style="color: red">账户或密码错误！</p>
            </c:if>
        </div>
    </div>
</div>
</body>
</html>