<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
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
    <!-- jQuery文件。务必在bootstrap.min.js 之前引入 -->
    <script src="https://cdn.staticfile.org/jquery/2.1.1/jquery.min.js"></script>
    <!-- 最新版本的 Bootstrap 核心 CSS 文件 -->
    <!-- 新 Bootstrap 核心 CSS 文件 -->
    <link href="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
    <script src="<%=basePath%>js/jquery.validate.min.js"
            type="text/javascript"></script>
    <!-- 最新的 Bootstrap 核心 JavaScript 文件 -->
    <script src="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>

    <!-- 样式文件 -->
    <link rel="stylesheet" href="./umeditor/themes/default/css/umeditor.css">

    <!-- 引入 etpl
    <script type="text/javascript" src="./third-party/template.min.js"></script>-->
    <!-- 配置文件 -->
    <script type="text/javascript" src="./umeditor/umeditor.config.js"></script>
    <!-- 编辑器源码文件 -->
    <script type="text/javascript" src="./umeditor/umeditor.js"></script>
    <!-- 语言包文件 -->
    <script type="text/javascript" src="./umeditor/lang/zh-cn/zh-cn.js"></script>

    <!-- 实例化编辑器代码 -->
    <script type="text/javascript">
        $(function() {
            window.um = UM.getEditor('container', {
                /* 传入配置参数,可配参数列表看umeditor.config.js */
                toolbar:[
                    'undo redo | bold italic underline strikethrough | forecolor backcolor | removeformat |',
                    '| justifyleft justifycenter justifyright justifyjustify |',
                    'emotion'
                ]
            });
        });
    </script>
    <title>发布公告</title>
    <style type="text/css">
        .four {
            margin-top:5px;
            padding-top: 10px;
            padding-bottom: 7px;
            border: 1px solid #d3d3d3;
            border-radius: 30px;
            background: #d9edf7;
            font-weight: bold;
            color: #37a;
        }

        .timeAndName {
            font-size: 9px;
        }

        .message-title {
            margin-left: 30px;
        }

        .message-content {
            margin-left: 30px;
            margin-right: 30px;
        }

        .welcome {
            padding: 10px 50px;
            border-radius: 30px;
            margin-top: 80px;
            color: #37a;
            background: #d3d3d3;
            margin-bottom: 10px;
            text-align: center;
        }
        .error{
            color:red;
        }
        .icon{
            height:15px;
            width: 15px;
        }
        .icon-text {
            margin-left: 5px;
            font-size: 12px;
        }
    </style>
    <script type="text/javascript">
        function submitText(){
            $("#myModalMessage").modal('show');
            var text=um.getContent();
            $("#myModalMessagegform").validate(
                {
                    rules : {
                        "messageTitle" : {
                            "required" : true
                        }
                    },
                    messages : {
                        "messageTitle" : {
                            "required" : "标题不能为空"
                        }
                    },
                    submitHandler : function(form) {
                        $.ajax({
                            async : false,
                            url : "${pageContext.request.contextPath}/addMessage.action",
                            data : {
                                "title":$("#messageTitle").val(),
                                "content":text
                            },
                            type : "POST",
                            success : function(data) {
                                $("#myModalMessage").modal('hide');
                                window.location.reload();
                            },
                            fail : function(e) {
                                alert("error");
                            },
                            error : function(e) {
                                alert("error");
                            }
                        })
                    }
                })
        }
        function deleteMessage(id){
            $.ajax({
                async : false,
                url : "${pageContext.request.contextPath}/deleteMessage.action",
                data : {
                    "id":id
                },
                type : "POST",
                success : function(data) {
                    if(data=="OK"){
                        alert("删除成功")
                    }
                    window.location.reload();
                },
                fail : function(e) {
                    alert("error");
                },
                error : function(e) {
                    alert("error");
                }
            })
        }
    </script>
</head>
<body>
<!--导航栏开始-->

<c:import url="navbarModel.jsp"></c:import>
<!--标题-->
<div class="container">
    <div class="row">
        <div class="col-md-12 column">
            <div class="welcome">
                <h2>编辑公告</h2>
            </div>
        </div>
    </div>
</div>
<!--编辑器-->
<div class="container" style="margin-left: 380px;">
    <script id="container"  type="text/plain" style="width: 600px; height: 200px;">输入公告内容.....</script>
    <button style="background:#f40;color:white;" onclick="submitText()">提交</button>
        </div>
        <!--公告信息展示模块-->
        <div class="container" style="text-align: center">
        <h4 style="border-radius: 10px;background: #71b3f7;color:white">公告</h4>
        </div>
        <c:forEach items="${ml}" var="m">
        <div class="container four">
        <div style="text-align: center;">
        <h4 class="message-title" style="font-weight: bold;">${m.title}<span
    class="timeAndName">&emsp;&emsp;${m.user.name}&emsp;&emsp;</span><span
    class="timeAndName"><fmt:formatDate value="${m.creatTime}"
							pattern="yyyy-MM-dd HH-mm" /></span>&emsp;&emsp;<a  style="color:#f40;font-size:6px;" onclick="deleteMessage(${m.id})">删除</a>
    </h4>
    </div>
    ${m.content}
    </div>
    </c:forEach>
    <c:import url="bottomModel.jsp"></c:import>

    <!--模态框-->
    <div class="modal fade" id="myModalMessage" tabindex="-1" role="dialog"
    aria-labelledby="myModalLabel">
        <div class="modal-dialog" role="document">
        <div class="modal-content">
        <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal"
    aria-label="Close">
        <span aria-hidden="true">&times;</span>
    </button>
    <h4 class="modal-title" id="myModalLabel">输入标题</h4>
        </div>
        <div class="modal-body">
        <form class="form-horizontal" id="myModalMessagegform">
        <div class="form-group">
        <label for="car_num" class="col-sm-3 control-label">标题</label>
        <div class="col-sm-4">
        <input type="text" class="form-control" id="messageTitle"
    placeholder="输入公告标题" name="messageTitle" />
        </div>
        </div>

        <div class="modal-footer">
        <button type="button" class="btn btn-default"
    data-dismiss="modal">关闭</button>
        <button type="submit" class="btn btn-primary" id="parkcar">确定</button>
        </div>
        </form>
        </div>

        </div>
        </div>
        </div>
        </body>
        </html>