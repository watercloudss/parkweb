<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="lly" uri="http://itheima.com/common/" %>
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
    <title></title>

</head>
<body>
<c:import url="navbarModel.jsp"></c:import>
<!--主体信息开始-->
<!--搜索用的-->
<div class="container top"
     style="margin-top: 80px; height: 60px; background: #f5f5f5;">
    <div class="row" style="margin-left: 20px; margin-top: 10px">
        <form class="form-inline"
              action="${pageContext.request.contextPath }/employee.action">
            <div class="form-group">
                <label for="exampleInputName2">工号：</label> <input type="text"
                                                                  class="form-control" id="exampleInputName1"
                                                                  name="code"
                                                                  placeholder="请输入工号">
            </div>
            <div class="form-group">
                <label for="exampleInputName2">帐号：</label> <input type="text"
                                                                  class="form-control" id="exampleInputName2"
                                                                  name="username"
                                                                  placeholder="请输入账号">
            </div>
            <div class="form-group">
                <label for="exampleInputEmail2">姓名：</label> <input type="text"
                                                                   class="form-control" id="exampleInputEmail3"
                                                                   name="name"
                                                                   placeholder="请输入姓名">
            </div>
            <button type="submit" class="btn btn-success"
                    style="background: #4cae4c">查询
            </button>
            <button type="button" class="btn btn-danger"
                    style="background: #d43f3a" data-toggle="modal"
                    data-target="#myModalAddUser">添加员工
            </button>
        </form>
    </div>
</div>
<div class="container main" style="margin-top: 10px; height: 450px">
    <div class="row">
        <table class="table table-striped">
            <tr>
                <td>#</td>
                <td>工号</td>
                <td>帐号</td>
                <td>姓名</td>
                <td>性别</td>
                <td>邮箱</td>
                <td>电话</td>
                <td>权限</td>
                <td>状态</td>
                <td>操作</td>
            </tr>
            <c:forEach items="${page.rows}" var="user" varStatus="id">
                <tr>
                    <td>${id.count}</td>
                    <td>${user.code}</td>
                    <td>${user.username}</td>
                    <td>${user.name}</td>
                    <c:if test="${user.sex eq 1}">
                        <td>男</td>
                    </c:if>
                    <c:if test="${user.sex eq 0}">
                        <td>女</td>
                    </c:if>
                    <td>${user.email}</td>
                    <td>${user.phone}</td>
                    <c:if test="${user.type eq 1}">
                        <td>
                            <button type="button"
                                    onclick="updateUserType(${user.id},0)"
                                    style="background: 37a; height: 25px; width: 50px; border-radius: 5px; background: #4cae4c; color: white">
                                管理员
                            </button>
                        </td>
                    </c:if>
                    <c:if test="${user.type eq 0}">
                        <td>
                            <button type="button"
                                    onclick="updateUserType(${user.id},1)"
                                    style="background: 37a; height: 25px; width: 50px; border-radius: 5px; background: #d43f3a; color: white">
                                职员
                            </button>
                        </td>
                    </c:if>
                    <c:if test="${user.state eq 1}">
                        <td>
                            <button type="button"
                                    onclick="updateUserState(${user.id},0)"
                                    style="background: 37a; height: 25px; width: 50px; border-radius: 5px; background: #4cae4c; color: white">
                                可用
                            </button>
                        </td>
                    </c:if>
                    <c:if test="${user.state eq 0}">
                        <td>
                            <button type="button"
                                    onclick="updateUserState(${user.id},1)"
                                    style="background: 37a; height: 25px; width: 50px; border-radius: 5px; background: #d43f3a; color: white">
                                禁用
                            </button>
                        </td>
                    </c:if>
                    <td>
                        <button type="button" id="deleteUser"
                                onclick="deleteUser(${user.id})"
                                style="background: 37a; height: 25px; width: 50px; border-radius: 5px; background: #f40; color: white">
                            删除
                        </button>
                    </td>
                </tr>
            </c:forEach>
        </table>

    </div>

</div>
<div class="col-md-7 text-right">
    <lly:page url="${pageContext.request.contextPath }/employee.action"/>
