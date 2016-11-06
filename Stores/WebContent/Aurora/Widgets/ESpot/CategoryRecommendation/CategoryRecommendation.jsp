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

<!-- BEGIN CategoryRecommendation.jsp -->

<%@ include file= "../../../Common/EnvironmentSetup.jspf" %>

<%@ include file="ext/CategoryRecommendation_Data.jsp" %>
<c:if test = "${param.custom_data ne 'true'}">
	<%@ include file="CategoryRecommendation_Data.jsp" %>
</c:if>

<c:set var="uniqueID" value="${marketingSpotDatas.marketingSpotIdentifier.uniqueID}"/>
<c:set var="espotName" value="${fn:replace(emsName,' ','')}"/>
<c:set var="espotName" value="${fn:replace(espotName,'\\\\','')}"/>

<c:if test="${env_inPreview eq 'true'}">	
	<%@ include file="../include/ESpotInfoPopupDisplay.jspf"%>
	<div class="genericESpot" id="CategoriesESpot_${espotName}">
		<div class="caption" style="display:none">[<c:out value="${emsName}"/>]</div>
			<div class="ESpotInfo" id="CategoriesESpotInfo_${espotName}">
			<a id="CategoriesESpotLink_${espotName}" 
				href="javascript:showESpotInfoPopup('ESpotInfo_popup_<c:out value="${espotName}"/>');"
				title='<c:out value="${emsName}"/>'>
			<div class="ESpotInfoIcon"></div></a>
		</div>
</c:if>	
	
<%@ include file="ext/CategoryRecommendation_UI.jsp" %>
<c:if test = "${param.custom_view ne 'true' && !empty categoryImageMap}">
	<%@ include file="CategoryRecommendation_UI.jsp" %>
</c:if>

<c:if test="${env_inPreview eq 'true'}">
	</div>
</c:if>

<!-- END CategoryRecommendation.jsp -->