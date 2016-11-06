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

<!-- BEGIN PageLoadContent.jsp -->

<%@ include file="../../Common/EnvironmentSetup.jspf" %>

<%@ include file="ext/PageLoadContent_Data.jsp" %>
<c:if test = "${param.custom_data ne 'true'}">
	<%@ include file="PageLoadContent_Data.jsp" %>
</c:if>

<%@ include file="ext/PageLoadContent_UI.jsp" %>
<c:if test = "${param.custom_view ne 'true'}">
	<%@ include file="PageLoadContent_UI.jsp" %>
</c:if>

<jsp:useBean id="PageLoadContent_TimeStamp" class="java.util.Date" scope="request"/>

<!-- END PageLoadContent.jsp -->