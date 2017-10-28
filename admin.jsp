<%@ page import="web.bussiness.gloable.GloableValue" %>
<%@ page import="OriPrj.OriDatabase.dao.OriDB" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %><%--
  Created by IntelliJ IDEA.
  User: a
  Date: 2017/10/27
  Time: 17:55
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>管理员控制台</title>
    <link rel="stylesheet" href="res/src/css/bootstrap.min.css"/>
    <link rel="stylesheet" href="res/src/jquery-ui-1.12.1.custom/jquery-ui.min.css"/>
    <link rel="stylesheet" href="res/src/css/jquery.growl.css"/>
    <script src="res/src/js/jquery-3.2.1.min.js"></script>
    <script src="res/src/js/bootstrap.min.js"></script>
    <script src="res/src/jquery-ui-1.12.1.custom/jquery-ui.min.js"></script>
    <script src="res/src/js/jquery.growl.js"></script>
    <script src="res/src/js/JsGloableValue.js"></script>
    <script src="res/src/js/BaseTool.js"></script>
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
<%
    //查询数据库共有的卡牌数
    OriDB db = (OriDB) request.getSession().getAttribute("DB");
    ResultSet rs = db.preStaQuery("SELECT count(*) FROM card");
    int CardSum = -1;
    try{
        rs.next();
        CardSum = rs.getInt(1);
    }catch (Exception e){
    	e.printStackTrace();
    }
%>
<body style="padding-top: 15px">
<div class="container">
    <div class="row clearfix">
        <div class="col-sm-12 column">
            <div class="col-sm-12 well">
                <div>
                    <p style="text-align: center;font-size: 30px;">
                        欢迎<b style="color: #d9534f">管理员</b>的到来!
                    </p>
                    <p style="font-size: 20px">
                        &nbsp;&nbsp;您可以在动态的完成数据库的初始化等操作。<br>
                        &nbsp;&nbsp;您只需轻轻一点，即可轻松<u>重载</u>或<u>刷新</u>数据库的数据。<br>
                        &nbsp;&nbsp;当前数据库共有卡牌:<b style="color:red;"><%=CardSum%></b><br>
                    </p>
                    <hr/>
                    <small>注意：系统仍在测试运行中！请注意备份您的游戏数据！</small>
                    <label><input type="text" class="form-control" placeholder="输入管理员密码" id="pw"/></label>
                </div>
                <hr/>
                <div class="col-sm-12">
                    <h3 style="font-weight: bold">数据库管理</h3>
                    <a class="btn btn-primary btn-large" href="javascript:void(0)" id="refreshBtn">更新游戏大厅</a>
                    <a class="btn btn-danger btn-large" href="javascript:void(0)" id="initDatabaseBtn">重启数据库</a>
                </div>
                <hr/>
                <h3 style="font-weight: bold">上传文件</h3>
                <input type="file" class="form-control" id="uploadFileInput" />
                <a class="btn btn-success btn-large" href="javascript:void(0)" id="uploadFileBtn">上传文件</a>
            </div>
            <!--Version-->
            <div class="col-sm-12 column well">
                <p style="text-align: center">
                    <a href="./index.jsp"><small style="color: #c12e2a">>返回主页<</small></a><br>
                    <small>WebApp-剧本杀助手 version:v<%=GloableValue.webAppVersion%></small><br>
                    <small>Contact me AT:<a href="http://blog.csdn.net/shenpibaipao" target="_blank">My Blog</a> or send me an <a href="mailto:hdai95@outlook.com" >Email</a></small>
                    <span class="glyphicon-envelope" ></span><br/>
                    <small>_(-ω-`_)⌒)_ Welcome Git Together:<a href="https://gitee.com/shenpibaipao/CardHunter" target="_blank">Git Home</a></small><br/>

                    <small>©CopyRight 2017 45.org.Indi All Rights Reserved. </small>
                </p>
            </div>
        </div>
    </div>
</div>
</body>
</html>

<script>
    $(document).ready(function () {
        $("#refreshBtn").click(function () {

            $.get(
                gv.root+"ReloadDBDatas",
                {
                    pw:$("#pw").val()
                },
                function (data) {
                    $.growl({
                        title: "操作结果",
                        message: data
                    });
                    $("#pw").val("");
                    jump(1,location.href)
                }
            )
        });
        $("#initDatabaseBtn").click(function () {
            $.post(
                gv.root+"ReloadDBDatas",
                {
                    type:"初始化数据库",
                    pw:$("#pw").val()
                },
                function (data) {
                    $.growl({
                        title: "操作结果",
                        message: data
                    });
                    $("#pw").val("");
                    jump(1,location.href)
                }
            )
        });
        $("#uploadFileBtn").click(function () {
            var pic = $("#uploadFileInput")[0].files[0];
            var fd = new FormData();
            fd.append('pw',$("#pw").val() );
            fd.append('uploadFile', pic);
            $.ajax({
                url: gv.root + "FileUploadServlet",
                type: "post",
                // Form数据
                data: fd,
                cache: false,
                contentType: false,
                processData: false,
                success: function (data) {
                    $.growl({
                        title: "操作结果",
                        message: data
                    });
                    $("#pw").val("");
                    jump(1,location.href)
                }
            });
        })
    })
</script>
