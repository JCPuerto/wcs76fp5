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
<c:set var="search01" value="'"/>
<c:set var="search02" value='"'/>
<c:set var="replaceStr01" value="\\'"/>
<c:set var="replaceStr02" value="inches"/>

<%-- Fetches the nearest physical stores selected by the user from cookie --%>
<c:set var="cookieVal" value="${cookie.WC_physicalStores.value}" />
<c:set var="cookieVal" value="${fn:replace(cookieVal, '%2C', ',')}" />

<c:set var ="catalogEntryId" value="${param.productId}" />
<c:if test="${empty catalogEntryId}">
	<c:set var ="catalogEntryId" value="${WCParam.productId}" />
</c:if>

<%-- Try to get it from our internal cached hashMap --%>
<c:set var="key1" value="${catalogEntryId}+getCatalogEntryViewAllByID"/>
<c:set var="catalogEntryView" value="${cachedCatalogEntryDetailsMap[key1]}"/>
<c:if test="${empty catalogEntryView}">
	<c:set var="key1" value="${catalogEntryId}+getCatalogEntryViewDetailsByID"/>
	<c:set var="catalogEntryView" value="${cachedCatalogEntryDetailsMap[key1]}"/>
</c:if>

<c:if test="${empty catalogEntryView}">
	<%-- Fetches the details of the currently displayed catalogEntry --%>
	<wcf:getData
		type="com.ibm.commerce.catalog.facade.datatypes.CatalogNavigationViewType"
		var="catalogEntry"
		expressionBuilder="getCatalogEntryViewDetailsByID"
		maxItems="1" recordSetStartNumber="0">
		<wcf:contextData name="storeId" data="${storeId}" />
		<wcf:contextData name="catalogId" data="${catalogId}" />
		<wcf:param name="UniqueID" value="${catalogEntryId}" />
	</wcf:getData>
	<%-- Cache it in our internal hash map --%>
	<wcf:set target = "${cachedCatalogEntryDetailsMap}" key="${catalogEntryId}+getCatalogEntryViewDetailsByID" value="${catalogEntry.catalogEntryView[0]}"/>
	<c:set var="catalogEntryView" value="${catalogEntry.catalogEntryView[0]}"/>
</c:if>

<c:set var="skus" value=""/>
<c:choose>
	<%-- If the catalog entry is a ProductBean --%>
	<c:when test="${catalogEntryView.catalogEntryTypeCode eq 'ProductBean'}">
		<c:choose>
			<%-- If the catalog entry is a ProductBean and it has only one SKU, then it is as good as ItemBean.
			So identify the uniqueID of the single SKU and mark it as ItemBean --%>
			<c:when test="${catalogEntryView.hasSingleSKU}">
				<c:set var="catalogEntryId" value="${catalogEntryView.singleSKUCatalogEntryID}"/>
				<c:set var="type" value="ItemBean"/>
			</c:when>
			<c:otherwise>
				<c:set var="catalogEntryId" value="${catalogEntryView.uniqueID}"/>
				<c:set var="firstSkuCatalogEntryId" value="${catalogEntryView.SKUs[0].uniqueID}"/>
				<c:set var="type" value="${catalogEntryView.catalogEntryTypeCode}"/>
				<%-- Pick the SKUs and the corresponding attributes --%>
				<c:forEach var="sku" items="${catalogEntryView.SKUs}">
					<c:if test="${!empty skus}">
						<c:set var="skus" value="${skus},"/>
					</c:if>
					<c:set var="attributes" value=""/>
					<c:forEach var="skuAttribute" items="${sku.attributes}">
						<c:if test="${skuAttribute.usage eq 'Defining'}">
							<c:if test="${!empty attributes}">
								<c:set var="attributes" value="${attributes},"/>
							</c:if>
							<c:set var="attributes" value="${attributes}'${skuAttribute.name}': '${fn:replace(fn:replace(skuAttribute.values[0].value, search01, replaceStr01), search02, replaceStr02)}'"/>
						</c:if>
					</c:forEach>
					<c:set var="skus" value="${skus}{id: '${sku.uniqueID}', attributes: {${attributes}}}"/>
				</c:forEach>
			</c:otherwise>
		</c:choose>
	</c:when>
	<c:otherwise>
		<c:set var="catalogEntryId" value="${catalogEntryView.uniqueID}"/>
		<c:set var="type" value="${catalogEntryView.catalogEntryTypeCode}"/>
	</c:otherwise>
