<%--
 =================================================================
  Licensed Materials - Property of IBM

  WebSphere Commerce

  (C) Copyright IBM Corp. 2010 All Rights Reserved.

  US Government Users Restricted Rights - Use, duplication or
  disclosure restricted by GSA ADP Schedule Contract with
  IBM Corp. 
 =================================================================
--%>  

<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>
<%@ taglib uri="http://commerce.ibm.com/coremetrics"  prefix="cm" %> 
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ include file="../../../include/JSTLEnvironmentSetup.jspf"%>

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
<fmt:message key='GET_WIDGET' bundle='${remoteWidgetText}' var="shareLabel"/>
<fmt:message key='SUBSCRIBE' bundle='${remoteWidgetText}' var="subscribeLabel"/>

<div class="sidebar_ad_remote_widget">
	<c:choose>
		<c:when test="${param.widgetIconStyle == 'top'}">
			<span class="feed_widget_area_right">
				<c:if test="${showWidget == 'true'}">
					<a class="feed_widget_label" href="${RemoteWidgetToolingViewURL}" id="WC_RemoteWidgetButtons_<c:out value="${param.emsId}"/>_a_1"><c:out value="${shareLabel}" /></a>
					<a href="${RemoteWidgetToolingViewURL}" id="WC_RemoteWidgetButtons_<c:out value="${param.emsId}"/>_a_2">
						<img class="feed_widget_icon" src="<c:out value="${hostPath}${jspStoreImgDir}" />images/remoteWidget/get_widget.png"
							alt="${shareLabel}" height="16" width="20"/></a>
				</c:if>

				<c:if test="${param.showFeed == 'true'}">
					<a class="feed_widget_label" href="${feedURL}" id="WC_RemoteWidgetButtons_<c:out value="${param.emsId}"/>_a_3"><c:out value="${subscribeLabel}" /></a>
					<a id="WC_RemoteWidgetButtons_<c:out value="${param.emsId}"/>_a_4" href="<c:out value="${feedURL}"/>">
						<img class="feed_widget_icon" src="<c:out value="${hostPath}${jspStoreImgDir}" />images/remoteWidget/feed_icon.png"
							alt="${subscribeLabel}"" height="16" width="16"/></a>
				</c:if>
			</span>
		</c:when>
		<c:when test="${param.widgetIconStyle == 'invert'}">
			<span class="feed_widget_area_invert">
				<c:if test="${showWidget == 'true'}">
					<a href="${RemoteWidgetToolingViewURL}" id="WC_RemoteWidgetButtons_<c:out value="${param.emsId}"/>_a_5">
						<img class="feed_widget_icon_invert" src="<c:out value="${hostPath}${jspStoreImgDir}" />images/remoteWidget/get_widget.png"
							alt="${shareLabel}" height="16" width="20"/></a>
					<a class="feed_widget_label_invert" href="${RemoteWidgetToolingViewURL}" id="WC_RemoteWidgetButtons_<c:out value="${param.emsId}"/>_a_6"><c:out value="${shareLabel}" /></a>
				</c:if>

				<c:if test="${param.showFeed == 'true'}">
					<a id="WC_RemoteWidgetButtons_<c:out value="${param.emsId}"/>_a_7" href="<c:out value="${feedURL}"/>">
						<img class="feed_widget_icon_invert" src="<c:out value="${hostPath}${jspStoreImgDir}" />images/remoteWidget/feed_icon.png"
							alt="${subscribeLabel}" height="16" width="16"/></a>
					<a class="feed_widget_label_invert" href="${feedURL}" id="WC_RemoteWidgetButtons_<c:out value="${param.emsId}"/>_a_8"><c:out value="${subscribeLabel}" /></a>
				</c:if>
			</span>
		</c:when>
		<c:otherwise>
			<c:set var="showLabels" value="true" />
			<c:if test="${showWidget == 'true' && param.showFeed == 'true' && (fn:length(shareLabel) + fn:length(subscribeLabel) > 20)}">
				<c:set var="showLabels" value="false" />
			</c:if>
			<c:if test="${showWidget == 'true'}">
				<span class="feed_widget_area_left">
					<c:if test="${showLabels == 'true'}">
						<a class="feed_widget_label" href="${RemoteWidgetToolingViewURL}" id="WC_RemoteWidgetButtons_<c:out value="${param.emsId}"/>_a_9"><c:out value="${shareLabel}" /></a>
					</c:if>
					<a class="feed_widget_icon" href="${RemoteWidgetToolingViewURL}" id="WC_RemoteWidgetButtons_<c:out value="${param.emsId}"/>_a_10">
						<img src="<c:out value="${hostPath}${jspStoreImgDir}" />images/remoteWidget/get_widget.png"
							alt="${shareLabel}" /></a>
				</span>
			</c:if>
			<c:if test="${param.showFeed == 'true'}">
				<span class="feed_widget_area_right">
					<c:if test="${showLabels == 'true'}">
						<a class="feed_widget_label" href="${feedURL}" id="WC_RemoteWidgetButtons_<c:out value="${param.emsId}"/>_a_11"><c:out value="${subscribeLabel}" /></a>
					</c:if>
					<a class="feed_widget_icon" id="WC_RemoteWidgetButtons_<c:out value="${param.emsId}"/>_a_12" href="<c:out value="${feedURL}"/>">
						<img src="<c:out value="${hostPath}${jspStoreImgDir}" />images/remoteWidget/feed_icon.png"
							alt="${subscribeLabel}" /></a>
				</span>
			</c:if>
		</c:otherwise>
	</c:choose>
</div>
