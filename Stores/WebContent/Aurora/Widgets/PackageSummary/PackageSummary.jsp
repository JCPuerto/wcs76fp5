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

<!-- BEGIN PackageSummary.jsp -->
<!-- Widget Package Summary -->

<%@ include file= "../../Common/JSTLEnvironmentSetup.jspf" %>

<%@ include file="ext/PackageSummary_Data.jsp" %>
<c:if test = "${param.custom_data ne 'true'}">
	<%@ include file="PackageSummary_Data.jsp" %>
</c:if>

<%@ include file="ext/PackageSummary_UI.jsp" %>
<c:if test = "${param.custom_view ne 'true'}">
	<%@ include file="PackageSummary_UI.jsp" %>
</c:if>

<jsp:useBean id="PackageSummary_TimeStamp" class="java.util.Date" scope="request"/>

<!-- End Widget Package Summary -->
<!-- END PackageSummary.jsp -->