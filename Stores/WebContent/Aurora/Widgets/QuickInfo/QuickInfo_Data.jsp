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
<c:set var="singleQuote" value="'"/>
<c:set var="escapeSingleQuote" value="\\'"/>
<c:set var="doubleQuote" value='"'/>
<c:set var="escapeDoubleQuote" value="inches"/>
<c:set var="inches" value="inches"/>

<wcf:getData type="com.ibm.commerce.catalog.facade.datatypes.CatalogNavigationViewType" var="catalogNavigationView" 
	expressionBuilder="getCatalogEntryViewAllByID" maxItems="1" recordSetStartNumber="0">
	<wcf:param name="UniqueID" value="${param.productId}"/>
	<wcf:contextData name="storeId" data="${storeId}" />
	<wcf:contextData name="catalogId" data="${catalogId}" />
</wcf:getData>

<c:if test="${!empty catalogNavigationView && !empty catalogNavigationView.catalogEntryView[0]}">
	<c:set var="catalogEntryDetails" value="${catalogNavigationView.catalogEntryView[0]}"/>
</c:if>

<c:set var="name" value="${fn:escapeXml(catalogEntryDetails.name)}" />
<c:set var="fullImageAltDescription" value="${catalogEntryDetails.fullImageAltDescription}" />
<c:set var="actualType" value="${fn:toLowerCase(catalogEntryDetails.catalogEntryTypeCode)}" />
<c:set var="type" value="${fn:replace(actualType,'bean','')}" />
<c:set var="displayPriceRange" value="true" />
<c:set var="partNumber" value="${fn:escapeXml(catalogEntryDetails.partNumber)}" />
<c:set var="longDescription" value="${catalogEntryDetails.longDescription}" />
<c:set var="entitledItems" value="${catalogEntryDetails.SKUs}"/>
<c:set var="numberOfSKUs" value="${catalogEntryDetails.numberOfSKUs}"/>

<c:forEach var="metadata" items="${catalogEntryDetails.metaData}" varStatus="status2">		
	<c:if test="${metadata.key == 'FullImagePath'}">
		<c:set var="fullImage" value="${env_imageContextPath}/${metadata.value}" />
	</c:if>
</c:forEach>

<c:choose>
	<c:when test="${!empty fullImage}">
		<c:set var="productFullImage" value="${fullImage}"/>
	</c:when>
	<c:otherwise>
		<c:set var="productFullImage" value="${hostPath}${jspStoreImgDir}images/NoImageIcon.jpg"/>
	</c:otherwise>
</c:choose>

<c:set var="quickInfoImageSource" value="${fn:replace(productFullImage, productMasterImage, quickInfoImage)}" />


<jsp:useBean id="angleThumbnailAttachmentMap" class="java.util.HashMap" type="java.util.Map"/>
<jsp:useBean id="angleThumbnailAttachmentShortDescMap" class="java.util.HashMap" type="java.util.Map"/>	
<jsp:useBean id="angleFullImageAttachmentMap" class="java.util.HashMap" type="java.util.Map"/>		
<jsp:useBean id="validTimePeriodAttrValues" class="java.util.HashMap" type="java.util.Map"/>

<c:set var="thumbnailCount" value="1" />
<c:set var="fullImageCount" value="1" />
<c:forEach  var="attachment" items="${catalogEntryDetails.attachments}">
		<c:if test="${'ANGLEIMAGES_THUMBNAIL' eq attachment.usage}">
			<c:set target="${angleThumbnailAttachmentMap}" property="${thumbnailCount}" value="${staticAssetContextRoot}/${attachment.attachmentAssetPath}"/>
			<c:set var="thumbnailCount" value="${thumbnailCount + 1}" />
			<c:forEach var="metaData" items="${attachment.metaData}">
				<c:if test="${metaData.typedKey eq 'shortdesc'}">
					<c:set target="${angleThumbnailAttachmentShortDescMap}" property="${thumbnailCount}" value="${metaData.typedValue}"/>
				</c:if>
			</c:forEach> 
		</c:if>
		<c:if test="${'ANGLEIMAGES_FULLIMAGE' eq attachment.usage}">
			<c:set target="${angleFullImageAttachmentMap}" property="${fullImageCount}" value="${staticAssetContextRoot}/${attachment.attachmentAssetPath}"/>
			<c:set var="fullImageCount" value="${fullImageCount + 1}" />
		</c:if>
