// 将数字及大小写字母存进Arr中
var arr = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9];
for (var i = 65; i < 122; i++) {
    if (i > 90 && i < 97) {
        continue;
    }
    //fromCharCode是将数字转换为asc对应的字符
    arr.push(String.fromCharCode(i));
}
var a = 1;
// 创建canvas区域
var canvasStr, value;

function createCanvas() {
    canvasStr = '';
    value = '';
    // 在arr中随机取出6位作为展示在canvas区域的字符串
    for (var i = 0; i < 4; i++) {
        var a = arr[Math.floor(Math.random() * arr.length)]
        canvasStr += a + ' ';
        value += a;
    }
    var myCanvas = document.getElementById('myCanvas');
    var ctx = myCanvas.getContext('2d');
    var x = myCanvas.width / 2;
    var oImg = new Image();
    oImg.src = 'images/bg.jpg';
    oImg.onload = function () {
        // 在canvas内重复图片元素作为背景
        var pattern = ctx.createPattern(oImg, 'repeat');
        ctx.fillStyle = pattern;
        ctx.fillRect(0, 0, myCanvas.width, myCanvas.height);
        // 填充canvas文字内容
        ctx.textAlign = 'center';
        ctx.fillStyle = '#ccc';
        ctx.font = '16px Roboto Slab';
        // 设置文字得倾斜
        ctx.setTransform(1, -0.12, 0.2, 1, 0, 12);
        ctx.fillText(canvasStr, x, 15);
    }
}

createCanvas();
bindevent();

function bindevent() {
    var refresh = document.getElementsByClassName('refresh')[0];
    refresh.addEventListener('click', function () {
        createCanvas();
    })
}

//表单校验
$(function () {
    $("#forgetPassword").click(function () {
        alert("请尝试联系高级管理员，让相关管理员为您更改密码！");
    });
})
$(function () {
    //自定义校验规则
    $.validator.addMethod(
        //规则的名称
        "checkCode",
        //校验的函数
        function (avalue, element, params) {
            inputValue = $("#input").val();
            if (value.toLowerCase() != inputValue.toLowerCase()) {
                return false;
            }
            return true;
        })
    $("#myform").validate({
        rules: {
            "username": {
                "required": true,
                "rangelength": [6, 12]
            },
            "password": {
                "required": true,
                "rangelength": [6, 12]
            },
            "input": {
                "required": true,
                "checkCode": true
            }
        },
        messages: {
            "username": {
                "required": "用户名不能为空",
                "rangelength": "用户名长度为6-12位"
            },
            "password": {
                "required": "密码不能为空",
                "rangelength": "密码长度6-12位"
            },
            "input": {
                "required": "验证码不能为空",
                "checkCode": "验证码输入错误"
            }
        }
    })
})
