<%@ include file="/taglibs.jsp" %>
<%@ page language="java" errorPage="/error.jsp" pageEncoding="UTF-8" contentType="text/html;charset=utf-8" %>

<ul class="nav">
    <security:authorize ifNotGranted="ROLE_ADMIN,ROLE_USER">
        <li><a href="${ctx}/login" title="<fmt:message key="menu.login"/>">
            <fmt:message key="menu.login"/>
        </a></li>
        <li class="divider-vertical"></li>
    </security:authorize>
    <security:authorize ifAnyGranted="ROLE_ADMIN">
    </security:authorize>
    <security:authorize ifAnyGranted="ROLE_USER">
    </security:authorize>
</ul>
