<%--
 =================================================================
  Licensed Materials - Property of IBM

  WebSphere Commerce

  (C) Copyright IBM Corp. 2011 All Rights Reserved.

  US Government Users Restricted Rights - Use, duplication or
  disclosure restricted by GSA ADP Schedule Contract with
  IBM Corp.
 =================================================================
--%>

<%@ include file= "../../Common/EnvironmentSetup.jspf" %>


<%@ include file="ext/BreadCrumb_Data.jsp" %>
<c:if test = "${param.custom_data ne 'true'}">
		<%@ include file="BreadCrumbHierarchy_Data.jspf" %>
</c:if>


<%@ include file="ext/BreadCrumb_UI.jsp" %>
<c:if test = "${param.custom_view ne 'true'}">
		<%@ include file="BreadCrumb_UI.jspf" %>
</c:if>