</div>
<c:import url="bottomModel.jsp"></c:import>
<script type="text/javascript">
    function deleteUser(id) {
        if (confirm('确定要删除该用户吗?')) {
            $.ajax({
                async: false,
                url: "${pageContext.request.contextPath}/deleteUser.action",
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

    function updateUserState(id, state) {
        $.ajax({
            async: false,
            url: "${pageContext.request.contextPath}/updateUserState.action",
            type: "POST",
            data: {
                "id": id,
                "state": state
            },
            success: function (data) {
                if (data == "OK") {
                    alert("修改成功！");
                    window.location.reload();
                } else {
                    alert("修改失败！")
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

    function updateUserType(id, type) {
        $.ajax({
            async: false,
            url: "${pageContext.request.contextPath}/updateUserType.action",
            type: "POST",
            data: {
                "id": id,
                "type": type
            },
            success: function (data) {
                if (data == "OK") {
                    alert("修改成功！");
                    window.location.reload();
                } else {
                    alert("修改失败！")
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
</script>
<!--Info Modal -->

<div class="modal fade" id="myModalAddUser" tabindex="-1" role="dialog"
     aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"
                        aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title" id="myModalLabel">添加员工</h4>
            </div>

            <div class="modal-body">
                <form class="form-horizontal" id="edit_userInfo">
                    <div class="form-group">
                        <label for="edit_username" class="col-sm-2 control-label">帐号</label>
                        <div class="col-sm-6">
                            <input type="text" class="form-control" id="edit_username"
                                   placeholder="输入6到12位字符" name="username"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="edit_code" class="col-sm-2 control-label">密码</label>
                        <div class="col-sm-6">
                            <input type="text" class="form-control" id="edit_password"
                                   readonly="readonly" placeholder="默认为帐号" name="password"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="edit_code" class="col-sm-2 control-label">工号</label>
                        <div class="col-sm-6">
                            <input type="text" class="form-control" id="edit_code"
                                   placeholder="输入五位数字  " name="code"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="edit_Name" class="col-sm-2 control-label">昵称</label>
                        <div class="col-sm-6">
                            <input type="text" class="form-control" id="edit_name"
                                   placeholder="输入2到12位的字符  " name="name"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="edit_Name" class="col-sm-2 control-label">性别</label>
                        <div class="col-sm-6">
                            <select class="form-control" id="sex">
                                <option value="1">男</option>
                                <option value="0">女</option>
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="edit_email" class="col-sm-2 control-label">邮箱</label>
                        <div class="col-sm-8">
                            <input type="text" class="form-control" id="edit_email"
                                   placeholder="输入正确的邮箱 " name="email"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="edit_phone" class="col-sm-2 control-label">电话</label>
                        <div class="col-sm-8">
                            <input type="text" class="form-control" id="edit_phone"
                                   placeholder="输入正确的手机号" name="phone"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="edit_say" class="col-sm-2 control-label">签名</label>
                        <div class="col-sm-10">
								<textarea rows="4" class="form-control" readonly="readonly"
                                          id="edit_say" name="say">美好的一天！</textarea>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default"
                                data-dismiss="modal">关闭
                        </button>
                        <button type="submit" class="btn btn-primary"
                                id="updateUserInfoBtn">添加
                        </button>
                    </div>
                </form>
            </div>

        </div>
    </div>
</div>
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
    //自定义校验规则
    $.validator
        .addMethod(
            //规则的名称
            "checkUsername",
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
                        "url": "${pageContext.request.contextPath}/checkUsername.action",
                        "data": {
                            "username": value
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
    $.validator
        .addMethod(
            //规则的名称
            "checkCode",
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
                        "url": "${pageContext.request.contextPath}/checkCode.action",
                        "data": {
                            "code": value
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
        $("#edit_userInfo").validate({
            rules: {
                "username": {
                    "required": true,
                    "rangelength": [6, 12],
                    "checkUsername": true
                },
                "name": {
                    "required": true,
                    "rangelength": [2, 12]
                },
                "code": {
                    "required": true,
                    "digits": true,
                    "rangelength": [5, 5],
                    "checkCode": true
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
                "username": {
                    "required": "帐号不能为空",
                    "rangelength": "帐号长度为6-12位",
                    "checkUsername": "该帐号已被使用"
                },
                "name": {
                    "required": "姓名不能为空",
                    "rangelength": "姓名长度为2-12位",
                },
                "code": {
                    "required": "工号不能为空",
                    "digits": "工号为五位数字",
                    "rangelength": "工号长度为5位",
                    "checkCode": "该员工号已被使用"
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
                    $.ajax({
                        async: false,
                        url: "${pageContext.request.contextPath}/addUser.action",
                        data: {
                            "username": $("#edit_username").val(),
                            "code": $("#edit_code").val(),
                            "name": $("#edit_name").val(),
                            "sex": $("#sex").val(),
                            "email": $("#edit_email").val(),
                            "phone": $("#edit_phone").val()
                        },
                        type: "POST",
                        success: function (data) {
                            if (data == "OK") {
                                alert("添加用户成功！");
                                window.location.reload();
                            } else {
                                alert("添加用户失败！")
                            }
                            $("#myModalInfo").modal('hide');
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
