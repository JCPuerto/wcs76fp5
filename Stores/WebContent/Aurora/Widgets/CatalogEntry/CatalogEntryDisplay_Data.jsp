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

<c:set var="search" value='"'/>
<c:set var="replaceStr" value="'"/>
<c:set var="search01" value="'"/>
<c:set var="replaceStr01" value="\\'"/>
<c:set var="replaceCmprStr" value=""/>

<flow:ifEnabled feature="ShowProductInNewWindow">
	<c:set var="ShowProductInNewWindow" value="target=\"_blank\"" />
</flow:ifEnabled>


<%-- Set catalogEntryDetails to catalogEntryView before including CatalogEntryThumbnailDisplayForDynamicKits.jspf --%>
<c:if test="${empty catalogEntryDetails}">
	<wcf:getData type="com.ibm.commerce.catalog.facade.datatypes.CatalogNavigationViewType" var="catalogNavigationView" 
		expressionBuilder="getCatalogEntryViewPriceWithAttributesByID" varShowVerb="showCatalogNavigationView" recordSetStartNumber="0">
		<wcf:param name="UniqueID" value="${catEntryIdentifier}"/>
		<wcf:contextData name="storeId" data="${storeId}" />
		<wcf:contextData name="catalogId" data="${catalogId}" />
	</wcf:getData>
	<c:set var = "catalogEntryDetails" value = "${catalogNavigationView.catalogEntryView[0]}"/>
</c:if>

<c:set var="catalogEntryView" value="${catalogEntryDetails}"/>
<c:set var="catalogEntryID" value="${catalogEntryDetails.uniqueID}" />
<c:set var="productName" value="${catalogEntryDetails.name}"  />
<c:set var="productShortDescription" value="${catalogEntryDetails.shortDescription}"  />
<c:set var="attributes" value="${catalogEntryDetails.attributes}"/>
	
<%-- if someone had passed just catalogEntryDetails object without catEntryIdentifier, then this will make sure that we always have catEntryIdentifier set --%>
<c:set var="catEntryIdentifier" value="${catalogEntryDetails.uniqueID}" /> 
	
<c:forEach var="metadata" items="${catalogEntryDetails.metaData}" varStatus="status2">
	<c:if test="${metadata.key == 'ThumbnailPath'}">
		<c:set var="productThumbNail" value="${env_imageContextPath}/${metadata.value}" />
	</c:if>			
	<c:if test="${metadata.key == 'FullImagePath'}">
		<c:set var="productFullImage" value="${env_imageContextPath}/${metadata.value}" />
	</c:if>
</c:forEach>

<c:choose>
	<c:when test="${!empty productThumbNail}">
		<c:set var="imgSource" value="${productThumbNail}" />
	</c:when>
	<c:otherwise>
		<c:set var="imgSource" value="${jspStoreImgDir}images/NoImageIcon_sm.jpg" />
	</c:otherwise>
</c:choose>

<%-- Convert 160x160 image to 70x70 to display in side bar --%>
<c:set var="imgSource_sideBar" value="${fn:replace(imgSource, productThumbnailImage, miniImage)}" />

<c:set var="altImgText">
	<c:out value='${fn:replace(productName, search, replaceStr)} ${formattedPriceString}' escapeXml='false'/>
</c:set>

<c:set var="highlightedName" value="${catalogEntryDetails.metaData.name}" />
<c:if test="${empty highlightedName}">
	<c:set var="highlightedName" value="${productName}" />
</c:if>

<c:set var="highlightedShortDescription" value="${catalogEntryDetails.metaData.shortDescription}" />
<c:if test="${empty highlightedShortDescription}">
	<c:set var="highlightedShortDescription" value="${productShortDescription}" />
</c:if>

<c:if test="${not empty catalogEntryDetails.metaData.score}">
	<fmt:formatNumber var="searchScore" type="number" maxFractionDigits="15" groupingUsed="true" value="${catalogEntryDetails.metaData.score}" />
</c:if>

<c:set var="buyable" value="${catalogEntryDetails.buyable}"/>

<c:set var="singleSKU" value="false"/>
<c:choose>
	<c:when test="${catalogEntryDetails.catalogEntryTypeCode == 'BundleBean'}">
		<c:set var="type" value="bundle" />
		<c:set var="singleSKU" value="${catalogEntryDetails.hasSingleSKU}"/>
	</c:when>
	<c:when test="${catalogEntryDetails.catalogEntryTypeCode == 'PackageBean'}">
		<c:set var="type" value="package" />
	</c:when>
	<c:when test="${catalogEntryDetails.catalogEntryTypeCode == 'ItemBean'}">
		<c:set var="type" value="item" />
	</c:when>
	<c:when test="${catalogEntryDetails.catalogEntryTypeCode == 'ProductBean'}">
		<c:set var="type" value="product" />
		<c:set var="singleSKU" value="${catalogEntryDetails.hasSingleSKU}"/>
	</c:when>
	<c:when test="${catalogEntryDetails.catalogEntryTypeCode == 'DynamicKitBean'}">
		<c:set var="type" value="dynamickit" />
		<c:set var="singleSKU" value="false"/>
		<c:set var="isDKConfigurable" value="${!empty catalogEntryView.dynamicKitModelReference}"/>
		<c:if test="${empty isDKConfigurable}">
			<c:set var="isDKConfigurable" value="true"/>
		</c:if>

		<c:if test="${empty isDKPreConfigured}">
			<%-- determine if the kit is pre-configured or not --%>
			<c:set var="isDKPreConfigured" value="${catalogEntryView.dynamicKitDefaultConfigurationComplete}"/>
		</c:if>
	</c:when>
