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

<!-- BEGIN ContentRecommendation.jsp -->

<%@ include file= "../../../Common/EnvironmentSetup.jspf" %>

<%@ include file="ext/ContentRecommendation_Data.jsp" %>
<c:if test = "${param.custom_data ne 'true'}">
	<%@ include file="ContentRecommendation_Data.jsp" %>
</c:if>

<c:set var="uniqueID" value="${marketingSpotDatas.marketingSpotIdentifier.uniqueID}"/>
<c:set var="espotName" value="${fn:replace(emsName,' ','')}"/>
<c:set var="espotName" value="${fn:replace(espotName,'\\\\','')}"/>

<%@ include file="ext/ContentRecommendation_UI.jsp" %>

<c:if test = "${param.custom_view ne 'true'}">
	<c:choose>
		<c:when test="${!empty param.isEmail && param.isEmail == 'true' && !empty contentFormatMap}">
			<%@include file="ContentRecommendation_Email_UI.jsp"%>
		</c:when>
		<c:otherwise>
			<c:if test="${env_inPreview eq 'true'}">	
				<%@ include file="../include/ESpotInfoPopupDisplay.jspf"%>
				
				<div class="genericESpot" id="ContentAreaESpot_1_${espotName}">
				    <div class="caption" style="display:none" id="ContentAreaESpot_2_${espotName}">[<c:out value="${emsName}"/>]</div>
					 <div class="ESpotInfo" id="ContentAreaESpotInfo_${espotName}">
					 <a id="ContentAreaESpotInfoLink_${espotName}" 
					 	href="javascript:showESpotInfoPopup('ESpotInfo_popup_<c:out value="${espotName}"/>');"
					 	title='<c:out value="${emsName}"/>'>
						<div class="ESpotInfoIcon"></div></a></div>
			
			</c:if>
			
			<c:if test="${!empty contentFormatMap}">		
				<%@include file="ContentRecommendation_UI.jsp"%>
			</c:if>
			
			<c:if test="${env_inPreview eq 'true'}">
				</div>
			</c:if>
		</c:otherwise>
	</c:choose>
</c:if>

<!-- END ContentRecommendation.jsp -->