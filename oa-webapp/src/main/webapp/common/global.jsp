<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib uri="/struts-tags" prefix="s" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.lxs.com/auth" prefix="v" %>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags" %>

<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!-- jquery版本 -->
<c:set var="jqueryVersion" value="1.8.0"/>
<script type="text/javascript">
	var ctx = '<%=request.getContextPath() %>';
</script>
