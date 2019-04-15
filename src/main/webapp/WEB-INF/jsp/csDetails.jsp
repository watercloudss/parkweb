<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="itheima" uri="http://itheima.com/common/" %>
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
    <title>车库详情</title>
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
            font-size: 12px
        }

        .error {
            color: red
        }
    </style>
</head>
<body>
<!--导航栏开始-->
<c:import url="navbarModel.jsp"></c:import>

<!--主体信息开始-->
<div class="container">
    <div class="row">
        <div class="col-md-12 column">
            <div class="welcome">
                <h2>"${c.c_name}"&nbsp;车库车位管理</h2>
            </div>
        </div>
    </div>
    <div class="row">

        <div class="panel panel-success">
            <!-- Default panel contents -->
            <div class="panel-heading">
                <h4>${c.c_name}</h4>
                <p>
                    位置：${c.c_location}<br> 描述：${c.c_description}<br>
                    车位总数：${c.c_total}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;车位价格：${c.c_price}元/${c.c_pricetime}小时<br>
                    <br>
                    <button style="background: #00B51D; color: white"
                            data-toggle="modal" data-target="#myModalUpdate">修改车库信息
                    </button>
                    <button style="background: #f40; color: white" data-toggle="modal"
                            data-target="#myModalAddCarspace">添加车库车位
                    </button>
                </p>
            </div>
            <!-- Table -->
            <table class="table">
                <tr>
                    <td>#</td>
                    <td>名称</td>
                    <td>位置</td>
                    <td>价格</td>
                    <td>类型</td>
                    <td>状态</td>
                    <td>操作</td>
                </tr>
                <c:forEach items="${sList}" var="csp" varStatus="id">
                    <tr>
                        <td>${id.count}</td>
                        <td>${csp.s_name}</td>
                        <td>${csp.s_location}</td>
                        <td>${csp.s_price}元&nbsp;/&nbsp;${csp.s_pricetime}小时</td>
                        <c:choose>
                            <c:when test="${csp.s_type eq 1}">
                                <td>小车位</td>
                            </c:when>
                            <c:when test="${csp.s_type eq 2}">
                                <td>大车位</td>
                            </c:when>
                        </c:choose>
                        <c:if test="${csp.s_state eq 0}">
                            <td><span style="color: green; font-size: 8px">空闲</span></td>
                        </c:if>
                        <c:if test="${csp.s_state eq 1}">
                            <td><span style="color: red; font-size: 8px">有车</span></td>
                        </c:if>
                        <td>
                            <button
                                    onclick="carspaceInfo(${csp.s_id},'${csp.s_name}','${csp.s_location}',${csp.s_type},${csp.s_price},${csp.s_pricetime})"
                                    type="button"
                                    style="background: 37a; height: 25px; width: 40px; border-radius: 5px; background: #4cae4c; color: white; font-size: 8px">
                                修改
                            </button>
                            <button id="deleteCarspace"
                                    onclick="deleteCarspace(${csp.s_id},${c.c_id},${c.c_total})"
                                    type="button"
                                    style="background: 37a; height: 25px; width: 40px; border-radius: 5px; background: #f40; color: white; font-size: 8px">
                                删除
                            </button>
                        </td>
                    </tr>
                </c:forEach>
            </table>
        </div>
        <div class="col-md-7 text-right">
            <itheima:page url="${pageContext.request.contextPath }/details.action"/>
        </div>
    </div>
