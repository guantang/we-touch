<%-- Error Messages --%>
<c:if test="${not empty result and not empty result.errors}">
    <c:forEach var="errorCode" items="${result.errorCodes}">
        <div class="alert alert-error">
            <button type="button" class="close" data-dismiss="alert">&times;</button>
            <i class="icon-ban-circle"></i>
            <strong><fmt:message key="icon.warning"/></strong><fmt:message key="${errorCode}"/>
        </div>
    </c:forEach>
</c:if>
<c:if test="${not empty errors}">
    <c:forEach var="error" items="${errors}">
        <div class="alert alert-error">
            <button type="button" class="close" data-dismiss="alert">&times;</button>
            <i class="icon-ban-circle"></i>
            <strong><fmt:message key="icon.warning"/></strong><c:out value="${error}"/>
        </div>
    </c:forEach>
    <c:remove var="errors"/>
</c:if>

<%-- Success Messages --%>
<c:if test="${not empty result and not empty result.messages}">
    <c:forEach var="messageCode" items="${result.messageCodes}">
        <div class="alert alert-success">
            <button type="button" class="close" data-dismiss="alert">&times;</button>
            <i class="icon-ok-circle"></i>
            <strong><fmt:message key="icon.success"/></strong><fmt:message key="${messageCode}"/>
        </div>
    </c:forEach>
    <c:remove var="message" scope="session"/>
</c:if>
<c:if test="${not empty message}">
    <c:forEach var="msg" items="${message}">
        <div class="alert alert-success">
            <button type="button" class="close" data-dismiss="alert">&times;</button>
            <i class="icon-ok-circle"></i>
            <strong><fmt:message key="icon.success"/></strong> <c:out value="${msg}"/>
        </div>
    </c:forEach>
    <c:remove var="message" scope="session"/>
</c:if>
