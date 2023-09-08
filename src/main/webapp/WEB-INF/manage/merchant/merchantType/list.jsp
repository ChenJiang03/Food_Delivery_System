<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"></c:set>
<html>
<head>
    <title>店铺类型列表</title>
    <script type="text/javascript" src="${path}/webConfig/js/jquery-3.6.4.min.js"></script>
    <script type="text/javascript">
      $(function (){
        //删除
        $(".del").click(function (){
          if(confirm("是否确认删除?")){
            var id=$(this).data("id");
            var that=this;
            $.ajax({
              url:"${path}/manage/merchant/merchantType/delete",
              type:"post",
              data:{id:id},
              success:function(data){
                if(data=="yes"){
                  $(that).parents("tr").remove();
                }
              }
            });
          }
        });
      });
    </script>
</head>
<body>
<jsp:include page="/manageConfig/inc/top.jsp"></jsp:include>
<div class="container clearfix">
  <jsp:include page="/manageConfig/inc/left.jsp"></jsp:include>
  <!--/sidebar-->
  <div class="main-wrap">

    <div class="crumb-wrap">
      <div class="crumb-list"><i class="icon-font"></i><a href="${path}/manage">首页</a><span class="crumb-step">&gt;</span><span class="crumb-name">作品管理</span></div>
    </div>
    <div class="search-wrap">
      <div class="search-content">

      </div>
    </div>
    <div class="result-wrap">
      <form name="myform" id="myform" method="post">
        <div class="result-title">
          <div class="result-list">
            <a href="${path}/manage/merchant/list">商家列表</a>
            <a href="${path}/manage/merchant/merchantType/add"><i class="icon-font"></i>新增店铺类型</a>
            <a id="batchDel" href="javascript:void(0)" data-type="merchant" data-path="${path}"><i class="icon-font"></i>批量删除</a>
            <a id="updateOrd" href="javascript:void(0)"><i class="icon-font"></i>更新排序</a>
          </div>
        </div>
        <div class="result-content">
          <table class="result-tab" width="100%">
            <tr>
              <th class="tc" width="5%"><input class="allChoose" name="" type="checkbox"></th>
              <th>ID</th>
              <th>标题</th>
              <th>简介</th>
              <th>操作</th>
            </tr>



            <c:forEach var="mt" items="${requestScope.merchantTypeList}">
              <tr id="tr_${mt.id}">
                <td class="tc"><input name="id[]" data-id="${mt.id}" class="check" value="59" type="checkbox"></td>
                <td>${mt.id}</td>
                <td>${mt.type}</td>
                <td>${mt.description}</td>
                <td>
                  <a class="link-update" href="${path}/manage/merchant/merchantType/update?id=${mt.id}">修改</a>
                  <a class="del" data-id="${mt.id}">删除</a>
                </td>
              </tr>

            </c:forEach>

          </table>
          <div class="list-page">
            <c:set var="page" value="${requestScope.pageUtils}"></c:set>
            ${page.pageNum}/${page.pageCount}页 ${page.dataCount}条
            <c:forEach begin="0" end="${page.pageCount-1<0?0:page.pageCount-1}" varStatus="stat">
              <a href="${path}/manage/merchant/merchantType/list?pageNum=${stat.count}" class="${stat.count eq page.pageNum?'current':''}">${stat.count}</a>
            </c:forEach>
          </div>
        </div>
      </form>
    </div>
  </div>
  <!--/main-->
</div>
</body>
</html>