</c:choose>

<c:set var="catEntryParams" value="{id: '${catalogEntryId}', type: '${type}', skus: [${skus}]}"/>
<c:set var="onlineInventoryStatus" value="NA"/>
<c:set var="storeCounter" value="0"/>
<c:set var="showAvailabilityLink" value="${type eq 'ProductBean'}"/>
<c:set var="showAvailability" value="${type eq 'ItemBean' or type eq 'PackageBean' or type eq 'DynamicKitBean'}"/>
<c:if test="${showAvailability || !empty firstSkuCatalogEntryId}">
	<c:choose>
		<c:when test="${empty firstSkuCatalogEntryId}">
			<c:set var="catalogEntryIdToUse" value="${catalogEntryId}"/>
		</c:when>
		<c:otherwise>
			<c:set var="catalogEntryIdToUse" value="${firstSkuCatalogEntryId}"/>
		</c:otherwise>
	</c:choose>

	<%-- Fetches the inventory list for a particular item in online store and physical store using store ids--%>
	<c:catch var="inventoryException">
		<wcf:getData
			type="com.ibm.commerce.inventory.facade.datatypes.InventoryAvailabilityType[]"
			var="itemInventoryList"
			expressionBuilder="findInventoryAvailabilityByCatalogEntryIdsAndOnlineStoreIdsAndPhysicalStoreIds">
			<wcf:param name="accessProfile" value="IBM_Store_Details" />
			<wcf:param name="onlineStoreId" value="${storeId}" />
			<wcf:param name="catalogEntryId" value="${catalogEntryIdToUse}" />
			<c:forTokens items="${cookieVal}" delims="," var="phyStoreId">
				<wcf:param name="physicalStoreId" value="${phyStoreId}" />
			</c:forTokens>
		</wcf:getData>
	</c:catch>
	
	<%-- If an exception is thrown, it means the store has no inventory --%>
	<c:choose>
		<c:when test="${empty inventoryException}">
			<c:set var="hasInventory" value="true"/>
		</c:when>
		<c:otherwise>
			<c:set var="hasInventory" value="false"/>
		</c:otherwise>
	</c:choose>
	
	<jsp:useBean id="inStoreInventoryNameMap" class="java.util.HashMap" type="java.util.Map"/>
	<jsp:useBean id="inStoreInventoryStatusMap" class="java.util.HashMap" type="java.util.Map"/>
	
	<c:set var="physicalStores" value=""/>
	
	<%-- Iterates through the inventory list to get the online inventory status and physical store inventory status --%>
	<c:forEach var="itemInventory" items="${itemInventoryList}" varStatus="counter">
		<c:choose>
			<%-- Selects the online inventory status when online store identifier is not empty --%>
			<c:when test="${!empty itemInventory.inventoryAvailabilityIdentifier.externalIdentifier.onlineStoreIdentifier}">
				<c:if test="${!empty  itemInventory.inventoryStatus}">
				    <c:set var="onlineInventoryStatus" value="${itemInventory.inventoryStatus}"/>
				</c:if>
			</c:when>
			<c:when test="${!empty itemInventory.inventoryAvailabilityIdentifier.externalIdentifier.physicalStoreIdentifier}">
				<c:set var="storeCounter" value="${storeCounter+1}"/>
				
				<c:choose>
					<c:when test="${! empty(itemInventory.availabilityDateTime)}">
						<c:catch>
							<fmt:parseDate parseLocale="${dateLocale}" var="date" value="${itemInventory.availabilityDateTime}" pattern="yyyy-MM-dd'T'HH:mm:ss.SSS'Z'" timeZone="GMT" dateStyle="long"/>
						</c:catch>
						<c:if test="${empty date}">
							<c:catch>
								<fmt:parseDate parseLocale="${dateLocale}" var="date" value="${itemInventory.availabilityDateTime}" pattern="yyyy-MM-dd'T'HH:mm:ss'Z'" timeZone="GMT" dateStyle="long"/>
							</c:catch>
						</c:if>
						<fmt:formatDate var="availableDate" value="${date}"/>
					</c:when>
					<c:otherwise>
						<c:set var="availableDate" value=""/>
					</c:otherwise>
				</c:choose>
				<c:choose>
					<c:when test="${empty itemInventory.inventoryStatus}">
						<c:set var="inventoryStatus" value="NA"/>
						<fmt:message key="INV_STATUS_NA" var="inventoryStatusText"/>
						<fmt:message key="IMG_NAME_NA" var="imageName"/>
						<fmt:message key="IMG_INV_STATUS_NA" var="altText"/>
					</c:when>
					<c:otherwise>
						<c:set var="inventoryStatus" value="${itemInventory.inventoryStatus.name}"/>
						<fmt:message key="INV_STATUS_${itemInventory.inventoryStatus.name}" var="inventoryStatusText"/>
						<fmt:message key="IMG_NAME_${itemInventory.inventoryStatus.name}" var="imageName"/>
						<fmt:message key="IMG_INV_STATUS_${itemInventory.inventoryStatus.name}" var="altText"/>
					</c:otherwise>
				</c:choose>
				<c:if test="${!empty physicalStores}">
					<c:set var="physicalStores" value="${physicalStores},"/>
				</c:if>
				<c:set var="physicalStores" value="${physicalStores}{
					id: '${itemInventory.inventoryAvailabilityIdentifier.externalIdentifier.physicalStoreIdentifier.uniqueID}',
					name: '${fn:escapeXml(itemInventory.inventoryAvailabilityIdentifier.externalIdentifier.physicalStoreIdentifier.externalIdentifier)}', 
					status: '${inventoryStatus}',
					statusText: '${fn:escapeXml(inventoryStatusText)}',
					image: '${jspStoreImgDir}${env_vfileColor}widget_product_info/${imageName}',
					altText: '${fn:escapeXml(altText)}',
					availableDate: '${availableDate}',
					availableQuantity: '${itemInventory.availableQuantity.value}'}"/>
				<%-- Stores the physical store name and the status in the inStoreInventoryNameMap and inStoreInventoryStatusMap --%>
				<c:set target="${inStoreInventoryNameMap}" property="${itemInventory.inventoryAvailabilityIdentifier.externalIdentifier.physicalStoreIdentifier.uniqueID}" value="${itemInventory.inventoryAvailabilityIdentifier.externalIdentifier.physicalStoreIdentifier.externalIdentifier}"/>
				<c:set target="${inStoreInventoryStatusMap}" property="${itemInventory.inventoryAvailabilityIdentifier.externalIdentifier.physicalStoreIdentifier.uniqueID}" value="${inventoryStatus}"/>
			</c:when>
		</c:choose>
	</c:forEach>
