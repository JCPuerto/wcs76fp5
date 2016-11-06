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
  * This JSP is called from HeaderDisplay.jsp and is cached based on the parameters passed in and defined in the cachespec.xml file.
  * The header includes the following information:
  *  - Common links, such as 'Shopping Cart', 'Contact Us', 'Help', etc  
  *  - Category selection list that displays all categories and subcategories in the store. 
  *  - Top Categories list
  *****
--%>
<!-- BEGIN CachedHeaderDisplay.jsp -->
  
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../../JSTLEnvironmentSetup.jspf"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@page import="com.ibm.commerce.bi.BIConfigRegistry"%>
<flow:fileRef id="vfileLogo" fileId="vfile.logo"/>


<wcf:url var="AjaxQuickCartDropDownDisplayURL" value="AjaxQuickCartDropDownDisplay" type="Ajax">
  <wcf:param name="langId" value="${param.langId}" />						
  <wcf:param name="storeId" value="${param.storeId}" />
  <wcf:param name="catalogId" value="${param.catalogId}" />
</wcf:url>
									
<script type="text/javascript">
	dojo.addOnLoad(function() {
		if('<c:out value='${headerLinksInTwoLines}'/>' == "true"){
			showHeaderLinksInTwoLines();
		}else{
			showLinksInOneLine();
		}
		parseWidget("outerCartContainer");	
	});
	
	var storeId = '<c:out value='${param.storeId}'/>';
	var langId = '<c:out value='${param.langId}'/>';
	var catalogId = '<c:out value='${param.catalogId}'/>';
	
	var isAuthenticated=false;
	<c:if test="${userType != 'G'}">isAuthenticated=true;</c:if>

	if('<c:out value='${topCategoryPage}'/>' == "true")
		var showProductCompare = false;
	else
		var showProductCompare = true;

	dojo.addOnLoad(initShopcartTarget);
	dojo.addOnLoad(showDropDownMenu);
	
</script>

<flow:ifEnabled feature="Analytics">
	<%
	CommandContext commandContext = (CommandContext) request.getAttribute(ECConstants.EC_COMMANDCONTEXT);
	Integer storeId = commandContext.getStoreId();
	boolean hostedVar = BIConfigRegistry.getInstance().useHostedLibraries(storeId);
	%>
	<c:set var="hostedVar" value="<%=hostedVar%>"/>
	<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/Analytics.js"/>"></script>
	<script type="text/javascript">
	dojo.addOnLoad(function() {
		analyticsJS.storeId=<c:out value="${storeId}"/>;
		analyticsJS.catalogId=<c:out value="${catalogId}"/>;
		analyticsJS.loadShopCartHandler();
		analyticsJS.loadPagingHandler();
		analyticsJS.loadProductQuickInfoHandler('productIdQuickInfo');
		analyticsJS.loadStoreLocatorPageViews();
		analyticsJS.loadWishlistHandler();
		dojo.require("wc.analytics.CoremetricsEventListener");
		
			(new wc.analytics.CoremetricsEventListener()).load(<c:out value="${hostedVar}"/>);
			});
	</script>
</flow:ifEnabled>

<wcf:url var="searchView" value="AjaxCatalogSearchView" type="Ajax"/>
<flow:ifEnabled feature="SearchBasedNavigation">
	<script type="text/javascript">
		dojo.addOnLoad(function() {
			dojo.require("dojo.parser");
			dojo.require("dojo.data.ItemFileWriteStore");			
			parseWidget("header-search");
		});
	</script>
	<wcf:url var="searchView" value="SearchDisplay" type="Ajax"/>
</flow:ifEnabled>
<wcf:url var="CatalogSearchViewURL" value="AjaxCatalogSearchView">
  <wcf:param name="langId" value="${param.langId}"/>
  <wcf:param name="storeId" value="${param.storeId}"/>
  <wcf:param name="catalogId" value="${param.catalogId}"/>
  <wcf:param name="advanced" value="true"/>				
  <wcf:param name="pageView" value="${defaultPageView}"/>
  <wcf:param name="beginIndex" value="0"/>
</wcf:url>

<flow:ifDisabled feature="AjaxMyAccountPage">
	<wcf:url var="TrackOrderStatusURL" value="NonAjaxTrackOrderStatus">
		<wcf:param name="storeId"   value="${param.storeId}"  />
		<wcf:param name="catalogId" value="${param.catalogId}"/>
		<wcf:param name="langId" value="${param.langId}" />
	</wcf:url>
	<flow:ifEnabled feature="EnableQuotes">
		<wcf:url var="TrackQuoteStatusURL" value="NonAjaxTrackOrderStatus">
			<wcf:param name="storeId"   value="${param.storeId}"  />
			<wcf:param name="catalogId" value="${param.catalogId}"/>
			<wcf:param name="langId" value="${param.langId}" />
			<wcf:param name="isQuote" value="true" />
		</wcf:url>
	</flow:ifEnabled>