</c:choose>

<c:if test="${!empty globalbreadcrumbs}">
	<c:forEach var="breadcrumb" items="${globalbreadcrumbs.breadCrumbTrailEntryView}">
			<c:if test="${breadcrumb.type_ == 'FACET_ENTRY_CATEGORY'}">
			 <c:choose>
				<c:when test="${empty searchTopCategoryId}">
					<c:set var="searchTopCategoryId" value="${breadcrumb.value}" scope="request"/>
				</c:when>
				<c:when test="${empty searchParentCategoryId}">
					<c:set var="searchParentCategoryId" value="${breadcrumb.value}" scope="request"/>
				</c:when>
			</c:choose>
			</c:if>
	</c:forEach>
</c:if>


<c:choose>
	<%-- Use the context parameters if they are available; usually in a subcategory --%>
	<c:when test="${empty WCParam.categoryId}">
		<%-- categoryId is empty..just display product URL --%>
		<c:set var="patternName" value="ProductURL"/>
		<c:set var="parent_category_rn" value="${searchParentCategoryId}" />
		<c:set var="top_category" value="${searchTopCategoryId}" />
		<c:set var="categoryId" value="${WCParam.categoryId}" />
	</c:when>
	<c:when test="${searchParentCategoryId == WCParam.categoryId}">
			<%-- CategoryId is present..but it is same as parent category Id --%>
			<c:set var="parent_category_rn" value="${searchTopCategoryId}" />
			<c:set var="top_category" value="${searchTopCategoryId}" />
			<c:set var="categoryId" value="${WCParam.categoryId}" />
			<c:set var="patternName" value="ProductURLWithCategory"/>
			<c:if test="${!empty top_category && top_category != searchParentCategoryId}">
				<c:set var="patternName" value="ProductURLWithParentCategory"/>
			</c:if>
	</c:when>
	<c:when test="${!empty searchParentCategoryId && !empty searchTopCategoryId}">
		<%-- both parent and top category are present.. display full product URL --%>
		<c:set var="parent_category_rn" value="${searchParentCategoryId}" />
		<c:set var="top_category" value="${searchTopCategoryId}" />
		<c:set var="categoryId" value="${WCParam.categoryId}" />
		<c:set var="patternName" value="ProductURLWithParentAndTopCategory"/>
		<c:if test="${top_category == parent_category_rn}">
			<%-- But both top and parent category are same..display only parent category in product URL --%>
			<c:set var="patternName" value="ProductURLWithParentCategory"/>
		</c:if>
	</c:when>
	<c:when test="${!empty searchParentCategoryId}">
		<%-- parent category is not empty..use product URL with parent category --%>
		<c:set var="parent_category_rn" value="${searchParentCategoryId}" />
		<c:set var="top_category" value="${searchTopCategoryId}" />
		<c:set var="categoryId" value="${WCParam.categoryId}" />
		<c:set var="patternName" value="ProductURLWithParentCategory"/>
	</c:when>
	<c:when test="${!empty WCParam.categoryId}">
			<c:set var="parent_category_rn" value="${searchTopCategoryId}" />
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

<c:set var = "categoryId_local" value = "${WCParam.categoryId}"/>
<c:if test = "${param.useClickInfoURL == 'true'}">
  <c:set var = "categoryId_local" value = ""/>
</c:if>

<wcf:url var="catEntryDisplayUrl" patternName="${patternName}" value="Product2">
	<wcf:param name="catalogId" value="${catalogId}"/>
	<wcf:param name="storeId" value="${storeId}"/>
	<wcf:param name="productId" value="${catEntryIdentifier}"/>
	<wcf:param name="langId" value="${langId}"/>
	<wcf:param name="errorViewName" value="ProductDisplayErrorView"/>
	<wcf:param name="categoryId" value="${categoryId_local}" />
	<wcf:param name="top_category" value="${top_category}" />
	<wcf:param name="parent_category_rn" value="${parent_category_rn}" />
	<wcf:param name="urlLangId" value="${urlLangId}" />
</wcf:url>

<c:if test = "${param.useClickInfoURL == 'true'}" >
	<c:url var="ClickInfoURL" value="${param.clickInfoURL}">
		<c:param name="URL" value="${catEntryDisplayUrl}" />
	</c:url>
	<%-- Replace catEntryDisplayUrl with clickInfoURL --%>
	<c:set var = "catEntryDisplayUrl" value = "${env_absoluteUrl}${ClickInfoURL}" />
</c:if>