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
<c:choose>
	<c:when test="${!empty WCParam.productId}">
		<c:set var="productId" value="${WCParam.productId}" />
	</c:when>
	<c:otherwise>
		<c:set var="productId" value="${param.productId}" />
	</c:otherwise>
</c:choose>

<c:if test="${empty catalogEntryDetails}" >
	<c:if test="${!empty productId}">
		<%-- Try to get it from our internal hashMap --%>
		<c:set var="key1" value="${productId}+getCatalogEntryViewAllByID"/>
		<c:set var="catalogEntryDetails" value="${cachedCatalogEntryDetailsMap[key1]}"/>
		<c:if test="${empty catalogEntryDetails}">
			<wcf:getData type="com.ibm.commerce.catalog.facade.datatypes.CatalogNavigationViewType" var="catalogNavigationView" 
				expressionBuilder="getCatalogEntryViewSummaryByID" varShowVerb="showCatalogNavigationView" maxItems="1" recordSetStartNumber="0">
				<wcf:param name="UniqueID" value="${productId}"/>
				<wcf:contextData name="storeId" data="${WCParam.storeId}" />
				<wcf:contextData name="catalogId" data="${WCParam.catalogId}" />
			</wcf:getData>
		</c:if>
	</c:if>
	<c:if test="${empty productId && !empty WCParam.partNumber}">
		<c:set var="key1" value="${WCParam.partNumber}+getCatalogEntryViewAllByPartnumber"/>
		<c:set var="catalogEntryDetails" value="${cachedCatalogEntryDetailsMap[key1]}"/>
		<c:if test="${empty catalogEntryDetails}">
			<wcf:getData type="com.ibm.commerce.catalog.facade.datatypes.CatalogNavigationViewType" var="catalogNavigationView" 
				expressionBuilder="getCatalogEntryViewSummaryByPartnumber" varShowVerb="showCatalogNavigationView" maxItems="1" recordSetStartNumber="0">
				<wcf:param name="PartNumber" value="${WCParam.partNumber}" />
				<wcf:contextData name="storeId" data="${WCParam.storeId}" />
				<wcf:contextData name="catalogId" data="${WCParam.catalogId}" />
			</wcf:getData>
		</c:if>
	</c:if>
	<c:if test="${!empty catalogNavigationView && !empty catalogNavigationView.catalogEntryView[0]}">
		<c:set var="catalogEntryDetails" value="${catalogNavigationView.catalogEntryView[0]}"/>
	</c:if>
</c:if>

<c:set var="catalogEntryID" value="${catalogEntryDetails.uniqueID}" />
<c:set var="packagePrice">
	<fmt:formatNumber value="${catalogEntryDetails.price[0].value.value}" type="currency" currencySymbol="${env_CurrencySymbolToFormat}" maxFractionDigits="${env_currencyDecimal}"/>
</c:set>
<c:set var="showAdd2CartButton" value="${catalogEntryDetails.buyable}" />