</c:forEach>

<c:set var="skus" value=""/>
<c:if test="${type == 'product'}">
	<c:if test="${!empty entitledItems}">
	<wcf:getData type="com.ibm.commerce.catalog.facade.datatypes.CatalogNavigationViewType" var="itemDetails" 
		expressionBuilder="getCatalogEntryViewDetailsWithAttachmentsByID" varShowVerb="showCatalogNavigationView" recordSetStartNumber="0">
		<c:forEach var='entitledItem' items='${entitledItems}' varStatus='outerStatus'>
			<wcf:param name="UniqueID" value="${entitledItem.uniqueID}"/>
		</c:forEach>
		<wcf:contextData name="storeId" data="${storeId}" />
		<wcf:contextData name="catalogId" data="${catalogId}" />
	</wcf:getData>
	</c:if>

	<c:forEach var='entitledItem' items='${itemDetails.catalogEntryView}' varStatus='outerStatus'>
		<c:if test="${!empty skus}">
			<c:set var="skus" value="${skus},"/>
		</c:if>
		
		<c:set var="attributes" value=""/>
		<c:forEach var="definingAttrValue" items="${entitledItem.attributes}" varStatus="innerStatus">
			<c:choose>
				<c:when test="${definingAttrValue.identifier == env_subsFulfillmentFrequencyAttrName}">
					<c:set var="fulfillmentFrequency" value="${definingAttrValue.values[0].value}"/>
					<c:set var="fulfillmentFrequencyAttrName" value="${definingAttrValue.name}"/>
				</c:when>
				<c:when test="${definingAttrValue.identifier == env_subsPaymentFrequencyAttrName}">
					<c:set var="paymentFrequency" value="${definingAttrValue.values[0].value}"/>
					<c:set var="paymentFrequencyAttrName" value="${definingAttrValue.name}"/>
				</c:when>
				<c:when test="${definingAttrValue.identifier == env_subsTimePeriodAttrName}">
					<c:set var="aValidTimePeriod" value="${definingAttrValue.values[0].value}"/>
					<c:set property="${definingAttrValue.values[0].value}" value="${definingAttrValue.values[0].value}" target="${validTimePeriodAttrValues}"/>	
				</c:when>
			</c:choose>
			<c:if test="${definingAttrValue.usage eq 'Defining'}">
				<c:if test="${!empty attributes}">
					<c:set var="attributes" value="${attributes},"/>
				</c:if>
				<c:set var="attributes" value="${attributes}'${definingAttrValue.name}': '${fn:replace(fn:replace(definingAttrValue.values[0].value, singleQuote, escapeSingleQuote), doubleQuote, escapeDoubleQuote)}'"/>
			</c:if>
		</c:forEach>
		
		<c:set var="thumbnailAttachments" value=""/>
		<c:set var="fullImageAttachments" value=""/>
		<c:forEach var="attachment" items="${entitledItem.attachments}" varStatus="innerStatus">
			<c:choose>
				<c:when test="${attachment.usage == 'ANGLEIMAGES_THUMBNAIL'}">
					<c:if test="${!empty thumbnailAttachments}">
						<c:set var="thumbnailAttachments" value="${thumbnailAttachments},"/>
					</c:if>
					<c:set var="thumbnailAttachments" value="${thumbnailAttachments}{path:'${staticAssetContextRoot}/${attachment.attachmentAssetPath}'}"/>
				</c:when>
				<c:when test="${attachment.usage == 'ANGLEIMAGES_FULLIMAGE'}">
					<c:if test="${!empty fullImageAttachments}">
						<c:set var="fullImageAttachments" value="${fullImageAttachments},"/>
					</c:if>
					<c:set var="fullImageAttachments" value="${fullImageAttachments}{path:'${staticAssetContextRoot}/${attachment.attachmentAssetPath}'}"/>
				</c:when>
			</c:choose>
		</c:forEach>
		<c:set var="skus" value="${skus}{id: '${entitledItem.uniqueID}', attributes: {${attributes}}, 
			thumbnailAttachments: [${thumbnailAttachments}], fullImageAttachments: [${fullImageAttachments}]}"/>
	</c:forEach>
