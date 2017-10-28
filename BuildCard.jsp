<%--
  Created by IntelliJ IDEA.
  User: a
  Date: 2017/10/25
  Time: 18:03
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>卡牌制作器</title>
    <link rel="stylesheet" href="res/src/css/bootstrap.min.css"/>
    <link rel="stylesheet" href="res/src/jquery-ui-1.12.1.custom/jquery-ui.min.css"/>
    <link rel="stylesheet" href="res/src/css/jquery.growl.css"/>
    <script src="res/src/js/jquery-3.2.1.min.js"></script>
    <script src="res/src/js/bootstrap.min.js"></script>
    <script src="res/src/jquery-ui-1.12.1.custom/jquery-ui.min.js"></script>
    <script src="res/src/js/jquery.growl.js"></script>
    <script src="res/src/js/JsGloableValue.js"></script>
    <script src="res/src/js/BaseTool.js"></script>
</head>
<body>
<form class="form-horizontal">
    <input type="number" class="form-control" id="i1" placeholder="drama"><br/>
    <input type="number" class="form-control" id="i2" placeholder="cardId"><br/>
    <input type="text" class="form-control" id="i3" placeholder="cardName"><br/>
    <input type="text" class="form-control" id="i4" placeholder="cardType" value="text"><br/>
    <input type="text" class="form-control" id="i5" placeholder="attr1"><br/>
    <input type="text" class="form-control" id="i6" placeholder="attr2"><br/>
    <input type="text" class="form-control" id="i7" placeholder="attr3"><br/>
    <input type="text" class="form-control" id="i8" placeholder="content1"><br/>
    <input type="text" class="form-control" id="i9" placeholder="content2"><br/>
    <input type="text" class="form-control" id="i10" placeholder="content3"><br/>
    <input type="text" class="form-control" id="i11" placeholder="content4"><br/>
    <input type="text" class="form-control" id="i12" placeholder="content5"><br/>
    <input type="text" class="form-control" id="i13" placeholder="content6"><br/>
    <input type="text" class="form-control" id="i14" placeholder="content7"><br/>
    <a class="btn btn-primary" id="tijiao">提交</a>
    <pre id="console"></pre>
</form>
</body>
</html>

<script>
$(document).ready(function () {
    var c = $("#console");
    $("#tijiao").click(function () {
        var str =   "INSERT INTO card(cardDrama,cardId,cardName,cardType,attr1,attr2,attr3,content1,content2,content3,content4,content5,content6,content7) value("+
                    "'"+$("#i1").val()+"','"+$("#i2").val()+"','"+$("#i3").val()+"','"+$("#i4").val()+"','"+$("#i5").val()+"','"+$("#i6").val()+"','"+$("#i7").val()+"','"+
                    $("#i8").val()+"','"+$("#i9").val()+"','"+$("#i10").val()+"','"+$("#i11").val()+"','"+$("#i12").val()+"','"+$("#i13").val()+"','"+$("#i14").val()+"'"+
                    ");\n";
        $("#console").html($("#console").html()+str);
        $("#i2").val(parseInt($("#i2").val())+1);

        $("#i3").val("");//$("#i5").val("");$("#i6").val("");$("#i7").val("");
        $("#i8").val("");$("#i9").val("");$("#i10").val("");
        $("#i11").val("");$("#i12").val("");
        $("#i13").val("");$("#i14").val("");
    })
})
</script>
