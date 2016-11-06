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

<%-- 
  *****
  * This JSP file renders the sample search landing page.
  *****
--%>


<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ taglib uri="http://commerce.ibm.com/coremetrics"  prefix="cm" %>
<%@ include file="../../../../include/JSTLEnvironmentSetup.jspf" %>
<%@ include file="../../../../include/nocache.jspf" %>

<%@page import="com.ibm.commerce.catalog.facade.datatypes.CatalogNavigationViewType"%>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">


<!-- BEGIN LandingPage.jsp -->

<!-- Landing Page Constants -->
<c:set var="attribute_image1" value="TIMER_sm.jpg"/>
<c:set var="attribute_image2" value="AUTOOFF_sm.jpg"/>
<c:set var="attribute_image3" value="PAUSE_sm.jpg"/>
<c:set var="attribute_image4" value="GRINDER_sm.jpg"/>
<fmt:message var="attribute_name1" key="SEARCH_LANDING_PAGE_TIMER" bundle="${storeText}" />
<fmt:message var="attribute_name2" key="SEARCH_LANDING_PAGE_AUTO_OFF" bundle="${storeText}" />
<fmt:message var="attribute_name3" key="SEARCH_LANDING_PAGE_PAUSE_N_SERVE" bundle="${storeText}" />
<fmt:message var="attribute_name4" key="SEARCH_LANDING_PAGE_GRINDER" bundle="${storeText}" />
<fmt:message var="categoryTitle" key="SEARCH_LANDING_PAGE_SAMPLE1_TITLE" bundle="${storeText}" />

<!-- Obtain the categoryId.  This can be hardcoded into the landing page or passed as a categoryId URL parameter, instead of from a name lookup -->
<wcbase:useBean id="catalog" classname="com.ibm.commerce.catalog.beans.CatalogDataBean" scope="page" />
<c:forEach var="topCategory" items="${catalog.topCategories}" varStatus="counter">
	<c:forEach var="subTopCategory" items="${topCategory.subCategories}">
		<c:if test="${subTopCategory.description.name == categoryTitle}">
			<c:set var="landingPageCategoryId" value="${subTopCategory.categoryId}"/>
		</c:if>
	</c:forEach>
</c:forEach>

<c:set var="navigationView" value="getCatalogNavigationView" scope="request"/>
<c:set var="searchProfile" value="IBM_findCatalogEntryByNameAndShortDescription" scope="request"/>
		
<wcf:getData type="com.ibm.commerce.catalog.facade.datatypes.CatalogNavigationViewType" var="catalogNavigationView" 
	expressionBuilder="${navigationView}" scope="request" varShowVerb="showCatalogNavigationView" 
	maxItems="1" recordSetStartNumber="0" scope="request">
	<wcf:param name="searchProfile" value="${searchProfile}" />
	<wcf:param name="searchTerm" value="" />
	<!-- 
		See SearchSetup.jspf for an explanation of the search type and its possible
		values.
	-->
	<wcf:param name="searchType" value="1000" />
	<wcf:param name="metaData" value="" />
	<wcf:param name="orderBy" value="" />
	<wcf:param name="facet" value="" />
	<wcf:param name="categoryId" value="${landingPageCategoryId}" />
	<wcf:param name="filterTerm" value="" />
	<wcf:param name="filterType" value="" />
	<wcf:param name="filterFacet" value="" />
	<wcf:param name="manufacturer" value="" />
	<wcf:param name="minPrice" value="" />
	<wcf:param name="maxPrice" value="" />
	<wcf:contextData name="storeId" data="${WCParam.storeId}" />
	<wcf:contextData name="catalogId" data="${WCParam.catalogId}" />
</wcf:getData>

<c:set var="globalfacets" value="${catalogNavigationView.facetView}" scope="request"/>

