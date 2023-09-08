<%--
  Created by IntelliJ IDEA.
  User: lbp
  Date: 2023/6/5
  Time: 10:56
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"></c:set>
<div class="sidebar-wrap">
    <div class="sidebar-title">
        <h1>菜单</h1>
    </div>
    <div class="sidebar-content">
        <ul class="sidebar-list">
            <li>
                <a href="#"><i class="icon-font">&#xe003;</i>常用操作</a>
                <ul class="sub-menu">
                    <li><a href="${path}/manage/merchant/list"><i class="icon-font">&#xe008;</i>商家管理</a></li>
                    <li><a href="${path}/manage/rider/list"><i class="icon-font">&#xe005;</i>骑手管理</a></li>
                    <li><a href="${path}/manage/user/list"><i class="icon-font">&#xe006;</i>用户管理</a></li>
                    <li><a href="${path}/manage/orders/list"><i class="icon-font">&#xe004;</i>订单管理</a></li>
                    <li><a href="${path}/static/weekEChart"><i class="icon-font">&#xe012;</i>周交易量展示</a></li>
                    <li><a href="${path}/static/monthEChart"><i class="icon-font">&#xe052;</i>当月日活度量</a></li>
                    <li><a href="${path}/manage/manager/list"><i class="icon-font" id="manage">&#xe033;</i>管理员管理</a></li>
                </ul>
            </li>
            <li>
                <a href="#"><i class="icon-font">&#xe018;</i>系统管理</a>
                <ul class="sub-menu">
                    <li><a href="#"><i class="icon-font">&#xe017;</i>系统设置</a></li>
                    <li><a href="#"><i class="icon-font">&#xe037;</i>清理缓存</a></li>
                    <li><a href="#"><i class="icon-font">&#xe046;</i>数据备份</a></li>
                    <li><a href="#"><i class="icon-font">&#xe045;</i>数据还原</a></li>
                </ul>
            </li>
        </ul>
    </div>
</div>

