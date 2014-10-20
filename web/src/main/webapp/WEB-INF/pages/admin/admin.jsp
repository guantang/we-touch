<%@ include file="/taglibs.jsp"%>

<fmt:setBundle basename="ApplicationResources"/>
<head>
    <title><fmt:message key="icmc.btn.login"/></title>
    <meta name="heading" content="<fmt:message key='menu.login'/>"/>
<%--<script type="text/javascript" src="${ctx}/scripts/login.js"></script>--%>
    <%--<script type="text/javascript" src="${ctx}/static/lib/jquery/jquery-1.8.3.js"></script>--%>
    <script type="text/javascript">
        currentPage = 1;
        totalPage = ${totalPage};
        function deleteUser(id) {
            $.ajax({
                type: "post",
                url: "${ctx}/admin/delete",
                data: {id : id},
                success: function(data, textStatus) {
                    if (data.data.retcode == 0) {
                        $('#'+id).text('');
                        $('#'+id).remove();
                        getCustomers(0);
                    } else {
                        alert("<fmt:message key="admin.error.deletecustomer"/>");
                    }
                },
                complete: function(XMLHttpRequest, textStatus) {
                },
                error: function() {
                    alert("<fmt:message key="admin.error.deletecustomer"/>");
                }
            });
        }

        function addUser() {
            $('#addForm').submit();
        }


        function pre() {
            if (currentPage <= 1 ) {
                return;
            }
            getCustomers(-1);
        }

        function next() {
            if (currentPage >= totalPage) {
                return;
            }
            getCustomers(1);
        }

        function search() {
            $('#oldSearchName').val($('#searchName').val());
            $('#oldSearchDomain').val($('#searchDomain').val());
            $.ajax({
                type: "post",
                url: "${ctx}/admin/search",
                data: {currentPage : 1, searchName : $('#searchName').val(), searchDomain : $('#searchDomain').val()},
                success: function(data, textStatus) {
                    if (data.data.retcode == 0) {
                        currentPage = 1;
                        totalPage = data.data.totalPage;
                        $('#sucSearchName').val($('#oldSearchName').val());
                        $('#sucSearchDomain').val($('#oldSearchDomain').val());
                        $('#currentPage').text(currentPage + '/' + totalPage);
                        $('#customerlist tbody').text('');
                        $.each(data.data.customers, function(n, value) {
                            $('#customerlist tbody').append('<tr id="'+value.customerId+'">'+
                                '<td>'+value.customerName+'</td>'+
                                '<td>'+value.domain+'</td>'+
                                '<td>'+
                                '<button class="btn" onclick="deleteUser('+value.customerId+')">'+
                                '<span class="glyphicon"></span><fmt:message key="admin.column.delete"/>'+
                                '</button>'+
                                '</td>'+
                                '</tr>')
                        })
                    } else {
                        alert("<fmt:message key="admin.error.getcustomers"/>");
                    }
                },
                complete: function(XMLHttpRequest, textStatus) {
                },
                error: function() {
                    alert("<fmt:message key="admin.error.getcustomers"/>");
                }
            });
        }

        function getCustomers(delta) {
            $.ajax({
                type: "post",
                url: "${ctx}/admin/search",
                data: {currentPage : currentPage + delta, searchName : $('#sucSearchName').val(), searchDomain : $('#sucSearchDomain').val()},
                success: function(data, textStatus) {
                    if (data.data.retcode == 0) {
                        currentPage += delta;
                        totalPage = data.data.totalPage;
                        $('#currentPage').text(currentPage + '/' + totalPage);
                        $('#customerlist tbody').text('');
                        $.each(data.data.customers, function(n, value) {
                            $('#customerlist tbody').append('<tr id="'+value.customerId+'">'+
                                '<td>'+value.customerName+'</td>'+
                                '<td>'+value.domain+'</td>'+
                                '<td>'+
                                '<button class="btn" onclick="deleteUser('+value.customerId+')">'+
                                '<span class="glyphicon"></span><fmt:message key="admin.column.delete"/>'+
                                '</button>'+
                                '</td>'+
                                '</tr>')
                        })
                    } else {
                        alert("<fmt:message key="admin.error.getcustomers"/>");
                    }
                },
                complete: function(XMLHttpRequest, textStatus) {
                },
                error: function() {
                    alert("<fmt:message key="admin.error.getcustomers"/>");
                }
            });
        }

        function validation (){
            if (!$('#customerName').val()) {
                alert("<fmt:message key="admin.error.name"/>");
                return false;
            } else if (!$('#domain').val()) {
                alert("<fmt:message key="admin.error.domain"/>");
                return false;
            }
            return true;
        }
    </script>
