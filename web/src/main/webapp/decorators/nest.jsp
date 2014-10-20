<%@ include file="/taglibs.jsp" %>
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

    <decorator:head/>
</head>

<body<decorator:getProperty property="body.id" writeEntireProperty="true"/><decorator:getProperty property="body.class" writeEntireProperty="true"/>>

<div id="page">
    <div id="content" class="clearfix">
        <div>
            <div id="messages">
                <%@ include file="/messages.jsp" %>
            </div>
            <div id="main_body">
                <decorator:body/>
            </div>
        </div>
    </div>

</div>
</body>
</html>

