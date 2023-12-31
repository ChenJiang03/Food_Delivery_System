<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"></c:set>

<footer>
    <section class="Otherlink">
        <aside>
            <div class="ewm-left">
                <p>手机扫描二维码：</p>
                <img src="${path}/webConfig/images/Android_ico_d.gif">
                <img src="${path}/webConfig/images/iphone_ico_d.gif">
            </div>
            <div class="tips">
                <p>客服热线</p>
                <p><i>1830927**73</i></p>
                <p>配送时间</p>
                <p><time>09：00</time>~<time>22:00</time></p>
                <p>网站公告</p>
            </div>
        </aside>
        <section>
            <div>
                <span><i class="i1"></i>配送支付</span>
                <ul>
                    <li><a href="${path}/static/pay" target="_blank" title="标题">支付方式</a></li>
                    <li><a href="${path}/static/way" target="_blank" title="标题">配送方式</a></li>
                    <li><a href="${path}/static/money" target="_blank" title="标题">配送费用</a></li>
                    <li><a href="${path}/static/money" target="_blank" title="标题">服务费用</a></li>
                </ul>
            </div>
            <div>
                <span><i class="i2"></i>关于我们</span>
                <ul>
                    <li><a href="${path}/static/job" target="_blank" title="标题">招贤纳士</a></li>
                    <li><a href="${path}/static/about" target="_blank" title="标题">网站介绍</a></li>
                    <li><a href="${path}/static/speed" target="_blank" title="标题">配送效率</a></li>
                    <li><a href="${path}/Merchant/register" target="_blank" title="标题">商家加盟</a></li>
                </ul>
            </div>
            <div>
                <span><i class="i3"></i>帮助中心</span>
                <ul>
                    <li><a href="${path}/static/service" target="_blank" title="标题">服务内容</a></li>
                    <li><a href="${path}/static/service" target="_blank" title="标题">服务介绍</a></li>
                    <li><a href="${path}/static/question" target="_blank" title="标题">常见问题</a></li>
                    <li><a href="${path}/static/map" target="_blank" title="标题">网站地图</a></li>
                </ul>
            </div>
        </section>
    </section>
    <div class="copyright">© 版权所有 2020</div>
</footer>