<html xmlns="http://www.w3.org/1999/xhtml" lang="${shortLocale}" xml:lang="${shortLocale}">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title><fmt:message key="SEARCH_LANDING_PAGE_SAMPLE1_TITLE" bundle="${storeText}" /></title>
		<link rel="stylesheet" href="<c:out value="${jspStoreImgDir}${vfileStylesheet}"/>" type="text/css"/>
		<!--[if lte IE 6]>
			<link rel="stylesheet" href="<c:out value="${jspStoreImgDir}${vfileStylesheetie}"/>" type="text/css"/>
		<![endif]-->
		<link rel="stylesheet" href="<c:out value="${jspStoreImgDir}ShoppingArea/CatalogSection/LandingPages/Sample1/css/landingPage1.css"/>" type="text/css"/>
		<script type="text/javascript" src="<c:out value="${dojoFile}"/>" djConfig="${dojoConfigParams}"></script>
		<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/MessageHelper.js"/>"></script>
		<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/CatalogArea/CategoryDisplay.js"/>"></script>
		<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/CatalogArea/CatalogEntryThumbnailDisplay.js"/>"></script>
		<%@ include file="../../../../include/CommonJSToInclude.jspf"%>
	</head>

	<c:set var="hasBreadCrumbTrail" value="true" scope="request"/>
	<c:set var="searchLandingPage" value="true" scope="request"/>
	<c:set var="searchLandingPageTitleKey" value="SEARCH_LANDING_PAGE_SAMPLE1_TITLE" scope="request"/>
	<c:set var="useHomeRightSidebar" value="true" scope="request"/>

	<body>
		<%@ include file="../../../../include/StoreCommonUtilities.jspf"%>
		<%@ include file="../../../../Snippets/ReusableObjects/CatalogEntryQuickInfoDetails.jspf" %>

		<div id="page">
			<!-- Header Nav Start -->
			<%@ include file="../../../../include/LayoutContainerTop.jspf"%>
			<!-- Header Nav End -->

			<!-- Main Content Start -->
			<div id="content_wrapper_box">

				<%@ include file="../../../../include/MessageDisplay.jspf"%>
				<%out.flush();%>		

				<div id="content759">
					<div id="box">
						<%out.flush();%>
							<c:set var="baseObjectPath" value="${jspStoreImgDir}ShoppingArea/CatalogSection/LandingPages/Sample1/video/" scope="request"/>
							<c:import url="${jspStoreDir}Snippets/Marketing/ESpot/ContentAreaESpot.jsp">
								<c:param name="emsName" value="SearchLandingPage1RowAds" />
								<c:param name="catalogId" value="${WCParam.catalogId}" />
								<c:param name="errorViewName" value="AjaxOrderItemDisplayView" />
								<c:param name="adWidth" value="760" />
								<c:param name="adHeight" value="320" />
							</c:import>
						<%out.flush();%>						

						<!-- Begin Shop By Brands --->
						<div class="contentgrad_spacer"></div>
						<div class="contentgrad_header">
							<div class="left_corner"></div>

							<div class="left">
								<span class="contentgrad_text"><fmt:message key="SEARCH_LANDING_PAGE_SHOP_BY_BRANDS" bundle="${storeText}" /></span>
							</div>
							<div class="right_corner"></div>
						</div>

						<div class="content_SearchLanding">
							<div class="searchlanding_info">

								<!---Brands to display --->
								<div class="searchlanding_brands">
									<c:if test="${!empty landingPageCategoryId}">
										<c:forEach var="facetField" items="${globalfacets}">
											<c:if test="${facetField.value eq 'mfName_ntk_cs'}">
												<c:forEach var="item" items="${facetField.entry}">
													<c:choose>
														<c:when test='${item.label == "Sharpson"}'>
															<c:set var="brandFilename" value="searchlanding_prod1.jpg"/>
														</c:when>
														<c:when test='${item.label == "Enzi"}'>
															<c:set var="brandFilename" value="searchlanding_prod2.jpg"/>
														</c:when>
														<c:when test='${item.label == "AromaStar"}'>
															<c:set var="brandFilename" value="searchlanding_prod3.jpg"/>
														</c:when>
														<c:when test='${item.label == "Kitchen\'s Best"}'>
															<c:set var="brandFilename" value="searchlanding_prod4.jpg"/>
														</c:when>
													</c:choose>
	
													<wcf:url var="brandURL" value="SearchDisplay">
														<wcf:param name="storeId" value="${WCParam.storeId}"/>
														<wcf:param name="catalogId" value="${WCParam.catalogId}"/>
														<wcf:param name="langId" value="${WCParam.langId}"/>
														<wcf:param name="sType" value="SimpleSearch"/>
														<wcf:param name="facet" value="${item.value}"/>
														<wcf:param name="categoryId" value="${landingPageCategoryId}"/>
														<wcf:param name="searchType" value="1000"/>
													</wcf:url>
	
													<a href="${brandURL}"><img src="${jspStoreImgDir}ShoppingArea/CatalogSection/LandingPages/Sample1/images/brands/${brandFilename}" class="brand" alt="${item.label}"></a>
												</c:forEach>
											</c:if>
										</c:forEach>
									</c:if>
								</div>
								<!--- End Brands to Display --->
							</div>
						</div>
						<div class="footer_brand">
							<div class="left_corner"></div>
							<div class="left"></div>
							<div class="right_corner"></div>
						</div>
						<!--- End Shop by Brands --->					

						<!-- Begin Shop By Features --->
						<div class="contentgrad_spacer"></div>
						<div class="contentgrad_header">
							<div class="left_corner"></div>

							<div class="left">
								<span class="contentgrad_text"><fmt:message key="SEARCH_LANDING_PAGE_SHOP_BY_FEATURES" bundle="${storeText}" /></span>
							</div>

							<div class="right_corner"></div>
						</div>

						<div class="content">
							<div class="searchlanding_features_info">
								<div class="highlight">
									<div class="ad">
										<c:if test="${!empty landingPageCategoryId}">
											<c:forEach var="i" begin="1" end="4">
												<c:set var="adClass" value="ad_space_3"/>
												<c:choose>
													<c:when test="${i == 1}">
														<c:set var="adClass" value="ad_space_1"/>
														<c:set var="imageFilename" value="${attribute_image1}"/>
														<c:set var="attributeName" value="${attribute_name1}"/>
													</c:when>
													<c:when test="${i == 2}">
														<c:set var="imageFilename" value="${attribute_image2}"/>
														<c:set var="attributeName" value="${attribute_name2}"/>
													</c:when>
													<c:when test="${i == 3}">
														<c:set var="imageFilename" value="${attribute_image3}"/>
														<c:set var="attributeName" value="${attribute_name3}"/>
													</c:when>
													<c:when test="${i == 4}">
														<c:set var="imageFilename" value="${attribute_image4}"/>
														<c:set var="attributeName" value="${attribute_name4}"/>
													</c:when>
												</c:choose>

												<wcf:url var="attributeSearchURL" value="SearchDisplay">
													<wcf:param name="storeId" value="${WCParam.storeId}"/>
													<wcf:param name="catalogId" value="${WCParam.catalogId}"/>
													<wcf:param name="langId" value="${WCParam.langId}"/>
													<wcf:param name="sType" value="SimpleSearch"/>
													<wcf:param name="facet" value="${item.value}"/>
													<wcf:param name="categoryId" value="${landingPageCategoryId}"/>
													<wcf:param name="searchTerm" value="${attributeName}"/>
													<wcf:param name="searchType" value="1000"/>
												</wcf:url>
		
												<div class="${adClass}"><img src="${jspStoreImgDir}/images/trasparent.gif" alt="<fmt:message key="No_Image" bundle="${storeText}" />" border="0"></div>
												<div class="ad_product_SearchLanding">
													<div>
														<div class="img_align">
															<a href="${attributeSearchURL}">
																<img src="${jspStoreImgDir}ShoppingArea/CatalogSection/LandingPages/Sample1/images/features/${imageFilename}" alt="<c:out value="${attributeName}"/>" border="0">
															</a>
														</div>
													</div>
													<div class="ad_contenttitle">
														<p class="title" style="padding-top: 2px;"><c:out value="${attributeName}"/></p>
													</div>
													<div><img src="${jspStoreImgDir}/images/colors/color1/ad_box_footer_small.png" alt=""></div>
												</div>
											</c:forEach>
										</c:if>							
										<br clear="left">
									</div>
								</div>
							</div>
						</div>
						<div class="footer">
							<div class="left_corner"></div>
							<div class="left"></div>
							<div class="right_corner"></div>
						</div>
						<!--- End Shop by Features --->

						<div id="HompageScrollableEspot" class="genericESpot">
							<div class="caption" id="CachedTopCategoriesDisplay_div_1a" style="display:none">[<c:out value="HomePageFeaturedProducts"/>]</div>
							<div class="contentgrad_spacer"></div>
							<div class="contentgrad_header" id="CachedTopCategoriesDisplay_div_1">
								 <div class="left_corner" id="CachedTopCategoriesDisplay_div_2"></div>
								 <div class="left" id="CachedTopCategoriesDisplay_div_3"><span class="contentgrad_text"><fmt:message key="CLEARANCE_SALE" bundle="${storeText}" /></span></div>
								 <div class="right_corner" id="CachedTopCategoriesDisplay_div_4"></div>
							</div>
							<div class="body759" id="CachedTopCategoriesDisplay_div_5">
								<div id="id" dojoType="wc.widget.ScrollablePane" autoScroll='false' scrollByPage="true" itemSize="174" altPrev = '<fmt:message key="SCROLL_LEFT" bundle="${storeText}" />' altNext = '<fmt:message key="SCROLL_RIGHT" bundle="${storeText}" />' tempImgPath = "<c:out value='${jspStoreImgDir}'/>images/empty.gif">
									<%out.flush();%>
									<c:import url="${jspStoreDir}Snippets/Catalog/CategoryDisplay/ProductRecommendationsDisplay.jsp">
										<c:param name="storeId" value="${storeId}"/>
										<c:param name="catalogId" value="${catalogId}"/>
										<c:param name="langId" value="${langId}"/>
										<c:param name="pageView" value="scrollESpot"/>
									</c:import>
									<%out.flush();%>					
								</div>
								<script type="text/javascript">dojo.addOnLoad(function() { parseWidget("id"); });</script>
								<br />
							</div>
							
							<div class="footer" id="CachedTopCategoriesDisplay_div_6">
								 <div class="left_corner" id="CachedTopCategoriesDisplay_div_7"></div>
								 <div class="left" id="CachedTopCategoriesDisplay_div_8"></div>
								 <div class="right_corner" id="CachedTopCategoriesDisplay_div_9"></div>
							</div>
						</div>

					</div>
				</div>				
			</div>

			<!-- Main Content End -->
			
			<!-- Footer Start Start -->
			<%@ include file="../../../../include/LayoutContainerBottom.jspf"%>  
			<!-- Footer Start End -->
		</div>
		<div id="page_shadow" class="shadow"></div>
		
	<flow:ifEnabled feature="Analytics"><cm:pageview/></flow:ifEnabled>
	</body>
</html>

<!-- END LandingPage.jsp -->