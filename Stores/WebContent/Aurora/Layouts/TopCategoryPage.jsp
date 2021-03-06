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

<!doctype HTML>

<!-- BEGIN TopCategoryPage.jsp -->

<%@include file="../Common/EnvironmentSetup.jspf" %>
<%@include file="../Common/JSTLEnvironmentSetupExtForRemoteWidgets.jspf" %>
<%@include file="../Common/nocache.jspf" %>
<%@ taglib uri="http://commerce.ibm.com/coremetrics"  prefix="cm" %>

<flow:ifEnabled feature="Analytics">
<cm:setCategoryCookie />
</flow:ifEnabled>

<%-- Get SEO data and canonical URL --%>
<wcf:url var="CategoryDisplayURL" patternName="CanonicalCategoryURL" value="Category3">
	<wcf:param name="langId" value="${langId}" />
	<wcf:param name="storeId" value="${storeId}" />
	<wcf:param name="catalogId" value="${catalogId}" />
	<wcf:param name="categoryId" value="${WCParam.categoryId}" />	
	<wcf:param name="urlLangId" value="${urlLangId}" />							
</wcf:url>

<wcf:getData type="com.ibm.commerce.catalog.facade.datatypes.CatalogNavigationViewType" var="catGroupDetailsView" expressionBuilder="getCatalogNavigationCatalogGroupView">
	<wcf:param name="UniqueID" value="${WCParam.categoryId}"/>
	<wcf:contextData name="storeId" data="${storeId}" />
	<wcf:contextData name="catalogId" data="${catalogId}" />
	<wcf:param name="searchProfile" value="IBM_findCatalogGroupDetails"/>
</wcf:getData>

<%-- Include the snippet which retrieves the category data to display on this page... --%>
<%@include file = "../Common/CategoryNavigationSetup.jspf" %>

<c:set var="seoTitle" value="${catGroupDetailsView.catalogGroupView[0].title}" />
<c:set var="metaDescription" value="${catGroupDetailsView.catalogGroupView[0].metaDescription}" />
<c:set var="metaKeyword" value="${catGroupDetailsView.catalogGroupView[0].metaKeyword}" />
<c:set var="categoryName" value="${catGroupDetailsView.catalogGroupView[0].name}"/>


<wcf:url var="CategoryNavigationResultsViewURL" value="CategoryNavigationResultsView" type="Ajax">
	<wcf:param name="langId" value="${langId}"/>
	<wcf:param name="storeId" value="${storeId}"/>
	<wcf:param name="catalogId" value="${catalogId}"/>
	<wcf:param name="pageSize" value="${pageSize}"/>
	<wcf:param name="sType" value="SimpleSearch"/>						
	<wcf:param name="categoryId" value="${WCParam.categoryId}"/>		
	<wcf:param name="searchType" value="${WCParam.searchType}"/>	
	<wcf:param name="metaData" value="${metaData}"/>	
	<wcf:param name="resultCatEntryType" value="${WCParam.resultCatEntryType}"/>	
	<wcf:param name="filterFacet" value="${WCParam.filterFacet}"/>
	<wcf:param name="manufacturer" value="${WCParam.manufacturer}"/>
</wcf:url>

