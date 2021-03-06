
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

<c:set var="productId" value="${WCParam.productId}" />


<c:if test="${!empty productId}">
	<%-- Try to get it from our internal hashMap --%>
	<c:set var="key1" value="${productId}+getCatalogEntryViewAllByID"/>
	<c:set var="catalogEntryDetails" value="${cachedCatalogEntryDetailsMap[key1]}"/>
	<c:if test="${empty catalogEntryDetails}">
		<wcf:getData type="com.ibm.commerce.catalog.facade.datatypes.CatalogNavigationViewType" var="catalogNavigationView" 
			expressionBuilder="getCatalogEntryViewAllByID" varShowVerb="showCatalogNavigationView" maxItems="1" recordSetStartNumber="0">
			<wcf:param name="UniqueID" value="${productId}"/>
			<wcf:contextData name="storeId" data="${storeId}" />
			<wcf:contextData name="catalogId" data="${catalogId}" />
		</wcf:getData>
		<wcf:set target = "${cachedCatalogEntryDetailsMap}" key="${key1}" value="${catalogNavigationView.catalogEntryView[0]}"/>
	</c:if>
</c:if>

<c:if test="${empty productId && !empty WCParam.partNumber}">
		<c:set var="key1" value="${WCParam.partNumber}+getCatalogEntryViewAllByPartnumber"/>
		<c:set var="catalogEntryDetails" value="${cachedCatalogEntryDetailsMap[key1]}"/>
		<c:if test="${empty catalogEntryDetails}">
			<wcf:getData type="com.ibm.commerce.catalog.facade.datatypes.CatalogNavigationViewType" var="catalogNavigationView" 
				expressionBuilder="getCatalogEntryViewAllByPartnumber" varShowVerb="showCatalogNavigationView" maxItems="1" recordSetStartNumber="0">
				<wcf:param name="PartNumber" value="${WCParam.partNumber}" />
				<wcf:contextData name="storeId" data="${storeId}" />
				<wcf:contextData name="catalogId" data="${catalogId}" />
			</wcf:getData>
			<c:set var="catalogEntryDetails" value="${catalogNavigationView.catalogEntryView[0]}"/>
			<wcf:set target = "${cachedCatalogEntryDetailsMap}" key="${key1}" value="${catalogNavigationView.catalogEntryView[0]}"/>
		</c:if>
</c:if>

<c:if test="${!empty catalogNavigationView && !empty catalogNavigationView.catalogEntryView[0]}">
	<c:set var="catalogEntryDetails" value="${catalogNavigationView.catalogEntryView[0]}"/>
	<c:set property="productId" value="${catalogEntryDetails.uniqueID}" target="${WCParam}"/>
	<c:set var="productId" value="${WCParam.productId}" />
</c:if>




<c:set var="catalogEntryID" value="${catalogEntryDetails.uniqueID}" />
<c:set var="shortDescription" value="${catalogEntryDetails.shortDescription}" />
<c:set var="entitledItems" value="${catalogEntryDetails.SKUs}"/>
<c:set var="numberOfSKUs" value="${catalogEntryDetails.numberOfSKUs}"/>
<c:set var="fullImageAltDescription" value="${catalogEntryDetails.fullImageAltDescription}" />
<c:if test="${numberOfSKUs eq 1}">
	<c:set var="firstItemID" value="${entitledItems[0].uniqueID}"/>
</c:if>
<c:set var="attachments" value="${catalogEntryDetails.attachments}" />

<c:set var="type" value="product" />

<c:forEach var="metadata" items="${catalogEntryDetails.metaData}" varStatus="status2">
	<c:if test="${metadata.key == 'ThumbnailPath'}">
		<c:set var="thumbNail" value="${env_imageContextPath}/${metadata.value}" />
	</c:if>			
	<c:if test="${metadata.key == 'FullImagePath'}">
		<c:set var="fullImage" value="${env_imageContextPath}/${metadata.value}" />
	</c:if>
</c:forEach>

<%--
Variable for Flex Flow options
--%>
<c:set var="miniShopCartEnabled" value="false"/>
<flow:ifEnabled feature="miniShopCart">
	<c:set var="miniShopCartEnabled" value="true"/>
</flow:ifEnabled>

<c:set var="compareEnabled" value="false"/>
<flow:ifEnabled feature="ProductCompare">
	<c:set var="compareEnabled" value="true"/>
</flow:ifEnabled>

<c:set var="addProductDnD" value="false"/>
<flow:ifEnabled feature="ProductDnD">
	<c:if test="${miniShopCartEnabled || compareEnabled}">
		<c:set var="addProductDnD" value="true"/>
	</c:if>