</c:if>

<%-- 
***
*	Start: Product Descriptive and Defining Attributes
* 	
* Defining attributes are properties of SKUs.  They are used for SKU resolution.
***
--%>

<wcf:useBean var="descriptiveAttributeMap" classname="java.util.HashMap"/>

<wcf:useBean var="subsFulfillmentFrequencyAttrList" classname="java.util.ArrayList"/>

<wcf:useBean var="subsPaymentFrequencyAttrList" classname="java.util.ArrayList"/>

<wcf:useBean var="subsTimePeriodAttrList" classname="java.util.ArrayList"/>

<wcf:useBean var="swatchAttrList" classname="java.util.ArrayList"/>

<wcf:useBean var="definingAttributeList" classname="java.util.ArrayList"/>

<wcf:useBean var="dynamicKitComponentList" classname="java.util.ArrayList"/>

<c:if test="${numberOfSKUs eq 1}">
	<%-- 
	If there is only one SKU then let's just display the attributes of the one item as text without selection.
	--%>
	<c:forEach var="attribute" items="${entitledItems[0].attributes}">
		<c:if test="${attribute.usage eq 'Defining'}">
			<c:choose>
				<c:when test="${attribute.identifier eq env_subsTimePeriodAttrName}">
					<c:set var="isValidValue" value="false"/>
					<c:forEach var="validValue" items="${validTimePeriodAttrValues}">
						<c:if test="${attribute.values[0].value == validValue.value}">
							<c:set var="isValidValue" value="true"/>
						</c:if>
					</c:forEach>
					
					<c:set var="attributeUOMKey" value="QI_ATTR_UOM_ANN" />
					<c:forEach var="extValue" items="${attribute.values[0].extendedValue}">
						<c:if test="${extendedValue.key == 'UnitOfMeasure'}">
							<c:set var="attributeUOMKey" value="QI_ATTR_UOM_${extValue.value}" />
						</c:if>
					</c:forEach>
					<fmt:message var="displayValue" key="${attributeUOMKey}" >
						<fmt:param value="${attribute.values[0].value}" />
					</fmt:message>
					
					<c:if test="${isValidValue}">
						<wcf:useBean var="listValues" classname="java.util.ArrayList" capacity="3"/>
						<wcf:set target="${listValues}" value="${fn:replace(attribute.name, singleQuote, escapeSingleQuote)}" />
						<wcf:set target="${listValues}" value="${fn:replace(attribute.values[0].value, singleQuote, escapeSingleQuote)}" />
						<wcf:set target="${listValues}" value="${fn:replace(displayValue, singleQuote, escapeSingleQuote)}" />
						<wcf:set target="${definingAttributeList}" value="${listValues}" />
						<c:remove var="listValues"/>
					</c:if>
				</c:when>
				<c:when test="${(attribute.identifier ne env_subsFulfillmentFrequencyAttrName) and (attribute.identifier ne env_subsPaymentFrequencyAttrName)}">
					<wcf:useBean var="listValues" classname="java.util.ArrayList" capacity="2"/>
					<wcf:set target="${listValues}" value="${fn:replace(attribute.name, singleQuote, escapeSingleQuote)}" />
					<wcf:set target="${listValues}" value="${fn:replace(attribute.values[0].value, singleQuote, escapeSingleQuote)}" />
					<wcf:set target="${definingAttributeList}" value="${listValues}" />
					<c:remove var="listValues"/>
				</c:when>
			</c:choose>
		</c:if>
	</c:forEach>
</c:if>

