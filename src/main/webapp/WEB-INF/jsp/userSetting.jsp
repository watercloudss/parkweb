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
    <link rel="stylesheet" href="<%=basePath%>css/userSetting.css"
          type="text/css">
    <title>个人设置</title>

</head>
<body>
<!--导航栏开始-->
<c:import url="navbarModel.jsp"></c:import>
<!--主体信息开始-->
<div class="container main">
    <div class="row">
        <div class="col-md-3 imglocation">
            <div class="row">
                <img class="main-userImg" src="<%=userImg%>${USER_LOGIN.headImg}">
                <div>
                    <input type="submit" value="更换头像" name="submit" class="btn"
                           data-toggle="modal" data-target="#imgModalInfo"/>
                </div>
            </div>
        </div>
        <div class="user-info">
            <div class="col-md-6">
                <label class="left">工号：</label> <label class="right">${USER_LOGIN.code}</label>
            </div>
            <div class="col-md-6 info-margin">
                <label class="left">昵称：</label> <label class="right">${USER_LOGIN.name}</label>
            </div>
            <div class="col-md-6 info-margin">
                <label class="left">帐号：</label> <label class="right">${USER_LOGIN.username}</label>
            </div>
            <div class="col-md-6 info-margin">
                <label class="left">邮箱：</label> <label class="right">${USER_LOGIN.email}</label>
            </div>
            <div class="col-md-6 info-margin">
                <label class="left">电话：</label> <label class="right">${USER_LOGIN.phone}</label>
            </div>
            <div class="col-md-6 info-margin">
                <label class="left">权限：</label>
                <c:choose>
                    <c:when test="${USER_LOGIN.type eq 0}">
                        <label class="right">员工</label>
                    </c:when>
                    <c:when test="${USER_LOGIN.type eq 1}">
                        <label class="right">管理员</label>
                    </c:when>
                </c:choose>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-md-4"></div>
        <div class="col-md-8 info-margin">
            <label class="left">签名：</label>
            <div class="right text">${USER_LOGIN.say}</div>
            <input type="submit" value="编辑信息" name="submit" class="btn1"
                   data-toggle="modal" data-target="#myModalInfo"> <input
                type="submit" value="修改密码" name="submit" class="btn1"
                data-toggle="modal" data-target="#myModalPassword">
        </div>
    </div>
</div>
<c:import url="bottomModel.jsp"></c:import>
<!--updloadimg Modal -->
<script type="text/javascript">
    function getObjectURL(file) {
        var url = null;
        if (window.createObjcectURL != undefined) {
            url = window.createOjcectURL(file);
        } else if (window.URL != undefined) {
            url = window.URL.createObjectURL(file);
        } else if (window.webkitURL != undefined) {
            url = window.webkitURL.createObjectURL(file);
        }
        return url;
    }

    function showRealPath(obj) {
        var file = obj.files[0];
        var url = getObjectURL(file);
        $("#realImagePath").html(
            "<img src='" + url + "'" + "width='160px' height='160px'/>");
    }

    $(function () {
        $("#uploadImgBtn").click(function () {
            if ($("#file").val() != "") {
                return true;
            } else {
                alert("请选择一张图片！");
                return false;
            }
        })
    })
</script>
<div class="modal fade" id="imgModalInfo" tabindex="-1" role="dialog"
     aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"
                        aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title" id="myModalLabel">上传图片</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal" id="img"
                      action="${pageContext.request.contextPath }/fileUpload.action"
                      method="post" enctype="multipart/form-data">
                    <div class="form-group">
                        <div
                                style="border: 1px solid #d5d5d5; width: 166px; height: 166px; padding-left: 2px; padding-top: 2px; margin-left: 200px;">
                            <span id="realImagePath"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="img" class="col-sm-2 control-label">选择图片</label>
                        <div class="col-sm-6">
                            <input id="file" type="file" name="uploadfile"
                                   onchange="showRealPath(this)"
                                   accept="image/jpg,image/png,image/jpeg" class="form-control"/>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default"
                                data-dismiss="modal">关闭
                        </button>
                        <button type="submit" class="btn btn-primary" id="uploadImgBtn">上传</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
