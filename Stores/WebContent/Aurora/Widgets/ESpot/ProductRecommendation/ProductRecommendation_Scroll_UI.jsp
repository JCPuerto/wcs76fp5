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
	
	<c:if test="${empty emsTitle}">
		<fmt:message var="emsTitle" key="ES_NEW_THIS_WEEK" />
	</c:if>
		

	<div class="widget_carousel <c:if test="${param.background eq 'none'}">no_bg</c:if>">
		<div class="header" role="heading" aria-level="1"><c:out value="${emsTitle}"/></div>
		<div id="carousel" dojoType="wc.widget.ScrollablePane" autoScroll='false' scrollByPage="true" itemSize="210" buttonSize="115" altPrev = '<fmt:message key="ES_SCROLL_LEFT"/>' altNext = '<fmt:message key="ES_SCROLL_RIGHT" />' tempImgPath = "<c:out value='${jspStoreImgDir}'/>images/empty.gif">		
			<c:forTokens items="${catentryIdList}" delims="," var="catEntryIdentifier" varStatus="status">	
				<div dojoType="dijit.layout.ContentPane" style="float:left;" id="prod_${status.count}" class="imgContainer dijitContentPane">
						<%@ include file="../include/SearchESpotSetup.jspf"%>
				</div>
			</c:forTokens>
		</div>
		<div class="clear_float"></div>
	</div>

