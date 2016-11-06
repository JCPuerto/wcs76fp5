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
<%-- Initializing the param variables --%>
<c:set var="top_category" value=""/>
<c:set var="parent_category_rn" value=""/>
<c:set var="categoryId" value=""/>
<c:set var="productId" value=""/>
<c:set var="pageName" value=""/>
<c:set var="searchTerm" value=""/>

<%-- Check first in the param and then in WCParam --%>
<c:if test="${!empty param.top_category}">
	<c:set var="top_category" value="${param.top_category}"/>
</c:if>
<c:if test="${!empty WCParam.top_category}">
	<c:set var="top_category" value="${WCParam.top_category}"/>
</c:if>
<c:if test="${!empty param.parent_category_rn}">
	<c:set var="parent_category_rn" value="${param.parent_category_rn}"/>
</c:if>
<c:if test="${!empty WCParam.parent_category_rn}">
	<c:set var="parent_category_rn" value="${WCParam.parent_category_rn}"/>
</c:if>
<c:if test="${!empty param.categoryId}">
	<c:set var="categoryId" value="${param.categoryId}"/>
</c:if>
<c:if test="${!empty WCParam.categoryId}">
	<c:set var="categoryId" value="${WCParam.categoryId}"/>
</c:if>
<c:if test="${!empty param.productId}">
	<c:set var="productId" value="${param.productId}"/>
</c:if>
<c:if test="${!empty WCParam.productId}">
	<c:set var="productId" value="${WCParam.productId}"/>
</c:if>
<c:if test="${!empty param.pageName}">
	<c:set var="pageName" value="${param.pageName}"/>
</c:if>
<c:if test="${!empty WCParam.pageName}">
	<c:set var="pageName" value="${WCParam.pageName}"/>
</c:if>
<c:if test="${!empty param.searchTerm}">
	<c:set var="searchTerm" value="${param.searchTerm}"/>
</c:if>
<c:if test="${!empty WCParam.searchTerm}">
	<c:set var="searchTerm" value="${WCParam.searchTerm}"/>
</c:if>

<%-- A Map to store the bread crumb items along with their URLs--%>
<jsp:useBean id="breadCrumbItemsMap" class="java.util.LinkedHashMap" type="java.util.Map"/>

<%-- Sets the Home url to the Map--%>
<fmt:message var="home" key="BCT_HOME" />
<c:set target="${breadCrumbItemsMap}" property="${home}" value="${env_TopCategoriesDisplayURL}"/>

<%-- Sets the Home as the last bread crumb item --%>
<c:set var="lastBreadCrumbItem" value="${home}"/>

