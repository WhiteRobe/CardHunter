<%@ page import="web.bussiness.gloable.GloableValue" %><%--
  Created by IntelliJ IDEA.
  User: a
  Date: 2017/10/23
  Time: 10:18
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>剧本杀助手-首页</title>
    <link rel="stylesheet" href="res/src/css/bootstrap.min.css"/>
    <link rel="stylesheet" href="res/src/jquery-ui-1.12.1.custom/jquery-ui.min.css"/>
    <link rel="stylesheet" href="res/src/css/jquery.growl.css"/>
    <script src="res/src/js/jquery-3.2.1.min.js"></script>
    <script src="res/src/js/bootstrap.min.js"></script>
    <script src="res/src/jquery-ui-1.12.1.custom/jquery-ui.min.js"></script>
    <script src="res/src/js/jquery.growl.js"></script>
    <script src="res/src/js/JsGloableValue.js"></script>
    <script src="res/src/js/BaseTool.js"></script>
    <script>
    $(document).ready(function () {
        //创建房间
        $("#createGameRoom").click(function () {
            $.get(
                gv.root+"GameCreateRoom",
                function (data) {
                    //console.log(data);
                    if(data.indexOf("true")>=0){
                        var index1 = data.indexOf(":");
                        var index2 = data.indexOf(":",index1+1);
                        //console.log(data.substring(index1+1,index2),data.substring(index2+1));
                        var roomId = data.substring(index1+1,index2);
                        var roomPW = data.substring(index2+1);
                        $.growl.notice({
                            title: "创建房间成功",
                            message: "房号:"+roomId+" 房间密码:"+roomPW
                        });
                        jump(1,"./GameRoom.jsp");
                    } else if (parseInt(data) === -1){
                        $.growl.error({
                            title: "创建房间失败",
                            message: "房间已满。"
                        });
                    } else if (parseInt(data) === -2){
                        $.growl.warning({
                            title: "创建房间失败",
                            message: "网络错误，请重试！"
                        });
                    }
                }
            );
        });
        //加入房间
        $("#joinGameRoom").click(function () {
            $.post(
                gv.root+"GameCreateRoom",
                {
                    roomId:$("#roomIdInput").val(),
                    roomPw:$("#roomPwInput").val()
                },
                function (data) {
                    //console.log(data);
                    if(data.indexOf("true")>=0){
                        var index1 = data.indexOf(":");
                        var index2 = data.indexOf(":",index1+1);
                        //console.log(data.substring(index1+1,index2),data.substring(index2+1));
                        var roomId = data.substring(index1+1,index2);
                        var roomPW = data.substring(index2+1);
                        $.growl.notice({
                            title: "加入房间成功",
                            message: "房号:"+roomId+" 房间密码:"+roomPW
                        });
                        jump(1,"./GameRoom.jsp");
                    } else {
                        $.growl.error({
                            title: "加入房间失败",
                            message: "房间号或密码错误，请重试！"
                        });
                    }
                }
            );
        });
    })
    </script>
    <style>
        hr{
            height:1px;
            border:none;
            border-top:1px solid silver;
        }
        small{
            color:gray;
        }
    </style>
</head>
<body style="padding-top: 15px">
<div class="container">
<div class="row clearfix">
    <div class="col-sm-12 column">
        <div class="col-sm-12 well">
            <div>
                <p style="text-align: center;font-size: 30px;">
                    欢迎来到<b style="color: #d9534f">剧本杀助手</b>!
                </p>
                <p style="font-size: 20px">
                    &nbsp;&nbsp;您可以在这里选择您要玩的剧本，加入、或创建一个新的房间与朋友即时游玩，而无需因繁琐的账号注册过程而费神。<br>
                    &nbsp;&nbsp;您只需轻轻一点，即可轻松<u>创建</u>或<u>加入</u>一个游戏。<br>
                    &nbsp;&nbsp;若您尚未加入游戏或拥有角色，您可以点击创建游戏以加入一个新的游戏；若您的朋友已经创建好房间，您可以输入<u>房间号</u>和<u>房间密码</u>直接加入。<br>
                    &nbsp;&nbsp;最后，祝您游戏愉快。
                </p>
                <small>注意：系统仍在测试运行中！请注意备份您的游戏数据！</small>
            </div>
            <hr/>
            <div class="col-sm-12">
                <h3 style="font-weight: bold">创建一个新房间</h3>
                <small>还没有房间？ </small>
                <a class="btn btn-primary btn-large" href="javascript:void(0)" id="createGameRoom">点击创建房间</a>
                <small> 或者，您可以加入一个已有的游戏房间：</small>
            </div>
            <div class="col-sm-12">
                <hr/>
                <h3 style="font-weight: bold">加入一个已有房间</h3>
                <label><input type="number" class="form-control" placeholder="房间号" id="roomIdInput" onkeyup="this.value=this.value.replace(/[^\d.]/g,'')" onafterpaste="this.value=this.value.replace(/[^\d.]/g,'')"/></label>
                <label><input type="number" class="form-control" placeholder="房间密码" id="roomPwInput" onkeyup="this.value=this.value.replace(/[^\d.]/g,'')" onafterpaste="this.value=this.value.replace(/[^\d.]/g,'')"/></label>
                <a class="btn btn-success btn-large" href="javascript:void(0)" id="joinGameRoom">加入房间</a>
            </div>
        </div>
    </div>
    <!--Version-->
    <div class="col-sm-12 column well">
        <p style="text-align: center">
            <a href="./admin.jsp"><small style="color: #c12e2a">>前往控制台<</small></a><br>
            <small>WebApp-剧本杀助手 version:v<%=GloableValue.webAppVersion%></small><br>
            <small>Contact me AT:<a href="http://blog.csdn.net/shenpibaipao" target="_blank">My Blog</a> or send me an <a href="mailto:hdai95@outlook.com" >Email</a></small>
            <span class="glyphicon-envelope" ></span><br/>
            <small>_(-ω-`_)⌒)_ Welcome Git Together:<a href="https://gitee.com/shenpibaipao/CardHunter" target="_blank">Git Home</a></small><br/>

            <small>©CopyRight 2017 45.org.Indi All Rights Reserved. </small>
        </p>
    </div>
</div>
</div>
</body>
</html>
