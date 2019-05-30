# parkweb
停车场收费系统<br>
一个基于ssm框架的小系统<br>
后端：使用了spring、springMVC、Mybatis<br>
前端：使用了Bootstrap、jQuery、UmEditer<br>
使用mysql数据库，IntellJ idea编辑器<br>
前端页面全部为自己设计的，使用了一些H5的元素，调用摄像头时建议使用chrom浏览器，有时需要设置调用设备摄像头的权限（具体百度），其中调用了百度AI的文字识别系统来识别车牌，识别的token是个人的会过期，过期时需要手动获取更改(懒得搞这块，手动获取下就行了)可以使用utils包下的GetAccess_token类获取，在HttpURLconn改下就行了<br>
在计算费用时，可能会出现一点小误差，目前正在寻找解决方法，可能是数据库price列设置为double导致数据不精准<br>
写这个系统主要是为了调用下百度AI接口和写出好看的页面，前端做的还可以，后端就有点.....小问题.....略过吧，哈哈哈！！！！！<br>
识别截图如下：<br>
<img src="https://raw.githubusercontent.com/flowingwaters/images/master/parkweb-img/4.PNG" width="650"/>
<img src="https://raw.githubusercontent.com/flowingwaters/images/master/parkweb-img/5.PNG" width="650"/>
<br>
系统的前端主要使用Bootstrap框架和jquery框架，加之css进行修改美化，主页面如下：<br>
<img src="https://raw.githubusercontent.com/flowingwaters/images/master/parkweb-img/6.PNG" width="650"/>
<br>
车位选择页面：<br>
<img src="https://raw.githubusercontent.com/flowingwaters/images/master/parkweb-img/7.PNG" width="650"/>
<br>
计算费用页面（有不足）：<br>
<img src="https://raw.githubusercontent.com/flowingwaters/images/master/parkweb-img/8.PNG" width="650"/>
