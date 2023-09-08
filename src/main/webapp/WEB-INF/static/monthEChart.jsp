<%--
  Created by IntelliJ IDEA.
  User: lbp
  Date: 2023/7/9
  Time: 19:52
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"></c:set>

<html>
<head>
    <title>当月日活度</title>
    <style>
        #main1 {
            margin-left: 50px;
            padding-top: 20px;
            width: 90%;
            height: 85%;
        }
    </style>
</head>
<body>
<jsp:include page="/manageConfig/inc/top.jsp"></jsp:include>
<div class="container clearfix">
    <jsp:include page="/manageConfig/inc/left.jsp"></jsp:include>
    <div class="main-wrap">
        <div id="main1"></div>
    </div>
</div>
</body>
<script type="text/javascript" src="https://fastly.jsdelivr.net/npm/echarts@5.4.2/dist/echarts.min.js"></script>
<script type="text/javascript">
    var dom = document.getElementById('main1');
    var myChart = echarts.init(dom, null, {
        renderer: 'canvas',
        useDirtyRect: false
    });
    var app = {};

    var option;

    // This example requires ECharts v5.4.0 or later
    const cellSize = [80, 80];
    const pieRadius = 30;
    function getVirtualData() {
        const date = +echarts.time.parse('2017-02-01');
        const end = +echarts.time.parse('2017-03-01');
        const dayTime = 3600 * 24 * 1000;
        const data = [];
        for (let time = date; time < end; time += dayTime) {
            data.push([
                echarts.time.format(time, '{yyyy}-{MM}-{dd}', false),
                Math.floor(Math.random() * 10000)
            ]);
        }
        return data;
    }
    const scatterData = getVirtualData();
    const pieSeries = scatterData.map(function (item, index) {
        return {
            type: 'pie',
            id: 'pie-' + index,
            center: item[0],
            radius: pieRadius,
            coordinateSystem: 'calendar',
            label: {
                formatter: '{c}',
                position: 'inside'
            },
            data: [
                { name: '商家', value: Math.round(Math.random() * 24) },
                { name: '骑手', value: Math.round(Math.random() * 24) },
                { name: '用户', value: Math.round(Math.random() * 24) }
            ]
        };
    });
    option = {
        tooltip: {},
        legend: {
            data: ['商家', '骑手', '用户'],
            bottom: 20
        },
        calendar: {
            top: 'middle',
            left: 'center',
            orient: 'vertical',
            cellSize: cellSize,
            yearLabel: {
                show: false,
                fontSize: 30
            },
            dayLabel: {
                margin: 20,
                firstDay: 1,
                nameMap: ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun']
            },
            monthLabel: {
                show: false
            },
            range: ['2017-02']
        },
        series: [
            {
                id: 'label',
                type: 'scatter',
                coordinateSystem: 'calendar',
                symbolSize: 0,
                label: {
                    show: true,
                    formatter: function (params) {
                        return echarts.time.format(params.value[0], '{dd}', false);
                    },
                    offset: [-cellSize[0] / 2 + 10, -cellSize[1] / 2 + 10],
                    fontSize: 14
                },
                data: scatterData
            },
            ...pieSeries
        ]
    };

    if (option && typeof option === 'object') {
        myChart.setOption(option);
    }
    window.addEventListener('resize', myChart.resize);
</script>
</html>