</div>
<c:import url="bottomModel.jsp"></c:import>
<script type="text/javascript">
    function carspaceInfo(sid, sname, slocation, stype, sprice, spricetime) {
        $("#carspace_id").val(sid);
        $("#carspace_name").val(sname);
        $("#carspace_location").val(slocation);
        if (stype == 1) {
            $("#min").attr("selected", true);
        } else {
            $("#max").attr("selected", true);
        }

        $("#carspace_price").val(sprice);
        $("#carspace_time").val(spricetime);
        $('#myModalCarspaceUpdate').modal('show');
    }

    function deleteCarspace(sid, cid, ctotal) {
        if (confirm('确定要删除该车位吗?')) {
            $.ajax({
                async: false,
                url: "${pageContext.request.contextPath}/deleteCarspace.action",
                type: "POST",
                data: {
                    "sid": sid,
                    "cid": cid,
                    "ctotal": ctotal
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

</script>
<!--添加车位-->
<div class="modal fade" id="myModalAddCarspace" tabindex="-1"
     role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"
                        aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title" id="myModalLabel">添加车位</h4>
            </div>

            <div class="modal-body">
                <form class="form-horizontal" id="add_carspaceInfo">
                    <div style="display: none">
                        <input id="carstation_id" value="${c.c_id}"/>
                    </div>
                    <div class="form-group">
                        <label for="add_name" class="col-sm-2 control-label">名称</label>
                        <div class="col-sm-6">
                            <input type="text" class="form-control" id="add_name"
                                   placeholder="输入车位名称" name="add_name"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="add_location" class="col-sm-2 control-label">位置</label>
                        <div class="col-sm-6">
                            <input type="text" class="form-control" id="add_location"
                                   placeholder="输入车位位置(可以不填)" name="add_location"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="add_price" class="col-sm-2 control-label">车位价格</label>
                        <div class="col-sm-2">
                            <input type="text" class="form-control" id="add_price"
                                   placeholder="价格" name="add_price"/>
                        </div>
                        <div class="col-sm-2">元/每</div>
                        <div class="col-sm-2">
                            <input type="text" class="form-control" id="add_time"
                                   placeholder="时间" name="add_time"/>
                        </div>
                        小时
                    </div>
                    <div class="form-group">
                        <label for="add_type" class="col-sm-2 control-label">车位类型</label>
                        <div class="col-sm-6">
                            <select class="form-control" id="add_type" name="add_type">
                                <option value="1">小车位</option>
                                <option value="2">大车位</option>
                            </select>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default"
                                data-dismiss="modal">关闭
                        </button>
                        <button type="submit" class="btn btn-primary" id="updatenfoBtn">添加</button>
                    </div>
                </form>
            </div>

        </div>
    </div>
</div>
<!--修改车位-->
<div class="modal fade" id="myModalCarspaceUpdate" tabindex="-1"
     role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"
                        aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title" id="myModalLabel">修改车位信息</h4>
            </div>

            <div class="modal-body">
                <form class="form-horizontal" id="edit_carspaceInfo">
                    <div style="display: none">
                        <input id="carspace_id"/>
                    </div>
                    <div class="form-group">
                        <label for="carspace_name" class="col-sm-2 control-label">名称</label>
                        <div class="col-sm-6">
                            <input type="text" class="form-control" id="carspace_name"
                                   name="carspace_name"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="carspace_location" class="col-sm-2 control-label">位置</label>
                        <div class="col-sm-6">
                            <input type="text" class="form-control" id="carspace_location"
                                   name="carspace_location"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="carspace_price" class="col-sm-2 control-label">车位价格</label>
                        <div class="col-sm-2">
                            <input type="text" class="form-control" id="carspace_price"
                                   name="carspace_price"/>
                        </div>
                        <div class="col-sm-2">元/每</div>
                        <div class="col-sm-2">
                            <input type="text" class="form-control" id="carspace_time"
                                   name="carspace_time"/>
                        </div>
                        小时
                    </div>
                    <div class="form-group">
                        <label for="edit_type" class="col-sm-2 control-label">车位类型</label>
                        <div class="col-sm-6">
                            <select class="form-control" id="carspace_type"
                                    name="carspace_type">
                                <option value="1" id="min">小车位</option>
                                <option value="2" id="max">大车位</option>
                            </select>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default"
                                data-dismiss="modal">关闭
                        </button>
                        <button type="submit" class="btn btn-primary" id="updatenfoBtn">修改</button>
                    </div>
                </form>
            </div>

        </div>
    </div>
</div>
<!--修改车库-->
<div class="modal fade" id="myModalUpdate" tabindex="-1" role="dialog"
     aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"
                        aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title" id="myModalLabel">修改车库信息</h4>
            </div>

            <div class="modal-body">
                <div class="form-group">
                    <p style="color: red; font-size: 5px">*注意：车位价格修改后，所有车位价格都将修改</p>
                </div>
                <form class="form-horizontal" id="edit_carstationInfo">
                    <div style="display: none">
                        <input value="${c.c_id}" id="edit_id"/>
                    </div>
                    <div class="form-group">
                        <label for="edit_name" class="col-sm-2 control-label">名称</label>
                        <div class="col-sm-6">
                            <input type="text" class="form-control" id="edit_name"
                                   value="${c.c_name}" name="name"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="edit_location" class="col-sm-2 control-label">位置</label>
                        <div class="col-sm-6">
                            <input type="text" class="form-control" id="edit_location"
                                   value="${c.c_location}" name="location"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="edit_description" class="col-sm-2 control-label">描述</label>
                        <div class="col-sm-6">
                            <input type="text" class="form-control" id="edit_description"
                                   value="${c.c_description} " name="description"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="edit_price" class="col-sm-2 control-label">车位价格</label>
                        <div class="col-sm-2">
                            <input type="text" class="form-control" id="edit_price"
                                   value="${c.c_price}" name="price"/>
                        </div>
                        <div class="col-sm-2">元/每</div>
                        <div class="col-sm-2">
                            <input type="text" class="form-control" id="edit_time"
                                   value="${c.c_pricetime }" name="time"/>
                        </div>
                        小时
                    </div>
                    <div class="form-group">
                        <label for="edit_total" class="col-sm-2 control-label">车位总数</label>
                        <div class="col-sm-2">
                            <input type="text" class="form-control" id="edit_total"
                                   readonly="readonly" value="${c.c_total}"/>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default"
                                data-dismiss="modal">关闭
                        </button>
                        <button type="submit" class="btn btn-primary"
                                id="updateUserInfoBtn">修改
                        </button>
                    </div>
                </form>
            </div>

        </div>
    </div>
</div>
<script type="text/javascript">
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
                        url: "${pageContext.request.contextPath}/updateCarstation.action",
                        data: {
                            "id": $("#edit_id").val(),
                            "name": $("#edit_name").val(),
                            "location": $("#edit_location").val(),
                            "description": $("#edit_description").val(),
                            "price": $("#edit_price").val(),
                            "time": $("#edit_time").val()
                        },
                        type: "POST",
                        success: function (data) {
                            if (data == "OK") {
                                alert("修改车库信息成功！");
                                window.location.reload();
                            } else {
                                alert("修改车库信息失败！")
                            }
                            $("#myModalUpdate").modal('hide');
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

    $(function () {
        $("#edit_carspaceInfo").validate({
            rules: {
                "carspace_name": {
                    "required": true,
                    "rangelength": [2, 12],
                },
                "carspace_price": {
                    "required": true,
                    "number": true,
                    "min": 0.01
                },
                "carspace_time": {
                    "required": true,
                    "number": true,
                    "min": 0.01
                }
            },
            messages: {
                "carspace_name": {
                    "required": "车位名称不能为空",
                    "rangelength": "车位名称长度为2-12位",
                },
                "carspace_price": {
                    "required": "价格不能为空",
                    "number": "价格为整数或小数",
                    "min": "最小为0.01"
                },
                "carspace_time": {
                    "required": "时间不能为空",
                    "number": "时间为整数或小数",
                    "min": "最小为0.01"
                }
            },
            submitHandler: function (form) {
                if (confirm('确定要提交已编辑的信息吗?')) {
                    $.ajax({
                        async: false,
                        url: "${pageContext.request.contextPath}/updateCarspace.action",
                        data: {
                            "id": $("#carspace_id").val(),
                            "name": $("#carspace_name").val(),
                            "location": $("#carspace_location").val(),
                            "type": $("#carspace_type").val(),
                            "price": $("#carspace_price").val(),
                            "time": $("#carspace_time").val()
                        },
                        type: "POST",
                        success: function (data) {
                            if (data == "OK") {
                                alert("修改车位信息成功！");
                                window.location.reload();
                            } else {
                                alert("修改车位信息失败！")
                            }
                            $("#myModalCarspaceUpdate").modal('hide');
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

    $(function () {
        $("#add_carspaceInfo").validate({
            rules: {
                "add_name": {
                    "required": true,
                    "rangelength": [2, 12],
                },
                "add_price": {
                    "required": true,
                    "number": true,
                    "min": 0.01
                },
                "add_time": {
                    "required": true,
                    "number": true,
                    "min": 0.01
                }
            },
            messages: {
                "add_name": {
                    "required": "车位名称不能为空",
                    "rangelength": "车位名称长度为2-12位",
                },
                "add_price": {
                    "required": "价格不能为空",
                    "number": "价格为整数或小数",
                    "min": "最小为0.01"
                },
                "add_time": {
                    "required": "时间不能为空",
                    "number": "时间为整数或小数",
                    "min": "最小为0.01"
                }
            },
            submitHandler: function (form) {
                if (confirm('确定要提交已编辑的信息吗?')) {
                    $.ajax({
                        async: false,
                        url: "${pageContext.request.contextPath}/addCarspace.action",
                        data: {
                            "cid": $("#carstation_id").val(),
                            "name": $("#add_name").val(),
                            "location": $("#add_location").val(),
                            "type": $("#add_type").val(),
                            "price": $("#add_price").val(),
                            "time": $("#add_time").val()
                        },
                        type: "POST",
                        success: function (data) {
                            if (data == "OK") {
                                alert("添加车位成功！");
                                window.location.reload();
                            } else {
                                alert("添加车位失败！")
                            }
                            $("#myModalAddCarspace").modal('hide');
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