</flow:ifEnabled>
<%--
End
--%>

<c:set var="patternName" value="ProductURLWithParentCategory"/>
<c:if test="${WCParam.categoryId != WCParam.top_category}">
	<c:set var="patternName" value="ProductURLWithParentAndTopCategory"/>
</c:if>
<wcf:url var="productDisplayUrl" patternName="${patternName}" value="Product2">
	<wcf:param name="catalogId" value="${WCParam.catalogId}"/>
	<wcf:param name="storeId" value="${WCParam.storeId}"/>
	<wcf:param name="productId" value="${catalogEntryID}"/>
	<wcf:param name="langId" value="${WCParam.langId}"/>
	<wcf:param name="parent_category_rn" value="${WCParam.categoryId}"/>
	<wcf:param name="categoryId" value="${WCParam.categoryId}"/>
	<wcf:param name="top_category" value="${WCParam.top_category}"/>
	<wcf:param name="urlLangId" value="${urlLangId}" />
</wcf:url>

<c:choose>
	<c:when test="${!empty fullImage}">
		<c:set var="productFullImage" value="${fullImage}"/>
	</c:when>
	<c:otherwise>
		<c:set var="productFullImage" value="${hostPath}${jspStoreImgDir}images/NoImageIcon.jpg"/>
	</c:otherwise>
</c:choose>

<c:set var="productImage" value="${fn:replace(productFullImage, productMasterImage, productPageImage)}" />

<c:if test="${!empty catalogEntryID}">
	<c:choose>
		<c:when test="${numberOfSKUs > 1}">
			<c:set var="dragType" value="product"/>
			<c:set var="dnd_catalogEntryID" value="${catalogEntryID}"/>
		</c:when>
		<c:otherwise>
			<c:set var="dragType" value="item"/>
			<c:set var="dnd_catalogEntryID" value="${firstItemID}"/>
		</c:otherwise>
	</c:choose>
</c:if>

<jsp:useBean id="angleThumbnailAttachmentMap" class="java.util.HashMap" type="java.util.Map"/>
<jsp:useBean id="angleThumbnailAttachmentShortDescMap" class="java.util.HashMap" type="java.util.Map"/>	
<jsp:useBean id="angleFullImageAttachmentMap" class="java.util.HashMap" type="java.util.Map"/>		

<c:set var="thumbnailCount" value="1" />
<c:set var="fullImageCount" value="1" />
<c:forEach  var="attachment" items="${attachments}">
		<c:if test="${'IMAGE_SIZE_40' eq attachment.usage}">
			<c:set var="image40Attachment" value="${attachment}" />
		</c:if>
		<c:if test="${'ANGLEIMAGES_THUMBNAIL' eq attachment.usage}">
			<c:set target="${angleThumbnailAttachmentMap}" property="${thumbnailCount}" value="${attachment.attachmentAssetPath}"/>
			<c:set var="thumbnailCount" value="${thumbnailCount + 1}" />
			<c:forEach var="metaData" items="${attachment.metaData}">
				<c:if test="${metaData.typedKey == 'shortdesc'}">
					<c:set target="${angleThumbnailAttachmentShortDescMap}" property="${thumbnailCount}" value="${metaData.typedValue}"/>
				</c:if>
			</c:forEach> 
		</c:if>
		<c:if test="${'ANGLEIMAGES_FULLIMAGE' eq attachment.usage}">
			<c:set target="${angleFullImageAttachmentMap}" property="${fullImageCount}" value="${attachment.attachmentAssetPath}"/>
			<c:set var="fullImageCount" value="${fullImageCount + 1}" />
		</c:if>
		
</c:forEach>

<c:choose>
	<c:when test="${!empty image40Attachment}">
		<c:set var="productCompareImagePath" value="${env_imageContextPath}/${image40Attachment.attachmentAssetPath}" />
	</c:when>
	<c:when test="${!empty thumbNail}">
		<c:set var="productCompareImagePath" value="${objectPath}${thumbNail}" />
	</c:when>
	<c:otherwise>
		<c:set var="productCompareImagePath" value="${jspStoreImgDir}images/NoImageIcon_sm45.jpg" />
	</c:otherwise>
</c:choose>

<c:set var="compareImageDescription" value="${fn:replace(shortDescription, search, replaceCmprStr)}"/>
<c:set var="compareImageDescription" value="${fn:replace(compareImageDescription, search01, replaceCmprStr)}"/>
