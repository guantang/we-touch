<%@ include file="/taglibs.jsp"%>

<fmt:setBundle basename="ApplicationResources"/>

<head>
    <title><fmt:message key="icmc.btn.login"/></title>
    <meta name="heading" content="<fmt:message key='menu.login'/>"/>
    <link rel="stylesheet" type="text/css" media="all" href="<c:url value='/static/login/login.css'/>" />
    <script type="text/javascript" src="${ctx}/scripts/login.js"></script>
    <script type="text/javascript" src="${ctx}/static/lib/jquery/jquery-1.8.3.js"></script>
    <script type="text/javascript">
        var customers;
        $(function(){
            //IE
            /*if($.browser.msie){
                $("#searchtext").get(0).attachEvent("onpropertychange",function (o){
                    getCustomer(o.srcElement.value);
                });
                //非IE
            }else{
                $("#searchtext").get(0).addEventListener("input",function(o){
                    getCustomer(o.target.value);
                },false);
            } */
            $(window).resize(function() {
//                $("#customers").css("display", "none");
                setPosition();
            });

            $("#searchtext").focusout(
                function(o) {
                    var t = setTimeout('$("#customers").slideUp();', 400);

                }
            )
            $("#searchtext").focus(
                function(o) {
                    if($.browser.msie){
//                        $("#customers").css("display", "table");
                        getCustomer(o.srcElement.value);
                        //非IE
                    }else{
//                        $("#customers").css("display", "table");
                        getCustomer(o.target.value);
                    }
                }
            )

            $("#searchtext").bind("keyup", function(e) {
                if (e.keyCode == 38) {
                    // 向上
                    next(false);
                } else if(e.keyCode == 40) {
                    // 向下
                    next(true);
                } else if (e.keyCode == 13) {
                    //回车
                    select();
                } else {
                    getCustomer($(this).val());
                }
            });

        })

        function getCustomer(value) {
            if(!value){
                $("#customers").css("display", "none");
                return;
            }
            $.ajax({
                type: "post",
                url: "${ctx}/cm/searchCustomer",
                data: {key : value},
                beforeSend: function(XMLHttpRequest){
                    //ShowLoading();
                },
                success: function(data, textStatus){
                    customers = data.data;
                    $("#customerlist").text('');
                    i = 0;
                    $.each(data.data,function(n,value) {
                        i++;
                        $("#customerlist").append('<tr><td>'+n+' '+value.domain+'</td></tr>');
                    });
                    setPosition();
                    if (i <= 0) {
                        $("#customers").css("display", "none");
                        return;
                    }

                    $("#customerlist tr").each(function(n){
                        if (n == 0) {
                            $(this).addClass("sel");
                        }
                        $(this).click(function(){
                            select();
                        })
                        $(this).mouseover(function(){
                            clearSelect();
                            $(this).addClass("sel");
                        })
                    });
                },
                complete: function(XMLHttpRequest, textStatus){
                },
                error: function(){
                    alert("fail to get customer data!");
                }
            });
        }

        function validateForm(form) {
            if ($('#usertype').val() == 1 && (!$('#domain').val())) {
                alert("<fmt:message key="errors.customer.empty"/>")
                return false;
            }
            return validateRequired(form);
        }
        function required () {
            this.aa = new Array("username", "<fmt:message key="errors.required"><fmt:param><fmt:message key="label.username"/></fmt:param></fmt:message>", new Function ("varName", " return this[varName];"));
            this.ab = new Array("password", "<fmt:message key="errors.required"><fmt:param><fmt:message key="label.password"/></fmt:param></fmt:message>", new Function ("varName", " return this[varName];"));
        }

    </script>
</head>
<body id="login" onload="loginFocus()">

<form method="post" id="loginForm" action="<c:url value='/do_login'/>" name="loginForm"
      onsubmit="saveUsername(this);return validateForm(this)" onkeydown="return isEnterKeyDown(event)">
    <div class="gMain">
        <div class="logo">
            <img src="${ctx}/static/login/images/logo.gif"/>
        </div>
        <div class="top">
            <div class="topL"></div>
            <div class="topR"></div>
        </div>
        <div class="main">
            <div class="title">
                <%--<img src="${ctx}/static/login/images/title.gif"/>--%>
            </div>
            <div class="mainM">
                <div class="loginForm">
                    <div class="loginInputLine">
                        <div id="contain">
                            <label for="searchtext" class="required desc left">
                                <fmt:message key="label.search"/>:
                            </label>
                            <input type="text" class="text medium" name="searchtext" id="searchtext" autocomplete="off" tabindex="1"/>
                        </div>
                        <div class="associate" id='customers'>
                            <table id="customerlist">
                            </table>
                        </div>
                    </div>
                    <div class="loginInputLine">
                        <label for="customername" class="required desc">
                            <fmt:message key="label.customername"/>:
                        </label>
                        <span id="customername"></span>
                    </div>
                    <div class="loginInputLine">
                        <label for="defaultdomain" class="required desc">
                            <fmt:message key="label.defaultdomain"/>:
                        </label>
                        <input type="hidden" class="text medium" name="domain" id="domain"/>
                        <span id="defaultdomain"></span>
                    </div>
                </div>
                <div class="error">
                    <c:if test="${param.error != null}">
                        <fmt:message key="errors.password.mismatch"/>
                        <%--${sessionScope.SPRING_SECURITY_LAST_EXCEPTION.message}--%>
                    </c:if>
                </div>
                <div class="loginForm">
                    <div class="loginInputLine">
                        <label for="username" class="required desc">
                            <fmt:message key="label.usertype"/>:
                        </label>
                        <select name="usertype" id="usertype">
                            <option value="1"><fmt:message key="select.option1"/></option>
                            <option value="2"><fmt:message key="select.option2"/></option>
                        </select>
                    </div>
                    <div class="loginInputLine">
                        <label for="username" class="required desc">
                            <fmt:message key="label.username"/>:
                        </label>
                        <input type="text" class="text medium" name="username" id="username" tabindex="2" />
                    </div>
                    <div class="loginInputLine">
                        <label for="password" class="required desc">
                            <fmt:message key="label.password"/>:
                        </label>
                        <input type="password" class="text medium" name="password" id="password" tabindex="3" />
                    </div>
                    <%--<c:if test="${appConfig['rememberMeEnabled']}">--%>
                    <div class="reName">
                        <input type="checkbox" class="checkbox" name="_spring_security_remember_me" id="rememberMe" tabindex="3" checked="true" />
                        <label for="rememberMe" class="choice"><fmt:message key="login.remembername"/></label>
                    </div>
                    <%--</c:if>--%>
                </div>
                <div class="loginFormIpt">
                    <input type="submit" class="button" name="login" value="<fmt:message key='icmc.btn.login'/>" tabindex="4" />
                </div>
            </div>
        </div>
        <div class="bottom">
            <div class="bottomL"></div>
            <div class="copyright">
                Coremail. &copy; Copyright <fmt:message key="copyright.year"/>
                <a href="<fmt:message key="company.url"/>"><fmt:message key="company.name"/></a>
            </div>
            <div class="bottomR"></div>
        </div>
    </div>
</form>



<%--<p><fmt:message key="login.passwordHint"/></p>--%>
<v:javascript formName="loginForm" cdata="false" dynamicJavascript="true" staticJavascript="false"/>
<script type="text/javascript" src="<c:url value='/scripts/validator.jsp'/>"></script>
</body>