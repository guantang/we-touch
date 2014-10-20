/**
 * Created with IntelliJ IDEA.
 * User: Administrator
 * Date: 14-9-22
 * Time: 下午4:22
 * To change this template use File | Settings | File Templates.
 */


function next(flag) {
    var obj = get($("#customerlist tr.sel"), 0);
    var next = null;
    if(obj) {
        next = get(flag? $(obj).next("tr"): $(obj).prev("tr"), 0);
    } else {
        next = flag? $("#customerlist tr").first(): $("#customerlist tr").last();
    }
    if(next) {
        if(obj) {
            $(obj).removeClass("sel");
        }
        $(next).addClass("sel");
    }
}


function get(array, index) {
    if(array.length && array.length > index) {
        return array[index];
    } else {
        return null;
    }
}

function select() {
    var obj = get($("#customerlist tr.sel"), 0);
    if (obj) {
        $("#searchtext").val($(obj).text());
        var customername = $(obj).text().split(' ')[0];
        $("#defaultdomain").text(customers[customername].domain);
        $('#domain').val(customers[customername].domain);
        $("#customername").text(customername);
        $("#loginaccount").text(customers[customername].account);
        $('#account').val(customers[customername].account);
        $("#customers").css("display", "none");
    }
}

function setPosition() {
    var offset1 = $("#customers").offset();
    var offset2 = $("#searchtext").offset();
    offset1.left = offset2.left;
    offset1.top = offset2.top + $("#contain").height;
    $("#customers").offset(offset1);
    $("#customerlist").width($("#searchtext").width());
//    $("#customers").offsetTop = $("#searchtext").offsetTop;
    $("#customers").css("display", "block");
}

function clearSelect() {
    $("#customerlist tr.sel").removeClass("sel");
}


function isEnterKeyDown(e) {
    if (e.keyCode == 13) {
        return false;
    }
    return true;
}

function getCookie(name) {
    var reg = new RegExp("(^| )" + name + "=([^;]*)(;|$)", "gi");
    var tmp = reg.exec(document.cookie);
    return unescape((tmp || [])[2] || "");
}

function setCookie(name, value) {
    document.cookie = name + '=' + escape(value)
        + ";expires=" + (new Date(1990, 1, 1)).toGMTString();  // ɾ�� path ���� cookie
    document.cookie = name + '=' + escape(value) + ";path=/"       // ֻ�������� cookie
        + ";expires=" + (new Date(2099, 12, 31)).toGMTString();
}

function loginFocus(){
    if (getCookie("username")) {
        document.getElementById("username").value = getCookie("username");
        document.getElementById("password").focus();
    } else {
        document.getElementById("username").focus();
    }

}
function saveUsername(theForm) {
    if(document.getElementById("rememberMe").checked){
        var expires = new Date();
        expires.setTime(expires.getTime() + 24 * 30 * 60 * 60 * 1000); // sets it for approx 30 days.
        setCookie("username", theForm.username.value);
    }
}





