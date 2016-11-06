<%--
 =================================================================
  Licensed Materials - Property of IBM

  WebSphere Commerce

  (C) Copyright IBM Corp. 2011, 2012 All Rights Reserved.

  US Government Users Restricted Rights - Use, duplication or
  disclosure restricted by GSA ADP Schedule Contract with
  IBM Corp.
 =================================================================
--%>

<%-- BIGIN MiniShopCartDisplay.jsp --%>

<%@ include file= "../../Common/EnvironmentSetup.jspf" %>

<script type="text/javascript">
  dojo.addOnLoad(function() {
		setMiniShopCartControllerURL(getAbsoluteURL()+'MiniShopCartDisplayView?storeId=<c:out value="${storeId}"/>&catalogId=<c:out value="${catalogId}"/>&langId=<c:out value="${langId}"/>');
	});
</script>

<%@ include file="ext/MiniShopCartDisplay_Data.jsp" %>
<c:if test = "${param.custom_data ne 'true'}">
	<%@ include file="MiniShopCartDisplay_Data.jsp" %>
</c:if>

<%@ include file="ext/MiniShopCartDisplay_UI.jsp" %>
<c:if test = "${param.custom_view ne 'true'}">
	<%@ include file="MiniShopCartDisplay_UI.jsp" %>
</c:if>

<%-- END MiniShopCartDisplay.jsp --%>

<jsp:useBean id="MiniShopCart_TimeStamp" class="java.util.Date" scope="request"/>