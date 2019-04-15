<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
            + path + "/";
    String userImg = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
            + "/";
%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta name="viewport" content="width=device-width, initial-scale=0">
    <!-- 最新版本的 Bootstrap 核心 CSS 文件 -->
    <!-- 新 Bootstrap 核心 CSS 文件 -->
    <link
            href="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/css/bootstrap.min.css"
            rel="stylesheet">

    <!-- jQuery文件。务必在bootstrap.min.js 之前引入 -->
    <script src="https://cdn.staticfile.org/jquery/2.1.1/jquery.min.js"></script>
    <script src="<%=basePath%>js/jquery.validate.min.js"
            type="text/javascript"></script>
    <!-- 最新的 Bootstrap 核心 JavaScript 文件 -->
    <script
            src="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="<%=basePath%>css/userSetting.css"
          type="text/css">
    <title>今日工作</title>
    <style type="text/css">
        .welcome {
            padding: 10px 50px;
            border-radius: 30px;
            margin-top: 80px;
            color: #37a;
            background: #d3d3d3;
            margin-bottom: 10px;
        }
    </style>
</head>
<body>
<!--导航栏开始-->
<c:import url="navbarModel.jsp"></c:import>


<div class="container">
    <div class="row">
        <div class="col-md-12 column">
            <div class="welcome">
                <h2>今日工作很棒！继续加油哦！</h2>
            </div>
        </div>
    </div>
    <div class="container main"
         style="margin-top: 10px; height: 450px; background: #dff0d8">
        <div class="row">
            <table class="table table-striped">
                <tr style="background: #dff0d8">
                    <td>#</td>
                    <td>车牌号</td>
                    <td>开始时间</td>
                    <td>结束时间</td>
                    <td>停车时长</td>
                    <td>总价</td>
                </tr>
                <c:forEach items="${coList}" var="o" varStatus="id">
                    <tr>
                        <td>${id.count}</td>
                        <td>${o.province}·${o.carNumber}</td>
                        <td><fmt:formatDate value="${o.startTime}"
                                            pattern="yyyy-MM-dd HH-mm"/></td>
                        <td><fmt:formatDate value="${o.endTime}"
                                            pattern="yyyy-MM-dd HH-mm"/></td>
                        <td>${o.time}小时</td>
                        <td>${o.cost}元</td>
                    </tr>
                </c:forEach>
                <tr style="background: #dff0d8">
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td>总数量：<span style="color: #f40">${count}辆</span></td>
                    <td>总数额：<span style="color: #f40">￥${cost}元</span></td>
                </tr>
            </table>
        </div>

    </div>
</div>
<c:import url="bottomModel.jsp"></c:import>
</body>
</html>