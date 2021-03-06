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
<%-- Pick the productId from WCParam, if empty pick from param --%>
<c:set var="uniqueID" value="${WCParam.productId}"/>
<c:if test="${empty uniqueID}">
	<c:set var="uniqueID" value="${param.productId}"/>
</c:if>

<%-- Fetch the merchandising details using the storeId, catalogId and itemId --%>
<%-- Try to get it from our internal hashMap. If we have fetched the details with getCatalogEntryViewAllByID, then it will work for us --%>
<c:set var="key1" value="${uniqueID}+getCatalogEntryViewAllByID"/>
<c:set var="catalogEntryView" value="${cachedCatalogEntryDetailsMap[key1]}"/>
<c:if test="${empty catalogEntryView}">
	<wcf:getData
		type="com.ibm.commerce.catalog.facade.datatypes.CatalogNavigationViewType"
		var="targetCatalogNavigationView"
		expressionBuilder="getCatalogEntryViewDetailsWithMerchandisingAssociationsByID"
		maxItems="1" recordSetStartNumber="0">
		<wcf:param name="UniqueID" value="${uniqueID}" />
		<wcf:contextData name="storeId" data="${storeId}" />
		<wcf:contextData name="catalogId" data="${catalogId}" />
	</wcf:getData>
	<c:set var="catalogEntryView" value="${targetCatalogNavigationView.catalogEntryView[0]}"/>
	<%-- No need to set this in our internal cache. No one else will use the associations on the page --%>
</c:if>

<c:set var="merchandisingAssociations" value="${catalogEntryView.merchandisingAssociations}"/>
<c:set var="hasAssociations" value="${!empty merchandisingAssociations[0]}"/>
<c:set var="hasMultipleAssociations" value="${!empty merchandisingAssociations[1]}"/>