</head>
<body>
<security:authorize ifAnyGranted="ROLE_ADMIN">
<div class="container">
    <div class="text-center">
        <hr>
        <h3><fmt:message key="admin.listtitle"/></h3>
        <form class="form-inline" id="searchForm" method="post" >
            <div class="form-inline">
                <label><fmt:message key="admin.column.name"/>:</label>
                <input name="searchName" id="searchName" type="text" placeholder="<fmt:message key="admin.column.name"/>">
                <label><fmt:message key="admin.column.domain"/>:</label>
                <input  name="searchDomain" id="searchDomain" type="text" placeholder="<fmt:message key="admin.column.domain"/>">
                <button type="button" class="btn  btn-success" onclick="search()">
                    <span class="glyphicon"></span><fmt:message key="admin.searchCustomer"/>
                </button>
            </div>
        </form>
        <input name="oldSearchName" id="oldSearchName" type="hidden">
        <input name="oldSearchDomain" id="oldSearchDomain" type="hidden">
        <input name="sucSearchName" id="sucSearchName" type="hidden">
        <input name="sucSearchDomain" id="sucSearchDomain" type="hidden">
        <table id="customerlist" class="table table-striped">
            <thead>
            <tr>
                <th><fmt:message key="admin.column.name"/></th>
                <th><fmt:message key="admin.column.domain"/></th>
                <th><fmt:message key="admin.column.operation"/></th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${customers}" var="customer">
                <tr id="${customer.customerId}">
                    <td>${customer.customerName}</td>
                    <td>${customer.domain}</td>
                    <td>
                        <button class="btn" onclick="deleteUser(${customer.customerId})">
                            <span class="glyphicon"></span><fmt:message key="admin.column.delete"/>
                        </button>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
        <ul class="pager">
            <li><a href="#" onclick="pre()"><fmt:message key="admin.page.pre"/></a></li>
            <li><span id="currentPage">1/${totalPage}</span></li>
            <li><a href="#" onclick="next()"><fmt:message key="admin.page.next"/></a></li>
        </ul>
    </div>
    <hr>

    <h3><fmt:message key="admin.createuser"/>:</h3>

    <form class="form-horizontal" id="addForm" action="<c:url value='/admin/add'/>" method="post"
          onsubmit="return validation();">
        <div class="form-group">
            <label class="col-sm-2 control-label"><fmt:message key="admin.column.name"/>:</label>
            <div class="col-sm-10">
                <input name="customerName" id="customerName" type="text" placeholder="<fmt:message key="admin.column.name"/>">
            </div>
        </div>
        <br>
        <div class="form-group">
            <label class="col-sm-2 control-label"><fmt:message key="admin.column.domain"/>:</label>
            <div class="col-sm-10">
                <input name="domain" id="domain" type="text" placeholder="<fmt:message key="admin.column.domain"/>">
            </div>
        </div>
        <br>
        <button type="submit" class="btn  btn-success">
            <span class="glyphicon"></span><fmt:message key="admin.createuser"/>
        </button>
    </form>
</div>
</security:authorize>
</body>
</html>