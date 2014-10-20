<%@ include file="/taglibs.jsp" %>
<%@ page language="java" errorPage="/error.jsp" pageEncoding="UTF-8" contentType="text/html;charset=utf-8" %>

<ul id="left_menu">
    <security:authorize ifNotGranted="ROLE_ADMIN,ROLE_USER">
        <li><a href="${ctx}/login" title="<fmt:message key="menu.login"/>">
            <fmt:message key="menu.login"/>
            </a></li>
    </security:authorize>
    <security:authorize ifAnyGranted="ROLE_ADMIN">
    </security:authorize>
    <security:authorize ifAnyGranted="ROLE_USER">
    </security:authorize>
</ul>

<script type="text/javascript"><!--
$("document").ready(function() {
    $("#left_menu").menu();
    if ("${inDiscountPeriod}") {
        $("#discountMenuItem").show();
    }
});
// --></script>
