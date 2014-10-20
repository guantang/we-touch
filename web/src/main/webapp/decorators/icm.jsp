<%@ include file="/taglibs.jsp" %>
<%@ page language="java" errorPage="/error.jsp" pageEncoding="UTF-8" contentType="text/html;charset=utf-8" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
<head>
    <title><decorator:title default="Welcome"/> | <fmt:message key="webapp.name"/></title>
    <meta http-equiv="Cache-Control" content="no-cache"/>
    <meta http-equiv="Pragma" content="no-cache"/>
    <meta http-equiv="Expires" content="0"/>
    <meta http-equiv="content-type" content="text/html; charset=utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="shortcut icon" href="${ctx}/images/favicon.ico" type="image/x-icon"/>
    <!-- Bootstrap -->
    <link href="${ctx}/static/lib/bootstrap_coremail/css/bootstrap.min.css" rel="stylesheet" media="screen">
    <link href="${ctx}/static/lib/bootstrap_coremail/css/bootstrap-responsive.min.css" rel="stylesheet" media="screen">

    <link rel="stylesheet" href="${ctx}/static/lib/bootstrap_coremail/css/font-awesome.min.css">
    <!--[if IE 7]>
        <link rel="stylesheet" href="${ctx}/static/lib/bootstrap_coremail/css/font-awesome-ie7.min.css">
    <![endif]-->

    <!-- Le styles -->
    <link type="text/css" href="${ctx}/static/lib/jquery-ui-bootstrap/css/custom-theme/jquery-ui-1.10.0.custom.css" rel="stylesheet" />
    <!--[if lt IE 9]>
        <link rel="stylesheet" type="text/css" href="${ctx}/static/lib/jquery-ui-bootstrap/css/custom-theme/jquery.ui.1.10.0.ie.css" />
    <![endif]-->

    <link rel="stylesheet" href="${ctx}/static/styles/common.css" />

    <!-- Le HTML5 shim, for IE6-8 support of HTML5 elements -->
    <!--[if lt IE 9]>
        <script type="text/javascript" src="${ctx}/static/lib/jquery-ui-bootstrap/js/html5.js"></script>
    <![endif]-->

    <script type="text/javascript" src="${ctx}/static/lib/jquery/jquery-1.8.3.js"></script>
    <script type="text/javascript" src="${ctx}/static/lib/jquery-ui-bootstrap/js/jquery-ui-1.10.0.custom.min.js"></script>

    <!-- Bootstrap shold load after jquery-->
    <script type="text/javascript" src="${ctx}/static/lib/jquery-ui-bootstrap/js/bootstrap.min.js"></script>

    <script type="text/javascript" src="${ctx}/static/scripts/common.js"></script>

    <script type="text/javascript" language="javascript">
        $("document").ready(function(){
            $("#dialog-change-password").dialog({
                autoOpen: false,
                height: 400,
                width: 450,
                modal: true,
                buttons : {
                    "确定" : function() {
                        $.ajax({
                            url: "${ctx}/user/pass/change",
                            type: "POST",
                            dataType: "json",
                            data: {
                                oldpass: $("#oldpass").val(),
                                newpass: $("#newpass").val(),
                                newpass2:$("#newpass2").val()
                            },
                            success : function(data, textStatus) {
                                // todo
                            },
                            error: function(XMLHttpRequest, textStatus, errorThrown) {
                                // todo
                            }
                        });
                        $( this ).dialog( "close" );
                    },
                    "取消" : function() {
                        $( this ).dialog( "close" );
                    }
                }
            });
            $("#button-change-password").click(function() {
                $("#dialog-change-password" ).dialog( "open" );
            });
        });
    </script>

    <decorator:head/>
</head>

<body<decorator:getProperty property="body.id" writeEntireProperty="true"/><decorator:getProperty property="body.class" writeEntireProperty="true"/>>

<c:set var = "ROLE_ADMIN" value="${false}" />
<security:authorize ifAnyGranted="ROLE_ADMIN">
    <c:set var = "ROLE_ADMIN" value="${true}" />
</security:authorize>

<div id="page">
    <div class="navbar navbar-inverse navbar-fixed-top">
        <div class="navbar-inner">
            <div class="container">
                <div class="brand">
                    icm单点登录平台
                </div>
                <!-- .btn-navbar is used as the toggle for collapsed navbar content -->
                <a class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </a>
                <div class="nav-collapse collapse navbar-inverse-collapse">
                    <security:authorize ifAnyGranted="ROLE_USER,ROLE_ADMIN">
                        <ul class="nav pull-right">
                            <c:if test="${pageContext.request.remoteUser != null}">
                                <div class="brand">
                                    <fmt:message key="greeting"/> : ${pageContext.request.remoteUser}
                                </div>
                            </c:if>
                            <li><a title="<fmt:message key='menu.logout'/> " href="<c:url value='/logout'/>"><fmt:message key="menu.logout"/></a></li>
                        </ul>
                    </security:authorize>
                </div>
            </div>
        </div>
    </div>

    <div id="content" class="container paddingTop40">
        <div id="main">
            <div id="main_body">
                <decorator:body/>
            </div>
        </div>

    </div>

    <div id="footer" class="navbar-fixed-bottom">
        <div class="container">
            <div id="divider"><div></div></div>
            <span class="right">
               Coremail. &copy; Copyright <fmt:message key="copyright.year"/>
                <a href="<fmt:message key="company.url"/>"><fmt:message key="company.name"/></a>
            </span>
        </div>
    </div>
</div>

<%--dialog相关--%>
</body>
</html>
