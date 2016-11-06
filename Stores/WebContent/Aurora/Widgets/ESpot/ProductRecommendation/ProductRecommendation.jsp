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

<!-- BEGIN ProductRecommendation.jsp -->

<%@ include file= "../../../Common/EnvironmentSetup.jspf" %>


<%@ include file="ext/ProductRecommendation_Data.jsp" %>
<c:if test = "${param.custom_data ne 'true'}">
	<%@ include file="ProductRecommendation_Data.jsp" %>
</c:if>

<c:if test="${!empty param.align}">
	<c:set var="align" value="${param.align}"/>
</c:if>

<c:if test="${!empty param.espotTitle}">
	<c:set var="emsTitle" value="${param.espotTitle}"/>
</c:if>

<c:set var="displayHeader" value="true"/>
<c:if test="${!empty param.displayHeader && param.displayHeader != 'true'}">
	<c:set var="displayHeader" value="false"/>
</c:if>

<c:set var="emsId" value="${marketingSpotDatas.marketingSpotIdentifier.uniqueID}"/>
<c:set var="espotName" value="${fn:replace(emsName,' ','')}"/>
<c:set var="espotName" value="${fn:replace(espotName,'\\\\','')}"/>

<c:if test="${env_inPreview eq 'true'}">
	<%@ include file="../include/ESpotInfoPopupDisplay.jspf"%>
	<div class="genericESpot" id="ProdRecommendations_${espotName}">
	<div class="caption" style="display:none">[<c:out value="${emsName}"/>]</div>
	<div class="ESpotInfo" id="ProdRecommendationsInfo_${espotName}">
		<a id="ProdRecommendationsESpotLink_${espotName}" 
    		href="javascript:showESpotInfoPopup('ESpotInfo_popup_<c:out value="${espotName}"/>');"
    		title='<c:out value="${emsName}"/>'>
			<div class="ESpotInfoIcon"></div>
		</a>
	</div>
</c:if>

<%@ include file="ext/ProductRecommendation_UI.jsp" %>

<c:if test = "${param.custom_view ne 'true' && !empty catentryIdList}">
	<c:choose>
		<c:when test="${align eq 'scroll'}">
			<%@include file="ProductRecommendation_Scroll_UI.jsp"%>
		</c:when>
		<c:when test="${align eq 'vertical'}">
				<%@include file="ProductRecommendation_Vertical_UI.jsp"%>
		</c:when>			
		<c:otherwise>
			<%@include file="ProductRecommendation_Horizontal_UI.jsp"%>
		</c:otherwise>
	</c:choose>
</c:if>

<c:if test="${env_inPreview eq 'true'}">
	</div>
</c:if>

<!-- END ProductRecommendation.jsp -->