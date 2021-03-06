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
	<fmt:message var="emsTitle" key="ES_RECOMMENDATIONS" />
</c:if>

<c:set var="widgetId" value="widget_recommended_${emsId}"/>

<c:forEach begin="${currentPage+1}" end="${totalPages}" var="pageNo">
	<c:set var="startIndex" value="1"/>
	<c:if test="${currentPage != 0}">
		<c:set var="startIndex" value="${(currentPage * pageSize) + 1}"/>
	</c:if>


	<c:set var="endIndex" value="${(currentPage + 1) * pageSize}"/>
	<c:if test="${endIndex > numEntries}">
		<c:set var="endIndex" value="${numEntries}"/>
	</c:if>
	
	<c:set var="recommendId" value="${widgetId}_${pageNo}"/>
	
		<div id="${recommendId}" class="widget_sidebar_container" <c:if test="${pageNo > 1}"> style="display:none" </c:if>>
			<div class="top">
				<div class="left_border"></div>
				<div class="middle"></div>
				<div class="right_border"></div>
			</div>

			<div class="left_border">
				<div class="right_border">
					<div class="content">
						<c:if test="${displayHeader == 'true' || totalPages > 1}">
						<div class="header_content">
							<c:if test="${totalPages > 1 }">
								<div class="right">				
									<c:if test="${currentPage != 0}">
											<a href="javaScript:setCurrentId('${recommendId}_links_1');RecommendationJS.showPrevResults('<c:out value="${widgetId}"/>','<c:out value="${pageNo}"/>');" id="${recommendId}_links_1"
												onmouseout="dojo.byId('prevImg_${recommendId}').src = '${jspStoreImgDir}${env_vfileColor}sidebar_containers/left_arrow_disabled.png';dojo.byId('prevImg_${recommendId}').className = 'left_arrow_disabled';" 
												onmouseover="dojo.byId('prevImg_${recommendId}').src = '${jspStoreImgDir}${env_vfileColor}sidebar_containers/left_arrow_enabled.png';dojo.byId('prevImg_${recommendId}').className = 'left_arrow_enabled';"
												class="left" title="<fmt:message key="ES_SHOW_PREVIOUS_RECOMMENDATION_SET"/>">
													<img class="left_arrow_disabled" id="prevImg_${recommendId}" src="${jspStoreImgDir}${env_vfileColor}/sidebar_containers/left_arrow_disabled.png" alt="<fmt:message key="ES_SHOW_PREVIOUS_RECOMMENDATION_SET"/>"/>
											</a>
									</c:if>								
									<span class="left">
										<fmt:message key="CATEGORY_RESULTS_PAGES_DISPLAYING" > 
											<fmt:param><fmt:formatNumber value="${currentPage + 1}"/></fmt:param>
											<fmt:param><fmt:formatNumber value="${totalPages}"/></fmt:param>
										</fmt:message>	
									</span>
									<c:if test="${currentPage < totalPages-1}">
											<a href="javaScript:setCurrentId('${recommendId}_links_2');RecommendationJS.showNextResults('<c:out value="${widgetId}"/>','<c:out value="${pageNo}"/>');" id="${recommendId}_links_2"
												onmouseout="dojo.byId('nextImg_${recommendId}').src = '${jspStoreImgDir}${env_vfileColor}sidebar_containers/right_arrow_disabled.png';dojo.byId('nextImg_${recommendId}').className = 'right_arrow_disabled';" 
												onmouseover="dojo.byId('nextImg_${recommendId}').src = '${jspStoreImgDir}${env_vfileColor}sidebar_containers/right_arrow_enabled.png';dojo.byId('nextImg_${recommendId}').className = 'right_arrow_enabled';"
												class="left" title="<fmt:message key="ES_SHOW_NEXT_RECOMMENDATION_SET"/>">
													<img class="right_arrow_disabled" id="nextImg_${recommendId}" src="${jspStoreImgDir}${env_vfileColor}/sidebar_containers/right_arrow_disabled.png" alt="<fmt:message key="ES_SHOW_NEXT_RECOMMENDATION_SET"/>"/>
											</a>
									</c:if>
									<div class="clear_float"></div>
								</div>
							</c:if>
							
							<c:if test="${displayHeader == 'true'}">
							<div class="clear_float"></div>
							<h1 class="left"><c:out value="${emsTitle}"/></h1>
							<div class="clear_float"></div>
							</c:if>
						</div>
						</c:if>
						
						<c:forTokens items="${catentryIdList}" begin="${startIndex - 1}" end="${endIndex - 1}" delims="," var="catEntryIdentifier" varStatus="status">	
								<%@ include file="../include/SearchESpotSetup.jspf"%>
								<div class="clear_float"></div>
								<c:if test="${!status.last}">
									<div class="divider"></div>
								</c:if>
						</c:forTokens>											
					</div>
				</div>
			</div>
			<div class="clear_float"></div>
				
			<div class="bottom">
				<div class="left_border"></div>
				<div class="middle"></div>
				<div class="right_border"></div>
			</div>
		</div>

		<c:set var="currentPage" value="${currentPage+1}"/>
</c:forEach>
