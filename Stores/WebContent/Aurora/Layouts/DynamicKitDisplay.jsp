<!DOCTYPE html>

<%--
 =================================================================
  Licensed Materials - Property of IBM

  WebSphere Commerce

  (C) Copyright IBM Corp. 2012 All Rights Reserved.

  US Government Users Restricted Rights - Use, duplication or
  disclosure restricted by GSA ADP Schedule Contract with
  IBM Corp.
 =================================================================
--%>

<!-- BEGIN DynamicKitDisplay.jsp -->

<%-- 
  *****
  * This JSP page displays the dynamic kit details.  It shows the following information:
  *  - Full-sized image, name, and long description of the dynamic kit
  *  - Discount description for the dynamic kit, if available
  *  - Pre-Configured price of the dynamic kit
  *  - Descriptive attributes, displayed as name:value
  *  - 'Quantity' box to enter the quantity (default is 1)
  *  - 'Add to shopping cart' button, 'Add to wish list' button for B2C stores
  *****
--%>
<%@include file="../Common/EnvironmentSetup.jspf" %>
<%@include file="../Common/nocache.jspf" %>
<%@ taglib uri="http://commerce.ibm.com/coremetrics"  prefix="cm" %>

<c:if test="${not empty WCParam.productId}">
	<c:set var="productId" value="${WCParam.productId}" />
</c:if>

<c:if test="${empty productId and not empty param.productId}">
	<c:set var="productId" value="${param.productId}" />
</c:if>

<wcf:url var="DynamicKitDisplayURL" patternName="ProductURL" value="Product1">
	<wcf:param name="langId" value="${langId}" />
	<wcf:param name="storeId" value="${storeId}" />
	<wcf:param name="catalogId" value="${catalogId}" />
	<wcf:param name="productId" value="${productId}" />
	<wcf:param name="urlLangId" value="${urlLangId}" />
</wcf:url>

<c:if test="${!empty productId}">
	<%-- Since this is a product page, get all the details about this product and save it in internal cache, so that other components can use it... --%>
	<wcf:getData type="com.ibm.commerce.catalog.facade.datatypes.CatalogNavigationViewType" var="catalogNavigationView" 
		expressionBuilder="getCatalogEntryViewAllWithoutAttachmentsByID" varShowVerb="showCatalogNavigationView" maxItems="1" recordSetStartNumber="0">
		<wcf:param name="UniqueID" value="${productId}"/>
		<wcf:contextData name="storeId" data="${storeId}" />
		<wcf:contextData name="catalogId" data="${catalogId}" />
	</wcf:getData>
	<%-- Cache it in our internal hash map --%>
	<c:set var="key1" value="${productId}+getCatalogEntryViewAllByID"/>
	<wcf:set target = "${cachedCatalogEntryDetailsMap}" key="${key1}" value="${catalogNavigationView.catalogEntryView[0]}"/>
</c:if>

<c:set var="pageTitle" value="${catalogNavigationView.catalogEntryView[0].title}" />
<c:set var="metaDescription" value="${catalogNavigationView.catalogEntryView[0].metaDescription}" />
<c:set var="metaKeyword" value="${catalogNavigationView.catalogEntryView[0].metaKeyword}" />
<c:set var="fullImageAltDescription" value="${catalogNavigationView.catalogEntryView[0].fullImageAltDescription}" scope="request" />
<c:set var="categoryId" value="${catalogNavigationView.catalogEntryView[0].parentCatalogGroupID}"/>
<c:set var="pageView" value="DynamicDisplayView" scope="request"/>

<html xmlns:wairole="http://www.w3.org/2005/01/wai-rdf/GUIRoleTaxonomy#"
<flow:ifEnabled feature="FacebookIntegration">
	<%-- Facebook requires this to work in IE browsers --%>
	xmlns:fb="http://www.facebook.com/2008/fbml" 
	xmlns:og="http://opengraphprotocol.org/schema/"
