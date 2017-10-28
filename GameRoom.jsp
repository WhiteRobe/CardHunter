<%@ page import="web.models.GameObjs.environment.GameRoom" %>
<%@ page import="web.models.GameObjs.spirits.Player" %>
<%@ page import="web.bussiness.gloable.GloableValue" %>
<%@ page import="web.models.GameObjs.items.GameBags" %>
<%@ page import="java.util.List" %>
<%@ page import="web.models.GameObjs.items.Card" %>
<%@ page import="web.models.GameObjs.items.GameItems" %>
<%@ page import="web.models.GameObjs.items.CardDeck" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.LinkedList" %>
<%@ page import="web.bussiness.sbo.MyFilter" %><%--
  Created by IntelliJ IDEA.
  User: a
  Date: 2017/10/25
  Time: 15:21
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<%
GameRoom gameRoom = (GameRoom) request.getSession().getAttribute("GAMEROOM");
if(gameRoom == null){
    response.setStatus(HttpServletResponse.SC_MOVED_PERMANENTLY);
    String newLocn = "./index.jsp";
    response.setHeader("Location",newLocn);
} else {
    Player gm = gameRoom.getGm();
    GameBags gmbag = gm.getItemBag();
    GameBags sealedDeck = (GameBags) gmbag.getItem("sealedDeck");
    GameBags publicDeck = (GameBags) gmbag.getItem("publicDeck");
%>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>游戏房间:<%=gameRoom.getRoomId()%></title>
    <link rel="stylesheet" href="res/src/css/bootstrap.min.css"/>
    <link rel="stylesheet" href="res/src/jquery-ui-1.12.1.custom/jquery-ui.min.css"/>
    <link rel="stylesheet" href="res/src/css/wheelmenu.css"/>
    <link rel="stylesheet" href="res/src/css/jquery.growl.css"/>
    <link rel="stylesheet" href="res/src/css/mywheel.css"/>
    <script src="res/src/js/jquery-3.2.1.min.js"></script>
    <script src="res/src/js/bootstrap.min.js"></script>
    <script src="res/src/jquery-ui-1.12.1.custom/jquery-ui.min.js"></script>
    <script src="res/src/js/jquery.growl.js"></script>
    <script src="res/src/js/JsGloableValue.js"></script>
    <script src="res/src/js/jquery.wheelmenu.min.js"></script>
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
        redtxt{
            color: red
        }
    </style>
</head>
<%
    Player me = (Player) request.getSession().getAttribute("PLAYER");
%>
<body>
<div class="container">
    <!--Head Info-->
    <h3 class="glyphicon glyphicon-th-list"> 房间信息 <small class="glyphicon glyphicon-eye-open" id="titleHideBtn">[点击隐藏/显示]</small></h3>
    <div class="col-sm-12 row clearfix titleHide">
        <hr/><a name="roomInfo"></a>
        <blockquote><p style="text-align: center;font-size: 15px">
            当前<b style="color: #d9534f">房间:<%=gameRoom.getRoomId()%></b> 密码:<%=gameRoom.getRoomPw()%> 已有玩家:<%=gameRoom.getPlayerNum()%>
        </p></blockquote>
    </div>
<div class="row clearfix">
<%
    if( me == null){
%>
    <!--New Player Panel-->
    <div class="col-sm-12 column">
        <div class="col-sm-12 well">
            <div>
                <p style="text-align: center;font-size: 30px;">
                    您尚未<b style="color: #d9534f">加入游戏</b>
                </p>
                <p style="font-size: 20px">
                    &nbsp;&nbsp;在本房间内已有玩家<b style="color: #f0ad4e"><%=gameRoom.getPlayerNum()%>/<%=gameRoom.getMaxPlayers()%></b>，而您尚未拥有角色。<br>
                    &nbsp;&nbsp;若您在本房间内尚未拥有角色，您可以<u>创建</u>一个新角色并尝试<b class="text-primary">[加入游戏]</b>；<br/>
                    &nbsp;&nbsp;若您在本房间内曾拥有角色，您可以输入<u>角色编号</u>和<u>角色密码</u>并尝试<b class="text-primary">[重新加入游戏]</b>。<br>
                    &nbsp;&nbsp;最后，祝您游戏愉快。
                </p>
            </div>
            <hr/>
            <div class="col-sm-12">
                <h3 style="font-weight: bold">创建一个角色</h3>
                <small>还没有角色？ </small>
                <a class="btn btn-primary btn-large" href="javascript:void(0)" id="createGamePlyer">点击创建角色</a>
                <small> 或者，您可以尝试重新加入游戏：</small>
            </div>
            <div class="col-sm-12">
                <hr/>
                <h3 style="font-weight: bold">尝试重新加入游戏</h3>
                <label><input type="number" class="form-control" placeholder="角色编号" id="playerIdInput" onkeyup="this.value=this.value.replace(/[^\d.]/g,'')" onafterpaste="this.value=this.value.replace(/[^\d.]/g,'')"/></label>
                <label><input type="number" class="form-control" placeholder="角色密码" id="playerPwInput" onkeyup="this.value=this.value.replace(/[^\d.]/g,'')" onafterpaste="this.value=this.value.replace(/[^\d.]/g,'')"/></label>
                <a class="btn btn-success btn-large" href="javascript:void(0)" id="joinGamePlyer">重新加入游戏</a>
            </div>
        </div>
    </div>
<%
    } else {
%>  <!--已登录-->

    <div class="col-sm-12 titleHide">
        <blockquote><p style="text-align: center;font-size: 15px;">
            当前<b style="color: #d9534f">角色:<%=me.getPlayerId()%></b> 密码:<%=me.getPlayerPw()%>
        </p></blockquote>
    </div>

    <!--轮盘菜单-->
    <div>
        <a href="#wheel1" class="wheel-button e"><span>+</span></a>
        <ul id="wheel1" data-angle="E" class="wheel">
            <li class="item"><a href="#roomInfo">房</a></li>
            <li class="item"><a href="#public">公</a></li>
            <li class="item"><a href="#postBoard">讨</a></li>
            <li class="item"><a href="#private">私</a></li>
            <li class="item"><a href="#roll">骰</a></li>
            <li class="item"><a href="#version">管</a></li>
        </ul>
    </div>
    <hr/>


    <!--公共信息区-->
    <a name="public"></a>
    <h3 class="glyphicon glyphicon-globe">
        <b>公共区域</b>
    </h3><hr/>
    <div class="col-sm-12 column">
        <div class="col-md-12 column">
            <div class="panel-group" id="panel-889995">

                <div class="panel panel-primary">
                    <div class="panel-heading">
                        <a class="panel-title collapsed" data-toggle="collapse" data-parent="#panel-889995" href="#panel-element-937312">
                            密封牌堆
                        </a>
                    </div>
                    <div id="panel-element-937312" class="panel-collapse collapse">
                        <div class="panel-body">
                            <a class="btn btn-primary" data-toggle="modal" data-target="#choukaPickModel" id="choukaPick">选择</a>
                            <a class="btn btn-success" data-toggle="modal" data-target="#choukaModel" id="chouka">抽牌</a>
                            <a class="btn btn-danger" data-toggle="modal" data-target="#choukaXipaiModel" id="choukaXipai">洗牌</a>
                        </div>
                    </div>
                </div>

                <div class="panel panel-success">
                    <div class="panel-heading">
                        <a class="panel-title" data-toggle="collapse" data-parent="#panel-889995" href="#panel-element-560942">
                            可见牌堆
                        </a>
                    </div>
                    <div id="panel-element-560942" class="panel-collapse in">
                        <div class="panel-body">
                            <a class="btn btn-primary" data-toggle="modal" data-target="#publicDeckModel">查看所有</a>
                            <a class="btn btn-success" data-toggle="modal" data-target="#publicDeckModelGroup">分组查看</a>
                        </div>
                    </div>
                </div>

            </div>
        </div>
        <hr/>
    </div>

    <!--讨论板-->
    <a name="postBoard"></a>
    <h3 class="glyphicon glyphicon-play"  >
        <b>讨论板 </b><small class="glyphicon glyphicon-eye-open" id="postBoardHideBtn">[点击隐藏/显示]</small>
    </h3><hr/>
    <div class="col-sm-12 column well postBoardHide">
        <div class="pre-scrollable" style="max-height: 300px;overflow:auto">
            <table class="table table-striped table-hover .table-bordered" width="auto" style="white-space:nowrap">
                <thead>
                <tr>
                    <th>发布人</th>
                    <th>发布内容</th>
                    <th>发布时间</th>
                </tr>
                </thead>
                <tbody id="postBoardContent">
                <!--AJAX提供数据-->
                </tbody>
            </table>
        </div>
        <hr/>
        <a class="btn btn-primary" data-toggle="modal" data-target="#pushMsgModal">发布</a>
        <a class="btn btn-success" id="manuelRefreshBtn">刷新</a>
        <a class="btn btn-danger" id="autoRefreshMsgBoardSwitchBtn">当前:自动更新</a>
    </div>

    <!--私人信息区-->
    <a name="private"></a>
    <h3 class="glyphicon glyphicon-user" >
        <b>私人区域</b>
    </h3><hr/>
    <small>点击线索可查看详细内容;[展示]将把线索展示到公共区；其他两个选项暂时没用。</small>
    <div class="col-sm-12 column well">
        <div>
            <%
                CardDeck myDeck = (CardDeck) me.getItemBag();
                for(GameItems item:myDeck.getBag().values()){
                	Card card = (Card)item;
                	String content = card.getCardContent().getStates("content1");
                	if(card.getCardType().equals("pic"))content="<img src='./res/pic/"+content+"' width='90%w'/>";//如果是图片就显示为图片
                	else content = MyFilter.XXSRebuild(content);
                    out.print("<button type='button' rel='popover' class='btn btn-default oldPopWindow' data-original-title='所属:"+card.getCardAttr().getStates("attr1")+"' " +
                            "data-container='body' data-toggle='popover' data-placement='top' name='t"+card.getCardId()+"' " +
                            "data-content=''>" +
                            "<b>"+card.getCardId()+":"+card.getCardName()+" </b>"+
                            "<a class='btn btn-primary cardUse' name='t"+card.getCardId()+"'>打出</a>" +
                            "<a class='btn btn-success cardShow' name='t"+card.getCardId()+"'>展示</a>" +
                            "<a class='btn btn-danger cardRemove' name='t"+card.getCardId()+"'>移除</a>" +
                            "</button>" +
                            "<div id='popover_content_wrapper"+card.getCardId()+"' style='display: none'>" +
                            content+
                            "</div>");
                }
            %>
        </div>
    </div>

    <!--Roll点-->
    <a name="roll"></a>
    <h3 class="glyphicon glyphicon-question-sign">
        <b>Roll点器</b>
    </h3>
    <hr/>
    <div class="col-sm-12 column well">
        <button id="rollBtn" class="btn btn-success">获取随机数</button>
        &nbsp;Roll点结果为:<b id="rollContent" style="color: red">??/??</b>
    </div>

    <!--控制台-->
    <a name="version"></a>
    <h3 class="glyphicon glyphicon-tower">
        <b>控制台 </b><small class="glyphicon glyphicon-eye-open" id="consoleHideBtn">[点击隐藏/显示]</small>
    </h3><hr/>
    <div class="col-sm-12 column well consoleHide">
        <small>您好！<b><%=me.getStates().getStates("playerName")%></b>，
        您可以选择：</small><br/><br/>
        <a class="btn btn-default" data-toggle="modal" data-target="#cgPlayerName">更换名字</a>
        <a class="btn btn-success"  data-toggle="modal" data-target="#switchPlayer">更换玩家</a>
        <a class="btn btn-danger" id="exitRoom">离开游戏</a>
        <%  //房间主人拥有控制游戏的能力
            if(gameRoom.getRoomOwner() == me){
            	out.println("<br/><br/><small>您是房间主人，您可以选择：</small><br/><br/>");
                out.println("<a class='btn btn-primary' data-toggle='modal' data-target='#chooseGame'>初始化游戏</a>");
            }
        %>
    </div>

    <!--Version-->
    <div class="col-sm-12 column well">
        <p style="text-align: center">
            <small>WebApp-剧本杀助手 version:v<%=GloableValue.webAppVersion%></small><br>
            <small>Contact me AT:<a href="http://blog.csdn.net/shenpibaipao" target="_blank">My Blog</a> or send me an <a href="mailto:hdai95@outlook.com" >Email</a></small>
            <span class="glyphicon-envelope" ></span><br/>
            <small>_(-ω-`_)⌒)_ Welcome Git Together:<a href="https://gitee.com/shenpibaipao/CardHunter" target="_blank">Git Home</a></small><br/>

            <small>©CopyRight 2017 45.org.Indi All Rights Reserved. </small><br>
        </p>
    </div>

    <!------------------------------------------------------------->
    <!--Model抽卡框:随机抽卡组-->
    <div class="modal fade" id="choukaModel" tabindex="-1" role="dialog" aria-hidden="true" style="top:50px">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title glyphicon glyphicon-plus"> 抽取卡牌</h4>
            </div>
            <div class="modal-body">
                选择卡组:
                <label><select class="form-control">
                    <!--AJAX提供数据-->
                </select></label>
                尚余:<b>?</b>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="pickCardConfirmBtn">抽取</button>
            </div>
        </div>
    </div>
</div>

    <!--Model抽卡框:特定选出-->
    <div class="modal fade" id="choukaPickModel" tabindex="-1" role="dialog" aria-hidden="true" style="top:50px">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h4 class="modal-title glyphicon glyphicon-plus"> 抽取卡牌[选出]</h4>
                </div>
                <div class="modal-body">
                    选择卡片:<input type="number" class="form-control" placeholder="卡牌编号" onkeyup="this.value=this.value.replace(/[^\d.]/g,'')" onafterpaste="this.value=this.value.replace(/[^\d.]/g,'')"/>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                    <button type="button" class="btn btn-primary" id="pickCardConfirmBtnPre">抽取</button>
                </div>
            </div>
        </div>
    </div>

    <!--Model查看公共框:所有查看-->
    <div class="modal fade" id="publicDeckModel" tabindex="-1" role="dialog" aria-hidden="true" style="top:50px">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h4 class="modal-title glyphicon glyphicon-eye-open"> 查看卡牌</h4>
                </div>
                <div class="modal-body">
                    <!--Ajax提供数据-->
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                </div>
            </div>
        </div>
    </div>

    <!--Model查看公共框:分组查看-->
    <div class="modal fade" id="publicDeckModelGroup" tabindex="-1" role="dialog" aria-hidden="true" style="top:50px">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h4 class="modal-title glyphicon glyphicon-eye-open"> 查看卡牌[分组]</h4>
                </div>
                <div class="modal-body">
                    选择分组：<label><select class="form-control">
                    <!--Ajax提供数据-->
                    </select></label>&nbsp;共有：<b>?</b>
                    <p class="well">
                        <!--Ajax提供数据-->
                        数据
                    </p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                </div>
            </div>
        </div>
    </div>

    <!--初始化游戏选择框-->
    <div class="modal fade" id="chooseGame" tabindex="-1" role="dialog" aria-hidden="true" style="top:50px">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h4 class="modal-title glyphicon glyphicon-gift"> 选择剧本</h4>
                </div>
                <div class="modal-body">
                    选择剧本:
                    <label><select class="form-control">
                        <!--AJAX提供数据-->
                    </select></label>
                    剧本名:<b>?</b>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                    <button type="button" class="btn btn-success" data-dismiss="modal" id="initGame">选择剧本</button>
                </div>
            </div>
        </div>
    </div>

    <!--更换玩家框-->
    <div class="modal fade" id="switchPlayer" tabindex="-1" role="dialog" aria-hidden="true" style="top:50px">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h4 class="modal-title glyphicon glyphicon-retweet"> 更换玩家</h4>
                </div>
                <div class="modal-body">
                    <input class="form-control" placeholder="请输入角色编号" id="switchPlayerIdInput" onkeyup="this.value=this.value.replace(/[^\d.]/g,'')" onafterpaste="this.value=this.value.replace(/[^\d.]/g,'')"/>
                    <input class="form-control" placeholder="请输入角色密码" id="switchPlayerPwInput" onkeyup="this.value=this.value.replace(/[^\d.]/g,'')" onafterpaste="this.value=this.value.replace(/[^\d.]/g,'')"/>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                    <button type="button" class="btn btn-success" data-dismiss="modal" id="switchPlayerComfirmBtn">登陆</button>
                </div>
            </div>
        </div>
    </div>

    <!--更换角色名框-->
    <div class="modal fade" id="cgPlayerName" tabindex="-1" role="dialog" aria-hidden="true" style="top:50px">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h4 class="modal-title glyphicon glyphicon-upload"> 更换角色名</h4>
                </div>
                <div class="modal-body">
                    <input class="form-control" placeholder="请输入新角色名字"/>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                    <button type="button" class="btn btn-success" data-dismiss="modal" id="cgPlayerNameComfirmBtn">修改</button>
                </div>
            </div>
        </div>
    </div>

    <!--发布讨论板框-->
    <div class="modal fade" id="pushMsgModal" tabindex="-1" role="dialog" aria-hidden="true" style="top:50px">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h4 class="modal-title glyphicon glyphicon-tag"> 发布讨论消息</h4>
                </div>
                <div class="modal-body">
                    <textarea style="height: 100px" class="form-control" placeholder="请输入消息"></textarea>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                    <button type="button" class="btn btn-success" data-dismiss="modal" id="pushMsgModalBtn">发布</button>
                </div>
            </div>
        </div>
    </div>
<%
    }
%>
</div>
</div>
</body>
</html>

<!--加入（创建玩家）、离开游戏、更换玩家等-->
<script>
$(document).ready(function () {
    //创建角色
    $("#createGamePlyer").click(function () {
        $.get(
            gv.root+"GameCreatePlayer",
            function (data) {
                //console.log(data);
                if(data.indexOf("true")>=0){
                    var index1 = data.indexOf(":");
                    var index2 = data.indexOf(":",index1+1);
                    //console.log(data.substring(index1+1,index2),data.substring(index2+1));
                    var playerId = data.substring(index1+1,index2);
                    var playerPW = data.substring(index2+1);
                    $.growl.notice({
                        title: "创建角色成功",
                        message: "角色编号:"+playerId+" 角色密码:"+playerPW
                    });
                    jump(1,location.href);
                } else if (parseInt(data) === -1){
                    $.growl.error({
                        title: "创建角色失败",
                        message: "房间玩家已满。"
                    });
                } else if (parseInt(data) === -2){
                    $.growl.warning({
                        title: "创建角色失败",
                        message: "网络错误，请重试！"
                    });
                }
            }
        );
    });
    //加入角色
    $("#joinGamePlyer").click(function () {
        $.post(
            gv.root+"GameCreatePlayer",
            {
                playerId:$("#playerIdInput").val(),
                playerPw:$("#playerPwInput").val()
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
                        title: "加入游戏成功",
                        message: "角色编号:"+roomId+" 角色密码:"+roomPW
                    });
                    jump(1,location.href);
                } else {
                    $.growl.error({
                        title: "加入游戏失败",
                        message: "角色编号或密码错误，请重试！"
                    });
                }
            }
        );
    });
    //离开游戏（房间）
    $("#exitRoom").click(function () {
        $.get(
            gv.root+"ExitRoom",
            function (data) {
                //console.log(data);
                if(data.indexOf("true")>=0){

                    $.growl.notice({
                        title: "离开游戏成功",
                        message: "稍后将自动返回大厅"
                    });
                    jump(1,"./index.jsp");
                } else {
                    $.growl.warning({
                        title: "离开游戏失败",
                        message: "网络错误，请重试！"
                    });
                }
            }
        );
    });
    //更换角色（玩家）
    $("#switchPlayerComfirmBtn").click(function () {
        var id = $("#switchPlayerIdInput").val();
        var pw = $("#switchPlayerPwInput").val();
        $.post(
            gv.root+"ExitRoom",
            {
                playerId:id,
                playerPw:pw
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
                        title: "加入游戏成功",
                        message: "角色编号:"+roomId+" 角色密码:"+roomPW
                    });
                    jump(1,location.href);//刷新网页
                } else {
                    $.growl.error({
                        title: "加入游戏失败",
                        message: "角色编号或密码错误，请重试！"
                    });
                    $("#switchPlayerIdInput").val("");//清空数据
                    $("#switchPlayerPwdInput").val("");
                }
            }
        )
    });
    //更换角色名
    $("#cgPlayerNameComfirmBtn").click(function () {
        var newname = XSSATKFilter($("#cgPlayerName .modal-body input").val());
        $.post(
            gv.root+"PlayerInfoChange",
            {
                newName:XSSATKFilter(newname)
            },
            function (data) {
                //console.log(data);
                if(data.indexOf("false")===0){
                    $.growl.error({
                        title: "修改名字失败",
                        message: "修改失败，请稍后重试！"
                    });
                    $("#cgPlayerName .modal-body input").val("");//清空数据
                } else {
                    $.growl.notice({
                        title: "修改名字成功",
                        message: "角色新名:"+newname
                    });
                    jump(1,location.href)
                }
            }
        )
    })
})
</script>
<!--轮盘等显示效果-->
<script>
$(document).ready(function () {
    //标题Div显示与隐藏
    var isHidePlayerInfo = false;
    $("#titleHideBtn").click(function () {
        if(isHidePlayerInfo){
            $("div .titleHide").css("display","inherit");
            isHidePlayerInfo = false;
        } else {
            $("div .titleHide").css("display","none");
            isHidePlayerInfo = true;
        }
    });
    //控制台显示、隐藏
    var isHideConsoleInfo = false;
    $("#consoleHideBtn").click(function () {
        if(isHideConsoleInfo){
            $("div .consoleHide").css("display","inherit");
            isHideConsoleInfo = false;
        } else {
            $("div .consoleHide").css("display","none");
            isHideConsoleInfo = true;
        }
    });
    //讨论板显示、隐藏
    var postBoardHideInfo = false;
    $("#postBoardHideBtn").click(function () {
        if(postBoardHideInfo){
            $("div .postBoardHide").css("display","inherit");
            postBoardHideInfo = false;
        } else {
            $("div .postBoardHide").css("display","none");
            postBoardHideInfo = true;
        }
    });
    //弹出框显示效果
    $("[data-toggle='popover']")
    .each(function () {
        var mid = $(this).attr('name').replace("t","");
        //console.log($(this).attr('name'));
        $(this).popover({
            html: true,
            content: function () {
                return $('#popover_content_wrapper'+mid).html();
            }
        })  /*//悬浮显示和自动消失
            .on("mouseenter", function () {
                var _this = this;
                $(this).popover("show");
                $(this).siblings(".popover").on("mouseleave", function () {
                    $(_this).popover('hide');
                });
            })*/
            .on("mouseleave", function () {
                var _this = this;
                setTimeout(function () {
                    if (!$(".popover:hover").length) {
                        $(_this).popover("hide")
                    }
                }, 100)
            });
    });


    $(".wheel-button").wheelmenu({
        trigger: "hover", // Can be "click" or "hover". Default: "click"
        animation: "fade", // Entrance animation. Can be "fade" or "fly". Default: "fade"
        animationSpeed: "fast", // Entrance animation speed. Can be "instant", "fast", "medium", or "slow". Default: "medium"
        angle: "E"// Angle which the menu will appear. Can be "all", "N", "NE", "E", "SE", "S", "SW", "W", "NW", or even array [0, 360]. Default: "all" or [0, 360]
    });
    var rollTimes = 1;
    $("#rollBtn").click(function () {
        $("#rollContent").html(parseInt(Math.random()*100)+"/"+rollTimes++);
    });
});
</script>
<!--初始化游戏、抽卡-->
<script>
$(document).ready(function () {
    //获取剧本列表
    var dramaList=new Array();
    $("#chooseGame").on('show.bs.modal',function () {
        $.get(
            gv.root+"GameRoomInitServlet",
            function (data) {
                if(data.indexOf("false")>=0){

                } else {
                    data = $.parseXML(data);
                    $("#chooseGame select").html("");
                    var sum = data.getElementsByTagName("sum")[0].childNodes[0].nodeValue;
                    for(var i=0;i<sum;i++){
                        var name = data.getElementsByTagName("unit")[i].childNodes[0].childNodes[0].nodeValue;
                        dramaList[i] = data.getElementsByTagName("unit")[i].childNodes[1].childNodes[0].nodeValue;
                        $("#chooseGame select").html($("#chooseGame select").html()+"<option>"+name+"</option>");
                    }
                    $("#chooseGame .modal-body b").html(dramaList[0]);//第一项赋值
                }
            }
        )
    });
    //动态显示剧本名字
    $("#chooseGame select").change(function () {
        var i = $(this).get(0).selectedIndex;
        $("#chooseGame .modal-body b").html(dramaList[i]);
    });

    //确认剧本
    $("#initGame").click(function () {
        var dramaId = $("#chooseGame select").val();
        $.post(
            gv.root+"GameRoomInitServlet?drama="+dramaId,
            {
                drama:$("#chooseGame select").val()
            },
            function (data) {
                if(data.indexOf("true")>=0){
                    $.growl.notice({
                        title: "选择剧本成功",
                        message: "请等待数据刷新"
                    });
                    jump(1,location.href)
                }
            }
        )
    });

    //获取可抽取的列表
    var remains=new Array();
    $("#chouka").click(function () {
        $.get(
            gv.root+"PickCard",
            function (data) {
                //onsole.log(data);
                data = $.parseXML(data);
                $("#choukaModel select").html("");
                var sum = data.getElementsByTagName("sum")[0].childNodes[0].nodeValue;
                for(var i=0;i<sum;i++){
                    var name = data.getElementsByTagName("unit")[i].childNodes[0].childNodes[0].nodeValue;
                    remains[i] = data.getElementsByTagName("unit")[i].childNodes[1].childNodes[0].nodeValue;
                    $("#choukaModel select").html($("#choukaModel select").html()+"<option>"+name+"</option>");
                }
                $("#choukaModel .modal-body b").html(remains[0]);//第一项赋值
            }
        )
    });
    //动态显示尚余数目
    $("#choukaModel select").change(function () {
        var i = $(this).get(0).selectedIndex;
        $("#choukaModel .modal-body b").html(remains[i]);
    });
    //最终执行抽卡
    $("#pickCardConfirmBtn").click(function () {
        $.post(
            gv.root+"PickCard",
            {
              pick:$("#choukaModel select").val()
            },
            function (data) {
                //console.log(data);
                $("#choukaModel").modal('hide');
                if(data.indexOf("true")>=0){
                    //更新个人区数据
                    $.growl.notice({
                        title: "抽卡成功",
                        message: "请等待数据刷新"
                    });
                    jump(1,location.href)
                } else {
                    $.growl.error({
                        title: "抽卡失败",
                        message: "卡组已空或网络异常!"
                    });
                }
            }
        )
    });
    //精确抽卡
    $("#pickCardConfirmBtnPre").click(function () {
        $.post(gv.root+"PickCard",
            {
                pick:"any",
                cardId:$("#choukaPickModel .modal-body input").val()
            },
            function (data) {
            $("#choukaPickModel").modal('hide');
            $("#choukaPickModel .modal-body input").val("");
            if(data.indexOf("true")>=0){
                //更新个人区数据
                $.growl.notice({
                    title: "抽卡成功",
                    message: "请等待数据刷新"
                });
                jump(1,location.href)
            } else {
                $.growl.error({
                    title: "抽卡失败",
                    message: "请确认卡片序号!"
                });
            }
        })
    })
})
</script>
<!--展示、查看、打出卡牌-->
<script>
$(document).ready(function () {
    //展示卡牌
    $(".cardShow").click(function () {
        var id = $(this).attr("name").replace("t","");
        //console.log(id);
        $.post(
            gv.root+"GetPublicCard",
            {
                cardId:id
            },
            function (data) {
                //console.log(data);
                if(data.indexOf("true")>=0){
                    $.growl.notice({
                        title: "展示成功",
                        message: "卡片编号:"+id
                    });
                }
            }
        );
    });
    //获取公共卡牌
    $("#publicDeckModel").on('show.bs.modal', function () {
        $.get(
            gv.root+"GetPublicCard",
            function (data) {
                //console.log(data);
                if(data.indexOf("false")>=0){

                } else {
                    data = $.parseXML(data);
                    var p = $("#publicDeckModel .modal-body");p.html("");
                    var sum = data.getElementsByTagName("sum")[0].childNodes[0].nodeValue;
                    for(var i=0;i<sum;i++){
                        var cardid = data.getElementsByTagName("unit")[i].childNodes[0].childNodes[0].nodeValue;
                        var name = data.getElementsByTagName("unit")[i].childNodes[1].childNodes[0].nodeValue;
                        var type = data.getElementsByTagName("unit")[i].childNodes[2].childNodes[0].nodeValue;
                        var attr1 = data.getElementsByTagName("unit")[i].childNodes[3].childNodes[0].nodeValue;
                        var content1 = data.getElementsByTagName("unit")[i].childNodes[4].childNodes[0].nodeValue;
                        //console.log(name,attr1,content1);
                        if (type === "pic") content1="<img src='./res/pic/"+content1+"' width='90%w'/>";
                        else  content1 = XSSATKStringRebuild(content1);
                        var str = "<button type='button' rel='popover' class='btn btn-default newPopWindow' data-original-title='所属:"+attr1+"' " +
                            "data-container='body' data-toggle='popover' data-placement='bottom' name='nt"+cardid+"' " +
                            "data-content=''>" +
                            "<b>"+name+" '"+cardid+"-所属:"+attr1+"'</b>"+
                            "</button>" +
                            "<div id='popover_content_wrapper_N"+cardid+"' style='display: none'>" +
                            content1+
                            "</div>";
                        p.html(p.html()+str);
                    }
                    //刷新显示插件
                    $(".newPopWindow").each(function () {
                        var mid = $(this).attr('name').replace("nt", "");
                        //console.log($(this).attr('name'));
                        $(this).popover({
                            html: true,
                            content: function () {
                                return $('#popover_content_wrapper_N' + mid).html();
                            }
                        });
                    });
                }
            }
        )
    });
    //设置模态框消失则弹出框跟着消失
    $("#publicDeckModel").on('hide.bs.modal', function () {
        $('.newPopWindow').popover('hide');
    });

    //第一次显示公共卡牌分组情况[分组]
    var groupNum=new Array();
    $("#publicDeckModelGroup").on('show.bs.modal', function () {
        $.get(
            gv.root+"GetPublicCardGroup",
            function (data) {
                //console.log(data);
                if(data.indexOf("false")>=0){
                    //获取失败后的结果
                } else {
                    data = $.parseXML(data);
                    $("#publicDeckModelGroup select").html("");
                    var sum = data.getElementsByTagName("sum")[0].childNodes[0].nodeValue;
                    for(var i=0;i<sum;i++){
                        var name = data.getElementsByTagName("unit")[i].childNodes[0].childNodes[0].nodeValue;
                        groupNum[i] = data.getElementsByTagName("unit")[i].childNodes[1].childNodes[0].nodeValue;
                        $("#publicDeckModelGroup select").html($("#publicDeckModelGroup select").html()+"<option>"+name+"</option>");
                    }
                    $("#publicDeckModelGroup .modal-body b").html(groupNum[0]);//第一项赋值
                    initPublicDeckModelGroup();
                }
            }
        )
    });
    //动态显示公共卡牌分组情况[分组]
    $("#publicDeckModelGroup select").change(function () {
        var i = $(this).get(0).selectedIndex;
        $("#publicDeckModelGroup .modal-body b").html(groupNum[i]);
    });
    //获取公共卡牌[分组]
    function initPublicDeckModelGroup() {
        $.post(
            gv.root+"GetPublicCardGroup",
            {
                group:$("#publicDeckModelGroup select").val()
            },
            function (data) {
                //console.log(data);
                if(data.indexOf("false")>=0){

                } else {
                    data = $.parseXML(data);
                    var p = $("#publicDeckModelGroup .modal-body p");p.html("");
                    var sum = data.getElementsByTagName("sum")[0].childNodes[0].nodeValue;
                    for(var i=0;i<sum;i++){
                        var cardid = data.getElementsByTagName("unit")[i].childNodes[0].childNodes[0].nodeValue;
                        var name = data.getElementsByTagName("unit")[i].childNodes[1].childNodes[0].nodeValue;
                        var type = data.getElementsByTagName("unit")[i].childNodes[2].childNodes[0].nodeValue;
                        var attr1 = data.getElementsByTagName("unit")[i].childNodes[3].childNodes[0].nodeValue;
                        var content1 = data.getElementsByTagName("unit")[i].childNodes[4].childNodes[0].nodeValue;
                        //console.log(name,attr1,content1);
                        if (type === "pic") content1="<img src='./res/pic/"+content1+"' width='90%w'/>";
                        else  content1 = XSSATKStringRebuild(content1);
                        var str = "<button type='button' rel='popover' class='btn btn-default newPopWindowGroup' data-original-title='G所属:"+attr1+"' " +
                            "data-container='body' data-toggle='popover' data-placement='bottom' name='ntg"+cardid+"' " +
                            "data-content=''>" +
                            "<b>"+name+" '"+cardid+"-所属:"+attr1+"'</b>"+
                            "</button>" +
                            "<div id='popover_content_wrapper_NG"+cardid+"' style='display: none'>" +
                            content1+
                            "</div>";
                        p.html(p.html()+str);
                    }
                    //刷新显示插件
                    $(".newPopWindowGroup").each(function () {
                        var mid = $(this).attr('name').replace("ntg", "");
                        //console.log($(this).attr('name'));
                        $(this).popover({
                            html: true,
                            content: function () {
                                return $('#popover_content_wrapper_NG' + mid).html();
                            }
                        });
                    });
                }
            }
        )
    }
    $("#publicDeckModelGroup select").change(function () {
        initPublicDeckModelGroup();
        $('.newPopWindowGroup').popover('hide');//换项目就隐藏旧的
    });
    //设置模态框消失则弹出框跟着消失[分组]
    $("#publicDeckModelGroup").on('hide.bs.modal', function () {
        $('.newPopWindowGroup').popover('hide');
    });

    /*
    var str = "<button type='button' class='btn btn-default newPopWindow' title='所属:"+attr1+"' " +
        "data-container='body' data-toggle='popover' data-placement='top' " +
        "data-content='"+content1+"'>" +
        "<b>"+name+"'-所属:"+attr1+"'</b>"+
        "</button>";*/
})
</script>
<!--讨论板相关-->
<script>
$(document).ready(function () {
    //发布讨论板消息
    $("#pushMsgModalBtn").click(function () {
        var str = XSSATKFilter($("#pushMsgModal .modal-body textarea").val());
        $("#pushMsgModal .modal-body textarea").val("");
        $.post(
            gv.root+"MsgBoarderServlet",
            {
                msg:str
            },
            function (data) {
                if(data.indexOf("true")>=0){
                    $.growl.notice({
                        title: "发布成功",
                        message: "请手动刷新或在自动刷新模式下等待数据更新"
                    });
                } else {
                    $.growl.error({
                        title: "发布失败",
                        message: "请稍后重试！"+data.replace("false:","")
                    });
                }
            }
        );
    });
    //切换自动更新-手动更新
    //var autoRefreshMsgBoard = true;
    $("#autoRefreshMsgBoardSwitchBtn").click(function () {
        if(autoRefreshMsgBoard){
            $(this).html("当前:手动更新");
            autoRefreshMsgBoard=false;
        } else {
            $(this).html("当前:自动更新");
            autoRefreshMsgBoard=true;
        }
    });
    //手动更新
    $("#manuelRefreshBtn").click(function () {
        //console.log(autoRefreshMsgBoard);
        if(autoRefreshMsgBoard === true) return;//自动获取时，该按钮无效
        else $.refreshMsgBoard(1);
    });
    //定时获取新的消息
    $.refreshMsgBoard(1);//自动执行更新查询
});
var autoRefreshMsgBoard = true;
</script>
<!--自动查询的脚本-->
<script>
//获取讨论板消息
$.extend({
    refreshMsgBoard : function (times) {
        var Times = times;//获取次数
        if(Times === 0 ){
            if(autoRefreshMsgBoard === true) Times=1;//如果是自动获取，仍继续，否则退出
            else return;
        }//0次之后直接返回
        $.get(gv.root+"MsgBoarderServlet",
            function (data) {
                //console.log(data+Times);
                if(data.indexOf("false")===0){
                    setTimeout("$.refreshMsgBoard("+--Times+")",20*1000);//失败 20秒后重试
                } else {
                    data = $.parseXML(data);
                    $("#postBoardContent").html("");
                    var sum = data.getElementsByTagName("sum")[0].childNodes[0].nodeValue;
                    for(var i=0;i<sum;i++){
                        var sendid = data.getElementsByTagName("unit")[i].childNodes[0].childNodes[0].nodeValue;
                        var msg = data.getElementsByTagName("unit")[i].childNodes[1].childNodes[0].nodeValue;
                        var dates = data.getElementsByTagName("unit")[i].childNodes[2].childNodes[0].nodeValue;
                        var times = data.getElementsByTagName("unit")[i].childNodes[3].childNodes[0].nodeValue;
                        $("#postBoardContent").html(
                            $("#postBoardContent").html()+
                            "<tr>" +
                            "<td>"+sendid+"</td>"+
                            "<td>"+msg+"</td>"+
                            "<td>"+times+"</td>"+
                            "</tr>");
                    }
                    setTimeout("$.refreshMsgBoard("+--Times+")",1000*10);//10秒刷新一次
                }
            }
        );
    }
});

</script>
<%
}
%>