</flow:ifDisabled>

<flow:ifEnabled feature="AjaxMyAccountPage">
	<wcf:url var="OrderStatusURL" value="AjaxLogonForm">
	  <wcf:param name="langId" value="${param.langId}" />
	  <wcf:param name="storeId" value="${param.storeId}" />
	  <wcf:param name="catalogId" value="${param.catalogId}" />
	  <wcf:param name="page" value="orderstatus" />
	</wcf:url>							
	<flow:ifEnabled feature="EnableQuotes">
		<wcf:url var="QuoteStatusURL" value="AjaxLogonForm">
			<wcf:param name="langId" value="${param.langId}" />
			<wcf:param name="storeId" value="${param.storeId}" />
			<wcf:param name="catalogId" value="${param.catalogId}" />
			<wcf:param name="page" value="orderstatus" />
			<wcf:param name="isQuote" value="true" />
		</wcf:url>							
	</flow:ifEnabled>
</flow:ifEnabled>

<wcf:url var="LogonFormURL" value="LogonForm">
  <wcf:param name="langId" value="${param.langId}" />
  <wcf:param name="storeId" value="${param.storeId}" />
  <wcf:param name="catalogId" value="${param.catalogId}" />
  <wcf:param name="myAcctMain" value="1" />
</wcf:url>
<wcf:url var="SavedOrderListDisplayURL" value="ListOrdersDisplayView">
	<wcf:param name="storeId"   value="${param.storeId}"  />
	<wcf:param name="catalogId" value="${param.catalogId}"/>
	<wcf:param name="langId" value="${param.langId}" />  
</wcf:url>		
<wcf:url var="MyAccountURL" value="AjaxLogonForm">
  <wcf:param name="langId" value="${param.langId}" />
  <wcf:param name="storeId" value="${param.storeId}" />
  <wcf:param name="catalogId" value="${param.catalogId}" />
  <wcf:param name="myAcctMain" value="1" />
</wcf:url>
<wcf:url var="LogoffURL" value="Logoff">
  <wcf:param name="langId" value="${param.langId}" />
  <wcf:param name="storeId" value="${param.storeId}" />
  <wcf:param name="catalogId" value="${param.catalogId}" />
  <wcf:param name="myAcctMain" value="1" />
  <wcf:param name="URL" value="LogonForm" />
</wcf:url>                                          

<wcf:url var="ShoppingCartURL" value="OrderCalculate" type="Ajax">
   <wcf:param name="langId" value="${param.langId}" />
  <wcf:param name="storeId" value="${param.storeId}" />
  <wcf:param name="catalogId" value="${param.catalogId}" />
  <wcf:param name="URL" value="AjaxOrderItemDisplayView" />
  <wcf:param name="errorViewName" value="AjaxOrderItemDisplayView" />
  <wcf:param name="updatePrices" value="1" />
  <wcf:param name="calculationUsageId" value="-1" />
  <wcf:param name="orderId" value="." />
</wcf:url>

<wcf:url var="QuickOrderURL" value="QuickOrderView">
  <wcf:param name="langId" value="${param.langId}" />
  <wcf:param name="storeId" value="${param.storeId}" />
  <wcf:param name="catalogId" value="${param.catalogId}" />
</wcf:url>

<wcf:url var="SiteMapURL" patternName="SitemapURL" value="SiteMap">
	<wcf:param name="langId" value="${param.langId}" />
	<wcf:param name="storeId" value="${param.storeId}" />
	<wcf:param name="catalogId" value="${param.catalogId}" />
	<wcf:param name="urlLangId" value="${urlLangId}" />
</wcf:url>

