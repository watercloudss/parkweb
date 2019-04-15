<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
    <title>车库列表</title>
    <style>
        .col-md-3 {
            border-radius: 25px;
            color: #fff;
            text-align: center;
            padding-bottom: 50px;
        }

        .col-md-3 img {
            margin-top: 30px;
        }

        .two {
            padding-top: 50px;
            padding-bottom: 50px;
            border: 1px solid #d3d3d3;
            border-radius: 30px
        }

        .welcome {
            padding: 10px 50px;
            border-radius: 30px;
            margin-top: 80px;
            color: #37a;
            background: #d3d3d3;
            margin-bottom: 10px;
        }

        .icon {
            height: 15px;
            width: 15 px；
        }

        .icon-text {
            margin-left: 5px;
            font-size: 12px;
        }

        .error {
            color: #f40;
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
                <h2>车库信息管理</h2>
            </div>
        </div>
    </div>

    <div class="row">
        <div class="panel panel-success">
            <!-- Default panel contents -->
            <div class="panel-heading">
                <div style="margin-bottom: 20px">
                    <button type="button" class="btn btn-danger"
                            style="background: #f40" data-toggle="modal"
                            data-target="#myModalAddCarStation">添加车库
                    </button>
                </div>
                <table class="table">
                    <tr>
                        <td>#</td>
                        <td>名称</td>
                        <td>位置</td>
                        <td>描述</td>
                        <td>车位总数</td>
                        <td>车位价格</td>
                        <td>操作</td>
                    </tr>
                    <c:forEach items="${cList}" var="csn" varStatus="id">
                        <tr>
                            <td>${id.count}</td>
                            <td>${csn.c_name}</td>
                            <td>${csn.c_location}</td>
                            <td>${csn.c_description}</td>
                            <td>${csn.c_total}</td>
                            <td>${csn.c_price}元&nbsp;/&nbsp;${csn.c_pricetime}小时</td>
                            <td><a href="<%=basePath%>details.action?id=${csn.c_id}">
                                <button
                                        type="button"
                                        style="background: 37a; height: 25px; width: 40px; border-radius: 5px; background: #4cae4c; color: white; font-size: 8px">
                                    详情
                                </button>
                            </a>
                                <button id="deleteUser" type="button"
                                        onclick="deleteCarStation(${csn.c_id})"
                                        style="background: 37a; height: 25px; width: 40px; border-radius: 5px; background: #f40; color: white; font-size: 8px">
                                    删除
                                </button>
                            </td>
                        </tr>
                    </c:forEach>
                </table>
            </div>
        </div>
    </div>
</div>
<div class="modal fade" id="myModalAddCarStation" tabindex="-1"
     role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"
                        aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title" id="myModalLabel">添加车库</h4>
            </div>

            <div class="modal-body">
                <div class="form-group">
                    <p style="color: red; font-size: 5px">
                        *注意：车位的默认名称为"车库名+数字"，例如"A1--1"。车位"位置"默认为空。车位类型默认为"小车位"。(车库和车位信息可点击"详情"，跳转后查看和修改)</p>
                </div>
                <form class="form-horizontal" id="edit_carstationInfo">
                    <div class="form-group">
                        <label for="edit_name" class="col-sm-2 control-label">名称</label>
                        <div class="col-sm-6">
                            <input type="text" class="form-control" id="edit_name"
                                   placeholder="输入车库的名称" name="name"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="edit_location" class="col-sm-2 control-label">位置</label>
                        <div class="col-sm-6">
                            <input type="text" class="form-control" id="edit_location"
                                   placeholder="输入车库的位置  " name="location"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="edit_descroption" class="col-sm-2 control-label">描述</label>
                        <div class="col-sm-8">
                            <input type="text" class="form-control" id="edit_description"
                                   placeholder="输入车库描述(可以不填)  " name="description"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="edit_total" class="col-sm-2 control-label">车位总数</label>
                        <div class="col-sm-3">
                            <input type="text" class="form-control" id="edit_total"
                                   placeholder="输入车位数量" name="total"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="edit_price" class="col-sm-2 control-label">车位价格</label>
                        <div class="col-sm-2">
                            <input type="text" class="form-control" id="edit_price"
                                   placeholder="价格" name="price"/>
                        </div>
                        <div class="col-sm-2">元/每</div>
                        <div class="col-sm-2">
                            <input type="text" class="form-control" id="edit_time"
                                   placeholder="时间" name="time"/>
                        </div>
                        小时
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default"
                                data-dismiss="modal">关闭
                        </button>
                        <button type="submit" class="btn btn-primary" id="add">添加</button>
                    </div>
                </form>
            </div>

        </div>
    </div>
</div>
<c:import url="bottomModel.jsp"></c:import>
<script type="text/javascript">
    function deleteCarStation(id) {
        if (confirm('确定要删除该用户吗?')) {
            $.ajax({
                async: false,
                url: "${pageContext.request.contextPath}/deleteCarStation.action",
                type: "POST",
                data: {
                    "id": id
                },
                success: function (data) {
                    if (data == "OK") {
                        alert("删除成功！");
                        window.location.reload();
                    } else {
                        alert("删除失败！")
                    }
                },
                fail: function (e) {
                    alert("fail");
                },
                error: function (e) {
                    alert("error");
                }
            })
        }
    }

    $(function () {
        $("#edit_carstationInfo").validate({
            rules: {
                "name": {
                    "required": true,
                    "rangelength": [2, 12],
                },
                "location": {
                    "required": true,
                },
                "total": {
                    "required": true,
                    "digits": true
                },
                "price": {
                    "required": true,
                    "number": true,
                    "min": 0.01
                },
                "time": {
                    "required": true,
                    "number": true,
                    "min": 0.01
                }
            },
            messages: {
                "name": {
                    "required": "车库名称不能为空",
                    "rangelength": "车库名称长度为2-12位",
                },
                "location": {
                    "required": "位置描述不能为空"
                },
                "total": {
                    "required": "车位总数不能为空",
                    "digits": "车位总数为整数"
                },
                "price": {
                    "required": "价格不能为空",
                    "number": "价格为整数或小数",
                    "min": "最小为0.01"
                },
                "time": {
                    "required": "时间不能为空",
                    "number": "时间为整数或小数",
                    "min": "最小为0.01"
                }
            },
            submitHandler: function (form) {
                if (confirm('确定要提交已编辑的信息吗?')) {
                    $.ajax({
                        async: false,
                        url: "${pageContext.request.contextPath}/addCarStation.action",
                        data: {
                            "name": $("#edit_name").val(),
                            "location": $("#edit_location").val(),
                            "description": $("#edit_description").val(),
                            "total": $("#edit_total").val(),
                            "price": $("#edit_price").val(),
                            "time": $("#edit_time").val()
                        },
                        type: "POST",
                        success: function (data) {
                            if (data == "OK") {
                                alert("添加车库成功！");
                                window.location.reload();
                            } else {
                                alert("添加车库失败！")
                            }
                            $("#myModalAddCarStation").modal('hide');
                        },
                        fail: function (e) {
                            alert("fail");
                        },
                        error: function (e) {
                            alert("error");
                        }
                    })
                }
            }
        })
    })
</script>
</body>
</html>