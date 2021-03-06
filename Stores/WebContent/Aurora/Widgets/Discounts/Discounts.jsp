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

<!-- BEGIN Discounts.jsp -->

<%@ include file= "../../Common/EnvironmentSetup.jspf" %>

<%@ include file="ext/Discounts_Data.jsp" %>
<c:if test = "${param.custom_data ne 'true'}">
	<%@ include file="Discounts_Data.jsp" %>
</c:if>


<%@ include file="ext/Discounts_UI.jsp" %>
<c:if test = "${param.custom_view ne 'true'}">
	<c:choose>
		<c:when test="${param.pageView eq 'main'}">
			<%@ include file="DiscountsExclusive_UI.jsp" %>
		</c:when>
		<c:otherwise>
			<%@ include file="Discounts_UI.jsp" %>
		</c:otherwise>
	</c:choose>
</c:if>

<jsp:useBean id="Discounts_TimeStamp" class="java.util.Date" scope="request"/>

<!-- END Discounts.jsp -->