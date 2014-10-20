<%@ include file="/taglibs.jsp" %>

<link rel="stylesheet" href="${ctx}/static/lib/jqGrid/ui.jqgrid.css">
<script type="text/javascript" src="${ctx}/static/lib/jqGrid/grid.locale-${fn:toLowerCase(pageContext.request.locale.country)}.js"></script>
<script type="text/javascript" src="${ctx}/static/lib/jqGrid/jquery.jqGrid.min.js"></script>
<script type="text/javascript" language="javascript"> <!--
jQuery.extend(jQuery.jgrid.defaults, {
    altRows:true,
    // 分页排序相关变量名 转换成 PageableArgumentResolver 支持的变量名
    prmNames: {
        page: 'page',
        rows: 'page.size',
        sort: 'page.sort',
        order: 'page.sort.dir'
    }
});
// --></script>