<!--Info Modal -->
<script type="text/javascript">
    $.validator
        .addMethod(
            "isMobile",
            function (value, element) {
                var length = value.length;
                var mobile = /^(13[0-9]{9})|(18[0-9]{9})|(14[0-9]{9})|(17[0-9]{9})|(15[0-9]{9})$/;
                return this.optional(element)
                    || (length == 11 && mobile.test(value));
            }, "请正确填写手机号码");
    $(function () {
        $("#edit_info")
            .validate(
                {
                    rules: {
                        "name": {
                            "required": true,
                            "rangelength": [2, 12]
                        },
                        "email": {
                            "required": true,
                            "email": true
                        },
                        "phone": {
                            "required": true,
                            "minlength": 11,
                            "isMobile": true
                        }
                    },
                    messages: {
                        "name": {
                            "required": "姓名不能为空",
                            "rangelength": "姓名长度为2-12位",
                        },
                        "email": {
                            "required": "邮箱不能为空",
                            "email": "邮箱格式不正确"
                        },
                        "phone": {
                            "required": "手机号不能为空",
                            "minlength": "输入不能少于11位",
                            "isMobile": "请输入正确的手机号"
                        }
                    },
                    submitHandler: function (form) {
                        if (confirm('确定要提交已编辑的信息吗?')) {
                            $
                                .ajax({
                                    async: false,
                                    url: "${pageContext.request.contextPath}/updateUserInfo.action",
                                    data: {
                                        "name": $("#edit_name")
                                            .val(),
                                        "email": $(
                                            "#edit_email")
                                            .val(),
                                        "phone": $(
                                            "#edit_phone")
                                            .val(),
                                        "say": $("#edit_say")
                                            .val()
                                    },
                                    type: "POST",
                                    success: function (data) {
                                        if (data == "OK") {
                                            alert("编辑信息成功！");
                                            window.location
                                                .reload();
                                        } else {
                                            alert("编辑信息失败！")
                                        }
                                        $("#myModalInfo")
                                            .modal('hide');
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
<div class="modal fade" id="myModalInfo" tabindex="-1" role="dialog"
     aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"
                        aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title" id="myModalLabel">编辑信息</h4>
            </div>

            <div class="modal-body">
                <form class="form-horizontal" id="edit_info">
                    <div class="form-group">
                        <label for="edit_Name" class="col-sm-2 control-label">昵称</label>
                        <div class="col-sm-6">
                            <input type="text" class="form-control" id="edit_name"
                                   value="${USER_LOGIN.name}" name="name"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="edit_email" class="col-sm-2 control-label">邮箱</label>
                        <div class="col-sm-8">
                            <input type="text" class="form-control" id="edit_email"
                                   value="${USER_LOGIN.email}" name="email"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="edit_phone" class="col-sm-2 control-label">电话</label>
                        <div class="col-sm-8">
                            <input type="text" class="form-control" id="edit_phone"
                                   value="${USER_LOGIN.phone}" name="phone"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="edit_say" class="col-sm-2 control-label">签名</label>
                        <div class="col-sm-10">
                            <textarea rows="4" class="form-control" id="edit_say"
                                      name="say">${USER_LOGIN.say}</textarea>
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

<!--password Modal -->
<script type="text/javascript">
    //自定义校验规则
    $.validator
        .addMethod(
            //规则的名称
            "checkPassword",
            //校验的函数
            function (value, element, params) {

                //定义一个标志
                var flag = false;

                //value:输入的内容
                //element:被校验的元素对象
                //params：规则对应的参数值
                //目的：对输入的username进行ajax校验
                $
                    .ajax({
                        "async": false,
                        "url": "${pageContext.request.contextPath}/checkPassword.action",
                        "data": {
                            "password": value
                        },
                        "type": "POST",
                        "dataType": "json",
                        "success": function (data) {
                            console.log(data);
                            flag = data;
                        }
                    });
                //返回false代表该校验器不通过
                return flag;
            }
        );
    $(function () {
        $("#edit_password_form").validate({
            onsubmit: true,
            rules: {
                "password": {
                    "required": true,
                    "rangelength": [6, 12],
                    "checkPassword": true
                },
                "newPassword": {
                    "required": true,
                    "rangelength": [6, 12]
                },
                "twoPassword": {
                    "required": true,
                    "rangelength": [6, 12],
                    "equalTo": "#edit_newPassword"
                }
            },
            messages: {
                "password": {
                    "required": "密码不能为空",
                    "rangelength": "密码长度为6-12位",
                    "checkPassword": "密码不正确"
                },
                "newPassword": {
                    "required": "新密码不能为空",
                    "rangelength": "新密码长度6-12位"
                },
                "twoPassword": {
                    "required": "新密码不能为空",
                    "rangelength": "新密码长度6-12位",
                    "equalTo": "两次密码不一致"
                }
            }
        })
    })
</script>
<div class="modal fade" id="myModalPassword" tabindex="-1"
     role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"
                        aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title" id="myModalLabel">修改密码</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal" id="edit_password_form"
                      action="${pageContext.request.contextPath }/updatePassword.action"
                      method="post">
                    <div class="form-group">
                        <label for="edit_password" class="col-sm-2 control-label">原密码</label>
                        <div class="col-sm-8">
                            <input type="password" class="form-control" id="edit_password"
                                   placeholder="输入以前的密码" name="password"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="edit_newPassword" class="col-sm-2 control-label">新密码</label>
                        <div class="col-sm-8">
                            <input type="password" class="form-control"
                                   id="edit_newPassword" placeholder="输入新的密码" name="newPassword"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="edit_twoPassword" class="col-sm-2 control-label">重新输出</label>
                        <div class="col-sm-8">
                            <input type="password" class="form-control"
                                   id="edit_twoPassword" placeholder="再次输入新密码" name="twoPassword"/>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default"
                                data-dismiss="modal">关闭
                        </button>
                        <button type="submit" class="btn btn-primary">保存</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
</body>
</html>
