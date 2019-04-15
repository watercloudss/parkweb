# parkweb
停车场收费系统
一个基于ssm框架的小系统<br>
其中调用了百度AI的文字识别系统来识别车牌，识别的token是个人的会过期，过期时需要手动获取更改(懒得搞这块，手动获取下就行了)<br>
可以使用utils包下的GetAccess_token类获取，在HttpURLconn改下就行了<br>
识别截图如下：![Image text](https://github.com/liuliyuan666/parkweb/blob/master/images/5.PNG)
![Image text](https://github.com/liuliyuan666/parkweb/blob/master/images/4.PNG)
系统的前端主要使用Bootstrap框架和jquery框架，加之css进行修改美化，主页面如下：![Image text](https://github.com/liuliyuan666/parkweb/blob/master/images/8.PNG)
车位选择页面：![Image text](https://github.com/liuliyuan666/parkweb/blob/master/images/7.PNG)
计算费用页面（有不足）![Image text](https://github.com/liuliyuan666/parkweb/blob/master/images/6.PNG)
