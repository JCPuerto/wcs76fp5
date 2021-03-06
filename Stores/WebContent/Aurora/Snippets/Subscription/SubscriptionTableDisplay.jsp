<%--
 =================================================================
  Licensed Materials - Property of IBM

  WebSphere Commerce

  (C) Copyright IBM Corp. 2010, 2012 All Rights Reserved.

  US Government Users Restricted Rights - Use, duplication or
  disclosure restricted by GSA ADP Schedule Contract with
  IBM Corp.
 =================================================================
--%>
<%--
  *****
  *
  * This JSP page displays the Subscription page 
  * In each list, 'Details' is a link to the Subscription Details page for that subscription
  *
  *
  * How to use this snippet?
  *	<c:import url="../../../Snippets/Subscription/SubscriptionTableDisplay.jsp" >
  *		<c:param name="isMyAccountMainPage" value="true"/>
  *	</c:import>
  *
  *****
--%>
<!-- BEGIN SubscriptionTableDisplay.jsp -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>    
<%@ include file="../../include/JSTLEnvironmentSetup.jspf"%>


<c:set var="pageSize" value="${WCParam.pageSize}" />
<c:if test="${empty pageSize}">
	<c:set var="pageSize" value="${maxOrderItemsPerPage}"/>
</c:if>

<c:set var="beginIndex" value="${WCParam.beginIndex}" />
<c:if test="${empty beginIndex}">
	<c:set var="beginIndex" value="0" />
</c:if>

<div role="grid" id="WC_SubscriptionTableDisplay_div_1" class="order_status_table scheduled_orders" aria-describedby="SubscriptionPage" aria-readonly="true">
	<div id="SubscriptionPage" class="hidden_summary">
		<fmt:message key="MO_SUBSCRIPTIONS_TABLE_DESCRIPTION" bundle="${storeText}"/>
	</div>
	<c:choose>         
		<c:when test="${!param.isMyAccountMainPage}">
			<div dojoType="wc.widget.RefreshArea" widgetId="SubscriptionDisplay" id="SubscriptionDisplay" controllerId="SubscriptionDisplayController">
		</c:when>
		<c:otherwise>
			<div dojoType="wc.widget.RefreshArea" widgetId="RecentSubscriptionDisplay" id="RecentSubscriptionDisplay" controllerId="RecentSubscriptionDisplayController">
		</c:otherwise>
	</c:choose>
	<%out.flush();%>
		<c:import url="${jspStoreDir}Snippets/Subscription/SubscriptionTableDetailsDisplay.jsp"> 
			<c:param name="catalogId" value="${WCParam.catalogId}" />
			<c:param name="langId" value="${WCParam.langId}" />
			<c:param name="storeId" value="${WCParam.storeId}" />
			<c:param name="isMyAccountMainPage" value="${param.isMyAccountMainPage}"/>
		</c:import>
	<%out.flush();%>
	</div>
</div>

<!-- END SubscriptionTableDisplay.jsp -->