<div id="header">
		<div id="header_logo">
		<%-- 
		***
		*  Start: Custom Banner and Logo
		***
		--%>                      
			<%-- Height and store name removal is to adapt new style --%>
			
			<%out.flush();%>
				<c:import url="${jspStoreDir}Snippets/Marketing/ESpot/CachedContentAreaESpot.jsp">
					<c:param name="storeId" value="${WCParam.storeId}" />
					<c:param name="catalogId" value="${catalogId}" />
					<c:param name="langId" value="${langId}" />
					<c:param name="emsName" value="storeLogoESpot" />
					<c:param name="linkId" value="WC_CachedHeaderDisplay_Link_2" />
				</c:import>
			<%out.flush();%>
			
			<c:if test="${!empty showOrgLogoName && showOrgLogoName==true}">
				<wcbase:useBean id="currentOrg" classname="com.ibm.commerce.user.beans.OrganizationDataBean">
					<c:set property="dataBeanKeyMemberId" value="${CommandContext.activeOrganizationId}" target="${currentOrg}" />
				</wcbase:useBean>
				<c:if test="${!empty currentOrg.organizationName}">
					<span class="header_organization_name" id="WC_CachedHeaderDisplay_OrganizationName">
						<c:out value="${currentOrg.organizationName}"/>
					</span>
				</c:if>
			</c:if>
		<%-- 
		***
		*  End: Custom Banner and Logo
		***
		--%>		
			<%-- CoShopping --%>
			<flow:ifEnabled feature="CoShopping">
				<%@ include file="../../../ShoppingArea/coshopping/CoShopWidget.jspf"%>
			</flow:ifEnabled>
		</div>
		<c:if test="${headerLinksInTwoLines==true}">
			<div id='header_links1'>
				<a href="<c:out value="${TopCategoriesDisplayURL}"/>" id="headerHome1" ><fmt:message key="HEADER_HOME" bundle="${storeText}" /></a>
				<fmt:message key="DIVIDING_BAR" bundle="${storeText}" />
				<a href="<c:out value="${ShoppingCartURL}"/>" class="h_tnav_but" id="headerShopCart1"><fmt:message key="HEADER_SHOPPING_CART" bundle="${storeText}" /></a>
			</div>
		</c:if>
		<flow:ifEnabled feature="search">
		  <form name="CatalogSearchForm" action="${searchView}" method="get" id="CatalogSearchForm">
			  <input type="hidden" name="storeId" value='<c:out value="${param.storeId}" />' id="WC_CachedHeaderDisplay_FormInput_storeId_In_CatalogSearchForm_1"/>
				<input type="hidden" name="catalogId" value='<c:out value="${param.catalogId}"/>' id="WC_CachedHeaderDisplay_FormInput_catalogId_In_CatalogSearchForm_1"/>
				<input type="hidden" name="langId" value='<c:out value="${param.langId}"/>' id="WC_CachedHeaderDisplay_FormInput_langId_In_CatalogSearchForm_1"/>
				<input type="hidden" name="pageSize" value="12" id="WC_CachedHeaderDisplay_FormInput_pageSize_In_CatalogSearchForm_1"/>
				<input type="hidden" name="beginIndex" value="0" id="WC_CachedHeaderDisplay_FormInput_beginIndex_In_CatalogSearchForm_1"/>
				<input type="hidden" name="searchSource" value="Q" id="WC_CachedHeaderDisplay_FormInput_searchSource_In_CatalogSearchForm_1"/>
				<input type="hidden" name="sType" value="SimpleSearch" id="WC_CachedHeaderDisplay_FormInput_sType_In_CatalogSearchForm_1"/>
				<input type="hidden" name="resultCatEntryType" value="2" id="WC_CachedHeaderDisplay_FormInput_resultType_In_CatalogSearchForm_1"/>
				<input type="hidden" name="showResultsPage" value="true" id="WC_CachedHeaderDisplay_input_1"/>
				<input type="hidden" name="pageView" value="<c:out value="${defaultPageView}"/>" id="WC_CachedHeaderDisplay_input_2"/>
				
				<label for="SimpleSearchForm_SearchTerm" class="nodisplay"><fmt:message key="SEARCH_CATALOG" bundle="${storeText}" /></label>
				<c:choose>
					<c:when test="${empty WCParam.searchTerm}">
						<fmt:message key="SEARCH_CATALOG" bundle="${storeText}" var="searchText"/>
					</c:when>
					<c:otherwise>
						<c:set var="searchText" value="${WCParam.searchTerm}" />
					</c:otherwise>
				</c:choose>
				<div id="header-search">
					<span id="searchTextHolder" class="nodisplay"><fmt:message key="SEARCH_CATALOG" bundle="${storeText}" /></span>
					<span class="spanacce"><fmt:message key="SEARCH_ACCESSKEY" bundle="${storeText}"/></span>
					<flow:ifDisabled feature="SearchBasedNavigation">
						<input type="text" accesskey="0" size="18" class="search-txt" name="searchTerm" id="SimpleSearchForm_SearchTerm" value="<c:out value='${searchText}' />" onfocus="JavaScript:clearSearchField();" onblur="JavaScript:fillSearchField();" onkeypress='if(event.keyCode==13) javascript:this.value=trim(this.value);'/>
					</flow:ifDisabled>

					<flow:ifEnabled feature="SearchBasedNavigation">
						<%@ include file="../../JSTLEnvironmentSetupExtForSearch.jspf" %>
						<c:url var="SearchAutoSuggestServletURL" value="AutoSuggestView">
						  <c:param name="coreName" value="${coreName}" />
						  <c:param name="serverURL" value="${serverURL}" />
						</c:url>
						<c:url var="CachedSuggestionsURL" value="CachedSuggestionsView">
						  <c:param name="langId" value="${param.langId}" />
						  <c:param name="storeId" value="${param.storeId}" />
						  <c:param name="catalogId" value="${param.catalogId}" />
						</c:url>

						<input type="text" accesskey="0" size="18" class="search-txt" name="searchTerm" id="SimpleSearchForm_SearchTerm" value="<c:out value='${searchText}' />" onfocus="JavaScript:retrieveCachedSuggestions('${contextAndServletPath}${CachedSuggestionsURL}'); clearSearchField();" onblur="fillSearchField();" onkeyup='doAutoSuggest(event, "${contextAndServletPath}${SearchAutoSuggestServletURL}", this.value);' onkeypress="return event.keyCode!=13;" autocomplete="off" maxlength="65" role="combobox" tabindex="0"/>

						<div id="autoSuggest_Container">
							<div id="autoSuggest_Result_div" class="autoSuggestBox" onmouseover="autoSuggestHover = true;" onmouseout="autoSuggestHover = false; document.getElementById('SimpleSearchForm_SearchTerm').focus();" style="display:none;">
								<div class="autoSuggest_wrapper">
									<div class="search_left_border"></div>
									<div id="autoSuggest_content_div" class="autoSuggest_content">
										<div dojoType="wc.widget.RefreshArea" widgetId="autoSuggestDisplay_Widget" controllerId="AutoSuggestDisplayController" id="autoSuggestDynamic_Result_div" role="wairole:region" waistate:live="polite" waistate:atomic="true" waistate:relevant="all">
										</div>
										<div id="autoSuggestStatic_1"></div>
										<div id="autoSuggestStatic_2"></div>
										<div id="autoSuggestStatic_3"></div>
										<div id="autoSuggestHistory"></div>
										<div class="view_all_results">
											<span class="right">
												<a href="#" onclick="JavaScript:document.CatalogSearchForm.searchTerm.value=trim(document.CatalogSearchForm.searchTerm.value); if(document.CatalogSearchForm.searchTerm.value.length > 0) {submitSpecifiedForm(document.CatalogSearchForm);} return false;"><fmt:message key="VIEW_ALL_RESULTS" bundle="${storeText}" /></a>
											</span>
										</div>
									</div>
									<div class="search_right_border"></div>
									<div class="autoSuggest_bottom">
										<div class="bottom_left_shadow"></div>
										<div class="middle_shadow"></div>
										<div class="bottom_right_shadow"></div>
										<div class="clear_float"></div>
									</div>
								</div>
							</div>
							<!--[if lte IE 6.5]><iframe id="autoSuggestDropDownIFrame" scrolling="no" frameborder="0" src="<c:out value="${jspStoreImgDir}"/>images/empty.gif"></iframe><![endif]-->
						</div>
						<script type="text/javascript">

							// The primary Array to hold all static search suggestions
							var staticContent = new Array();

							// The titles of each search grouping
							var staticContentHeaders = new Array();
							var staticContentHeaderHistory = "<fmt:message key="SEARCH_HISTORY" bundle="${storeText}" />"

							// The auto suggest container ID's
							var staticContentSectionDiv = ["autoSuggestStatic_1", "autoSuggestStatic_2", "autoSuggestStatic_3"];
						</script>
							
						<div dojoType="wc.widget.RefreshArea" widgetId="AutoSuggestCachedSuggestions" controllerId="AutoSuggestCachedSuggestionsController" id="autoSuggestCachedSuggestions_div" role="wairole:region" waistate:live="polite" waistate:atomic="true" waistate:relevant="all" style="display:none;">
						</div>
					</flow:ifEnabled>
					
					<div id="searchDiv" class="search-btn">
						<a id="WC_CachedHeaderDisplay_button_1" href="#" onclick="JavaScript:document.CatalogSearchForm.searchTerm.value=trim(document.CatalogSearchForm.searchTerm.value); if(document.CatalogSearchForm.searchTerm.value.length > 0) {submitSpecifiedForm(document.CatalogSearchForm);} return false;" onmouseover="document.getElementById('search_overlay').src = '<c:out value="${jspStoreImgDir}${vfileColorBIDI}search-btn-h.png"/>';" onmouseout="document.getElementById('search_overlay').src = '<c:out value="${jspStoreImgDir}${vfileColorBIDI}search-btn.png"/>';" onmousedown="document.getElementById('search_overlay').src = '<c:out value="${jspStoreImgDir}${vfileColorBIDI}search-btn-d.png"/>';" onmouseup="document.getElementById('search_overlay').src = '<c:out value="${jspStoreImgDir}${vfileColorBIDI}search-btn.png"/>';">
							<img src="<c:out value='${jspStoreImgDir}${vfileColorBIDI}search-btn.png'/>" id="search_overlay" alt="<fmt:message key="SEARCH_CATALOG" bundle="${storeText}" />"/>
						</a>
					</div>
				</div>

			</form>
		</flow:ifEnabled>
	
	 <div id="header_links">
	   <flow:ifEnabled feature="FacebookIntegration">
			<%--Display Facebook Connect Links  --%>
			<%@ include file="CachedHeaderDisplayFacebook.jspf"%>
	   </flow:ifEnabled>   
	   <span id="headerHomeLink">
		<a href="<c:out value="${TopCategoriesDisplayURL}"/>" id="headerHome" ><fmt:message key="HEADER_HOME" bundle="${storeText}" /></a>
		<fmt:message key="DIVIDING_BAR" bundle="${storeText}" />
	   </span>
		<flow:ifEnabled feature="CoShopping">
			<%-- the header link --%>
			<span id="headerCoshoppingArea">
				<a href="javascript:void(0);" class="h_tnav_but" id="headerCoshopping"><fmt:message key="Coshopping" bundle="${storeText}" /></a>
			   <fmt:message key="DIVIDING_BAR" bundle="${storeText}" />
			</span>	
	   </flow:ifEnabled>   
	   <span id="headerShopCartLink">
		<a href="<c:out value="${ShoppingCartURL}"/>" class="h_tnav_but" id="headerShopCart"><fmt:message key="HEADER_SHOPPING_CART" bundle="${storeText}" /></a>
	    <fmt:message key="DIVIDING_BAR" bundle="${storeText}" />
	   </span>	
	  <flow:ifEnabled feature="QuickOrder">
		<a href="<c:out value="${QuickOrderURL}"/>" class="h_tnav_but" id="headerQuickOrder"><fmt:message key="HEADER_QUICK_ORDER" bundle="${storeText}" /></a>
	  <fmt:message key="DIVIDING_BAR" bundle="${storeText}" />
	  </flow:ifEnabled>
	  
	  <c:if test="${userType != 'G'}">
	  <flow:ifEnabled feature="MultipleActiveOrders">
			<a href="<c:out value="${SavedOrderListDisplayURL}"/>" class="h_tnav_but" id="WC_CachedHeaderDisplay_Link_Saved_Orders"><fmt:message key="FOOTER_SAVED_ORDERS" bundle="${storeText}" /></a>
	  		<fmt:message key="DIVIDING_BAR" bundle="${storeText}" />
	  </flow:ifEnabled>
	  <a href="<c:out value="${MyAccountURL}"/>" class="h_tnav_but" id="headerMyAccount"><fmt:message key="HEADER_MY_ACCOUNT" bundle="${storeText}" /></a>
		<fmt:message key="DIVIDING_BAR" bundle="${storeText}" />
		<flow:ifEnabled feature="TrackingStatus">
			<flow:ifEnabled feature="AjaxMyAccountPage">
				<a href="<c:out value="${OrderStatusURL}"/>" class="h_tnav_but" id="WC_CachedHeaderDisplay_Link_3"><fmt:message key="HEADER_ORDER_STATUS" bundle="${storeText}" /></a>
			</flow:ifEnabled>
			<flow:ifDisabled feature="AjaxMyAccountPage">
				<a href="<c:out value="${TrackOrderStatusURL}"/>" class="h_tnav_but" id="WC_CachedHeaderDisplay_Link_4"><fmt:message key="HEADER_ORDER_STATUS" bundle="${storeText}" /></a>
			</flow:ifDisabled>
			<fmt:message key="DIVIDING_BAR" bundle="${storeText}" />

			<flow:ifEnabled feature="EnableQuotes">
				<flow:ifEnabled feature="AjaxMyAccountPage">
					<a href="<c:out value="${QuoteStatusURL}"/>" class="h_tnav_but" id="WC_CachedHeaderDisplay_Link_5"><fmt:message key="HEADER_QUOTE_STATUS" bundle="${storeText}" /></a>
				</flow:ifEnabled>
				<flow:ifDisabled feature="AjaxMyAccountPage">
					<a href="<c:out value="${TrackQuoteStatusURL}"/>" class="h_tnav_but" id="WC_CachedHeaderDisplay_Link_6"><fmt:message key="HEADER_QUOTE_STATUS" bundle="${storeText}" /></a>
				</flow:ifDisabled>
				<fmt:message key="DIVIDING_BAR" bundle="${storeText}" />
			</flow:ifEnabled>			
		</flow:ifEnabled>
	  </c:if>
	  <flow:ifEnabled feature="search">
	  	<flow:ifEnabled feature="AdvancedSearch">
	   		<a href="<c:out value="${CatalogSearchViewURL}"/>" class="h_tnav_but" id="headerAdvancedSearch" ><fmt:message key="HEADER_ADVANCED_SEARCH" bundle="${storeText}" /></a>
	  		<fmt:message key="DIVIDING_BAR" bundle="${storeText}" />
	  	</flow:ifEnabled>
	  </flow:ifEnabled>
	  <flow:ifEnabled feature="StoreLocator">
			<wcf:url var="StoreLocatorView" value="AjaxStoreLocatorDisplayView">
			  <wcf:param name="langId" value="${param.langId}" />
			  <wcf:param name="storeId" value="${param.storeId}" />
			  <wcf:param name="catalogId" value="${param.catalogId}" />
			</wcf:url>
	
			<a href="<c:out value="${StoreLocatorView}"/>" class="h_tnav_but" id="WC_CachedHeaderDisplay_Link_4a"><fmt:message key="HEADER_STORE_LOCATOR" bundle="${storeText}" /></a>
			<fmt:message key="DIVIDING_BAR" bundle="${storeText}" />
		</flow:ifEnabled>
		
	  <%@ include file="CachedHeaderDisplayExt.jspf"%>
	  <%@ include file="GiftRegistryCachedHeaderDisplayExt.jspf"%>

	  <c:choose>
		<c:when test="${userType != 'G'}">
			<a href="<c:out value="${LogoffURL}"/>" class="h_tnav_but" id="headerLogout"><fmt:message key="HEADER_LOGOUT" bundle="${storeText}" /></a>
		</c:when>
		<c:otherwise>
		<a href="<c:out value="${LogonFormURL}"/>" class="h_tnav_but" id="headerLogin"><fmt:message key="HEADER_LOGIN" bundle="${storeText}" /></a>
		</c:otherwise>
	  </c:choose>
	</div>