<c:if test="${hasAssociations}">
	<c:set var="catalogEntryName" value="${catalogEntryView.name}"/>
	<c:set var="catalogEntryThumbnail" value="${env_imageContextPath}/${catalogEntryView.metaData['ThumbnailPath']}" />
	<c:set var="firstMerchandisingAssociationName" value="${merchandisingAssociations[0].catalogEntryView.name}"/>
	<c:set var="firstMerchandisingAssociationID" value="${merchandisingAssociations[0].catalogEntryView.uniqueID}"/>
	<c:set var="firstMerchandisingAssociationShortDesc" value="${merchandisingAssociations[0].catalogEntryView.shortDescription}"/>
	<c:set var="firstMerchandisingAssociationThumbnail" value="${env_imageContextPath}/${merchandisingAssociations[0].catalogEntryView.metaData['ThumbnailPath']}" />

	<%-- 'L' stands form List price, pick the list price and offer price of the baseItem --%>
	<c:choose>
		<c:when test="${catalogEntryView.price[0].description eq 'L'}">
			<c:set var="baseItemListedPrice" value="${catalogEntryView.price[0].value.value}"/>
			<c:set var="baseItemOfferedPrice" value="${catalogEntryView.price[1].value.value}"/>
		</c:when>
		<c:otherwise>
			<c:set var="baseItemOfferedPrice" value="${catalogEntryView.price[0].value.value}"/>
			<c:set var="baseItemListedPrice" value="${catalogEntryView.price[1].value.value}"/>
		</c:otherwise>
	</c:choose>
	
	<%-- If the listed price is less than or equal to offered price, 
	then listed price should not be displayed --%>
	<c:if test="${firstListedCombinedTotal le firstOfferedCombinedTotal}">
		<c:set var="firstListedCombinedTotal" value=""/>
	</c:if>
	
	<%-- To hold the association in a map --%>
	<jsp:useBean id="merchandisingAssociationMap" class="java.util.LinkedHashMap" type="java.util.Map"/>
	
	<c:forEach var="merchandisingAssociation" items="${merchandisingAssociations}" varStatus="status">
		
		<%-- 'L' stands for list price, pick the list price of the merchandising association and add 
		it to the base item list price. Also pick the offer price of the merchandising association and 
		add it to the base item offer price to get the combined price. --%>
		<c:choose>
			<c:when test="${merchandisingAssociation.catalogEntryView.price[0].description eq 'L'}">
				<c:set var="listedCombinedPrice" value="${baseItemListedPrice + merchandisingAssociation.catalogEntryView.price[0].value.value}"/>
				<c:set var="offeredCombinedPrice" value="${baseItemOfferedPrice + merchandisingAssociation.catalogEntryView.price[1].value.value}"/>
			</c:when>
			<c:otherwise>
				<c:set var="offeredCombinedPrice" value="${baseItemOfferedPrice + merchandisingAssociation.catalogEntryView.price[0].value.value}"/>
				<c:set var="listedCombinedPrice" value="${baseItemListedPrice + merchandisingAssociation.catalogEntryView.price[1].value.value}"/>
			</c:otherwise>
		</c:choose>
		
		<%-- Formatting the price to display with currency symbol --%>
		<c:set var="lcPrice" value=""/>
		<c:if test="${listedCombinedPrice gt offeredCombinedPrice}">
			<fmt:formatNumber var="lcPrice" value="${listedCombinedPrice}" type="currency" currencySymbol="${env_CurrencySymbolToFormat}" maxFractionDigits="${env_currencyDecimal}"/>
		</c:if>
		<fmt:formatNumber var="ocPrice" value="${offeredCombinedPrice}" type="currency" currencySymbol="${env_CurrencySymbolToFormat}" maxFractionDigits="${env_currencyDecimal}"/>
		
		<%-- If the associated item is a ProductBean and it has only one SKU, then it is as good as ItemBean.
		So identify the uniqueID of the single SKU and mark it as ItemBean --%>
		<c:choose>
			<c:when test="${merchandisingAssociation.catalogEntryView.catalogEntryTypeCode eq 'ProductBean' and merchandisingAssociation.catalogEntryView.hasSingleSKU}">
				<c:set var="maUniqueID" value="${merchandisingAssociation.catalogEntryView.singleSKUCatalogEntryID}"/>
				<c:set var="type" value="ItemBean"/>
			</c:when>
			<c:otherwise>
				<c:set var="maUniqueID" value="${merchandisingAssociation.catalogEntryView.uniqueID}"/>
				<c:set var="type" value="${merchandisingAssociation.catalogEntryView.catalogEntryTypeCode}"/>
			</c:otherwise>
		</c:choose>
		<c:set var="componentItems" value=""/>
		<%-- If the associated item is a BundleBean, get the components forming this bundle --%>
		<c:if test="${type eq 'BundleBean'}">
			<%-- Fetch it from database. We will not save the associated items in the internal cache, since this is specific to this component and not expected to be reused across components --%>
			<wcf:getData
				type="com.ibm.commerce.catalog.facade.datatypes.CatalogNavigationViewType"
				var="bundleDetails"
				expressionBuilder="getCatalogEntryViewDetailsWithComponentsAndAttachmentsByID"
				maxItems="1" recordSetStartNumber="0">
				<wcf:param name="UniqueID" value="${maUniqueID}" />
				<wcf:contextData name="storeId" data="${WCParam.storeId}" />
				<wcf:contextData name="catalogId" data="${WCParam.catalogId}" />
			</wcf:getData>
			<c:forEach var="component" items="${bundleDetails.catalogEntryView[0].components}">
				<c:if test="${!empty componentItems}">
					<c:set var="componentItems" value="${componentItems},"/>
				</c:if>
				<%-- If the component inside the bundle is a ProductBean, pick the first SKU as the default --%>
				<c:choose>
					<c:when test="${component.catalogEntryView.catalogEntryTypeCode eq 'ProductBean'}">
						<c:set var="componentItems" value="${componentItems}{id: '${component.catalogEntryView.SKUs[0].uniqueID}', quantity: ${component.quantity}}"/>
					</c:when>
					<c:otherwise>
						<c:set var="componentItems" value="${componentItems}{id: '${component.catalogEntryView.uniqueID}', quantity: ${component.quantity}}"/>
					</c:otherwise>
				</c:choose>
			</c:forEach>
		</c:if>
		
		<%-- Associated items url --%>
		<wcf:url var="catalogEntryUrl" patternName="ProductURL" value="Product2">
			<wcf:param name="catalogId" value="${catalogId}"/>
			<wcf:param name="storeId" value="${storeId}"/>
			<wcf:param name="productId" value="${maUniqueID}"/>
			<wcf:param name="langId" value="${langId}"/>
			<wcf:param name="errorViewName" value="ProductDisplayErrorView"/>
			<wcf:param name="urlLangId" value="${urlLangId}" />
		</wcf:url>
		
		<%-- Pick the first combined prices and keep it to display initially --%>
		<c:if test="${status.count == 1}">
			<c:set var="firstListedCombinedTotal" value="${lcPrice}"/>
			<c:set var="firstOfferedCombinedTotal" value="${ocPrice}"/>
			<c:set var="firstMerchandisingAssociationUrl" value="${catalogEntryUrl}"/>
		</c:if>
		
		<%-- id, type, name, thumbnail, price and components are stored as json object 
		format against the uniqueID as key in the merchandisingAssociationMap --%>
		<c:set var="singleQuote" value="'"/>
		<c:set var="escapeSingleQuote" value="\\\\'"/>
		<c:set var="thumbnail" value="${env_imageContextPath}/${merchandisingAssociation.catalogEntryView.metaData['ThumbnailPath']}"/>
		<c:set target="${merchandisingAssociationMap}" property="${maUniqueID}" 
			value="{id: '${maUniqueID}',
					type: '${type}',
					name: '${fn:replace(merchandisingAssociation.catalogEntryView.name, singleQuote, escapeSingleQuote)}',
					shortDesc: '${fn:replace(merchandisingAssociation.catalogEntryView.shortDescription, singleQuote, escapeSingleQuote)}',
					thumbnail: '${fn:replace(thumbnail, singleQuote, escapeSingleQuote)}',
					url: '${fn:replace(catalogEntryUrl, singleQuote, escapeSingleQuote)}',
					listedCombinedPrice: '${lcPrice}',
					offeredCombinedPrice: '${ocPrice}',
					components: [${componentItems}],
					quantity: '${merchandisingAssociation.quantity}'}"/>
	</c:forEach>
	
	<%-- Keep the store specific parameters like storeId, catalogId and langId in json object format --%>
	<c:set var="storeParams" value="{storeId: '${fn:escapeXml(storeId)}',catalogId: '${fn:escapeXml(catalogId)}',langId: '${fn:escapeXml(langId)}'}"/>
	<c:set var="baseComponentItems" value=""/>
	<c:set var="skus" value=""/>
	<c:choose>
		<c:when test="${catalogEntryView.catalogEntryTypeCode eq 'ProductBean'}">
			<c:choose>
				<%-- If the base item is a ProductBean and it has only one SKU, then it is as good as ItemBean.
				So identify the uniqueID of the single SKU and mark it as ItemBean --%>
				<c:when test="${catalogEntryView.hasSingleSKU}">
					<c:set var="baseItemId" value="${catalogEntryView.singleSKUCatalogEntryID}"/>
					<c:set var="baseItemType" value="ItemBean"/>
				</c:when>
				<c:otherwise>
					<c:set var="baseItemId" value="${uniqueID}"/>
					<c:set var="baseItemType" value="${catalogEntryView.catalogEntryTypeCode}"/>
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
								<c:set var="attributes" value="${attributes}'${skuAttribute.name}': '${skuAttribute.values[0].value}'"/>
							</c:if>
						</c:forEach>
						<c:set var="skus" value="${skus}{id: '${sku.uniqueID}', attributes: {${attributes}}}"/>
					</c:forEach>
				</c:otherwise>
			</c:choose>
		</c:when>
		<%-- If the base item is a BundleBean, get the components forming this bundle --%>
		<c:when test="${catalogEntryView.catalogEntryTypeCode eq 'BundleBean'}">
			<c:set var="baseItemId" value="${uniqueID}"/>
			<c:set var="baseItemType" value="${catalogEntryView.catalogEntryTypeCode}"/>
			
			<%-- Look in our internal cached map. ALL will give us required data --%>
			<c:set var="key1" value="${uniqueID}+getCatalogEntryViewAllByID"/>
			<c:set var="catalogEntryView" value="${cachedCatalogEntryDetailsMap[key1]}"/>
			<c:if test="${empty catalogEntryView}">
				<%-- Look in our internal cached map for a particular expression builder --%>
				<c:set var="key1" value="${uniqueID}+getCatalogEntryViewDetailsWithComponentsAndAttachmentsByID"/>
				<c:set var="catalogEntryView" value="${cachedCatalogEntryDetailsMap[key1]}"/>
				<c:if test="${empty catalogEntryView}">
					
					<wcf:getData
						type="com.ibm.commerce.catalog.facade.datatypes.CatalogNavigationViewType"
						var="baseBundleDetails"
						expressionBuilder="getCatalogEntryViewDetailsWithComponentsAndAttachmentsByID"
						maxItems="1" recordSetStartNumber="0">
						<wcf:param name="UniqueID" value="${baseItemId}" />
						<wcf:contextData name="storeId" data="${WCParam.storeId}" />
						<wcf:contextData name="catalogId" data="${WCParam.catalogId}" />
					</wcf:getData>

					<c:set var="catalogEntryView" value="${baseBundleDetails.catalogEntryView[0]}"/>
					<wcf:set target = "${cachedCatalogEntryDetailsMap}" key="${key1}" value="${catalogEntryView}"/>
				</c:if>
			</c:if>
			
			
			<c:forEach var="component" items="${catalogEntryView.components}">
				<c:if test="${!empty baseComponentItems}">
					<c:set var="baseComponentItems" value="${baseComponentItems},"/>
				</c:if>
				<c:choose>
					<%-- If the bundle has a component which is a ProductBean, pick all the SKUs and default the id to the first SKU --%>
					<c:when test="${component.catalogEntryView.catalogEntryTypeCode eq 'ProductBean'}">
						<c:set var="componentSkuIds" value""/>
						<c:forEach var="componentSku" items="${component.catalogEntryView.SKUs}">
							<c:if test="${!empty componentSkuIds}">
								<c:set var="componentSkuIds" value="${componentSkuIds},"/>
							</c:if>
							<c:set var="componentSkuIds" value="${componentSkuIds}{id: '${componentSku.uniqueID}'}"/>
						</c:forEach>
						<c:set var="baseComponentItems" 
							value="${baseComponentItems}{id: '${component.catalogEntryView.SKUs[0].uniqueID}', 
														skus: [${componentSkuIds}],
														quantity: ${component.quantity}}"/>
					</c:when>
					<c:otherwise>
						<c:set var="baseComponentItems" value="${baseComponentItems}{id: '${component.catalogEntryView.uniqueID}', quantity: ${component.quantity}}"/>
					</c:otherwise>
				</c:choose>
			</c:forEach>
		</c:when>
		<c:otherwise>
			<c:set var="baseItemId" value="${uniqueID}"/>
			<c:set var="baseItemType" value="${catalogEntryView.catalogEntryTypeCode}"/>
		</c:otherwise>
	</c:choose>
	<c:set var="baseItemParams" value="{id: '${baseItemId}', type: '${baseItemType}', components: [${baseComponentItems}], skus: [${skus}]}"/>
</c:if>