</flow:ifEnabled>
xmlns:waistate="http://www.w3.org/2005/07/aaa" lang="${shortLocale}" xml:lang="${shortLocale}">
	<head>
		<title><c:out value="${pageTitle}"/></title>
		<meta name="description" content="<c:out value="${metaDescription}"/>"/>
		<meta name="keyword" content="<c:out value="${metaKeyword}"/>"/>
	    <link rel="canonical" href="<c:out value="${DynamicKitDisplayURL}"/>" />
	    
		<!--Main Stylesheet for browser -->
		<link rel="stylesheet" href="${jspStoreImgDir}${env_vfileStylesheet}" type="text/css" media="screen"/>
		<!-- Style sheet for print -->
		<link rel="stylesheet" href="${jspStoreImgDir}${env_vfileStylesheetprint}" type="text/css" media="print"/>
		
		<!-- Include script files -->
		<script type="text/javascript" src="${dojoFile}" djConfig="${dojoConfigParams}"></script>
		<%@include file="../Common/CommonJSToInclude.jspf" %>
		<script type="text/javascript" src="${jsAssetsDir}javascript/StoreCommonUtilities.js"></script>
		<script type="text/javascript" src="${jsAssetsDir}javascript/Widgets/Search.js"></script>
		<script type="text/javascript" src="${jsAssetsDir}javascript/Widgets/ESpot/ProductRecommendation.js"></script>
		<script type="text/javascript" src="${jsAssetsDir}javascript/CommonContextsDeclarations.js"></script>
		<script type="text/javascript" src="${jsAssetsDir}javascript/CommonControllersDeclaration.js"></script>
		<script type="text/javascript" src="${jsAssetsDir}javascript/Widgets/ProductFullImage/ProductFullImage.js"></script>
		<script type="text/javascript" src="${jsAssetsDir}javascript/Widgets/MerchandisingAssociation/MerchandisingAssociation.js"></script>
		<script type="text/javascript" src="${jsAssetsDir}javascript/Widgets/ProductTab/ProductTab.js"></script>
		<script type="text/javascript" src="${jsAssetsDir}javascript/Widgets/InventoryStatus/InventoryStatus.js"></script>
		<script type="text/javascript" src="${jsAssetsDir}javascript/Widgets/ShoppingList/ShoppingList.js"></script>
		<script type="text/javascript" src="${jsAssetsDir}javascript/Widgets/ShoppingList/ShoppingListServicesDeclaration.js"></script>
		<script type="text/javascript" src="${jsAssetsDir}javascript/Common/ShoppingActionsServicesDeclaration.js"></script>
		<script type="text/javascript" src="${jsAssetsDir}javascript/Common/ShoppingActions.js"></script>
		<script type="text/javascript" src="${jsAssetsDir}javascript/Widgets/MiniShopCartDisplay/MiniShopCartDisplay.js"></script>
		<script type="text/javascript" src="${jsAssetsDir}javascript/Widgets/Department/Department.js"></script>
		<script type="text/javascript" src="${jsAssetsDir}javascript/Widgets/QuickInfo/QuickInfo.js"></script>
		<script type="text/javascript" src="${jsAssetsDir}javascript/Widgets/ProductFullImage/ProductFullImage.js"></script>
		<script type="text/javascript">
			dojo.addOnLoad(function() { 
					shoppingActionsJS.setCommonParameters('${langId}','${storeId}','${catalogId}','${userType}','${env_CurrencySymbolToFormat}');
					shoppingActionsServicesDeclarationJS.setCommonParameters('${langId}','${storeId}','${catalogId}');
				});
		</script>
		
		<flow:ifEnabled feature="FacebookIntegration">
			<%@include file="../Common/JSTLEnvironmentSetupExtForFacebook.jspf" %>
			
			<%--Facebook Open Graph tags that are required  --%>
			<meta property="og:title" content="<c:out value="${pageTitle}"/>" />
			
			<c:set var="catalogEntryDetails" value="${cachedCatalogEntryDetailsMap[key1]}"/>			
			<c:choose>
				<c:when test="${!empty catalogEntryDetails.metaData['ThumbnailPath']}">
					<c:set var="imagePath" value="${env_imageContextPath}/${catalogEntryDetails.metaData['ThumbnailPath']}" />
				</c:when>				
				<c:when test="${!empty catalogEntryDetails.metaData['FullImagePath']}">
					<c:set var="imagePath" value="${env_imageContextPath}/${catalogEntryDetails.metaData['FullImagePath']}" />
				</c:when>
				<c:otherwise>
					<c:set var="imagePath" value="${jspStoreImgDir}images/logo.png" />
				</c:otherwise>
			</c:choose> 
			<meta property="og:image" content="<c:out value="${schemeToUse}://${request.serverName}${portUsed}${imagePath}" />"/>
			
			<meta property="og:url" content="<c:out value="${DynamicKitDisplayURL}"/>"/>
			<meta property="og:type" content="product"/>
			<meta property="og:description" content="${catalogNavigationView.catalogEntryView[0].metaDescription}" />
			<meta property="fb:app_id" name="fb_app_id" content="<c:out value="${facebookAppId}"/>"/>
		</flow:ifEnabled>
		
	</head>
		
	<body>

		<%-- This file includes the progressBar mark-up and success/error message display markup --%>
		<%@ include file="../Common/CommonJSPFToInclude.jspf"%>
		<%@ include file="../Widgets/QuickInfo/QuickInfoPopup.jspf" %>
		<%@ include file="../Widgets/ShoppingList/ItemAddedPopup.jspf" %>
		
		<!-- Begin Page -->
		<div id="page">

			<!-- Import Header Widget -->
			<div class="header_wrapper_position" id="headerWidget">
				<%out.flush();%>
					<c:import url = "${env_jspStoreDir}Widgets/Header/Header.jsp" />
				<%out.flush();%>
			</div>
			<!-- End Header -->

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

								

								<!-- Product Image and Product Information -->

								<div class="container_product_details_image_information container_margin_5px">
									<div class="left_column">

										<!-- Widget Product Image Viewer -->
										<div class="widget_product_image_viewer_position">
											<%out.flush();%>
												<c:import url = "${env_jspStoreDir}Widgets/ProductFullImage/ProductFullImage.jsp" />
											<%out.flush();%>
										</div>										
										<!-- End Widget Product Image Viewer -->

									</div>

									<div class="right_column">

										<!-- Widget Product Information Viewer -->
										<div class="widget_product_info_viewer_position">
											<%out.flush();%>
												<c:import url = "${env_jspStoreDir}Widgets/ProductDescription/ProductDescription.jsp" />
											<%out.flush();%>
											<flow:ifEnabled feature="FacebookIntegration">
				                            	<%--Display Facebook plug-in, Like button  --%>
												<%out.flush();%>												
				                            	<c:import url="${env_jspStoreDir}Widgets/FacebookLike/FacebookLike.jsp" >
				                            		<c:param name="productDisplayURL" value="${DynamicKitDisplayURL}"/>
												</c:import>
												<%out.flush();%>
			                                </flow:ifEnabled>
										</div>
										<!-- End Widget Product Information Viewer -->

									</div>

									<div class="clear_float"></div>

								</div>
								<!-- End Product Image and Product Information -->

								<!-- Content with Right Sidebar -->
								<div class="container_content_rightsidebar container_margin">

									<div class="left_column">
										<c:if test = "${requestScope.dynamicKitAvailable and requestScope.isDKPreConfigured}">
											<%-- Only if this dk is available and preconfigured, display merchandising associations... AddBothToCart doesn't make sense if one is not buyable --%>
											<!-- Start coordinate widget -->
											<div class="widget_coordinate_position">
												<%out.flush();%>
													<c:import url = "${env_jspStoreDir}Widgets/MerchandisingAssociation/MerchandisingAssociation.jsp" />
												<%out.flush();%>
											</div>
											<!-- End coordinate widget-->
										</c:if>
										
										<div class="item_spacer_3px"></div>
										<div class="item_spacer_10px"></div>
										<flow:ifEnabled feature="IntelligentOffer">
											<div class="widget_product_listing_position">
												<c:choose>
													<c:when test="${env_fetchMarketingDetailsOnLoad}">
														<div dojoType="wc.widget.RefreshArea" widgetId="IntelligentOffer_widget" id ="IntelligentOffer_widget" controllerId="IntelligentOffer_Controller">
														</div>
													</c:when>	
													<c:otherwise>
														<%out.flush();%>
														<c:import url="${env_jspStoreDir}Widgets/ESpot/IntelligentOffer/IntelligentOffer.jsp">
															<c:param name="emsName" value="ProductPageIntelligentOffer" />
															<c:param name="catalogId" value="${WCParam.catalogId}" />
															<c:param name="partNumber" value="${partnumber}" />
															<c:param name="parentCategoryId" value="${WCParam.categoryId}" />
															<c:param name="pageSize" value="4" />
															<c:param name="pageView" value="miniGrid" />
														</c:import>
														<%out.flush();%>
													</c:otherwise>
												</c:choose>
											</div>	
										</flow:ifEnabled>
										
										<!-- Widget Tab Container -->
										<div class="widget_tab_container_position">
											<%out.flush();%>
												<c:import url = "${env_jspStoreDir}Widgets/ProductTab/ProductTab.jsp" />
											<%out.flush();%>
										</div>
										<!-- End Widget Tab Container -->
									</div>
									
									<wcf:getData
										type="com.ibm.commerce.catalog.facade.datatypes.CatalogNavigationViewType"
										var="subCategory"
										expressionBuilder="getCatalogNavigationCatalogGroupView"
										maxItems="1" recordSetStartNumber="0">
										<wcf:param name="UniqueID" value="${categoryId}" />
										<wcf:contextData name="storeId" data="${storeId}" />
										<wcf:contextData name="catalogId" data="${catalogId}" />
									</wcf:getData>
									
									<c:set var="emsNameTemp" value="${fn:replace(subCategory.catalogGroupView[0].identifier,' ','')}"/>
									<c:set var="emsNameTemp" value="${fn:replace(emsNameTemp,'\\\\','')}"/>
									
									<div class="right_column">
									
										<!-- Widget Reccommended Vertical -->
										<div class="widget_recommended_position">											
											<c:if test="${!env_fetchMarketingDetailsOnLoad}">
											<% out.flush(); %>
												<c:import url="${env_jspStoreDir}Widgets/ESpot/ProductRecommendation/ProductRecommendation.jsp">
													<c:param name="emsName" value="${emsNameTemp}ProductRight_CatEntries"/>
													<c:param name="pageView" value="sidebar"/>
													<c:param name="pageSize" value="2"/>
													<c:param name="align" value="vertical"/>
												</c:import>
											<% out.flush(); %>
											</c:if>											
										</div>
										<!-- End Widget Reccommended Vertical -->	
									
										<div class="nested_widget_spacer"></div>
										
										<fmt:message var="titleString" key="ES_RECENTLY_VIEWED"/>	
										<!-- Widget Recently Viewed -->
										<div class="widget_recentlyviewed_position">											
											<c:if test="${!env_fetchMarketingDetailsOnLoad}">
											<% out.flush(); %>
												<c:import url="${env_jspStoreDir}Widgets/ESpot/ProductRecommendation/ProductRecommendation.jsp">
													<c:param name="emsName" value="RecViewed_CatEntries"/>
													<c:param name="pageView" value="sidebar"/>
													<c:param name="pageSize" value="2"/>
													<c:param name="align" value="vertical"/>
													<c:param name="espotTitle" value="${titleString}"/>
												</c:import>
											<% out.flush(); %>
											</c:if>											
										</div>
										<!-- End Widget Recently Viewed -->								
									</div>
									<div class="clear_float"></div>
								</div>
								<!-- End Content With Right Sidebar -->
								
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
					<c:param name="mainDiscounts" value="true"/>
					<c:param name="doubleContentAreaESpot" value="true"/>
					<c:param name="sideBarProductRecommendations" value="true"/>
					<c:param name="sideBarBrowsingHistory" value="true"/>
					<c:param name="productId" value="${productId}"/>
				</c:import>
			<%out.flush();%>
			</c:if>
			<!--End: Contents after page load-->

		</div>
		
	<flow:ifEnabled feature="Analytics">
	<%@include file="../AnalyticsFacetSearch.jspf" %>
		<cm:product catalogNavigationViewType="${catalogNavigationView}" extraparms="null, ${analyticsFacet}"/>
		<cm:pageview/>
	</flow:ifEnabled>

	</body>

<!-- END DynamicKitDisplay.jsp -->

</html>