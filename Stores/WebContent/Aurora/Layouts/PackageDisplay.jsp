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

<!-- BEGIN PackageDisplay.jsp -->

<%-- 
  *****
  * This JSP diplay the product details given a productId or partNumber. This page imports the following components
  * Header Component - Display header links, department widget, mini shop-cart widget and Search widget
  * Product Image Component - Display the product image
  * Product Description Component - Displays product short description, attributes, inventory component, price component etc.,
  * Merchandising Association Component
  * E-spots for Recently Viewed and Recommendations
  * Product TAB component
  * Footer Component - Display footer links
  *****
--%>

<%@include file="../Common/EnvironmentSetup.jspf" %>
<%@include file="../Common/nocache.jspf" %>
<%@include file="../Common/ReviewsSetup.jspf" %>
<%@ taglib uri="http://commerce.ibm.com/coremetrics"  prefix="cm" %>

<wcf:url var="ProductDisplayURL" patternName="ProductURL" value="Product1">
	<wcf:param name="langId" value="${langId}" />
	<wcf:param name="storeId" value="${WCParam.storeId}" />
	<wcf:param name="catalogId" value="${WCParam.catalogId}" />
	<wcf:param name="productId" value="${productId}" />
	<wcf:param name="urlLangId" value="${urlLangId}" />
</wcf:url>

<c:set var="packageId" value="${productId}" scope="request"/>

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
	    <link rel="canonical" href="<c:out value="${ProductDisplayURL}"/>" />
		
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
		<%@ include file="../Widgets/Reviews/ReviewHead.jspf"%>
		
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
			
			<meta property="og:url" content="<c:out value="${ProductDisplayURL}"/>"/>
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
								<div class="container_product_details_bundle_package container_margin_5px">
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
												<c:import url = "${env_jspStoreDir}Widgets/ProductDescription/ProductDescription.jsp">
													<c:param name="hasShoppingSection" value="false"/>
												</c:import>
											<%out.flush();%>
											<flow:ifEnabled feature="FacebookIntegration">
				                            	<%--Display Facebook plug-in, Like button  --%>
												<%out.flush();%>												
				                            	<c:import url="${env_jspStoreDir}Widgets/FacebookLike/FacebookLike.jsp" >
				                            		<c:param name="productDisplayURL" value="${ProductDisplayURL}"/>
												</c:import>
												<%out.flush();%>
			                                </flow:ifEnabled>											
										</div>
										<!-- End Widget Product Information Viewer -->
									</div>
									<div class="clear_float"></div>
								</div>
								<!-- End Product Image and Product Information -->
								
								<div class="container_full_width_bundle">
									<fmt:message key='PKG_CONFIGURE_ITEMS_IN_PACKAGE'/>
								</div>
								
								<!-- Content with Right Sidebar -->
								<div class="container_content_rightsidebar container_margin">
									<div class="left_column">
										<!-- Start product listing widget -->
										<div class="widget_product_listing_position">
											<%out.flush();%>
												<c:import url = "${env_jspStoreDir}Widgets/ComponentListing/ComponentListing.jsp">
													<c:param name="type" value="package"/>
												</c:import>
											<%out.flush();%>
										</div>
										<!-- End product listing widget -->
										
										<c:if test = "${requestScope.bundleKitAvailable eq 'true'}">
											<%-- Only if this bundle is available, display merchandising associations... AddBothToCart doesn't make sense if one of them is not buyable --%>
											<!-- Start coordinate widget -->
											<div class="widget_coordinate_position">
												<%out.flush();%>
													<c:import url = "${env_jspStoreDir}Widgets/MerchandisingAssociation/MerchandisingAssociation.jsp" />
												<%out.flush();%>
											</div>
											<!-- End coordinate widget-->
										</c:if>
										
									</div>
				
									<div class="right_column">
									
										<!-- Widget Package Summary -->
										<div class="widget_bundle_summary_position">
										<% out.flush(); %>
											<c:import url = "${env_jspStoreDir}Widgets/PackageSummary/PackageSummary.jsp"/>
										<% out.flush(); %>
										</div>
										<!-- End Widget Package Summary -->
										
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

								<flow:ifEnabled feature="RatingReviewIntegration">
								<div class="container_full_width_bundle">
									<fmt:message key="PT_CUSTOMER_REVIEWS"/>
									<div class="nested_widget_spacer"></div>
									<c:set target="${reviewParameters}" property="display" value="details" />
									<%@ include file="../Widgets/Reviews/ReviewDisplay.jspf"%>
								</div>
								</flow:ifEnabled>

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
					<c:param name="sideBarBrowsingHistory" value="true"/>
					<c:param name="productId" value="${packageId}"/>
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

<!-- END PackageDisplay.jsp -->		
</html>