<%-- Page specific bread crumbs --%>
<c:choose>
	<%-- When it is a Product Compare Page --%>
	<c:when test="${pageName eq 'ProductComparePage'}">
		<fmt:message var="lastBreadCrumbItem" key="BCT_PRODUCT_COMPARE" />
	</c:when>
	<%-- When it is a Advanced Search Page --%>
	<c:when test="${pageName eq 'AdvancedSearchPage'}">
		<fmt:message var="lastBreadCrumbItem" key="TITLE_ADVANCED_SEARCH" />
	</c:when>
	<%-- When it is a Normal Search Page --%>
	<c:when test="${pageName eq 'SearchPage'}">
		<c:choose>
			<c:when test="${empty searchTerm}">
				<fmt:message var="lastBreadCrumbItem" key="SEARCH_ALL_PRODUCTS" />
			</c:when>
			<c:otherwise>
				<c:set var="lastBreadCrumbItem" value="${searchTerm}"/>
			</c:otherwise>
		</c:choose>
	</c:when>
	<%-- Default BreadCrumb for rest of the pages --%>
	<c:otherwise>
		<%-- Check if top_category is passed as a param --%>
		<c:if test="${!empty top_category}">
			<%-- Generates the Top Category URL --%>
			<c:catch var ="invalidTopCategoryException">
				<wcf:getData
					type="com.ibm.commerce.catalog.facade.datatypes.CatalogNavigationViewType"
					var="bcTopCategory"
					expressionBuilder="getCatalogNavigationCatalogGroupView"
					maxItems="1" recordSetStartNumber="0">
					<wcf:param name="UniqueID" value="${top_category}" />
					<wcf:contextData name="storeId" data="${storeId}" />
					<wcf:contextData name="catalogId" data="${catalogId}" />
				</wcf:getData>
				<wcf:url var="CategoryDisplayURL" patternName="CanonicalCategoryURL" value="Category3">
					<wcf:param name="langId" value="${langId}" />
					<wcf:param name="urlLangId" value="${urlLangId}" />
					<wcf:param name="storeId" value="${storeId}" />
					<wcf:param name="catalogId" value="${catalogId}" />
					<wcf:param name="categoryId" value="${bcTopCategory.catalogGroupView[0].uniqueID}" />
					<wcf:param name="pageView" value="${env_defaultPageView}" />
					<wcf:param name="beginIndex" value="0" />
				</wcf:url>
			</c:catch>
			<c:if test="${empty invalidTopCategoryException}">
				<%-- Sets the Top Category URL to the Map --%>
				<c:set target="${breadCrumbItemsMap}" property="${bcTopCategory.catalogGroupView[0].name}" value="${CategoryDisplayURL}"/>
				
				<%-- Sets the Top Category as the last bread crumb item --%>
				<c:set var="lastBreadCrumbItem" value="${bcTopCategory.catalogGroupView[0].name}"/>
			</c:if>
		</c:if>

		<%-- Check if parent_category_rn is passed as a param and is not same as top_category --%>
		<c:if test="${!empty parent_category_rn and (parent_category_rn ne top_category) and (parent_category_rn ne categoryId)}">
			<%-- Generates the Parent Category URL --%>
			<c:catch var ="invalidParentCategoryException">
				<wcf:getData
					type="com.ibm.commerce.catalog.facade.datatypes.CatalogNavigationViewType"
					var="bcParentCategory"
					expressionBuilder="getCatalogNavigationCatalogGroupView"
					maxItems="1" recordSetStartNumber="0">
					<wcf:param name="UniqueID" value="${parent_category_rn}" />
					<wcf:contextData name="storeId" data="${storeId}" />
					<wcf:contextData name="catalogId" data="${catalogId}" />
				</wcf:getData>
				<wcf:url var="ParentCategoryDisplayURL" patternName="SearchCategoryURL" value="SearchDisplay">
					<wcf:param name="langId" value="${langId}"/>
					<wcf:param name="urlLangId" value="${urlLangId}" />
					<wcf:param name="storeId" value="${storeId}"/>
					<wcf:param name="catalogId" value="${catalogId}"/>
					<wcf:param name="categoryId" value="${bcParentCategory.catalogGroupView[0].uniqueID}" />
					<wcf:param name="pageView" value="${env_defaultPageView}" />
					<wcf:param name="beginIndex" value="0"/>
					<wcf:param name="sType" value="SimpleSearch"/>
					<wcf:param name="resultCatEntryType" value="${WCParam.resultCatEntryType}"/>
					<wcf:param name="showResultsPage" value="true"/>
				</wcf:url>
			</c:catch>
			
			<c:if test="${empty invalidParentCategoryException}">
				<%-- Sets the Parent Category URL to the Map --%>
				<c:set target="${breadCrumbItemsMap}" property="${bcParentCategory.catalogGroupView[0].name}" value="${ParentCategoryDisplayURL}"/>
				
				<%-- Sets the Parent Category as the last bread crumb item --%>
				<c:set var="lastBreadCrumbItem" value="${bcParentCategory.catalogGroupView[0].name}"/>
			</c:if>
		</c:if>

		<%-- Check if categoryId is passed as a param --%>
		<c:if test="${!empty categoryId}">
			<%-- Generates the Sub Category URL --%>
			<c:catch var ="invalidSubCategoryException">
				<wcf:getData
					type="com.ibm.commerce.catalog.facade.datatypes.CatalogNavigationViewType"
					var="bcSubCategory"
					expressionBuilder="getCatalogNavigationCatalogGroupView"
					maxItems="1" recordSetStartNumber="0">
					<wcf:param name="UniqueID" value="${categoryId}" />
					<wcf:contextData name="storeId" data="${storeId}" />
					<wcf:contextData name="catalogId" data="${catalogId}" />
				</wcf:getData>
				<%-- Check if parentCatalogGroupID is present --%>
				<c:set var="parentCatalogGroupID" value="${bcSubCategory.catalogGroupView[0].parentCatalogGroupID[0]}" />
				<c:if test="${!empty parentCatalogGroupID and (parentCatalogGroupID ne parent_category_rn) and (parentCatalogGroupID ne top_category)}">
					<%-- Generates the Top Category URL --%>
					<c:catch var ="invalidTopCategoryException">
						<wcf:getData
							type="com.ibm.commerce.catalog.facade.datatypes.CatalogNavigationViewType"
							var="bcTopCategory"
							expressionBuilder="getCatalogNavigationCatalogGroupView"
							maxItems="1" recordSetStartNumber="0">
							<wcf:param name="UniqueID" value="${parentCatalogGroupID}" />
							<wcf:contextData name="storeId" data="${storeId}" />
							<wcf:contextData name="catalogId" data="${catalogId}" />
						</wcf:getData>
						<wcf:url var="CategoryDisplayURL" patternName="CanonicalCategoryURL" value="Category3">
							<wcf:param name="langId" value="${langId}" />
							<wcf:param name="urlLangId" value="${urlLangId}" />
							<wcf:param name="storeId" value="${storeId}" />
							<wcf:param name="catalogId" value="${catalogId}" />
							<wcf:param name="categoryId" value="${bcTopCategory.catalogGroupView[0].uniqueID}" />
							<wcf:param name="pageView" value="${env_defaultPageView}" />
							<wcf:param name="beginIndex" value="0" />
						</wcf:url>
					</c:catch>
					<c:if test="${empty invalidTopCategoryException}">
						<%-- Sets the Top Category URL to the Map --%>
						<c:set target="${breadCrumbItemsMap}" property="${bcTopCategory.catalogGroupView[0].name}" value="${CategoryDisplayURL}"/>
						
					</c:if>
				</c:if>

				<wcf:url var="SubCategoryDisplayURL" patternName="SearchCategoryURL" value="SearchDisplay">
					<wcf:param name="langId" value="${langId}"/>
					<wcf:param name="urlLangId" value="${urlLangId}" />
					<wcf:param name="storeId" value="${storeId}"/>
					<wcf:param name="catalogId" value="${catalogId}"/>
					<wcf:param name="categoryId" value="${bcSubCategory.catalogGroupView[0].uniqueID}" />
					<wcf:param name="pageView" value="${env_defaultPageView}" />
					<wcf:param name="beginIndex" value="0"/>
					<wcf:param name="sType" value="SimpleSearch"/>
					<wcf:param name="resultCatEntryType" value="${WCParam.resultCatEntryType}"/>
					<wcf:param name="showResultsPage" value="true"/>
				</wcf:url>
			</c:catch>
			<c:if test="${empty invalidSubCategoryException}">
				<%-- Sets the Sub Category URL to the Map --%>
				<c:set target="${breadCrumbItemsMap}" property="${bcSubCategory.catalogGroupView[0].name}" value="${SubCategoryDisplayURL}"/>
				
				<%-- Sets the Sub Category as the last bread crumb item --%>
				<c:set var="lastBreadCrumbItem" value="${bcSubCategory.catalogGroupView[0].name}"/>
			</c:if>
		</c:if>

		<%-- Check if productId is passed as a param --%>
		<c:if test="${!empty productId}">
			<%-- Sets Product Name as the last bread crumb item --%>
			<c:catch var ="invalidProductException">
				<wcf:getData
					type="com.ibm.commerce.catalog.facade.datatypes.CatalogNavigationViewType"
					var="bcCatalogEntry"
					expressionBuilder="getCatalogEntryViewSummaryByID"
					maxItems="1" recordSetStartNumber="0">
					<wcf:param name="UniqueID" value="${productId}" />
					<wcf:contextData name="storeId" data="${storeId}" />
					<wcf:contextData name="catalogId" data="${catalogId}" />
				</wcf:getData>
			</c:catch>
			<c:if test="${empty invalidProductException}">
				<c:set var="lastBreadCrumbItem" value="${bcCatalogEntry.catalogEntryView[0].name}"/>
			</c:if>
		</c:if>
		
		<c:set target="${breadCrumbItemsMap}" property="${lastBreadCrumbItem}" value="${null}"/>
	</c:otherwise>
</c:choose>
<c:set var="compareReturnName" value="${lastBreadCrumbItem}" scope="request"/>
