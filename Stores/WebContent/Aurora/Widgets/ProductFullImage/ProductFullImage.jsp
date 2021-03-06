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

<!-- BEGIN ProductFullImage.jsp -->

<%@ include file= "../../Common/JSTLEnvironmentSetup.jspf" %>

<%@ include file="ext/ProductFullImage_Data.jsp" %>
<c:if test = "${param.custom_data ne 'true'}">
	<%@ include file="ProductFullImage_Data.jsp" %>
</c:if>

<%@ include file="ext/ProductFullImage_UI.jsp" %>
<c:if test = "${param.custom_view ne 'true'}">
	<%@ include file="ProductFullImage_UI.jsp" %>
</c:if>

<jsp:useBean id="cacheTimeStamp" class="java.util.Date" scope="request"/>

<!-- END ProductFullImage.jsp -->