<c:forEach var="attribute" items="${catalogEntryDetails.attributes}" varStatus="aStatus">
	<c:if test="${ attribute.usage eq 'Descriptive' and attribute.displayable}" >
		<c:if test="${!fn:startsWith(attribute.identifier,'ribbonad')}">
			<c:set var="attrValue" value=""/>
			<c:forEach items="${attribute.values}" var="value">
				<c:if test="${not empty attrValue}">
					<c:set var="attrValue" value="${attrValue}, "/>
				</c:if>
				<c:set var="attrValue" value="${attrValue}${value.value}"/>
			</c:forEach>
			<wcf:set target="${descriptiveAttributeMap}" key="${attribute.name}" value="${attrValue}"/>
		</c:if>
	</c:if>
	<c:if test="${ attribute.usage eq 'Defining' and numberOfSKUs gt 1}" >
		<c:set var="swatchEnabled" value="false"/>
		<c:forEach var="attrValue" items="${attribute.values}">
			<c:forEach var="attrExtValue" items="${attrValue.extendedValue}">
				<c:if test="${attrExtValue.key == 'Image1'}">
						<c:if test="${!empty attrExtValue.value}">
							<c:set var="swatchEnabled" value="true"/>
						</c:if>
				</c:if>
			</c:forEach>										
		</c:forEach>
		<c:choose>
			<c:when test="${attribute.identifier == env_subsFulfillmentFrequencyAttrName}">
				<wcf:useBean var="listValues" classname="java.util.ArrayList" capacity="3"/>
				<wcf:set target="${listValues}" value="${fn:replace(attribute.name, singleQuote, escapeSingleQuote)}"/>
				<wcf:set target="${listValues}" value="${fn:replace(fulfillmentFrequency, singleQuote, escapeSingleQuote)}"/>		
				<wcf:set target="${subsFulfillmentFrequencyAttrList}" value="${listValues}" />
				<c:remove var="listValues"/>
			</c:when>
			<c:when test="${attribute.identifier == env_subsPaymentFrequencyAttrName}">
				<wcf:useBean var="listValues" classname="java.util.ArrayList" capacity="3"/>
				<wcf:set target="${listValues}" value="${fn:replace(attribute.name, singleQuote, escapeSingleQuote)}"/>
				<wcf:set target="${listValues}" value="${fn:replace(paymentFrequency, singleQuote, escapeSingleQuote)}"/>
				<wcf:set target="${subsPaymentFrequencyAttrList}" value="${listValues}" />
				<c:remove var="listValues"/>
			</c:when>
			<c:when test="${attribute.identifier == env_subsTimePeriodAttrName}">
				<wcf:useBean var="values" classname="java.util.ArrayList"/>
				<wcf:useBean var="displayValues" classname="java.util.ArrayList" />
				<wcf:useBean var="listValues" classname="java.util.ArrayList" capacity="3"/>
				<c:forEach var="allowedValue" items="${attribute.values}" varStatus="vStatus">
					<c:set var="isValidValue" value="false"/>
					<c:forEach var="validValue" items="${validTimePeriodAttrValues}">
						<c:if test="${allowedValue.value == validValue.value}">
							<c:set var="isValidValue" value="true"/>
						</c:if>
					</c:forEach>
					
					<c:set var="attributeUOMKey" value="QI_ATTR_UOM_ANN" />
					<c:forEach var="extValue" items="${allowedValue.extendedValue}">
						<c:if test="${extendedValue.key == 'UnitOfMeasure'}">
							<c:set var="attributeUOMKey" value="QI_ATTR_UOM_${extValue.value}" />
						</c:if>
					</c:forEach>
					<fmt:message var="displayValue" key="${attributeUOMKey}" >
						<fmt:param value="${allowedValue.value}" />
					</fmt:message>
					
					<c:if test="${isValidValue}">
						<wcf:set target="${values}" value="${fn:replace(allowedValue.value, singleQuote, escapeSingleQuote)}" />
						<wcf:set target="${displayValues}" value="${fn:replace(displayValue, singleQuote, escapeSingleQuote)}" />
					</c:if>
				</c:forEach>
				
				<wcf:set target="${listValues}" value="${fn:replace(attribute.name, singleQuote, escapeSingleQuote)}"/>
				<wcf:set target="${listValues}" value="${values}"/>
				<wcf:set target="${listValues}" value="${displayValues}"/>
				<wcf:set target="${subsTimePeriodAttrList}" value="${listValues}" />
				<c:remove var="values" />
				<c:remove var="displayValues" />
				<c:remove var="listValues" />
			</c:when>
			<c:when test="${swatchEnabled}">
				<wcf:useBean var="swatchValues" classname="java.util.ArrayList" />
				<wcf:useBean var="swatchImages" classname="java.util.ArrayList" />
				<wcf:useBean var="listValues" classname="java.util.ArrayList" capacity="3"/>
				<c:set var="attributeCount" value="${fn:length(catalogEntryDetails.attributes)}"/>
				<c:if test="${attributeCount > 1 && aStatus.count == 1}">
					<c:set var="doNotDisable" value="${fn:replace(attribute.name, singleQuote, escapeSingleQuote)}"/>
				</c:if>

				<c:forEach var="swatchValue" items="${attribute.values}">
					<c:forEach var="swatchExtValue" items="${swatchValue.extendedValue}">
						<c:if test="${swatchExtValue.key == 'Image1Path'}">
							<wcf:set target="${swatchValues}" value="${fn:replace(swatchValue.value, singleQuote, escapeSingleQuote)}" />
							<wcf:set target="${swatchImages}" value="${env_imageContextPath}/${swatchExtValue.value}" />
						</c:if>
					</c:forEach>										
				</c:forEach>
				
				<wcf:set target="${listValues}" value="${fn:replace(attribute.name, singleQuote, escapeSingleQuote)}"/>
				<wcf:set target="${listValues}" value="${swatchValues}"/>
				<wcf:set target="${listValues}" value="${swatchImages}"/>				
				<wcf:set target="${swatchAttrList}" value="${listValues}" />
				<c:remove var="swatchValues" />
				<c:remove var="swatchImages" />
				<c:remove var="listValues" />
			</c:when>
			<c:otherwise>
				<wcf:useBean var="attributeValues" classname="java.util.ArrayList" />
				<c:forEach var="allowedValue" items="${attribute.values}">
					<wcf:set target="${attributeValues}" value="${fn:replace(allowedValue.value, singleQuote, escapeSingleQuote)}" />
				</c:forEach>
				<wcf:useBean var="listValues" classname="java.util.ArrayList" capacity="3"/>
				<wcf:set target="${listValues}" value="${fn:replace(attribute.name, singleQuote, escapeSingleQuote)}" />
				<wcf:set target="${listValues}" value="${attributeValues}" />
				<wcf:set target="${definingAttributeList}" value="${listValues}" />
				<c:remove var="attributeValues" />
				<c:remove var="listValues" />
			</c:otherwise>
		</c:choose>
	</c:if>