</c:if>
<%-- Pick 'Select Store' message if no physical store currently picked. Pick 'Change Store' if some physical store is picked already.  --%>
<c:choose>
	<c:when test="${storeCounter eq 0}">
		<fmt:message key="INV_STATUS_CHECK_IN_STORES" var="invStatusCheckStores"/>
	</c:when>
	<c:otherwise>
		<fmt:message key="INV_STATUS_CHECK_OTHER_STORES" var="invStatusCheckStores"/>
	</c:otherwise>
</c:choose>

<%-- Pick the category ids--%>
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

<%-- Store Locator URL --%>
<wcf:url var="StoreLocatorView" value="AjaxStoreLocatorDisplayView">
	<wcf:param name="langId" value="${langId}" />
	<wcf:param name="storeId" value="${storeId}" />
	<wcf:param name="catalogId" value="${catalogId}" />
	<wcf:param name="top_category" value="${top_category}" />
	<wcf:param name="parent_category_rn" value="${parent_category_rn}" />
	<wcf:param name="categoryId" value="${categoryId}" />
	<wcf:param name="fromPage" value="InventoryStatus" />
</wcf:url>


<%-- Keep the store specific parameters like storeId, catalogId and langId in json object format --%>
<c:set var="storeParams" value="{storeId: '${fn:escapeXml(storeId)}',catalogId: '${fn:escapeXml(catalogId)}',langId: '${fn:escapeXml(langId)}'}"/>