</div>

<%-- if a generic error occurs, CatalogDataBean cannot retrieve catalogId from WCParam. CatalogDataBean will throw an exception in this case.
 To get around that, we'll pass in a catalogId explicitly. --%>
 <c:set var="catalogId" value="${param.catalogId}"/>
 <c:if test="${empty catalogID}">
 	<c:set var="catalogId" value="${param.catalogId}"/> <%-- from HeaderDisplay.jspf --%>
 </c:if>

<flow:ifEnabled feature="SearchBasedNavigation">
	<wcbase:useBean id="newcatalog" classname="com.ibm.commerce.catalog.beans.CategoryHierarchyDataBean" scope="request">
		<c:set value="${catalogId}" target="${newcatalog}" property="catalogId"/>	
		<c:set value="2" target="${newcatalog}" property="catalogLevelNumber"/>	
	</wcbase:useBean>
	
	<c:set var="numTopCat" value="${fn:length(newcatalog.categoryHierarchy)}"/>
	<c:set var="categoryHierarchy" value="${newcatalog.categoryHierarchy}" scope="request"/>
</flow:ifEnabled>
<flow:ifDisabled feature="SearchBasedNavigation">
	<wcbase:useBean id="catalog" classname="com.ibm.commerce.catalog.beans.CatalogDataBean" scope="request">
		<c:set value="${catalogId}" target="${catalog}" property="catalogId"/>	
	</wcbase:useBean>
	
	<c:set var="numTopCat" value="${fn:length(catalog.topCategories)}"/>
	<c:set var="categoryHierarchy" value="${catalog.topCategories}" scope="request"/>