</c:forEach>

<%-- 
***
*	End: Product Descriptive and Defining Attributes
***
--%>
			
<%-- product url --%>
<wcf:url var="catalogEntryUrl" patternName="ProductURL" value="Product2">
	<wcf:param name="catalogId" value="${catalogId}"/>
	<wcf:param name="storeId" value="${storeId}"/>
	<wcf:param name="productId" value="${param.productId}"/>
	<wcf:param name="langId" value="${langId}"/>
	<wcf:param name="errorViewName" value="ProductDisplayErrorView"/>
	<wcf:param name="urlLangId" value="${urlLangId}" />
</wcf:url>

<%-- Keep the store specific parameters like storeId, catalogId and langId in json object format --%>
<c:set var="storeParams" value="{storeId: '${storeId}',catalogId: '${catalogId}',langId: '${langId}'}"/>

<%-- Hide the purchase section if the catalog entry is a bundle--%>
<c:set var="purchase_section" value=""/>
<c:if test="${type eq 'bundle'}">
	<c:set var="purchase_section" value="display:none;"/>
</c:if>

<c:if test="${type eq 'dynamickit'}">
	<c:set var="isDKConfigurable" value="${!empty catalogEntryDetails.dynamicKitModelReference}"/>
	<c:if test="${empty isDKConfigurable}">
		<c:set var="isDKConfigurable" value="true"/>
	</c:if>

	<c:if test="${empty isDKPreConfigured}">
		<%-- determine if the kit is pre-configured or not --%>
		<c:set var="isDKPreConfigured" value="${catalogEntryDetails.dynamicKitDefaultConfigurationComplete}"/>
	</c:if>
	
	<c:forEach items="${catalogEntryDetails.components}" var="component">
		<c:choose>
			<c:when test="${not empty component.catalogEntryView.shortDescription}">
				<c:set var="componentDescription" value="${component.catalogEntryView.shortDescription}"/>
			</c:when>
			<c:when test="${not empty component.catalogEntryView.name}">
				<c:set var="componentDescription" value="${component.catalogEntryView.name}"/>
			</c:when>
		</c:choose>
		<fmt:formatNumber var="componentQty" value="${component.quantity}" type="number" maxFractionDigits="0"/>
		<c:if test="${componentQty > 1}">
			<%-- output order item component quantity in the form of "5 x ComponentName" --%>
			<fmt:message var="componentDescription" key="ITEM_COMPONENT_QUANTITY_NAME" > 
				<fmt:param><c:out value="${componentQty}" escapeXml="false"/></fmt:param>
				<fmt:param><c:out value="${componentDescription}" escapeXml="false"/></fmt:param>
			</fmt:message>
		</c:if>
		<wcf:set target="${dynamicKitComponentList}" value="${componentDescription}" />
	</c:forEach>
	
	<c:set var="pageView" value="DynamicDisplayView" scope="request"/>
