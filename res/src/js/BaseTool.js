function XSSATKFilter(string) {
    var s = "";
    if(string.length === 0 )return s;
    s = string.replace(/&/g,"&amp;");
    s = s.replace(/</g,"&lt;");
    s = s.replace(/>/g,"&gt;");
    //s = s.replace(/ /g,"&nbsp;");
    s = s.replace(/'/g,"&#39;");
    s = s.replace(/"/g,"&quot;");
    return s;
}
function XSSATKStringRebuild(string) {
    var s = "";
    if(string.length === 0 )return s;
    s = string.replace(/&amp;/g,"&");
    s = s.replace(/&lt;/g,"<");
    s = s.replace(/&gt;/g,">");
    //s = s.replace(/&nbsp;/g," ");
    s = s.replace(/&#39;/g,"\'");
    s = s.replace(/&quot;/g,"\"");
    return s;
}
//JQuery 获取URL参数
$.getUrlParam = function (name) {
    var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)");
    var r = window.location.search.substr(1).match(reg);
    if (r !== null) return unescape(r[2]); return null;
};
//计时跳转
function jump(countSec,url,id) {
    setTimeout(function(){
        countSec--;
        if(countSec > 0) {
            if(id!==undefined)document.getElementById(id).innerHTML = countSec;
            jump(countSec,url,id);
        } else {
            location.href=url;
        }
    }, 1000);
}