<html xmlns:wairole="http://www.w3.org/2005/01/wai-rdf/GUIRoleTaxonomy#"
xmlns:waistate="http://www.w3.org/2005/07/aaa" lang="${shortLocale}" xml:lang="${shortLocale}">
	<head>
	
		<title><c:out value="${seoTitle}"/></title>
		<meta name="description" content="<c:out value="${metaDescription}"/>"/>
		<meta name="keyword" content="<c:out value="${metaKeyword}"/>"/>
		<link rel="canonical" href="<c:out value="${CategoryDisplayURL}"/>" />

		<!--Main Stylesheet for browser -->
		<link rel="stylesheet" href="${jspStoreImgDir}${env_vfileStylesheet}" type="text/css" media="screen"/>
		<!-- Style sheet for print -->
		<link rel="stylesheet" href="${jspStoreImgDir}${env_vfileStylesheetprint}" type="text/css" media="print"/>

		<!-- Include script files -->
		<script type="text/javascript" src="${dojoFile}" djConfig="${dojoConfigParams}"></script>
		<%@include file="../Common/CommonJSToInclude.jspf" %>
		<script type="text/javascript" src="${jsAssetsDir}javascript/StoreCommonUtilities.js"></script>
		<script type="text/javascript" src="${jsAssetsDir}javascript/Widgets/Search.js"></script>
		<script type="text/javascript" src="${jsAssetsDir}javascript/CommonContextsDeclarations.js"></script>
		<script type="text/javascript" src="${jsAssetsDir}javascript/CommonControllersDeclaration.js"></script>
		<script type="text/javascript" src="${jsAssetsDir}javascript/Widgets/ShoppingList/ShoppingList.js"></script>
		<script type="text/javascript" src="${jsAssetsDir}javascript/Widgets/ShoppingList/ShoppingListServicesDeclaration.js"></script>
		<script type="text/javascript" src="${jsAssetsDir}javascript/Common/ShoppingActionsServicesDeclaration.js"></script>
		<script type="text/javascript" src="${jsAssetsDir}javascript/Common/ShoppingActions.js"></script>
		<script type="text/javascript" src="${jsAssetsDir}javascript/Widgets/MiniShopCartDisplay/MiniShopCartDisplay.js"></script>
		<script type="text/javascript" src="${jsAssetsDir}javascript/Widgets/Department/Department.js"></script>
		<script type="text/javascript" src="${jsAssetsDir}javascript/Widgets/QuickInfo/QuickInfo.js"></script>
		<script type="text/javascript" src="${jsAssetsDir}javascript/Layouts/SearchBasedNavigationDisplay.js"></script>
		<script type="text/javascript" src="${jsAssetsDir}javascript/Widgets/ESpot/ProductRecommendation.js"></script>
		<script type="text/javascript">
			dojo.addOnLoad(function() { 
				shoppingActionsJS.setCommonParameters('${langId}','${storeId}','${catalogId}','${userType}','${env_CurrencySymbolToFormat}');
				shoppingActionsServicesDeclarationJS.setCommonParameters('${langId}','${storeId}','${catalogId}');
				});
		</script>

	</head>
		
	<body>

		<%-- This file includes the progressBar mark-up and success/error message display markup --%>
		<%@ include file="../Common/CommonJSPFToInclude.jspf"%>

		<script type="text/javascript">
			<!-- Initializes the undo stack. This must be called from a <script>  block that lives inside the <body> tag to prevent bugs on IE. -->
			dojo.require("dojo.back");
			dojo.back.init();
			dojo.addOnLoad(function(){
				SearchBasedNavigationDisplayJS.init('${CategoryNavigationResultsViewURL}');
				shoppingActionsJS.initCompare('<c:out value="${param.fromPage}"/>');
			});
		</script>

		<!-- Begin Page -->
		<div id="page">
		
			<!-- Start Content -->
			<%@ include file="../Widgets/QuickInfo/QuickInfoPopup.jspf" %>
			<%@ include file="../Widgets/ShoppingList/ItemAddedPopup.jspf" %>

			<!-- Import Header Widget -->
			<div class="header_wrapper_position" id="headerWidget">
				<%out.flush();%>
					<c:import url = "${env_jspStoreDir}Widgets/Header/Header.jsp" />
				<%out.flush();%>
			</div>
			
			<!--Start Page Content-->
			<div class="content_wrapper_position" role="main">
				<div class="content_wrapper">
					<!--For border customization -->
					<div class="content_top">
						<div class="left_border"></div>
						<div class="middle"></div>
						<div class="right_border"></div>
					</div>
					<!-- Main Content Area -->
					<div class="content_left_shadow">
						<div class="content_right_shadow">				
							<div class="main_content">
								<!-- Start Main Content -->
								
								<!-- Start Double E-Spot Container -->
								<div class="widget_double_espot_container_position">
									<div class="widget_double_espot_container">
										<c:choose>
											<c:when test="${env_fetchMarketingDetailsOnLoad}">
												<div dojoType="wc.widget.RefreshArea" id="DoubleContentAreaESpot_Widget" controllerId="DoubleContentAreaESpot_Controller">
												</div>
											</c:when>
											<c:otherwise>
												<%out.flush();%>
												<c:import url="${env_jspStoreDir}Widgets/ESpot/ContentRecommendation/ContentRecommendation.jsp">
													<c:param name="emsName" value="CatalogBanner_Content" />
													<c:param name="numberContentPerRow" value="2" />
													<c:param name="catalogId" value="${catalogId}" />
												</c:import>
												<%out.flush();%>
											</c:otherwise>
										</c:choose>
									</div>
								</div>
								<!-- End Double E-Spot Container --->	
								
								<div class="container_full_width container_margin_8px">
									<!-- Widget Breadcrumb-->
									<div class="widget_breadcrumb_position">
										<%out.flush();%>
											<c:import url = "${env_jspStoreDir}Widgets/BreadCrumb/BreadCrumb.jsp" />
										<%out.flush();%>
									</div>
									<!-- Widget Breadcrumb -->
								</div>
																
								<!-- Content with Left Sidebar -->
								<div class="container_content_leftsidebar container_margin_5px">
									<div class="left_column">
										
										<div class="widget_left_nav_position" role="navigation">
											
											<%out.flush();%>
												<c:import url = "${env_jspStoreDir}Widgets/LeftNavigation/LeftNavigation.jsp">
													<c:param name="categoryBasedNavigation" value="true"/>
												</c:import>
											<%out.flush();%>												

										</div>
										
									</div>
									<div class="right_column">
										<!-- Widget Title Container -->
										<div class="widget_title_container_position">
											<div class="widget_title_container">
												<span role="heading" aria-level="1">${categoryName}</span>
											</div>
										</div>
										<!-- End Widget Title Container -->
										
										<c:set var="emsNameTemp" value="${fn:replace(catGroupDetailsView.catalogGroupView[0].identifier,' ','')}"/>
										<c:set var="emsNameTemp" value="${fn:replace(emsNameTemp,'\\\\','')}"/>

										<!-- Widget Hero Image Container -->
										<div class="widget_hero_image_container_position">
											<div class="widget_hero_image_container">
												<c:choose>
													<c:when test="${env_fetchMarketingDetailsOnLoad}">
														<div dojoType="wc.widget.RefreshArea" id="TopCategoryHeroESpot_Widget" controllerId="TopCategoryHeroESpot_Controller">
														</div>
													</c:when>
													<c:otherwise>
														<%out.flush();%>
															<c:import url="${env_jspStoreDir}Widgets/ESpot/ContentRecommendation/ContentRecommendation.jsp">
																<c:param name="emsName" value="${emsNameTemp}Row1_Content" />
																<c:param name="numberContentPerRow" value="2" />
																<c:param name="catalogId" value="${catalogId}" />
															</c:import>
														<%out.flush();%>
													</c:otherwise>
												</c:choose>
											</div>
										</div>
										<div class="clear_float"></div>
										<!-- End Widget Hero Image Container -->
																				
										<div class="widget_tall_double_espot_position">
											<div class="widget_tall_double_espot">
												<c:choose>
													<c:when test="${env_fetchMarketingDetailsOnLoad}">
														<div dojoType="wc.widget.RefreshArea" id="TopCategoryTallDoubleESpot_Widget" controllerId="TopCategoryTallDoubleESpot_Controller">
														</div>
													</c:when>
													<c:otherwise>
														<%out.flush();%>
															<c:import url="${env_jspStoreDir}Widgets/ESpot/ContentRecommendation/ContentRecommendation.jsp">
																<c:param name="emsName" value="${emsNameTemp}Row2_Content" />
																<c:param name="numberContentPerRow" value="2" />
																<c:param name="catalogId" value="${catalogId}" />
															</c:import>
														<%out.flush();%>
													</c:otherwise>
												</c:choose>
											</div>											
										</div>
																				
										<div class="widget_product_listing_position">
											<c:choose>
												<c:when test="${env_fetchMarketingDetailsOnLoad}">
													<div dojoType="wc.widget.RefreshArea" id="TopCategoriesESpot_Widget" controllerId="TopCategoriesESpot_Controller">
													</div>
												</c:when>
												<c:otherwise>
													<%out.flush();%>
													<c:import url="${env_jspStoreDir}Widgets/ESpot/CategoryRecommendation/CategoryRecommendation.jsp">
														<c:param name="emsName" value="${emsNameTemp}Row3_Categories" />
														<c:param name="numberCategoriesPerRow" value="4" />
														<c:param name="catalogId" value="${catalogId}" />
														<c:param name="errorViewName" value="AjaxOrderItemDisplayView" />														
													</c:import>
													<%out.flush();%>
												</c:otherwise>
											</c:choose>
										</div>
																													
										
											<c:set var="eMarketingSpotName" value="${emsNameTemp}Row4_CatEntries"/>
											<flow:ifEnabled feature="RemoteWidget"> 
												<c:set var="showWidget" value="true"/>
												<c:set var="showFeed" value="true"/>											
												<c:url var="eMarketingFeedURL" value="${restURLScheme}://${pageContext.request.serverName}:${restURLPort}${restURI}/stores/${storeId}/MarketingSpotData/${eMarketingSpotName}">
													<c:param name="responseFormat" value="atom" />
													<c:param name="langId" value="${langId}" />
													<c:param name="currency" value="${env_currencyCode}"/>
												</c:url>
											</flow:ifEnabled> 
											<div class="widget_product_listing_position">
												<c:if test="${!env_fetchMarketingDetailsOnLoad}">
													<% out.flush(); %>
													<c:import url="${env_jspStoreDir}Widgets/ESpot/ProductRecommendation/ProductRecommendation.jsp">
														<c:param name="pageSize" value="4" />
														<c:param name="emsName" value="${eMarketingSpotName}" />
														<c:param name="errorViewName" value="AjaxOrderItemDisplayView" />
														<c:param name="pageView" value="miniGrid"/>															
														<c:param name="showFeed" value="${showFeed}"/>
														<c:param name="showWidget" value="${showWidget}"/>
														<c:param name="sidebarWidgetId" value="" />
														<c:param name="bannerWidgetId" value="" />
														<c:param name="feedURL" value="${eMarketingFeedURL}"/>
													</c:import>
													<% out.flush(); %>
												</c:if>
											</div>																														
										
										<fmt:message var="titleString" key="ES_BEST_SELLERS"/>	
										<div class="widget_product_listing_position">								   
											   <c:if test="${!env_fetchMarketingDetailsOnLoad}">
														<% out.flush(); %>
														<c:import url="${env_jspStoreDir}Widgets/ESpot/ProductRecommendation/ProductRecommendation.jsp">
															<c:param name="emsName" value="BestSellers_CatEntries"/>
															<c:param name="pageView" value="miniGrid"/>
															<c:param name="pageSize" value="4"/>
															<c:param name="espotTitle" value="${titleString}"/>
															<c:param name="categoryId" value="${WCParam.categoryId}"/>
														</c:import>
														<% out.flush(); %>
												</c:if>											
										</div>
										
										<fmt:message var="titleString" key="ES_TOP_RANKED"/>	
										<div class="widget_product_listing_position">											
												<c:if test="${!env_fetchMarketingDetailsOnLoad}">
													<% out.flush(); %>
													<c:import url="${env_jspStoreDir}Widgets/ESpot/ProductRecommendation/ProductRecommendation.jsp">
														<c:param name="emsName" value="TopBrowsed_CatEntries"/>
														<c:param name="pageView" value="miniGrid"/>
														<c:param name="pageSize" value="4"/>
														<c:param name="showFeed" value="true"/>	
														<c:param name="espotTitle" value="${titleString}"/>
														<c:param name="categoryId" value="${WCParam.categoryId}"/>
													</c:import>
													<% out.flush(); %>
												</c:if>
										</div>
										
										<flow:ifEnabled feature="IntelligentOffer">
											<div class="widget_product_listing_position">
												<c:choose>
													<c:when test="${env_fetchMarketingDetailsOnLoad}">
														<div dojoType="wc.widget.RefreshArea" widgetId="IntelligentOffer_widget" id ="IntelligentOffer_widget" controllerId="IntelligentOffer_Controller" role="wairole:region" waistate:live="polite" waistate:atomic="true" waistate:relevant="all">
														</div>
													</c:when>	
													<c:otherwise>
														<%out.flush();%>
														<c:import url="${env_jspStoreDir}Widgets/ESpot/IntelligentOffer/IntelligentOffer.jsp">
															<c:param name="emsName" value="Category_IntellOffer" />
															<c:param name="catalogId" value="${catalogId}" />
															<c:param name="parentCategoryId" value="${WCParam.categoryId}" />
															<c:param name="pageView" value="miniGrid"/>
															<c:param name="pageSize" value="4"/>
														</c:import>
														<%out.flush();%>
													</c:otherwise>
												</c:choose>
											</div>	
										</flow:ifEnabled>
										
										<span class="spanacce" id="searchBasedNavigation_widget_ACCE_Label"><fmt:message key="ACCE_Region_Product_List"/></span>
										<div dojoType="wc.widget.RefreshArea" widgetId="searchBasedNavigation_widget" id = "searchBasedNavigation_widget" controllerId="searchBasedNavigation_controller" ariaMessage="<fmt:message key="ACCE_Status_Product_List_Updated"/>" ariaLiveId="${ariaMessageNode}" role="region" aria-labelledby="searchBasedNavigation_widget_ACCE_Label">
											<% out.flush(); %>
												<c:import url="${env_jspStoreDir}Layouts/CategoryNavigationResults.jsp"/>
											<% out.flush(); %>
										</div>
										
										<div class="item_spacer_10px"></div>
										<div class="item_spacer_10px"></div>
										<div class="item_spacer_10px"></div>

									</div>
									<!-- End Right Column -->
									<div class="clear_float"></div>
								</div>
								<!-- End Content With Left Sidebar -->
								
								<!-- End Main Content -->
							</div>
						</div>				
					</div>
					<!--For border customization -->
					<div class="content_bottom">
						<div class="left_border"></div>
						<div class="middle"></div>
						<div class="right_border"></div>
					</div>
				</div>
			</div>
			<!--End Page Content-->
			
			<!--Start Footer Content-->
			<div class="footer_wrapper_position">
				<%out.flush();%>
					<c:import url = "${env_jspStoreDir}Widgets/Footer/Footer.jsp" />
				<%out.flush();%>
			</div>
			<!--End Footer Content-->
			
			<!--Start: Contents after page load-->
			<c:if test="${env_fetchMarketingDetailsOnLoad}">
			<%out.flush();%>
				<c:import url = "${env_jspStoreDir}Widgets/PageLoadContent/PageLoadContent.jsp">
					<c:param name="doubleContentAreaESpot" value="true"/>
					<c:param name="topCategoryHeroESpot" value="true"/>
					<c:param name="topCategoryTallDoubleESpot" value="true"/>
					<c:param name="topCategoriesESpot" value="true"/>
					<c:param name="categoryFeaturedProductsESpot" value="true"/>
					<c:param name="bestSellingProductsESpot" value="true"/>
					<c:param name="topBrowsedProductsESpot" value="true"/>
					<c:param name="departmentName" value="${emsNameTemp}"/>
				</c:import>
			<%out.flush();%>
			</c:if>
			<!--End: Contents after page load-->
			
		</div>
	
	<flow:ifEnabled feature="Analytics"><cm:pageview/></flow:ifEnabled>
	</body>
	
<!-- END TopCategoryPage.jsp -->	
</html>