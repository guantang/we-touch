<%@ include file="/taglibs.jsp"%>


<div id="center">
    <security:authorize ifNotGranted="ROLE_USER,ROLE_ADMIN">
        <c:redirect url="/login" />
        <div class="hero-unit">
            <h1>Welcome!</h1>
            <p><fmt:message key="tips.user.not_login"/></p>
            <p>
                <a href="${ctx}/login" class="btn btn-primary btn-large">
                    <fmt:message key="menu.login"/>
                </a>
            </p>
        </div>
    </security:authorize>
    <security:authorize ifAnyGranted="ROLE_USER,ROLE_ADMIN">
        <c:redirect url="/login" />
        <div class="hero-unit">
            <h1>Welcome!</h1>
        </div>
    </security:authorize>
</div>

