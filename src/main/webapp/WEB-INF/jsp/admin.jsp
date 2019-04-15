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
    <script src="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <title>首页</title>
    <link rel="stylesheet" href="<%=basePath%>css/admin.css" type="text/css">
</head>
<body>

<c:import url="navbarModel.jsp"></c:import>

<!--主体信息开始-->
<!--欢迎语-->
<div class="container">
    <div class="row">
        <div class="col-md-12 column">
            <div class="welcome">
                <h2>${USER_LOGIN.name},欢迎您使用停车场收费系统!</h2>
                <p>${USER_LOGIN.say}</p>
                <p id="system">
						<span class="label label-primary" onclick="systemState()"><a
                                style="color: white">刷新</a></span><br> 当前停车：<span class="redColor">${s.pn}辆</span>&emsp;&emsp;空余车位：<span
                        class="greenColor">${s.np}个</span><br>
                    拥有车库：${s.k}个&emsp;&emsp;&emsp;拥有车位：${s.all}个
                </p>
            </div>
        </div>
    </div>
</div>
<!--功能模块-->
<div class="container two">
    <div class="row">
        <div class="col-md-11 column">

            <div class="col-md-1 column"></div>
            <!--进入模块-->
            <div class="col-md-3 column" style="background: #f40;"
                 onclick="clickOut()">
                <img src="images/logo-one.png">
                <h2>车辆入库</h2>
                <p>录入车辆信息，分配停车位置</p>
            </div>


            <div class="col-md-1 column"></div>

            <!--出去模块-->
            <div class="col-md-3 column" style="background: #00B51D"
                 onclick="parkCar()">
                <img src="images/logo-two.png">
                <h2>车辆出库</h2>
                <p>车辆出库，计算停车费用</p>
            </div>

            <div class="col-md-1 column"></div>

            <!--车位查询模块-->
            <form action="<%=basePath%>carInto.action">
                <div class="col-md-3 column" style="background: #30A080"
                     onclick="search()">
                    <img src="images/logo-three.png">
                    <h2>搜索一下</h2>
                    <p>搜索停车位和车辆信息</p>
                </div>
            </form>

        </div>
    </div>
</div>

<!--天气信息展示模块-->
<div class="container three">
    <iframe name="weather_inc"
            src="https://i.tianqi.com/index.php?c=code&id=2&icon=5&py=xinxiang&temp=1&num=5&site=12"
            style="border: solid 1px #7ec8ea" style="border-radius: 10px;" width="700" height="70" frameborder="0"
            marginwidth="0" marginheight="0" scrolling="no"></iframe>
</div>
<!--公告信息展示模块-->
<div class="container" style="text-align: center">
    <h4 style="border-radius: 10px;background: #71b3f7;color:white">公告</h4>
</div>
<c:forEach items="${ml}" var="m" varStatus="id">
    <c:if test="${id.count mod 2 == 0}">
        <div class="container four" style="margin-bottom: 30px;">
            <div style="text-align: center;">
                <h4 class="message-title" style="font-weight: bold;">${m.title}<span
                        class="timeAndName">&emsp;&emsp;${m.user.name}&emsp;&emsp;</span><span
                        class="timeAndName"><fmt:formatDate value="${m.creatTime}" pattern="yyyy-MM-dd HH-mm"/></span>
                </h4>
            </div>
                ${m.content}
        </div>
    </c:if>
    <c:if test="${id.count mod 2 != 0}">
        <div class="container five">
            <div style="text-align: center;">
                <h4 class="message-title" style="font-weight: bold;">${m.title}<span
                        class="timeAndName">&emsp;&emsp;${m.user.name}&emsp;&emsp;</span><span
                        class="timeAndName"><fmt:formatDate value="${m.creatTime}" pattern="yyyy-MM-dd HH-mm"/></span>
                </h4>
            </div>
                ${m.content}
        </div>
    </c:if>
