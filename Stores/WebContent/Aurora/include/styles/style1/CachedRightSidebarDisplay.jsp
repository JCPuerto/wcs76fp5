<%--
 =================================================================
  Licensed Materials - Property of IBM

  WebSphere Commerce

  (C) Copyright IBM Corp. 2008, 2011 All Rights Reserved.

  US Government Users Restricted Rights - Use, duplication or
  disclosure restricted by GSA ADP Schedule Contract with
  IBM Corp.
 =================================================================
--%>
<!-- BEGIN CachedRightSidebarDisplay.jsp -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../../JSTLEnvironmentSetup.jspf"%>
<%@ page import="com.ibm.commerce.command.CommandContext" %>

<c:set var="currency" value="${CommandContext.currency}" />

<c:if test="${requestScope.useHomeRightSidebar != null && !empty requestScope.useHomeRightSidebar}">
	<div id="right_nav">
		<c:choose>
			<c:when test="${requestScope.useHomeRightSidebar}">
				<c:choose>
					<c:when test="${requestScope.compareProductPage}">
						<div class="ads" id="WC_CachedHomeSidebarDisplay_div_1">
							<% out.flush(); %>
							<c:import url="${jspStoreDir}Snippets/Marketing/ESpot/ESpotNavDisplay.jsp">
								<c:param name="storeId" value="${WCParam.storeId}" />
								<c:param name="catalogId" value="${catalogId}" />
								<c:param name="langId" value="${langId}" />
								<c:param name="emsName" value="HomePageRightSideBarAds" />
								<c:param name="adclass" value="no_ad" />
								<c:param name="errorViewName" value="AjaxOrderItemDisplayView" />							
							</c:import>
							<% out.flush(); %>
						</div>
					</c:when>
					<c:when test="${requestScope.searchLandingPage}">
						<div class="home_sidebar_container_searchlanding" id="WC_CachedHomeSidebarDisplay_div_2">
							<% out.flush(); %>
							<c:import url="${jspStoreDir}Snippets/Marketing/ESpot/ESpotNavDisplay.jsp">
								<c:param name="storeId" value="${WCParam.storeId}" />
								<c:param name="catalogId" value="${catalogId}" />
								<c:param name="langId" value="${langId}" />
								<c:param name="emsName" value="SearchLandingPage1SideBarAds" />
								<c:param name="adclass" value="home_sidebar_content_searchlanding" />
								<c:param name="errorViewName" value="AjaxOrderItemDisplayView" />							
							</c:import>
							<% out.flush(); %> 

							<c:set var="eMarketingSpotName" value="RightSideBarFeaturedProducts"/>
							<c:import url="${jspStoreDir}Snippets/Marketing/ESpot/ESpotNavDisplay.jsp">
								<c:param name="storeId" value="${WCParam.storeId}" />
								<c:param name="catalogId" value="${catalogId}" />
								<c:param name="langId" value="${langId}" />
								<c:param name="emsName" value="${eMarketingSpotName}" />
								<c:param name="errorViewName" value="AjaxOrderItemDisplayView" />
							</c:import>
							<% out.flush(); %> 
						</div>
					</c:when>
					<c:when test="${requestScope.staticContentPage}">
						<c:set var="eMarketingSpotName" value="RightSideBarFeaturedProducts"/>
						<flow:ifEnabled feature="RemoteWidget">
							<c:set var="eMarketingShowWidget" value="false"/>
							<c:set var="eMarketingShowFeed" value="false"/>
						</flow:ifEnabled> 

						<% out.flush(); %>
						<flow:ifEnabled feature="RemoteWidget">
							<c:import url="${jspStoreDir}Snippets/Marketing/ESpot/ESpotNavDisplay.jsp">
								<c:param name="storeId" value="${WCParam.storeId}" />
								<c:param name="catalogId" value="${catalogId}" />
								<c:param name="langId" value="${langId}" />
								<c:param name="emsName" value="${eMarketingSpotName}" />
								<c:param name="errorViewName" value="AjaxOrderItemDisplayView" />
								<c:param name="showWidget" value="${eMarketingShowWidget}" />
								<c:param name="showFeed" value="${eMarketingShowFeed}" />
								<c:param name="sidebarWidgetId" value="${eMarketingSidebarWidgetId}" />
								<c:param name="bannerWidgetId" value="${eMarketingBannerWidgetId}" />  
								<c:param name="feedURL" value="${eMarketingFeedURL}"/>
							</c:import>
						</flow:ifEnabled>
						<% out.flush(); %>
					</c:when>
					<c:otherwise>
						<div class="home_sidebar_container" id="WC_CachedHomeSidebarDisplay_div_2">
							<div class="home_sidebar_content" id="WC_CachedHomeSidebarDisplay_div_3">
								<% out.flush(); %>
								<c:import url="${jspStoreDir}Snippets/Marketing/ESpot/ESpotNavDisplay.jsp">
									<c:param name="storeId" value="${WCParam.storeId}" />
									<c:param name="catalogId" value="${catalogId}" />
									<c:param name="langId" value="${langId}" />
									<c:param name="emsName" value="HomePageRightSideBarAds" />
									<c:param name="adclass" value="sidebar_ad" />
									<c:param name="errorViewName" value="AjaxOrderItemDisplayView" />
								</c:import>
								<% out.flush(); %>
								<flow:ifEnabled feature="ProductRankings">
									<% out.flush(); %>
									<c:import url="${jspStoreDir}Snippets/Catalog/ProductRankingsDisplay.jsp">
										<c:param name="storeId" value="${WCParam.storeId}" />
										<c:param name="catalogId" value="${catalogId}" />
										<c:param name="langId" value="${langId}" />
										<c:param name="errorViewName" value="AjaxOrderItemDisplayView" />
									</c:import>
									<% out.flush(); %>
								</flow:ifEnabled>
								<%@ include file="CachedHomeRightSidebarExt.jspf"%>
								<flow:ifEnabled feature="FacebookIntegration">
									<%--Display Facebook plug-in, Like button  --%>
									<%@ include file="CachedRightSidebarFacebook.jspf"%>
								</flow:ifEnabled>
							</div>
						</div>
					</c:otherwise>
				</c:choose>
			</c:when>
			<c:otherwise>
				<div class="rightads" id="WC_CachedRightSidebarDisplay_div_1">
				<c:choose>
					<c:when test="${requestScope.shoppingCartPage || requestScope.pendingOrderDetailsPage}">
						<% out.flush(); %>
						<c:import url="${jspStoreDir}Snippets/Marketing/ESpot/ESpotNavDisplay.jsp">
							<c:param name="storeId" value="${WCParam.storeId}" />
							<c:param name="catalogId" value="${catalogId}" />
							<c:param name="langId" value="${langId}" />
							<c:param name="emsName" value="ShoppingCartRightSideBarAds" />
							<c:param name="adclass" value="email_ad" />
							<c:param name="errorViewName" value="AjaxOrderItemDisplayView" />
						</c:import>
						<% out.flush(); %>
					</c:when>
					<c:otherwise>
						<flow:ifEnabled feature="ProductCompare">
							<div id="compare">  
								<div  class="compare_top" id="WC_CachedRightSidebarDisplay_div_2"></div>
								<div class="toptext" id="WC_CachedRightSidebarDisplay_div_3">
									<h2 class="sidebar_header"><fmt:message key='COMPARE_TITLE' bundle='${storeText}'/></h2>
								</div>
								<%@ include file="../../../Snippets/ReusableObjects/CompareZoneDisplay.jspf" %> 
							</div>     
						</flow:ifEnabled>
							
						<% out.flush(); %>
						<flow:ifDisabled feature="RemoteWidget">
							<c:import url="${jspStoreDir}Snippets/Marketing/ESpot/ESpotNavDisplay.jsp">
								<c:param name="storeId" value="${WCParam.storeId}" />
								<c:param name="catalogId" value="${catalogId}" />
								<c:param name="langId" value="${langId}" />
								<c:param name="emsName" value="RightSideBarAds" />
								<c:param name="adclass" value="email_ad" />
								<c:param name="errorViewName" value="AjaxOrderItemDisplayView" />
							</c:import>
						</flow:ifDisabled>
						<flow:ifEnabled feature="RemoteWidget">
							<c:url var="feedURL" value="${restURLScheme}://${pageContext.request.serverName}:${restURLPort}${restURI}/stores/${WCParam.storeId}/MarketingSpotData/RightSideBarAds">
								<c:param name="responseFormat" value="atom" />
								<c:param name="langId" value="${langId}" />
								<c:param name="currency" value="${currency}"/>
							</c:url>
							<c:import url="${jspStoreDir}Snippets/Marketing/ESpot/ESpotNavDisplay.jsp">
								<c:param name="storeId" value="${WCParam.storeId}" />
								<c:param name="catalogId" value="${catalogId}" />
								<c:param name="langId" value="${langId}" />
								<c:param name="emsName" value="RightSideBarAds" />
								<c:param name="adclass" value="email_ad" />
								<c:param name="errorViewName" value="AjaxOrderItemDisplayView" />
								<c:param name="showFeed" value="true" />
								<c:param name="showWidget" value="true" />
								<c:param name="sidebarWidgetId" value="" />
								<c:param name="bannerWidgetId" value="" />
								<c:param name="feedURL" value="${feedURL}"/>
							</c:import>
						</flow:ifEnabled>
						<% out.flush(); %>
					</c:otherwise>
				</c:choose>
				
				<c:choose>
					<c:when test="${requestScope.shoppingCartPage || requestScope.pendingOrderDetailsPage}">
						<c:set var="eMarketingSpotName" value="ShoppingCartFeaturedProducts"/>
						<flow:ifEnabled feature="RemoteWidget"> 
							<c:set var="eMarketingShowWidget" value="false"/>
							<c:set var="eMarketingShowFeed" value="false"/>
						</flow:ifEnabled> 
					</c:when>
					<c:when test="${requestScope.categoryPage || requestScope.productPage || requestScope.topCategoryPage || requestScope.showCategoryFeaturedProductsESpot}">
						<c:set var="eMarketingSpotName" value="CategoryPageRecommendations"/>
						<flow:ifEnabled feature="RemoteWidget"> 
							<c:set var="eMarketingShowWidget" value="true"/>
							<c:set var="eMarketingShowFeed" value="true"/>
							<c:set var="eMarketingSidebarWidgetId" value="" />
							<c:set var="eMarketingBannerWidgetId" value="" />
							<c:url var="eMarketingFeedURL" value="${restURLScheme}://${pageContext.request.serverName}:${restURLPort}${restURI}/stores/${WCParam.storeId}/MarketingSpotData/${eMarketingSpotName}">
								<c:param name="responseFormat" value="atom" />
								<c:param name="langId" value="${langId}" />
								<c:param name="currency" value="${currency}"/>
							</c:url>
						</flow:ifEnabled> 
					</c:when>
					<c:otherwise>
						<c:set var="eMarketingSpotName" value="RightSideBarFeaturedProducts"/>
						<flow:ifEnabled feature="RemoteWidget">
							<c:set var="eMarketingShowWidget" value="false"/>
							<c:set var="eMarketingShowFeed" value="false"/>
						</flow:ifEnabled> 
					</c:otherwise>
				</c:choose>
				
				<% out.flush(); %>
				<flow:ifDisabled feature="RemoteWidget">
					<c:import url="${jspStoreDir}Snippets/Marketing/ESpot/ESpotNavDisplay.jsp">
						<c:param name="storeId" value="${WCParam.storeId}" />
						<c:param name="catalogId" value="${catalogId}" />
						<c:param name="langId" value="${langId}" />
						<c:param name="emsName" value="${eMarketingSpotName}" />
						<c:param name="errorViewName" value="AjaxOrderItemDisplayView" />
					</c:import>
				</flow:ifDisabled>
				<flow:ifEnabled feature="RemoteWidget">
					<c:import url="${jspStoreDir}Snippets/Marketing/ESpot/ESpotNavDisplay.jsp">
						<c:param name="storeId" value="${WCParam.storeId}" />
						<c:param name="catalogId" value="${catalogId}" />
						<c:param name="langId" value="${langId}" />
						<c:param name="emsName" value="${eMarketingSpotName}" />
						<c:param name="errorViewName" value="AjaxOrderItemDisplayView" />
						<c:param name="showWidget" value="${eMarketingShowWidget}" />
						<c:param name="showFeed" value="${eMarketingShowFeed}" />
						<c:param name="sidebarWidgetId" value="${eMarketingSidebarWidgetId}" />
						<c:param name="bannerWidgetId" value="${eMarketingBannerWidgetId}" />  
						<c:param name="feedURL" value="${eMarketingFeedURL}"/>
					</c:import>
				</flow:ifEnabled>
				<% out.flush(); %>
				<flow:ifEnabled feature="ProductRankings">
					<% out.flush(); %>
					<c:import url="${jspStoreDir}Snippets/Catalog/ProductRankingsDisplay.jsp">
						<c:param name="storeId" value="${WCParam.storeId}" />
						<c:param name="catalogId" value="${catalogId}" />
						<c:param name="langId" value="${langId}" />
						<c:param name="errorViewName" value="AjaxOrderItemDisplayView" />
					</c:import>
					<% out.flush(); %>
				</flow:ifEnabled>
				<%@ include file="CachedRightSidebarExt.jspf"%>
				</div>
			</c:otherwise>
		</c:choose>
	</div>
</c:if>
<!-- END CachedRightSidebarDisplay.jsp -->