</flow:ifDisabled>

<div id="header_nav">

			<div id="header_menu_dropdown" style="display:none;">
			
				<div id="header_menu_overlay">
				<c:set var="noTopCategoryDisplay" value="true"/>

				<c:forEach var="topCategory" items="${categoryHierarchy}" varStatus="status">
					<c:set var="noTopCategoryDisplay" value="false"/>
					<c:if test="${status.count <= maxTopCategoriesInHeader}">
					
					<div id="CachedHeaderDisplayMenuOverlayItem_<c:out value='${status.count}'/>" tabindex="0" onfocus="parseHeader('CachedHeaderDisplayMenuOverlayItem_<c:out value='${status.count}'/>'); if (document.getElementById('HeaderMenu_DropDown_1') != null && document.getElementById('HeaderMenu_DropDown_1') != 'undefined') { document.getElementById('HeaderMenu_DropDown_1').focus();}" onmouseover="parseHeader('CachedHeaderDisplayMenuOverlayItem_<c:out value='${status.count}'/>')" class="dijit dijitLeft dijitInline dijitDropDownButton dijitDropDownButtonFocused"
					><div class='dijitRight'>
					<div class="dijitStretch dijitButtonNode dijitButtonContents" type=""
						 waiRole="button" waiState="haspopup-true,labelledby-CachedHeaderDisplayMenuOverlay_1_<c:out value='${status.count}'/>_label"
							><div class="dijitInline"></div
						><span class="dijitButtonText" 
						id="CachedHeaderDisplayMenuOverlay_1_<c:out value='${status.count}'/>_label"><c:out value="${topCategory.description.name}" escapeXml="false"/></span
						><span class='dijitA11yDownArrow'></span>
					</div>
				</div></div>
					
					</c:if>
				</c:forEach>
				
				
				<c:if test="${numTopCat > maxTopCategoriesInHeader}">
					<div onmouseover="parseHeader()" class="dijit dijitLeft dijitInline dijitDropDownButton dijitDropDownButtonFocused"
					><div class='dijitRight'>
					<div class="dijitStretch dijitButtonNode dijitButtonContents" type=""
						 waiRole="button" waiState="haspopup-true,labelledby-CachedHeaderDisplay_1_SeeAll_label"
							><div class="dijitInline"></div
						><span class="dijitButtonText" 
						id="CachedHeaderDisplay_1_SeeAll_label"><fmt:message key="SEE_ALL" bundle="${storeText}"/></span
						><span class='dijitA11yDownArrow'></span>
					</div>
				</div></div>
				</c:if>	
			</div>
			
			
			
			<div id="header_menu_loaded" style="display:none;">
			
				
				<c:forEach var="topCategory" items="${categoryHierarchy}" varStatus="status">
				
				<c:if test="${status.count <= maxTopCategoriesInHeader}">
							<wcf:url var="CategoryDisplayURL" patternName="CanonicalCategoryURL" value="Category3">
								<wcf:param name="langId" value="${param.langId}" />
								<wcf:param name="storeId" value="${param.storeId}" />
								<wcf:param name="catalogId" value="${param.catalogId}" />
								<wcf:param name="top" value="Y" />
								<wcf:param name="categoryId" value="${topCategory.categoryId}" />
								<wcf:param name="pageView" value="${defaultPageView}" />
								<wcf:param name="beginIndex" value="0" />
								<wcf:param name="urlLangId" value="${urlLangId}" />
							</wcf:url>
							
							<fmt:message key="DROPDOWN_ACTIVATE" bundle="${storeText}" var="categoryTitle">
							<fmt:param value="${topCategory.description.name}"/>
							</fmt:message>



							<div dojoType="wc.widget.WCDropDownButton" url="<c:out value='${CategoryDisplayURL}'/>" title="<c:out value='${categoryTitle}'/>" id="HeaderMenu_DropDown_<c:out value='${status.count}'/>">
							<span><c:out value="${topCategory.description.name}" escapeXml="false"/></span>
							
							<%-- 
							*** 
							*  Start: DropDownMenu Content
							***
							--%>		
							<div dojoType="wc.widget.WCMenu" maxItemsPerColumn="${maxItemsPerColumn}" forceDisplayShowAll="${forceDisplayShowAll}" showAllURL="<c:out value='${CategoryDisplayURL}'/>" showAllText="<fmt:message key="SHOW_ALL_TEXT" bundle="${storeText}" /> ${topCategory.description.name}" class ="dropdown" id="WC_CachedHeaderDisplay_div_3_<c:out value='${status.count}'/>">
												
												<flow:ifEnabled feature="SearchBasedNavigation">
													<c:set var="subTopCategoryList" value="${topCategory.directSubCategories}" />
												</flow:ifEnabled>
												<flow:ifDisabled feature="SearchBasedNavigation">
													<c:set var="subTopCategoryList" value="${topCategory.subCategories}" />
												</flow:ifDisabled>
												
												<c:forEach var="subTopCategory" items="${subTopCategoryList}" varStatus="status2">
													<flow:ifDisabled feature="SearchBasedNavigation">
														<%-- Use patternName = CategoryURLWithDetails, if beginIndex != 0 OR pageView != image --%>
														<wcf:url var="subTopCategoryDisplayUrl" patternName="CategoryURL" value="Category4">
															<wcf:param name="catalogId" value="${param.catalogId}" />
															<wcf:param name="storeId" value="${param.storeId}" />
															<wcf:param name="categoryId" value="${subTopCategory.categoryId}" />
															<wcf:param name="langId" value="${param.langId}" />
															<wcf:param name="parent_category_rn" value="${topCategory.categoryId}" />
															<wcf:param name="top_category" value="${topCategory.categoryId}" />
															<wcf:param name="pageView" value="${defaultPageView}" />
															<wcf:param name="beginIndex" value="0"/>
															<wcf:param name="urlLangId" value="${urlLangId}" />
														</wcf:url>
													</flow:ifDisabled>
													<flow:ifEnabled feature="SearchBasedNavigation">
														<wcf:url var="subTopCategoryDisplayUrl" patternName="SearchCategoryURL" value="SearchDisplay">
															<wcf:param name="langId" value="${langId}"/>
															<wcf:param name="storeId" value="${param.storeId}"/>
															<wcf:param name="catalogId" value="${param.catalogId}"/>
															<wcf:param name="pageView" value="image"/>
															<wcf:param name="beginIndex" value="0"/>
															<wcf:param name="sType" value="SimpleSearch"/>
															<wcf:param name="categoryId" value="${subTopCategory.categoryId}"/>
															<wcf:param name="resultCatEntryType" value="${WCParam.resultCatEntryType}"/>
															<wcf:param name="showResultsPage" value="true"/>
															<wcf:param name="urlLangId" value="${urlLangId}" />
														</wcf:url>
													</flow:ifEnabled>

													<div dojoType="dijit.MenuItem" onClick="loadLink('<c:out value='${subTopCategoryDisplayUrl}'/>');" id="WC_CachedHeaderDisplay_div_4_<c:out value='${status.count}'/>_<c:out value='${status2.count}'/>">
														<span><a href='<c:out value="${subTopCategoryDisplayUrl}"/>' id="WC_CachedHeaderDisplay_links_1_<c:out value='${status.count}'/>_<c:out value='${status2.count}'/>"><c:out value="${subTopCategory.description.name}" escapeXml="false"/></a></span>
													</div> 
												</c:forEach>
										</div>
									</div>	
							 <%-- 
								***
								*  End: DropDownMenu Content
								***
							  --%>
							  </c:if>
				</c:forEach>
				<%--See All --%>
				<fmt:message key="SEE_ALL_DROPDOWN" bundle="${storeText}" var="topcatTitle"/>
				<c:if test="${numTopCat > maxTopCategoriesInHeader}">
						<div dojoType="wc.widget.WCDropDownButton" title="<c:out value='${topcatTitle}'/>" url="<c:out value='${SiteMapURL}'/>" id="WC_CachedHeaderDisplay_div_5_SeeAllDropDown">
							<span><fmt:message key="SEE_ALL" bundle="${storeText}"/></span>
								
									<div dojoType="wc.widget.WCMenu" widgetsInTemplate="true" maxSize="6" showAllText="<fmt:message key="SEE_ALL_DROPDOWN" bundle="${storeText}" />" showAllURL="<c:out value='${SiteMapURL}'/>" class="dropdown" id="WC_CachedHeaderDisplay_div_6_SeeAllMenu">
												<c:forEach var="topCat" items="${categoryHierarchy}" varStatus="status2">
													<%-- variables come from HeaderDisplay.jspf --%>
												<wcf:url var="CategoryDisplayURL" patternName="CanonicalCategoryURL" value="Category3">
														<wcf:param name="langId" value="${param.langId}" />
														<wcf:param name="storeId" value="${param.storeId}" />
														<wcf:param name="catalogId" value="${param.catalogId}" />
														<wcf:param name="top" value="Y" />
														<wcf:param name="categoryId" value="${topCat.categoryId}" />
														<wcf:param name="pageView" value="${defaultPageView}" />
														<wcf:param name="beginIndex" value="0" />
														<wcf:param name="urlLangId" value="${urlLangId}" />
													</wcf:url>												
													<div dojoType="dijit.MenuItem" onClick="loadLink('<c:out value='${CategoryDisplayURL}'/>');" id="WC_CachedHeaderDisplay_div_7_SeeAll_<c:out value='${status2.count}'/>">
														<span><a href='<c:out value="${CategoryDisplayURL}"/>' id="WC_CachedHeaderDisplay_links_2_SeeAll_<c:out value='${status2.count}'/>"><c:out value="${topCat.description.name}" escapeXml="false"/></a></span>
													</div> 
												</c:forEach>
										</div>
									</div>	
				</c:if>
			</div>
		</div>
			<flow:ifEnabled feature="miniShopCart">
			<div id="outerCartContainer" <c:if test="${noTopCategoryDisplay == 'true'}">class="top_category_no_display"</c:if>>
				<div dojoType="dojo.dnd.Target" jsId="miniShopCart_dndTarget" id="miniShopCart_dndTarget" accept="item, product, package, bundle, dynamicKit" >
					<div id="shopping-cart">
						<div id="shopcartContainer">
							<div dojoType="wc.widget.RefreshArea" id="MiniShoppingCart" widgetId="MiniShoppingCart" controllerId="MiniShoppingCartController" onmouseover="showMiniShopCartDropDown('placeHolder','quick_cart_container','orderItemsList');" role="wairole:region" waistate:live="polite" waistate:atomic="true" waistate:relevant="all">
								<%out.flush();%>
									<c:import url="${jspStoreDir}include/MiniShopCartDisplay.jsp">
									 <%-- variables come from HeaderDisplay.jspf --%>
									  <c:param name="storeId" value="${param.storeId}"/>
										<c:param name="catalogId" value="${param.catalogId}"/>
										<c:param name="langId" value="${param.langId}"/>
									</c:import>
								<%out.flush();%>
							</div>
							<script type="text/javascript">
								dojo.addOnLoad(function(){
									if(dojo.byId('MiniShoppingCart') != null){
										originalMiniCartWidth = dojo.coords(dojo.byId('MiniShoppingCart'),true).w;
									}

									<flow:ifEnabled feature="SearchBasedNavigation">
										dojo.connect(dojo.byId("SimpleSearchForm_SearchTerm"), "onkeydown", function(evt) {
											key = evt.keyCode;
											if(key == dojo.keys.ENTER) {
												if(document.CatalogSearchForm.searchTerm.value.length > 0) {
													if(autoSuggestURL != "") {
														// go to suggested URL
														document.location.href = autoSuggestURL;
													}
													else {
														document.CatalogSearchForm.searchTerm.value = trim(document.CatalogSearchForm.searchTerm.value);
														submitSpecifiedForm(document.CatalogSearchForm);
													}
												}
											}
										});
									</flow:ifEnabled>

								});
							</script>
						 </div>
					</div> 
				</div>
			 </div>
			</flow:ifEnabled>			
</div>
			
<!-- END CachedHeaderDisplay.jsp -->