</c:if>

<c:forEach var="prices" items="${catalogEntryDetails.price}">
	<c:if test="${prices.priceUsage == 'Offer'}">
		<c:set var="maximumItemPrice" value="${prices.maximumValue.value}"/>
		<c:if test="${empty maximumItemPrice}">						
			<c:set var="maximumItemPrice" value="${prices.value.value}"/>
		</c:if>
	</c:if>
</c:forEach>

<%-- 
	Loop through all the SKUs and see if any one of them is marked 'buyable'. 
	Even if one of them is buyable, we show Add to Cart button.. Buyable flag set at product level is ignored 
--%>
<c:set var="available" value="false" scope="request"/> <%-- set default value to false --%>
<c:if test="${!empty maximumItemPrice}">
	<%-- We have price... Continue with other checks --%>
	<c:choose>
		<c:when test="${type eq 'bundle' or type eq 'package'}">
			<%--For bundle and package check the buyable flag at the bundle or pacakge level instead of looping through each individual components --%>
			<c:set var="available" value="${catalogEntryDetails.buyable}" scope="request"/>
		</c:when>
		<c:otherwise>
			<%-- It is not a Subscription item OR Subscription products with the well known 3 attributes set properly --%>
			<c:if test="${!isSubscription || (fulfillmentFrequency != '' && paymentFrequency != '' && aValidTimePeriod != '')}" >
				<c:choose>
					<%-- If it is a product iterate through all its SKUs --%>
					<c:when test="${type eq 'product'}">
						<c:forEach var="entitledItem" items="${entitledItems}">
							<c:if test = "${entitledItem.buyable eq 'true'}">
								<c:set var="available" value="true" scope="request"/> <%-- We have one item which is marked as buyable..Show AddToCart button --%>
							</c:if>
						</c:forEach>
					</c:when>
					<c:otherwise>
						<%-- Since it is an item, pick from buyable field --%>
						<c:set var="available" value="${catalogEntryDetails.buyable}" scope="request"/>
					</c:otherwise>
				</c:choose>
			</c:if>
		</c:otherwise>
	</c:choose>
</c:if>

<%-- For dynamic kit, check the buyable flag directly at the details level instead of looping through each individual components --%>
<c:if test="${type eq 'dynamickit'}">
	<c:set var="available" value="${catalogEntryDetails.buyable}" scope="request"/>
</c:if>

<c:set var="catEntryParams" value="{id: '${param.productId}', type: '${actualType}', skus: [${skus}]}"/>
<%-- if true, QuickInfo popup - update attributes will be enabled else, add to cart/wishlist feature --%>
<c:set var="updateAttributes" value="${not empty param.updateAttributes && param.updateAttributes == 'true'}"/>