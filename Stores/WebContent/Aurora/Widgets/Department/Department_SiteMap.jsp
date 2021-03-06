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

<!-- BEGIN Department_SiteMap.jsp -->

<%@ include file= "../../Common/JSTLEnvironmentSetup.jspf" %>


<c:if test="${empty fullCategoryList}">
	<%@ include file="Department_Data.jsp" %>
</c:if>

<%@ include file="../Footer/Footer_Data.jsp" %>
<%@ include file="Department_SiteMap_UI.jsp" %>

<!-- END Department_SiteMap.jsp -->