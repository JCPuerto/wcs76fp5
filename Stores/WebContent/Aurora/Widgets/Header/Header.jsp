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

<!-- BEGIN Header.jsp -->

<%@ include file= "../../Common/EnvironmentSetup.jspf" %>

<%@ include file="ext/Header_Data.jsp" %>
<c:if test = "${param.custom_data ne 'true'}">
	<%@ include file="Header_Data.jsp" %>
</c:if>

<%@ include file="ext/Header_UI.jsp" %>
<c:if test = "${param.custom_view ne 'true'}">
	<%@ include file="Header_UI.jsp" %>
</c:if>
<jsp:useBean id="Header_TimeStamp" class="java.util.Date" scope="request"/>

<!-- END Header.jsp -->