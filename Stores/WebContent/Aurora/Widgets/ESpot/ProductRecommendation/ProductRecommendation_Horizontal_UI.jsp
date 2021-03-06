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
	<fmt:message var="emsTitle" key="ES_ON_SALE_THIS_WEEK" />
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
	
<div class="widget_product_listing container_margin_5px" id="${recommendId}" <c:if test="${pageNo > 1}"> style="display:none" </c:if>>
			<c:if test="${emsName != 'WishListCenter_CatEntries' && emsName != 'RecViewed_CatEntries'}">
				<div class="top">
					<div class="left_border"></div>
					<div class="middle_tile"></div>
					<div class="right_border"></div>
				</div>
			</c:if>

			<div class="middle">
				<div class="left_border">
					<div class="right_border">
						<div class="content">
							<div class="header_bar simple_bar">
								<c:if test="${displayHeader == 'true'}">
								<c:choose>
									<c:when test="${emsName == 'WishListCenter_CatEntries' || emsName == 'RecViewed_CatEntries'}">
										<h2 class="myaccount_header bottom_line no_side_lines"><c:out value="${emsTitle}"/></h2>
									</c:when>
									<c:otherwise>
										<div class="title"><c:out value="${emsTitle}"/></div>
									</c:otherwise>
								</c:choose>
								</c:if>
								<c:if test="${totalPages > 1 }">
									<div class="paging_controls">
											<c:if test="${currentPage != 0}">
												<a href="javaScript:setCurrentId('${recommendId}_links_1');RecommendationJS.showPrevResults('<c:out value="${widgetId}"/>','<c:out value="${pageNo}"/>');" id="${recommendId}_links_1"
													onmouseout="dojo.byId('prevImg_${recommendId}').src = '${jspStoreImgDir}${env_vfileColor}sidebar_containers/left_arrow_disabled.png';dojo.byId('prevImg_${recommendId}').className = 'left_arrow_disabled';" 
													onmouseover="dojo.byId('prevImg_${recommendId}').src = '${jspStoreImgDir}${env_vfileColor}sidebar_containers/left_arrow_enabled.png';dojo.byId('prevImg_${recommendId}').className = 'left_arrow_enabled';"
													class="left" title="<fmt:message key="ES_SHOW_PREVIOUS_RECOMMENDATION_SET"/>">
														<img class="left_arrow_disabled" id="prevImg_${recommendId}" src="${jspStoreImgDir}${env_vfileColor}/sidebar_containers/left_arrow_disabled.png" alt="<fmt:message key="ES_SHOW_PREVIOUS_RECOMMENDATION_SET"/>"/>
												</a>
											</c:if>
											<div class="left paging">
												<fmt:message key="CATEGORY_RESULTS_PAGES_DISPLAYING" > 
													<fmt:param><fmt:formatNumber value="${currentPage + 1}"/></fmt:param>
													<fmt:param><fmt:formatNumber value="${totalPages}"/></fmt:param>
												</fmt:message>	
											</div>
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
								
								<flow:ifEnabled feature="RemoteWidget"> 						
									<c:if test="${param.showWidget == 'true' || param.showFeed == 'true'}">
											<%out.flush();%>
											<c:import url="${env_jspStoreDir}Widgets/ESpot/include/RemoteWidgetButtons.jsp">
												<c:param name="showWidget" value="${param.showWidget}" />
												<c:param name="showFeed" value="${param.showFeed}" />
												<c:param name="widgetIconStyle" value="${param.widgetIconStyle}" />
												<c:param name="sidebarWidgetId" value="${param.sidebarWidgetId}" />
												<c:param name="sidebarColors" value="${param.sidebarColors}" />
												<c:param name="bannerWidgetId" value="${param.bannerWidgetId}" />        
												<c:param name="bannerColors" value="${param.bannerColors}" />
												<c:param name="feedURL" value="${param.feedURL}" />
												<c:param name="feedLayer" value="${param.feedLayer}" />
												<c:param name="emsId" value="${emsId}" />
											</c:import>
											<%out.flush();%>  
										</c:if>
								</flow:ifEnabled>
							</div>
								
							<div class="product_listing_container">
								<fieldset>
									<legend><span class="spanacce"><fmt:message key='ES_PRODUCT_LISTING'/></span></legend>
									<div class="grid_mode">
										<div class="row  first_row">
											<c:forTokens items="${catentryIdList}" begin="${startIndex-1}" end="${endIndex-1}" delims="," var="catEntryIdentifier" varStatus="status">	
													<%@ include file="../include/SearchESpotSetup.jspf"%>
												<%-- Removed divider, since css provides border with background image --%>
											</c:forTokens>	
										</div>
									</div>
								</fieldset>
							</div>			
						</div>
					</div>
				</div>
			</div>

			<div class="bottom">
				<div class="left_border"></div>
				<div class="middle_tile"></div>
				<div class="right_border"></div>
			</div>

		</div>

	<c:set var="currentPage" value="${currentPage+1}"/>
</c:forEach>