</c:forEach>
<c:import url="bottomModel.jsp"></c:import>
<script type="text/javascript">
    function systemState() {
        $.ajax({
            async: false,
            url: "${pageContext.request.contextPath}/systemState.action",
            data: {},
            type: "POST",
            success: function (data) {
                console.log(data);
                var h = "<p id='system'><span class='label label-primary' onclick='systemState()'>刷新</span><br>当前停车：<span class='redColor'>" + data.pn + "辆</span>&emsp;&emsp;空余车位：<span class='greenColor'>" + data.np + "个</span><br>拥有车库：" + data.k + "个&emsp;&emsp;&emsp;拥有车位：" + data.all + "个</p>";
                $("#system").html(h);
            },
            fail: function (e) {
                alert("error");
            },
            error: function (e) {
                alert("error");
            }
        })
    }

    function search() {
        $("#myModalSearch").modal('show');
        var mycars = new Array("京", "津", "沪", "渝", "冀", "豫", "云", "辽", "黑",
            "湘", "皖", "鲁", "新", "苏", "浙", "赣", "鄂", "桂", "甘", "晋", "蒙",
            "陕", "吉", "闽", "贵", "粤", "青", "藏", "川", "宁", "琼", "使", "领");
        for (var i = 0; i < mycars.length; i++) {
            $("#selectIdtwo").append(
                "<option value='" + mycars[i] + "'>" + mycars[i]
                + "</option>");
        }
    }

    function searchcaspace() {
        var v = $("#carspacename").val();
        if (v == "" || v == " " || v == null) {
            $("#error").html("<p style='color:red;margin-left:150px'>车位名不能为空</p>");
            return;
        } else {
            $("#error").html("<p id='error'></p>")
        }
        $.ajax({
            async: false,
            url: "${pageContext.request.contextPath}/searchcaspace.action",
            data: {
                "carspacename": $("#carspacename").val()
            },
            type: "POST",
            success: function (data) {
                if (data.s_name != null) {
                    var state, type;
                    if (data.s_state == 1) {
                        state = "有车";
                    } else {
                        state = "无车";
                    }
                    if (data.s_type == 1) {
                        type = "小车位";
                    } else {
                        type = "大车位";
                    }
                    var la = "<p>所属车库：" + data.carstation.c_name
                        + "<br>" + "车位名称：" + data.s_name
                        + "&emsp;&emsp;车位类型：" + type + "<br>"
                        + "车位价格：" + data.s_price + "元/"
                        + data.s_pricetime + "小时<br>" + "目前状态："
                        + state + "</p>";
                    $("#spaceInfo").html(la);
                } else {
                    $("#spaceInfo").html("<p style='color:red'>没有查询到该车位</p>");
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

    function parkCar() {
        $("#myModalCarOut").modal('show');
        var mycars = new Array("京", "津", "沪", "渝", "冀", "豫", "云", "辽", "黑",
            "湘", "皖", "鲁", "新", "苏", "浙", "赣", "鄂", "桂", "甘", "晋", "蒙",
            "陕", "吉", "闽", "贵", "粤", "青", "藏", "川", "宁", "琼", "使", "领");
        for (var i = 0; i < mycars.length; i++) {
            $("#selectId").append(
                "<option value='" + mycars[i] + "'>" + mycars[i]
                + "</option>");
        }
    }

    $.validator
        .addMethod(
            "checkCarNumber",
            function (value, element) {
                var mobile = /^(([A-Z](([0-9]{5}[DF])|([DF]([A-HJ-NP-Z0-9])[0-9]{4})))|([A-Z][A-HJ-NP-Z0-9]{4}[A-HJ-NP-Z0-9挂学警港澳使领]))$/;
                return this.optional(element) || mobile.test(value);
            }, "请正确填写车牌号码");
    $(function () {
        $("#searchInfo")
            .validate(
                {
                    rules: {
                        "car_numtwo": {
                            "required": true,
                            "checkCarNumber": true
                        }
                    },
                    messages: {
                        "car_numtwo": {
                            "required": "车牌号不能为空",
                            "checkCarNumber": "请输入正确的车牌号码"
                        }
                    },
                    submitHandler: function (form) {
                        $.ajax({
                            async: false,
                            url: "${pageContext.request.contextPath}/searchcarnumber.action",
                            data: {
                                "carNumber": $("#car_numtwo").val(),
                                "selectId": $("#selectIdtwo").val()
                            },
                            type: "POST",
                            success: function (data) {
                                var co = data.co;
                                if (co == null) {
                                    $("#orderInfo").html("<p style='color:red'>没有搜索到车辆信息</p>");
                                    return;
                                }
                                if (co.state == 1) {
                                    $("#orderInfo").html("<p style='color:red'>没有搜索到车辆信息</p>");
                                    return;
                                }
                                var cs = data.cs;
                                var la = "<p>车牌号："
                                    + co.province
                                    + "·"
                                    + co.carNumber
                                    + "<br>"
                                    + "停车人姓名："
                                    + co.customerName
                                    + "&emsp;&emsp;停车人电话："
                                    + co.customerPhone
                                    + "<br>"
                                    + "目前在："
                                    + cs.carstation.c_name
                                    + "车库&emsp;"
                                    + cs.s_name + "车位"
                                    + "</p>";
                                $("#orderInfo").html(la);
                            },
                            fail: function (e) {
                                alert("请求失败");
                            },
                            error: function (e) {
                                alert("error");
                            }
                        })
                    }
                })
    })
    $(function () {
        $("#costInfo")
            .validate(
                {
                    rules: {
                        "car_num": {
                            "required": true,
                            "checkCarNumber": true
                        }
                    },
                    messages: {
                        "car_num": {
                            "required": "车牌号不能为空",
                            "checkCarNumber": "请输入正确的车牌号码"
                        }
                    },
                    submitHandler: function (form) {
                        $
                            .ajax({
                                async: false,
                                url: "${pageContext.request.contextPath}/selectCarorder.action",
                                data: {
                                    "selectId": $("#selectId")
                                        .val(),
                                    "car_num": $("#car_num")
                                        .val()
                                },
                                type: "POST",
                                success: function (data) {
                                    if (data.co != null) {
                                        console.log(data.user);
                                        var co = data.co;
                                        var c = data.carspace;
                                        var u = data.user;
                                        var type;
                                        if (c.s_type == 1) {
                                            type = "小车位";
                                        } else {
                                            type = "大车位";
                                        }
                                        var la = "<div id='oid' style='display:none;'>"
                                            + co.id
                                            + "</div>"
                                            + "<strong>车牌号：</strong><em>"
                                            + co.province
                                            + "·"
                                            + co.carNumber
                                            + "</em><br>"
                                            + "<strong>车库：</strong><em>"
                                            + c.carstation.c_name
                                            + "</em>&emsp;&emsp;&emsp;<strong>车位：</strong><em>"
                                            + c.s_name
                                            + "</em><br>"
                                            + "<strong>车位类型:</strong><em>"
                                            + type
                                            + "</em><br>"
                                            + "<strong>入库时间:</strong><em>"
                                            + data.startTime
                                            + "</em>&emsp;&emsp;&emsp;<strong>出库时间:</strong><em>"
                                            + data.endTime
                                            + "</em><br>"
                                            + "<strong>价格：</strong><em>"
                                            + c.s_price
                                            + "元/"
                                            + c.s_pricetime
                                            + "小时</em>&emsp;&emsp;&emsp;<strong>停车时间：</strong><em>"
                                            + data.time
                                            + "小时</em><br>"
                                            + "<strong>操作人:</strong><em>"
                                            + u.name
                                            + "</em>&emsp;&emsp;&emsp;<strong>工号：</strong><em>"
                                            + u.code
                                            + "</em><br>"
                                            + "<strong>总计:</strong><strong style='color:red'>￥"
                                            + data.cost
                                            + "元</strong><br><br>"
                                            + "<span onclick='account(+"
                                            + co.id
                                            + ","
                                            + c.s_id
                                            + ","
                                            + data.time
                                            + ","
                                            + data.oneEndTime
                                            + ","
                                            + data.cost
                                            + ")' class='endBtn'>结算</span>"
                                        $("#carCost").html(la);
                                        alert("计算费用成功！");
                                    } else {
                                        alert("没有查找到该车牌号！");
                                    }
                                },
                                fail: function (e) {
                                    alert("没有查找到该车牌号！");
                                },
                                error: function (e) {
                                    alert("error！");
                                }
                            })
                    }

                })
    })

    function account(oid, sid, time, endTime, cost) {
        $.ajax({
            async: false,
            url: "${pageContext.request.contextPath}/endCarorder.action",
            data: {
                "oid": oid,
                "sid": sid,
                "time": time,
                "endTime": endTime,
                "cost": cost
            },
            type: "POST",
            success: function (data) {
                if (data == "OK") {
                    alert("结算成功！");
                    $("#myModalCarOut").modal('hide');
                } else {
                    alert("结算失败！");
                }
            },
            fail: function (e) {
                alert("error");
            },
            error: function (e) {
                alert("error");
            }
        })

    }
</script>
<!--计算停车费用模态框-->
<div class="modal fade" id="myModalCarOut" tabindex="-1" role="dialog"
     aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"
                        aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title" id="myModalLabel">计算停车费用</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal" id="costInfo">
                    <p id="carspaceInfo"></p>
                    <div class="form-group">
                        <label for="car_num" class="col-sm-3 control-label">车牌号</label>
                        <div class="col-sm-2">
                            <select class="form-control sel" id="selectId" name="selectId">
                            </select>
                        </div>
                        <div class="col-sm-4">
                            <input type="text" class="form-control" id="car_num"
                                   placeholder="输入车牌号码" name="car_num"/>
                        </div>
                        <div class="col-sm-2">
                            <span class="OCRcarnumber" onclick="clickCamera()">拍照识别</span>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="panel panel-success"
                             style="width: 450px; margin-left: 80px">
                            <div class="panel-heading">
                                <p id="carCost" style="line-height: 25px">
                                    <strong>车牌号：</strong><em>&emsp;&emsp;</em><br>
                                    <strong>车库：</strong><em>&emsp;&emsp;</em>&emsp;&emsp;&emsp;<strong>车位：</strong><em>&emsp;&emsp;</em><br>
                                    <strong>车位类型:</strong><em>&emsp;&emsp;</em><br> <strong>入库时间:</strong><em>&emsp;&emsp;</em>&emsp;&emsp;&emsp;<strong>出库时间:</strong><em>&emsp;&emsp;</em><br>
                                    <strong>价格：</strong><em>&emsp;&emsp;</em>&emsp;&emsp;&emsp;<strong>停车时间：</strong><em>&emsp;&emsp;</em><br>
                                    <strong>操作人:</strong><em>&emsp;&emsp;</em>&emsp;&emsp;&emsp;<strong>工号：</strong><em>&emsp;&emsp;</em><br>
                                    <strong>总计:</strong><strong style="color: red">&emsp;&emsp;</strong><br>
                                    <br> <span class="endBtn">结算</span>
                                </p>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default"
                                data-dismiss="modal" onclick="flush()">关闭
                        </button>
                        <button type="submit" class="btn btn-primary" id="parkcar">计算费用</button>
                    </div>
                </form>
            </div>

        </div>
    </div>
</div>
<!--搜索模态框-->
<div class="modal fade" id="myModalSearch" tabindex="-1" role="dialog"
     aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"
                        aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title" id="myModalLabel">搜索</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal" id="searchInfo">
                    <p id="carspaceInfo"></p>
                    <div class="form-group">
                        <label for="car_num" class="col-sm-3 control-label">车牌号</label>
                        <div class="col-sm-2">
                            <select class="form-control sel" id="selectIdtwo"
                                    name="selectId">
                            </select>
                        </div>
                        <div class="col-sm-4">
                            <input type="text" class="form-control" id="car_numtwo"
                                   placeholder="输入车牌号码" name="car_numtwo"/>
                        </div>
                        <button class="col-sm-2"
                                style="display: block; padding: 0; background: #f40; width: 40px; text-align: center; border-radius: 5px; color: white; margin-top: 5px;">
                            搜索
                        </button>
                    </div>
                    <div class="form-group">
                        <div class="panel panel-success"
                             style="display: block; width: 450px; margin-left: 80px">
                            <div class="panel-heading">
                                <p id="orderInfo" style="line-height: 25px"></p>
                            </div>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="carpace" class="col-sm-3 control-label">车位名</label>
                        <div class="col-sm-3">
                            <input type="text" class="form-control" id="carspacename"
                                   placeholder="输入车位名" name="carspacename"/>
                        </div>
                        <span class="col-sm-3" onclick="searchcaspace()"
                              style="display: block; padding: 0; background: #f40; width: 40px; text-align: center; border-radius: 5px; color: white; margin-top: 5px;">搜索</span>
                    </div>
                    <p id="error"></p>
                    <div class="form-group">
                        <div class="panel panel-success"
                             style="width: 450px; margin-left: 80px">
                            <div class="panel-heading">
                                <p id="spaceInfo" style="line-height: 25px"></p>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default"
                                data-dismiss="modal">关闭
                        </button>
                    </div>
                </form>
            </div>

        </div>
    </div>
</div>

<!--orc模态框-->
<div class="modal fade" id="myModalOCR" tabindex="-1" role="dialog"
     aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content" style="width:700px">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"
                        aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title" id="myModalLabel">拍照识别</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <div class="col-sm-4">
                            <video id="video" width="300" height="200" controls></video>
                        </div>
                        <div class="col-sm-2"></div>
                        <div class="col-sm-4">
                            <canvas id="canvas" width="300" height="200"
                                    style="padding:3px;border:1px dashed #f40;"></canvas>
                        </div>
                    </div>

                </form>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default"
                            data-dismiss="modal" onclick="flush()">关闭
                    </button>
                    <button class="col-sm-2 OCRcarnumber" id="capture">拍照</button>
                    <button class="col-sm-2 OCRcarnumber" style="background: #f40" onclick="goGetCarNumber()">识别并计算费用
                    </button>
                </div>
            </div>

        </div>
    </div>
</div>
<script type="text/javascript">
    function flush() {
        window.location.reload();
    }

    function clickOut() {
        window.location.href = "<%=basePath%>carInto.action";
    }

    function clickCamera() {
        $("#myModalCarOut").modal("hide");
        $("#myModalOCR").modal("show");
    }

    function goGetCarNumber() {
        var img = convertCanvasToImage();
        $.ajax({
            async: false,
            url: "${pageContext.request.contextPath}/OCRNumber.action",
            data: {
                "Base64Image": img
            },
            type: "POST",
            success: function (data) {
                if (data.co == null) {
                    alert("请重新拍照识别！");
                    return;
                }
                $("#myModalOCR").modal("hide");
                $("#myModalCarOut").modal("show");
                var co = data.co;
                var c = data.carspace;
                var u = data.user;
                var type;
                if (c.s_type == 1) {
                    type = "小车位";
                } else {
                    type = "大车位";
                }
                var la = "<div id='oid' style='display:none;'>"
                    + co.id
                    + "</div>"
                    + "<strong>车牌号：</strong><em>"
                    + co.province
                    + "·"
                    + co.carNumber
                    + "</em><br>"
                    + "<strong>车库：</strong><em>"
                    + c.carstation.c_name
                    + "</em>&emsp;&emsp;&emsp;<strong>车位：</strong><em>"
                    + c.s_name
                    + "</em><br>"
                    + "<strong>车位类型:</strong><em>"
                    + type
                    + "</em><br>"
                    + "<strong>入库时间:</strong><em>"
                    + data.startTime
                    + "</em>&emsp;&emsp;&emsp;<strong>出库时间:</strong><em>"
                    + data.endTime
                    + "</em><br>"
                    + "<strong>价格：</strong><em>"
                    + c.s_price
                    + "元/"
                    + c.s_pricetime
                    + "小时</em>&emsp;&emsp;&emsp;<strong>停车时间：</strong><em>"
                    + data.time
                    + "小时</em><br>"
                    + "<strong>操作人:</strong><em>"
                    + u.name
                    + "</em>&emsp;&emsp;&emsp;<strong>工号：</strong><em>"
                    + u.code
                    + "</em><br>"
                    + "<strong>总计:</strong><strong style='color:red'>￥"
                    + data.cost
                    + "元</strong><br><br>"
                    + "<span onclick='account(+"
                    + co.id
                    + ","
                    + c.s_id
                    + ","
                    + data.time
                    + ","
                    + data.oneEndTime
                    + ","
                    + data.cost
                    + ")' class='endBtn'>结算</span>"
                $("#carCost").html(la);
            },
            fail: function (e) {
                alert("error");
            },
            error: function (e) {
                alert("error");
            }
        })
    }
</script>
<script type="text/javascript" src="<%=basePath%>js/OCRcarNumber.js"></script>
</body>
</html>

