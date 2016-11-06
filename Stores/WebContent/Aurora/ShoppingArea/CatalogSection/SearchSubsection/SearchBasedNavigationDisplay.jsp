<%--
 =================================================================
  Licensed Materials - Property of IBM

  WebSphere Commerce

  (C) Copyright IBM Corp. 2008, 2012 All Rights Reserved.

  US Government Users Restricted Rights - Use, duplication or
  disclosure restricted by GSA ADP Schedule Contract with
  IBM Corp.
 =================================================================
--%>

<%-- 
  *****
  * This JSP file renders the catalog search page.
  *****
--%>
<!-- BEGIN SearchBasedNavigationDisplay.jsp -->

<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../../../include/JSTLEnvironmentSetup.jspf" %>
<%@ include file="../../../include/nocache.jspf" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>
<%@ taglib uri="http://commerce.ibm.com/coremetrics"  prefix="cm" %>

<c:if test="${WCParam.advanced != 'true'}">
	<%@ include file="../../../Snippets/Search/SearchSetup.jspf" %>
	<c:set var="searchFacets" value="true" scope="request"/>
</c:if>

<wcf:url value="AjaxCatalogSearchResultView" var="SimpleSearchResultDisplayViewURL" type="Ajax">
	<wcf:param name="pageView" value="${WCParam.pageView}"/>
	<wcf:param name="storeId" value="${WCParam.storeId}"/>
	<wcf:param name="langId" value="${langId}"/>
	<wcf:param name="catalogId" value="${WCParam.catalogId}"/>
	<wcf:param name="searchTerm" value="${searchTerm}"/>
	<wcf:param name="resultCatEntryType" value="${WCParam.resultCatEntryType}"/>
	<wcf:param name="pageSize" value="${WCParam.pageSize}"/>
	<wcf:param name="beginIndex" value="${WCParam.beginIndex}"/>
	<wcf:param name="sType" value="${WCParam.sType}"/>	
	<wcf:param name="searchType" value="${WCParam.searchType}"/>
	<wcf:param name="searchTermCaseSensitive" value="${WCParam.searchTermCaseSensitive}"/>
	<wcf:param name="searchTermOperator" value="${WCParam.searchTermOperator}"/>
	<wcf:param name="filterTerm" value="${WCParam.filterTerm}"/>
	<wcf:param name="filterType" value="${WCParam.filterType}"/>
	<wcf:param name="filterTermCaseSensitive" value="${WCParam.filterTermCaseSensitive}"/>
	<wcf:param name="filterTermOperator" value="${WCParam.filterTermOperator}"/>
	<wcf:param name="searchTermScope" value="${WCParam.searchTermScope}"/>
	<wcf:param name="categoryId" value="${WCParam.categoryId}"/>
	<wcf:param name="categoryType" value="${WCParam.categoryType}"/>
	<wcf:param name="qtyAvailable" value="${WCParam.qtyAvailable}"/>
	<wcf:param name="qtyAvailableOperator" value="${WCParam.qtyAvailableOperator}"/>
	<wcf:param name="qtyMeasure" value="${WCParam.qtyMeasure}"/>
	<wcf:param name="qtyMeasureCaseSensitive" value="${WCParam.qtyMeasureCaseSensitive}"/>
	<wcf:param name="qtyMeasureOperator" value="${WCParam.qtyMeasureOperator}"/>
	<wcf:param name="minPrice" value="${WCParam.minPrice}"/>
	<wcf:param name="maxPrice" value="${WCParam.maxPrice}"/>
	<wcf:param name="catgrpSchemaType" value="1"/>
	<wcf:param name="RASchemaType" value="1"/>
	<wcf:param name="facet" value="${WCParam.facet}"/>
	<wcf:param name="metaData" value="${WCParam.metaData}"/>
</wcf:url>

<c:set var="breadcrumbTitle" value=""/>
<fmt:message var="breadcrumbDivider" key="DIVIDING_BAR" bundle="${storeText}"/>

<c:set var="facetCount" value="0"/>
<c:if test="${!empty WCParam.categoryId && !empty globalbreadcrumbs && empty searchTerm}">
	<c:forEach var="breadcrumb" items="${globalbreadcrumbs.breadCrumbTrailEntryView}">
		<c:choose>
			<c:when test="${breadcrumb.type_ == 'FACET_ENTRY_CATEGORY'}">
				<c:choose>
					<c:when test="${empty breadcrumbTitle}">
						<c:set var="breadcrumbTitle" value="${breadcrumb.label}"/>
					</c:when>
					<c:otherwise>
						<c:set var="breadcrumbTitle" value="${breadcrumb.label} ${breadcrumbDivider} ${breadcrumbTitle}"/>
					</c:otherwise>
				</c:choose>
			</c:when>
			<c:otherwise>
				<c:set var="facetCount" value="${facetCount + 1}"/>
			</c:otherwise>
		</c:choose>
	</c:forEach>
</c:if>

