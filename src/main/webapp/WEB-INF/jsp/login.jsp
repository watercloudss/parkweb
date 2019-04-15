<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
            + path + "/";
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

    <!-- 引入表单校验jquery插件 -->
    <script src="<%=basePath%>js/jquery.validate.min.js"
            type="text/javascript"></script>

    <!-- 最新的 Bootstrap 核心 JavaScript 文件 -->
    <script
            src="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="<%=basePath%>css/login.css" type="text/css">
    <title>登录页面</title>
</head>
<body>

<!--导航栏开始-->
<div class="container-fluid">
    <nav class="navbar navbar-default navbar-fixed-top " role="navigation">
        <div class="container">
            <div class="navbar-header"
                 style="margin-top: 5px; margin-right: 30px">
                <a href="#"><img style="height: 40px; width: 40px" title="点击跳转"
                                 src="images/logo-max.png"></a> <span class="logo-text">停车场收费系统</span>
            </div>

        </div>
    </nav>
</div>

<!--主体信息开始-->
<div class="container-fluid main">
    <div class="container">
        <!--左方logo开始-->
        <div class="col-md-6 maxlogotext">
            <img style="width: 300px" src="images/logo-max.png">
            <h3>让我来帮助您更高效的工作！</h3>
        </div>
        <!--右方输入框开始-->
        <div class="col-md-6 right">
            <div class="form-location">
                <form class="form-horizontal"
                      action="${pageContext.request.contextPath }/login.action"
                      method="post" id="myform">
                    <div style="margin-left: 80px">
                        <font color="red"> <span id="message">${msg}</span>
                        </font>
                    </div>
                    <div class="form-group">
                        <label for="username" class="col-sm-2 control-label">用户名:</label>
                        <div class="col-sm-6">
                            <input type="text" class="form-control" id="username"
                                   name="username" placeholder="请输入用户名" style="background-color:transparent">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="inputPassword3" class="col-sm-2 control-label">密&nbsp;&nbsp;&nbsp;码:</label>
                        <div class="col-sm-6">
                            <input type="password" class="form-control" id="inputPassword"
                                   name="password" placeholder="请输入密码" style="background-color:transparent">
                        </div>
                    </div>
                    <!--验证码-->
                    <div class="form-group">
                        <label for="inputPassword3" class="col-sm-2 control-label">验证码:</label>
                        <div class="col-sm-4">
                            <input type="text" class="form-control" id="input" name="input"
                                   placeholder="区分大小写" style="background-color:transparent"><span class="test"></span>
                        </div>
                        <div class="col-sm-3 canvasBox">
                            <div class="imgBox">
                                <canvas id="myCanvas" width=100 height=30></canvas>
                            </div>
                            <input type="button" class="refresh">
                        </div>
                    </div>

                    <div class="form-group">
                        <div class="col-sm-offset-2 col-sm-10">
                            <input type="submit" value="登录" name="submit" class="btn">
                            <span class="forget"><a id="forgetPassword">忘记密码？</a></span>
                        </div>

                    </div>

                </form>
            </div>
        </div>
    </div>
</div>
<%@ include file="bottomModel.jsp" %>
<script src="js/login.js"></script>
</body>
</html>
