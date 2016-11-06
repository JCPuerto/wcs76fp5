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


<%@ include file="../../../Common/JSTLEnvironmentSetup.jspf"%>
<%@ include file="../../../Common/JSTLEnvironmentSetupExtForRemoteWidgets.jspf"%>

<c:set var="feedURL" value="${param.feedURL}"/>
<c:if test="${contentPersonalizationId != null}">
	<c:set var="feedURL" value="${feedURL}&contentPersonalizationId=${contentPersonalizationId}"/>
</c:if>

<wcf:url var="RemoteWidgetToolingViewURL" value="RemoteWidgetToolView">
	<wcf:param name="langId" value="${param.langId}" /> 
	<wcf:param name="storeId" value="${param.storeId}" />
	<wcf:param name="catalogId" value="${param.catalogId}" />
	<wcf:param name="sidebarWidgetId" value="${param.sidebarWidgetId}" />
	<wcf:param name="sidebarColors" value="${param.sidebarColors}" />
	<wcf:param name="bannerWidgetId" value="${param.bannerWidgetId}" />
	<wcf:param name="bannerColors" value="${param.bannerColors}" />
	<wcf:param name="feedLayer" value="${param.feedLayer}" />
	<wcf:param name="feedURL" value="${feedURL}" />
</wcf:url>

<c:set var="showWidget" value="false" />
<c:if test="${param.showWidget == 'true' && !empty affiliateId && !(empty param.sidebarWidgetId && empty param.bannerWidgetId)}">
	<c:set var="showWidget" value="true" />
</c:if>
<fmt:message key='GET_WIDGET_TITLE' var="shareLabel"/>
<fmt:message key='SUBSCRIBE' var="subscribeLabel"/>

<div class="subscribe_share_controls">
	<c:if test="${showWidget == 'true'}">
		<img class="icon" src="<c:out value='${hostPath}${jspStoreImgDir}' />images/remoteWidget/share_icon.png"
				alt="${shareLabel}"/>
		<a class="text" href="${RemoteWidgetToolingViewURL}" id="Share_<c:out value='${param.emsId}'/>"><c:out value="${shareLabel}" /></a>
	</c:if>

	<c:if test="${param.showFeed == 'true'}">					
		<img class="icon" src="<c:out value='${hostPath}${jspStoreImgDir}' />images/remoteWidget/feed_icon.png"
				alt="${subscribeLabel}" />
		<a class="text" href="${feedURL}" id="Subscribe_<c:out value='${param.emsId}'/>"><c:out value="${subscribeLabel}" /></a>
	</c:if>
</div>