<c:choose>

	<c:when test="${totalContentCount == 0 && totalCount == 1 && !searchMissed && empty WCParam.categoryId}">

		<c:forEach var="breadcrumb" items="${globalbreadcrumbs.breadCrumbTrailEntryView}">
			<c:if test="${breadcrumb.type_ == 'FACET_ENTRY_CATEGORY'}">
				<c:if test="${empty searchTopCategoryId}">
					<c:set var="searchTopCategoryId" value="${breadcrumb.value}" scope="request"/>
				</c:if>
				<c:set var="searchParentCategoryId" value="${breadcrumb.value}" scope="request"/>
			</c:if>
		</c:forEach>

		<c:forEach var="catEntry" items="${globalresults}" varStatus="status">
			<c:set var="catEntryIdentifier" value="${catEntry.uniqueID}"/>
		</c:forEach>

		<c:choose>
			<%-- Use the context parameters if they are available; usually in a subcategory --%>
			<c:when test="${!empty searchParentCategoryId && !empty searchTopCategoryId}">
				<%-- both parent and top category are present.. display full product URL --%>
				<c:set var="parent_category_rn" value="${searchTopCategoryId}" />
				<c:set var="top_category" value="${searchTopCategoryId}" />
				<c:set var="categoryId" value="${searchParentCategoryId}" />
				<c:set var="patternName" value="ProductURLWithParentAndTopCategory"/>
			</c:when>
			<c:when test="${!empty searchParentCategoryId}">
				<%-- parent category is not empty..use product URL with parent category --%>
				<c:set var="parent_category_rn" value="${searchParentCategoryId}" />
				<c:set var="top_category" value="${searchTopCategoryId}" />
				<c:set var="categoryId" value="${WCParam.categoryId}" />
				<c:set var="patternName" value="ProductURLWithParentCategory"/>
			</c:when>
			<%-- In a top category; use top category parameters --%>
			<c:when test="${WCParam.top == 'Y'}">
				<c:set var="parent_category_rn" value="${searchParentCategoryId}" />
				<c:set var="top_category" value="${searchTopCategoryId}" />
				<c:set var="categoryId" value="${WCParam.categoryId}" />
				<c:set var="patternName" value="ProductURLWithCategory"/>
			</c:when>
			<%-- Store front main page; usually eSpots, parents unknown --%>
			<c:otherwise>
				<c:set var="parent_category_rn" value="${searchParentCategoryId}" />
				<c:set var="top_category" value="${searchTopCategoryId}" />
				<%-- Just display productURL without any category info --%>
				<c:set var="patternName" value="ProductURL"/>
			</c:otherwise>
		</c:choose>

		<wcf:url var="catEntryDisplayUrl" patternName="${patternName}" value="Product2">
			<wcf:param name="catalogId" value="${WCParam.catalogId}"/>
			<wcf:param name="storeId" value="${WCParam.storeId}"/>
			<wcf:param name="productId" value="${catEntryIdentifier}"/>
			<wcf:param name="langId" value="${langId}"/>
			<wcf:param name="errorViewName" value="ProductDisplayErrorView"/>
			<wcf:param name="categoryId" value="${WCParam.categoryId}" />
			<wcf:param name="parent_category_rn" value="${searchParentCategoryId}" />
			<wcf:param name="top_category" value="${searchTopCategoryId}" />
			<wcf:param name="urlLangId" value="${urlLangId}" />
		</wcf:url>

		<c:redirect url="${catEntryDisplayUrl}"/>
	</c:when>
	<c:otherwise>
		<c:choose>
			<c:when test="${!empty WCParam.categoryId}">
				<wcf:getData type="com.ibm.commerce.catalog.facade.datatypes.CatalogNavigationViewType" var="catGroupDetailsView" expressionBuilder="getCatalogNavigationCatalogGroupView">
					<wcf:param name="UniqueID" value="${WCParam.categoryId}"/>
					<wcf:contextData name="storeId" data="${WCParam.storeId}" />
					<wcf:contextData name="catalogId" data="${WCParam.catalogId}" />
					<wcf:param name="searchProfile" value="IBM_findCatalogGroupDetails"/>
				</wcf:getData>
				<c:set var="seoTitle" value="${catGroupDetailsView.catalogGroupView[0].title}" />
				<c:set var="metaDescription" value="${catGroupDetailsView.catalogGroupView[0].metaDescription}" />
				<c:set var="fullImageAltDescription" value="${catGroupDetailsView.catalogGroupView[0].fullImageAltDescription}" scope="request" />
				<wcbase:useBean id="catGroup" classname="com.ibm.commerce.catalog.beans.CategoryDataBean" scope="page" />
				<c:set var="metaKeyword" value="${catGroup.description.keyWord}" />
			</c:when>
			<c:otherwise>
				<c:set var="metaDescription" value="" />
				<c:set var="metaKeyword" value="" />
			</c:otherwise>
		</c:choose>
		<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

		<html xmlns:wairole="http://www.w3.org/2005/01/wai-rdf/GUIRoleTaxonomy#"
		xmlns:waistate="http://www.w3.org/2005/07/aaa" lang="${shortLocale}" xml:lang="${shortLocale}">
		<head>
			<!-- Mimic Internet Explorer 7 -->
			<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" >
			<title>
				<c:choose>
					<c:when test="${seoTitle != null && !empty seoTitle}">
						<c:out value="${seoTitle}"/>
					</c:when>
					<c:when test="${!empty breadcrumbTitle}">
						<c:out value="${breadcrumbTitle}"/> - <c:out value="${storeName}"/>
					</c:when>
					<c:when test="${WCParam.advanced == 'true'}">
						<fmt:message key="TITLE_ADVANCED_SEARCH" bundle="${storeText}"/>
					</c:when>
					<c:otherwise>
						<fmt:message key="TITLE_SEARCH_RESULTS" bundle="${storeText}"/>
					</c:otherwise>
				</c:choose>
			</title>
			<meta name="description" content="<c:out value="${metaDescription}"/>"/>
			<meta name="keyword" content="<c:out value="${metaKeyword}"/>"/>
			<c:if test="${!empty WCParam.categoryId}">
				<wcf:url var="CategoryDisplayURL" patternName="CanonicalCategoryURL" value="Category3">
					<wcf:param name="langId" value="${langId}" />
					<wcf:param name="storeId" value="${WCParam.storeId}" />
					<wcf:param name="catalogId" value="${WCParam.catalogId}" />
					<wcf:param name="categoryId" value="${WCParam.categoryId}" />	
					<wcf:param name="urlLangId" value="${urlLangId}" />							
				</wcf:url>
				<link rel="canonical" href="<c:out value="${CategoryDisplayURL}"/>" />
			</c:if>
			<link rel="stylesheet" href="<c:out value="${jspStoreImgDir}${vfileStylesheet}"/>" type="text/css"/>
			<!--[if lte IE 6]>
			<link rel="stylesheet" href="<c:out value="${jspStoreImgDir}${vfileStylesheetie}"/>" type="text/css"/>
			<![endif]-->
			<script type="text/javascript" src="<c:out value="${dojoFile}"/>" djConfig="${dojoConfigParams}"></script>
			<%@ include file="../../../include/CommonJSToInclude.jspf"%>
			<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/MessageHelper.js"/>"></script>
			<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/Vector.js"/>"></script>
			<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/CatalogArea/CategoryDisplay.js"/>"></script>
			<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/CatalogArea/CatalogSearchDisplay.js"/>"></script>
			<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/ServicesDeclaration.js"/>"></script>
			<script type="text/javascript">
				dojo.addOnLoad(function() {
					<fmt:message key="ERR_RESOLVING_SKU" bundle="${storeText}" var="ERR_RESOLVING_SKU" />
					<fmt:message key="QUANTITY_INPUT_ERROR" bundle="${storeText}" var="QUANTITY_INPUT_ERROR" />
					<fmt:message key="WISHLIST_ADDED" bundle="${storeText}" var="WISHLIST_ADDED" />
					<fmt:message key="SHOPCART_ADDED" bundle="${storeText}" var="SHOPCART_ADDED" />
					<fmt:message key="SHOPCART_REMOVEITEM" bundle="${storeText}" var="SHOPCART_REMOVEITEM" />
					<fmt:message key="ERROR_MESSAGE_TYPE" bundle="${storeText}" var="ERROR_MESSAGE_TYPE" />
					<fmt:message key="ERROR_CONTRACT_EXPIRED_GOTO_ORDER" bundle="${storeText}" var="ERROR_CONTRACT_EXPIRED_GOTO_ORDER" />
					<fmt:message key="GENERICERR_MAINTEXT" bundle="${storeText}" var="ERROR_RETRIEVE_PRICE">                                     
						<fmt:param><fmt:message key="GENERICERR_CONTACT_US" bundle="${storeText}" /></fmt:param>
					</fmt:message>
					<fmt:message key="SEARCH_INVALID_LOW_PRICE" bundle="${storeText}" var="SEARCH_INVALID_LOW_PRICE" />
					<fmt:message key="SEARCH_INVALID_HIGH_PRICE" bundle="${storeText}" var="SEARCH_INVALID_HIGH_PRICE" />

					MessageHelper.setMessage("ERROR_RETRIEVE_PRICE", <wcf:json object="${ERROR_RETRIEVE_PRICE}"/>);
					MessageHelper.setMessage("ERR_RESOLVING_SKU", <wcf:json object="${ERR_RESOLVING_SKU}"/>);
					MessageHelper.setMessage("QUANTITY_INPUT_ERROR", <wcf:json object="${QUANTITY_INPUT_ERROR}"/>);
					MessageHelper.setMessage("WISHLIST_ADDED", <wcf:json object="${WISHLIST_ADDED}"/>);
					MessageHelper.setMessage("SHOPCART_ADDED", <wcf:json object="${SHOPCART_ADDED}"/>);
					MessageHelper.setMessage("SHOPCART_REMOVEITEM", <wcf:json object="${SHOPCART_REMOVEITEM}"/>);
					MessageHelper.setMessage("ERROR_MESSAGE_TYPE", <wcf:json object="${ERROR_MESSAGE_TYPE}"/>);
					MessageHelper.setMessage("ERROR_CONTRACT_EXPIRED_GOTO_ORDER", <wcf:json object="${ERROR_CONTRACT_EXPIRED_GOTO_ORDER}"/>);
					MessageHelper.setMessage("SEARCH_INVALID_LOW_PRICE", <wcf:json object="${SEARCH_INVALID_LOW_PRICE}"/>);
					MessageHelper.setMessage("SEARCH_INVALID_HIGH_PRICE", <wcf:json object="${SEARCH_INVALID_HIGH_PRICE}"/>);

					//Set the global variables
					CatalogSearchDisplayJS.invalidPageNumMsg = "<fmt:message key="SEARCH_INVALID_PAGE_NUM" bundle="${storeText}"/>";
					<c:if test="${not empty WCParam.showResultsPage}">	
						CatalogSearchDisplayJS.showResultsPage = "<wcf:out value='${WCParam.showResultsPage}' escapeFormat='js'/>";
					</c:if>    	  
					CatalogSearchDisplayJS.searchModeVisible = true;	
					CatalogSearchDisplayJS.setAdvanceSearch(false);
					var historyUrl = "<c:out value='${SimpleSearchResultDisplayViewURL}' escapeXml='false'/>";
					<c:choose>
						<c:when test ="${WCParam.sType=='SimpleSearch'}">
							CatalogSearchDisplayJS.initSearchHistory("AjaxCatalogSearchResultView", "Search_area", historyUrl);
						</c:when>
						<c:otherwise>
							CatalogSearchDisplayJS.initSearchHistory("AjaxCatalogSearchResultView", "Search_area", "advanced");
						</c:otherwise>
					</c:choose>
				});
				dojo.addOnLoad(function() { parseWidget("Search_Result_div"); });
				dojo.addOnLoad(function() { parseWidget("Search_Result_div2"); });
				dojo.addOnLoad(function() { CatalogSearchDisplayJS.processURL(); });	

				categoryDisplayJS.setCommonParameters('<c:out value='${WCParam.langId}'/>','<c:out value='${WCParam.storeId}'/>','<c:out value='${WCParam.catalogId}'/>','<c:out value='${userType}'/>');
				ServicesDeclarationJS.setCommonParameters('<c:out value='${WCParam.langId}'/>','<c:out value='${WCParam.storeId}'/>','<c:out value='${WCParam.catalogId}'/>');
			</script>

			<flow:ifEnabled feature="Analytics">
			<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/Analytics.js"/>"></script>
			<script type="text/javascript">
			  dojo.addOnLoad(function() {
					analyticsJS.storeId=<c:out value="${storeId}"/>;
					analyticsJS.catalogId=<c:out value="${catalogId}"/>
					//analyticsJS.loadMiniShopCartHandler();
					analyticsJS.loadPagingHandler();
					analyticsJS.loadSearchResultHandler("catalogSearchResultDisplay_Controller","catalog_search_result_information", true, "Advanced_Search_Form_div");
				});

			</script>
			</flow:ifEnabled>

		</head>  
		<body> 
			<script type="text/javascript">
				<!-- Initializes the undo stack. This must be called from a <script>  block that lives inside the <body> tag to prevent bugs on IE. -->
				 dojo.require("dojo.back");
				 dojo.back.init();
			</script>
			<c:set var="searchPage" value="true" scope="request"/>
			<c:set var="hasBreadCrumbTrail" value="true" scope="request"/>
			<c:set var="useHomeRightSidebar" value="false" scope="request"/>
			<script type="text/javascript">
				wc.render.declareContext(
					"catalogSearchResultDisplay_Context",
					{searchResultsPageNum: "", searchResultsView: "", searchResultsURL: "searchForm" },
					"");
				wc.render.declareContext(
					"contentSearchResultDisplay_Context",
					{searchResultsPageNum: "", searchResultsView: "", searchResultsURL: "searchForm" },
					"");
			</script>
			<script type="text/javascript">
				dojo.require("wc.render.common");
				wc.render.declareRefreshController({
					id: "catalogSearchResultDisplay_Controller",
					renderContext: wc.render.getContextById("catalogSearchResultDisplay_Context"),
					url: "",
					formId: ""

				,renderContextChangedHandler: function(message, widget) {
					var controller = this;
					var renderContext = this.renderContext;
						console.debug(controller.url);
						console.debug(renderContext.properties);    			
						widget.refresh(renderContext.properties);
				}

				,postRefreshHandler: function(widget) {
					var controller = this;
					var renderContext = this.renderContext;
					console.debug("in post refreshscript searchResultCallBack url is " + controller.renderContext.properties["searchResultsURL"]);
						CatalogSearchDisplayJS.searchResultCallback(controller.renderContext.properties["searchResultsURL"]);
					}
				});

				wc.render.declareRefreshController({
					id: "contentSearchResultDisplay_Controller",
					renderContext: wc.render.getContextById("contentSearchResultDisplay_Context"),
					url: "",
					formId: ""

				,renderContextChangedHandler: function(message, widget) {
					var controller = this;
					var renderContext = this.renderContext;
						console.debug(controller.url);
						console.debug(renderContext.properties);    			
						widget.refresh(renderContext.properties);
				}

				,postRefreshHandler: function(widget) {
					var controller = this;
					var renderContext = this.renderContext;
					console.debug("in post refreshscript searchResultCallBack url is " + controller.renderContext.properties["searchResultsURL"]);
						CatalogSearchDisplayJS.searchResultCallback(controller.renderContext.properties["searchResultsURL"]);
					}
				});
		
			</script>
			
			<%@ include file="../../../include/StoreCommonUtilities.jspf"%>
			
			<c:set var="emsName" value="searchResultSpot"/>
			<%@ include file="../../../Snippets/Marketing/ESpot/ESpotInfoPopupDisplay.jspf"%>
			<div id="page">
				<%@ include file="../../../include/LayoutContainerTop.jspf"%>
				<div id="content_wrapper_box">
					<%@ include file="../../../Snippets/ReusableObjects/CatalogEntryQuickInfoDetails.jspf" %>
				   	<div id="content588">
						<%@ include file="../../../include/MessageDisplay.jspf"%>
						<div id ="Search_Advanced_Header" style ="display:none">
							<h1><fmt:message key="TITLE_ADVANCED_SEARCH" bundle="${storeText}"/></h1>
						</div>

						<%-- Check to see if there are no results.  Make sure this is the first set of results --%>
						<%-- If there are no items found, only display a message that indicates no item is found --%>
						<div class="text">
							<c:choose>
								<c:when test="${WCParam.advanced == 'true'}">
									<%@ include file="CatalogSearchForm.jspf"%>
									<flow:ifEnabled feature="Analytics">
										<div id="catalog_search_result_information" style="visibility:hidden; height: 0px">
											{	searchResult: {
												pageSize: 0, 
												searchTerms: '', 
												totalPageNumber: 0, 
												totalResultCount: 0, 
												currentPageNumber: 0
												}
											}
										</div>
									</flow:ifEnabled>									
								</c:when>
								<c:when test="${!empty searchTerm || !empty WCParam.searchTerm || empty WCParam.categoryId}">	
									<div id="Search_Result_Summary">
										<h1><fmt:message key="TITLE_SEARCH_RESULTS" bundle="${storeText}"/></h1>
										<c:if test="${totalSearchCount == 0 || searchMissed}">
											<span class="strong">
												<fmt:message key="SEARCH_FOR" bundle="${storeText}"/>
												"<c:out value="${WCParam.searchTerm}"/>"
												<fmt:message key="SEARCH_PRODUCED" bundle="${storeText}">
													<fmt:param>0</fmt:param>
												</fmt:message>
											</span>
											<br/>
											<br/>
										</c:if>
										<c:if test="${searchMissed && !(empty spellcheck && empty contentspellcheck)}">
											<span class="did_you_mean"><fmt:message key="SEARCH_DID_YOU_MEAN" bundle="${storeText}"/> </span>
											<c:forEach var="alternative" items="${spellcheck}">
												<wcf:url var="SpellCheckSearchDisplayViewURL" value="SearchDisplay" type="Ajax">
													<wcf:param name="langId" value="${langId}"/>
													<wcf:param name="storeId" value="${WCParam.storeId}"/>
													<wcf:param name="catalogId" value="${WCParam.catalogId}"/>		
													<wcf:param name="pageView" value="${pageView}"/>
													<wcf:param name="beginIndex" value="0"/>
													<wcf:param name="pageSize" value="${WCParam.pageSize}"/>
													<wcf:param name="sType" value="${WCParam.sType}"/>						
													<wcf:param name="searchTerm" value="${alternative}"/>
													<wcf:param name="filterTerm" value="${WCParam.filterTerm}" />
													<wcf:param name="manufacturer" value="${WCParam.manufacturer}" />
													<wcf:param name="minPrice" value="${WCParam.minPrice}" />
													<wcf:param name="maxPrice" value="${WCParam.maxPrice}" />
													<wcf:param name="resultCatEntryType" value="${WCParam.resultCatEntryType}"/>						
													<wcf:param name="showResultsPage" value="true"/>				  
													<wcf:param name="orderBy" value="${WCParam.orderBy}"/>
													<wcf:param name="searchSource" value="Q"/>
													<wcf:param name="searchTermScope" value="${WCParam.searchTermScope}"/>
												</wcf:url>
												&nbsp;<a class="did_you_mean_link" href="<c:out value="${SpellCheckSearchDisplayViewURL}" escapeXml="false" />"><c:out value="${alternative}" /></a>&nbsp;
											</c:forEach>
											<c:forEach var="alternative" items="${contentspellcheck}">
												<c:set var="alreadyDisplayed" value="0"/>
												<c:forEach var="alreadySuggested" items="${spellcheck}">
													<c:if test="${alternative == alreadySuggested}">
														<c:set var="alreadyDisplayed" value="1"/>
													</c:if>
												</c:forEach>
												<c:if test="${alreadyDisplayed == 0}">
													<wcf:url var="SpellCheckSearchDisplayViewURL" value="SearchDisplay" type="Ajax">
														<wcf:param name="langId" value="${langId}"/>
														<wcf:param name="storeId" value="${WCParam.storeId}"/>
														<wcf:param name="catalogId" value="${WCParam.catalogId}"/>		
														<wcf:param name="pageView" value="${pageView}"/>
														<wcf:param name="beginIndex" value="0"/>
														<wcf:param name="pageSize" value="${WCParam.pageSize}"/>
														<wcf:param name="sType" value="${WCParam.sType}"/>						
														<wcf:param name="searchTerm" value="${alternative}"/>
														<wcf:param name="filterTerm" value="${WCParam.filterTerm}" />
														<wcf:param name="manufacturer" value="${WCParam.manufacturer}" />
														<wcf:param name="minPrice" value="${WCParam.minPrice}" />
														<wcf:param name="maxPrice" value="${WCParam.maxPrice}" />
														<wcf:param name="resultCatEntryType" value="${WCParam.resultCatEntryType}"/>						
														<wcf:param name="showResultsPage" value="true"/>				  
														<wcf:param name="orderBy" value="${WCParam.orderBy}"/>
														<wcf:param name="searchSource" value="Q"/>
														<wcf:param name="searchTermScope" value="${WCParam.searchTermScope}"/>
													</wcf:url>
													&nbsp;<a class="did_you_mean_link" href="<c:out value="${SpellCheckSearchDisplayViewURL}" escapeXml="false" />"><c:out value="${alternative}" /></a>&nbsp;
												</c:if>
											</c:forEach>
											<c:set var="alreadySuggestedProductsAndContent" value="true"/>
											<br/>				
											<br/>
										</c:if>
										
										<c:if test="${totalSearchCount == 0 || searchMissed}">
											<flow:ifEnabled feature="AdvancedSearch">
												<span class="Search_Result_Summary_Text">
												<fmt:message key="SEARCH_REFINE_SEARCH" bundle="${storeText}">
													<fmt:param><a class="Search_Result_Summary_Text catalog_link" href="javascript:CatalogSearchDisplayJS.showHideSearchMode(true); CatalogSearchDisplayJS.showHideSearchCancelButton(true);" id="WC_CatalogSearchResultDisplay_link_1"><fmt:message key="SEARCH_LINK" bundle="${storeText}"/></a></fmt:param>
												</fmt:message>
												</span>
											</flow:ifEnabled>
											<br/><br/>
												<flow:ifEnabled feature="Analytics">
													<c:set var="singleQuote" value="'"/>
													<c:set var="escapedSingleQuote" value="\\\\'"/>
													<c:set var="doubleQuote" value="\""/>
													<c:set var="escapedDoubleQuote" value="\\\\\""/>

													<c:remove var="analyticsEscapedSearchTerm"/>
													<c:set var="analyticsEscapedSearchTerm" value="${fn:replace(searchTerm, singleQuote, escapedSingleQuote)}"/>
													<c:set var="analyticsEscapedSearchTerm" value="${fn:replace(analyticsEscapedSearchTerm, doubleQuote, escapedDoubleQuote)}"/>

													<div id="catalog_search_result_information" style="visibility:hidden; height: 0px">
														{	searchResult: {
															pageSize: 0, 
															searchTerms: '<c:out value="${analyticsEscapedSearchTerm}"/>', 
															totalPageNumber: 0, 
															totalResultCount: 0, 
															currentPageNumber: 0
															}
														}
												</div>
												</flow:ifEnabled>											
										</c:if>

										<%-- If there are items in the search result, then first decide how many pages should be used --%>
										<c:if test="${totalSearchCount > 0}">	
											
											<span class="Search_Result_Summary_Text">
												<%-- Output what the user searched on at the top of the search results page --%>
												<fmt:message key="SEARCH_FOR" bundle="${storeText}" />
											
												<%-- Check if the user entered a search term to search on --%>
												<c:choose>
													<c:when test="${!empty searchTerm}">
														<%-- output the search term if the user entered a search term --%>
														<span class="strong">"<c:out value="${searchTerm}"/>"</span>
													</c:when>
													<c:when test="${!empty WCParam.searchTerm}">
														<%-- output the search term if the user entered a search term --%>
														<span class="strong">"<c:out value="${WCParam.searchTerm}"/>"</span>
													</c:when>
													<c:otherwise>
														<%-- output the something else if no search term was searched on --%>
														<span class="strong"><fmt:message key="SEARCH_ALL_PRODUCTS" bundle="${storeText}"/></span>
													</c:otherwise>
												</c:choose>
												<%-- Check if the user entered a excluded search term to search on --%>
												<c:if test="${!empty WCParam.filterTerm}">
													<%-- output the filter term --%>
													<fmt:message key="SEARCH_EXCLUDING" bundle="${storeText}"/>&nbsp;<span class="strong"><c:out value="${WCParam.filterTerm}"/></span>
												</c:if>
											
												<%-- Check if the user entered a category to search in--%>
												<c:if test="${!empty WCParam.catGroupId}">
													<%-- output the category --%>
													<fmt:message key="SEARCH_CATEGORY" bundle="${storeText}">
														<fmt:param><span class="strong"><c:out value="${category.description.name}" escapeXml="false"/></span></fmt:param>
													</fmt:message>
												</c:if>
											
												<%-- Check if the user entered a brand to searh in--%>
												<c:if test="${!empty WCParam.manufacturer}">
													<%-- output the brand --%>
													<fmt:message key="SEARCH_MANUFACTURER" bundle="${storeText}">
														<fmt:param><span class="strong"><c:out value="${WCParam.manufacturer}" escapeXml="false"/></span></fmt:param>
													</fmt:message>
												</c:if>
												<%-- Check if the user entered a maximum and/or minimum price to search on --%>
												<%-- Get the currency description for the selected currency --%>
												<c:forEach var="dbCurrency" items="${sdb.storeCurrencies}">
													<c:if test="${dbCurrency.currencyCode == CommandContext.currency}">
														<c:set var="currDesc" value="${dbCurrency.currencyDescription}" />
													</c:if>
												</c:forEach>
											
												<c:choose>
													<%-- If a user enters the valid minimum price range and the maximum price range, 
														 then print out the price range
													--%>
													<c:when test="${!empty WCParam.minPrice && !empty WCParam.maxPrice}">
														<fmt:message key="SEARCH_PRICE_RANGE" bundle="${storeText}">
															<fmt:param><span class="strong"><c:out value="${WCParam.minPrice}" escapeXml="false"/></span></fmt:param>
															<fmt:param><span class="strong"><c:out value="${WCParam.maxPrice}" escapeXml="false"/></span></fmt:param>
															<fmt:param><c:out value="${currDesc}" escapeXml="false"/></fmt:param>
														</fmt:message>
													</c:when>
											
													<%-- Only print out the minimum price if the user doesn't enter the maximum price --%>	
													<c:when test="${!empty WCParam.minPrice && empty WCParam.maxPrice}">
														<fmt:message key="SEARCH_PRICE_RANGE_FROM" bundle="${storeText}">
															<fmt:param><span class="strong"><c:out value="${WCParam.minPrice}" escapeXml="false"/></span></fmt:param>
															<fmt:param><c:out value="${currDesc}" escapeXml="false"/></fmt:param>
														</fmt:message>
													</c:when>
													
													<%-- Only print out the maximum price if the user doesn't enter the minim price --%>	
													<c:when test="${empty WCParam.minPrice && !empty WCParam.maxPrice}">
														<fmt:message key="SEARCH_PRICE_RANGE_UP_TO" bundle="${storeText}">
															<fmt:param><span class="strong"><c:out value="${WCParam.maxPrice}" escapeXml="false"/></span></fmt:param>
															<fmt:param><c:out value="${currDesc}" escapeXml="false"/></fmt:param>
														</fmt:message>
													</c:when>
												</c:choose>
												<%-- Display the total number of found items --%>
												<fmt:message key="SEARCH_PRODUCED" bundle="${storeText}">
													<fmt:param><span class="strong"><c:out value="${totalSearchCount}"/></span></fmt:param>
												</fmt:message>
											</span>
											<c:if test="${!empty searchTerm}">
												<c:if test="${empty alreadySuggestedProductsAndContent && !empty spellcheck && totalCount == 0}">
													<span class="Search_Result_Summary_Text strong"><fmt:message key="NO_PRODUCTS_FOUND" bundle="${storeText}"/></span>
													<p>
														<span class="did_you_mean"><fmt:message key="SEARCH_DID_YOU_MEAN" bundle="${storeText}"/> </span>
														<c:forEach var="alternative" items="${spellcheck}">
															<wcf:url var="SpellCheckSearchDisplayViewURL" value="SearchDisplay" type="Ajax">
																<wcf:param name="langId" value="${langId}"/>
																<wcf:param name="storeId" value="${WCParam.storeId}"/>
																<wcf:param name="catalogId" value="${WCParam.catalogId}"/>		
																<wcf:param name="pageView" value="${pageView}"/>
																<wcf:param name="beginIndex" value="0"/>
																<wcf:param name="pageSize" value="${WCParam.pageSize}"/>
																<wcf:param name="sType" value="${WCParam.sType}"/>						
																<wcf:param name="searchTerm" value="${alternative}"/>
																<wcf:param name="filterTerm" value="${WCParam.filterTerm}" />
																<wcf:param name="manufacturer" value="${WCParam.manufacturer}" />
																<wcf:param name="minPrice" value="${WCParam.minPrice}" />
																<wcf:param name="maxPrice" value="${WCParam.maxPrice}" />
																<wcf:param name="resultCatEntryType" value="${WCParam.resultCatEntryType}"/>						
																<wcf:param name="showResultsPage" value="true"/>				  
																<wcf:param name="orderBy" value="${WCParam.orderBy}"/>
																<wcf:param name="searchSource" value="Q"/>
																<wcf:param name="searchTermScope" value="${WCParam.searchTermScope}"/>
															</wcf:url>
															&nbsp;<a class="did_you_mean_link" href="<c:out value="${SpellCheckSearchDisplayViewURL}" escapeXml="false" />"><c:out value="${alternative}" /></a>&nbsp;
														</c:forEach>
													</p>
													<br/>
												</c:if>
												<p class="result_misses_link">
													<fmt:message key="PRODUCTS_ARTICLES_AND_VIDEOS" bundle="${storeText}">
														<fmt:param><c:out value="${totalCount}"/></fmt:param>
														<fmt:param><c:out value="${totalContentCount}"/></fmt:param>
													</fmt:message>
												</p>
											</c:if>
										</c:if>
									</div>
								</c:when>
								<c:when test="${!empty WCParam.categoryId}">
									<wcbase:useBean id="category" classname="com.ibm.commerce.catalog.beans.CategoryDataBean" scope="page" />
									<h1><c:out value="${category.description.name}" /></h1>
									<c:if test="${!empty category.description.fullIImage}">
									<div class="ad" id="ad_Category"> <img src="<c:out value="${category.objectPath}${category.description.fullIImage}"/>" alt="<c:out value="${requestScope.fullImageAltDescription}" />" border="0"/> </div>
									</c:if>
									<c:set var="showCategoryFeaturedProductsESpot" value="true" scope="request"/>
								</c:when>
							</c:choose>
						</div>

						<div id="box">
							<div id="Search_Forms_div">
								<%@ include file="CatalogSearchForm.jspf"%>
							</div>
							<br clear="all" style="line-height:0"/>
							<c:if test="${showCategoryFeaturedProductsESpot && facetCount == 0}">
								<% out.flush(); %>
								<c:import url="${jspStoreDir}Snippets/Marketing/ESpot/ContentAreaESpot.jsp">
									<c:param name="storeId" value="${WCParam.storeId}" />
									<c:param name="catalogId" value="${WCParam.catalogId}" />
									<c:param name="langId" value="${langId}" />
									<c:param name="numberProductsPerRow" value="4" />
									<c:param name="emsName" value="CategoryPageFeaturedProducts" />
									<c:param name="errorViewName" value="AjaxOrderItemDisplayView" />
								</c:import>
								<% out.flush(); %>
							</c:if>
							<c:if test="${totalCount > 0}">
								<div id="Search_Area_div" class="searchResultSpot">
									<div class="ESpotInfo"><a href="#" onclick="showESpotInfoPopup('ESpotInfo_popup_<c:out value="${emsName}"/>'); return false;"><div class="ESpotInfoIcon"></div></a></div>
									<div dojoType="wc.widget.RefreshArea" widgetId="catalogSearchResultDisplay_Widget" controllerId="catalogSearchResultDisplay_Controller" class="MyAccountCenterLinkDisplay_Class" id="Search_Result_div" role="wairole:region" waistate:live="polite" waistate:atomic="true" waistate:relevant="all"> 
										<%out.flush();%>
											<c:import 
											url="${jspStoreDir}ShoppingArea/CatalogSection/SearchSubsection/SearchBasedNavigationResultDisplay.jsp">
												<c:param name="pageView" value="${WCParam.pageView}"/>
												<c:param name="storeId" value="${WCParam.storeId}"/>
												<c:param name="langId" value="${langId}"/>
												<c:param name="catalogId" value="${WCParam.catalogId}"/>
												<c:param name="categoryId" value="${WCParam.categoryId}"/>
												<c:param name="searchTerm" value="${searchTerm}"/>
												<c:param name="searchType" value="${WCParam.searchType}"/>
												<c:param name="metaData" value="${WCParam.metaData}"/>
												<c:param name="resultCatEntryType" value="${WCParam.resultCatEntryType}"/>
												<c:param name="pageSize" value="${WCParam.pageSize}"/>
												<c:param name="beginIndex" value="${WCParam.beginIndex}"/>
												<c:param name="sType" value="${WCParam.sType}"/>
											</c:import>
										<%out.flush();%>  
									</div>
								</div>							
							</c:if>

							<c:if test="${totalContentCount > 0}">
								<div id="Search_Area_div2" class="searchResultSpot">
									<div class="ESpotInfo"><a href="#" onclick="showESpotInfoPopup('ESpotInfo_popup_<c:out value="${emsName}"/>'); return false;"><div class="ESpotInfoIcon"></div></a></div>
									<div dojoType="wc.widget.RefreshArea" widgetId="catalogSearchResultDisplay_Widget2" controllerId="contentSearchResultDisplay_Controller" class="MyAccountCenterLinkDisplay_Class" id="Search_Result_div2" role="wairole:region" waistate:live="polite" waistate:atomic="true" waistate:relevant="all"> 
										<%out.flush();%>
											<c:import 
											url="${jspStoreDir}ShoppingArea/CatalogSection/SearchSubsection/SearchBasedNavigationContentResultDisplay.jsp">
												<c:param name="pageView" value="${WCParam.pageView}"/>
												<c:param name="storeId" value="${WCParam.storeId}"/>
												<c:param name="langId" value="${langId}"/>
												<c:param name="catalogId" value="${WCParam.catalogId}"/>
												<c:param name="categoryId" value="${WCParam.categoryId}"/>
												<c:param name="searchTerm" value="${searchTerm}"/>
												<c:param name="searchType" value="${WCParam.searchType}"/>
												<c:param name="metaData" value="${WCParam.metaData}"/>
												<c:param name="resultCatEntryType" value="${WCParam.resultCatEntryType}"/>
												<c:param name="pageSize" value="${WCParam.pageSize}"/>
												<c:param name="beginIndex" value="${WCParam.beginIndex}"/>
												<c:param name="sType" value="${WCParam.sType}"/>
											</c:import>
										<%out.flush();%>
									</div>
								</div>
							</c:if>
						<flow:ifEnabled feature="IntelligentOffer">
							<%-- Begin - Added for Coremetrics Intelligent Offer to Display top seller dynamic recommendations for the currently viewed category--%>
							<%out.flush();%>
							<c:import url="${jspStoreDir}Snippets/Marketing/ESpot/IntelligentOfferESpot.jsp">
								<c:param name="emsName" value="CategoryPageIntelligentOffer" />
								<c:param name="catalogId" value="${WCParam.catalogId}" />
								<c:param name="parentCategoryId" value="${WCParam.categoryId}" />
							</c:import>
							<%out.flush();%>
							<%-- End - Added for Coremetrics Intelligent Offer --%>
						</flow:ifEnabled>
						</div>
						
					</div>
				</div>
				<%@ include file="../../../include/LayoutContainerBottom.jspf"%>
			</div>
			<div id="page_shadow" class="shadow"></div>
		</body>
		</html>
	</c:otherwise>
</c:choose>

<!-- END SearchBasedNavigationDisplay.jsp -->

