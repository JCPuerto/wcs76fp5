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

<%-- START ProductDescription_Data.jsp --%>

<c:choose>
	<c:when test="${!empty param.productId}">
		<c:set var="productId" value="${param.productId}" />
	</c:when>
	<c:when test="${!empty WCParam.productId}">
		<c:set var="productId" value="${WCParam.productId}" />
	</c:when>
</c:choose>

<c:set var="search" value='"'/>
<c:set var="replaceCmprStr" value=""/>
<c:set var="search01" value="'"/>
<c:set var="replaceStr01" value="\\'"/>
<c:set var="replaceStr02" value="inches"/>


<c:if test="${empty catalogEntryDetails}">	
	<c:if test="${!empty productId}">
		<%-- Try to get it from our internal hashMap --%>
		<c:set var="key1" value="${productId}+getCatalogEntryViewAllByID"/>
		<c:set var="catalogEntryDetails" value="${cachedCatalogEntryDetailsMap[key1]}"/>
		<c:if test="${empty catalogEntryDetails}">
			<wcf:getData type="com.ibm.commerce.catalog.facade.datatypes.CatalogNavigationViewType" var="catalogNavigationView" 
				expressionBuilder="getCatalogEntryViewAllWithoutAttachmentsByID" varShowVerb="showCatalogNavigationView" maxItems="1" recordSetStartNumber="0">
				<wcf:param name="UniqueID" value="${productId}"/>
				<wcf:contextData name="storeId" data="${WCParam.storeId}" />
				<wcf:contextData name="catalogId" data="${WCParam.catalogId}" />
			</wcf:getData>
			<c:set var="catalogEntryDetails" value="${catalogNavigationView.catalogEntryView[0]}"/>
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
				<wcf:contextData name="storeId" data="${WCParam.storeId}" />
				<wcf:contextData name="catalogId" data="${WCParam.catalogId}" />
			</wcf:getData>
			<c:set var="catalogEntryDetails" value="${catalogNavigationView.catalogEntryView[0]}"/>
			<wcf:set target = "${cachedCatalogEntryDetailsMap}" key="${key1}" value="${catalogNavigationView.catalogEntryView[0]}"/>
		</c:if>
	</c:if>

	<c:if test="${!empty catalogNavigationView && !empty catalogNavigationView.catalogEntryView[0]}">
		<c:set var="catalogEntryDetails" value="${catalogNavigationView.catalogEntryView[0]}"/>
	</c:if>
</c:if>

<c:set var="type" value="${fn:toLowerCase(catalogEntryDetails.catalogEntryTypeCode)}" />
<c:set var="type" value="${fn:replace(type,'bean','')}" />
<c:set var="catalogEntryID" value="${catalogEntryDetails.uniqueID}" />
<c:set var="shortDescription" value="${catalogEntryDetails.shortDescription}" />
<c:set var="longDescription" value="${catalogEntryDetails.longDescription}" />
<c:set var="name" value="${catalogEntryDetails.name}" />
<c:set var="partnumber" value="${catalogEntryDetails.partNumber}" />
<c:set var="manufacturerName" value="${catalogEntryDetails.manufacturer}" />
<c:set var="entitledItems" value="${catalogEntryDetails.SKUs}"/>
<c:set var="numberOfSKUs" value="${catalogEntryDetails.numberOfSKUs}"/>
<c:set var="attributes" value="${catalogEntryDetails.attributes}"/>

<c:if test="${not empty param.displayAttachments and param.displayAttachments}">
	<wcf:useBean var="attachmentsList" classname="java.util.ArrayList"/>
	<c:forEach items="${catalogEntryDetails.attachments}" var="attachment">
		<c:set var="fetchAttachments" value="true" />
		<%-- if usage is specified, only display attachment of the specified usage. --%>
		<c:choose>
			<c:when test="${!empty param.usage}">
			    <c:if test="${param.usage ne attachment.usage}">
				    <c:set var="fetchAttachments" value="false" />
			    </c:if>
			</c:when>
			<c:when test="${!empty param.excludeUsageStr}">
				<%-- checks the usage type of this attachment and see if should exclude this attachment from display --%>
	            <c:forTokens items="${param.excludeUsageStr}" delims="," var="usageType">
				    <c:if test="${usageType == attachment.usage}">
					    <c:set var="fetchAttachments" value="false" />
				    </c:if>
			    </c:forTokens>
			</c:when>
		</c:choose>
			
		<c:if test="${fetchAttachments}">
			<c:set var="mimeType" value="${attachment.mimeType}" />
			<c:set var="mimePart" value="" />
		
			<c:forTokens items="${mimeType}" delims="/" var="mimePartFromType" end="0">
				<c:set var="mimePart" value="${mimePartFromType}" />
			</c:forTokens>
	    
			<c:set var="attachmentType" value="default"/>
			<c:if test="${not empty mimeType}">	
				<c:if test="${mimeType eq 'text/plain'}">
					<c:set var="attachmentType" value="text"/>
				</c:if>
				<c:if test="${mimeType eq 'image/gif' || mimeType eq 'image/jpeg' || mimeType eq 'image/png'}">
					<c:set var="attachmentType" value="image"/>
				</c:if>
				<c:if test="${mimeType eq 'application/pdf'}">
					<c:set var="attachmentType" value="pdf"/>
				</c:if>
				<c:if test="${mimeType eq 'application/postscript' || mimeType eq 'application/msword'}">
					<c:set var="attachmentType" value="doc"/>
				</c:if>
				<c:if test="${mimeType eq 'application/vnd.ms-powerpoint'}">
					<c:set var="attachmentType" value="presentation"/>
				</c:if>
				<c:if test="${mimeType eq 'application/vnd.ms-excel'}">
					<c:set var="attachmentType" value="spreadsheet"/>
				</c:if>
				<c:if test="${mimeType eq 'audio/x-wav' || mimeType eq 'audio/x-pn-realaudio' || mimeType eq 'audio/x-pn-realaudio-plugin'}">
					<c:set var="attachmentType" value="audio"/>
				</c:if>
				<c:if test="${mimeType eq 'video/mpeg' || mimeType eq 'video/quicktime'|| mimeType eq 'video/x-msvideo'|| mimeType eq 'application/x-shockwave-flash'}">
					<c:set var="attachmentType" value="video"/>
				</c:if>
				<c:if test="${mimeType eq 'application/x-gzip' || mimeType eq 'application/zip' || mimeType eq 'application/x-gtar' || mimeType eq 'application/x-tar' || mimeType eq 'application/java-archive'}">
					<c:set var="attachmentType" value="archive"/>
				</c:if>
			</c:if>
			<c:if test="${empty mimePart}">
				<c:set var="attachmentType" value="webpage"/>
			</c:if>
			<c:set var="attchImage" value="${jspStoreImgDir}${env_vfileColor}${attachmentType}_32.png" />
			
	 		<c:forEach var="metaData" items="${attachment.metaData}">
				<c:if test="${metaData.typedKey == 'name'}">
					<c:set var="attchName" value="${metaData.typedValue}" />
				</c:if>
				<c:if test="${metaData.typedKey == 'shortdesc'}">
					<c:set var="attchShortDesc" value="${metaData.typedValue}" />
					<c:set var="description" value="${attchShortDesc}"/>
				</c:if>
				<c:if test="${metaData.typedKey == 'longdesc'}">
					<c:set var="attchLongDesc" value="${metaData.typedValue}" />
				</c:if>
			</c:forEach>
			<c:if test="${empty description and not empty attchLongDesc}">
				<c:set var="description" value="${attchLongDesc}"/>
			</c:if>
			<c:choose>
				<c:when test="${empty mimePart}">
					<c:set var="linkName" value="${attachment.attachmentAssetPath}"/>
				</c:when>
				<c:otherwise>
					<fmt:message key="DOWNLOAD_{0}" var="linkName">
						<fmt:param value="${fn:toUpperCase(attachmentType)}"/>
					</fmt:message>
				</c:otherwise>
			</c:choose>
			
			<jsp:useBean id="attachmentDetails" class="java.util.HashMap" type="java.util.Map"/>
			<c:set target="${attachmentDetails}" property="name" value="${attchName}"/>
			<c:set target="${attachmentDetails}" property="linkName" value="${linkName}"/>
			<c:set target="${attachmentDetails}" property="assetPath" value="${attachment.attachmentAssetPath}"/>
			<c:set target="${attachmentDetails}" property="image" value="${attchImage}"/>
			<c:set target="${attachmentDetails}" property="attachmentType" value="${fn:toUpperCase(attachmentType)}"/>
			<c:set target="${attachmentDetails}" property="description" value="${description}"/>
			
			<wcf:set target="${attachmentsList}" value="${attachmentDetails}"/>
			<c:remove var="attachmentDetails"/>
			<c:remove var="attachmentType"/>
			<c:remove var="attchImage"/>
		</c:if>
	</c:forEach>
</c:if>

<c:forEach var="metadata" items="${catalogEntryDetails.metaData}" varStatus="status2">
	<c:if test="${metadata.key == 'ThumbnailPath'}">
		<c:set var="thumbNail" value="${env_imageContextPath}/${metadata.value}" />
	</c:if>			
	<c:if test="${metadata.key == 'FullImagePath'}">
		<c:set var="fullImage" value="${env_imageContextPath}/${metadata.value}" />
	</c:if>
	<c:if test="${metadata.key == 'score'}">
		<fmt:formatNumber var="searchScore" type="number" maxFractionDigits="15" groupingUsed="true" value="${metadata.value}" />
	</c:if>
</c:forEach>	

<c:if test="${numberOfSKUs > 0}">
	<c:set var="firstItemID" value="${entitledItems[0].uniqueID}"/>
</c:if>
<c:forEach var="prices" items="${catalogEntryDetails.price}">
	<c:if test="${prices.priceUsage == 'Offer'}">
		<c:set var="maximumItemPrice" value="${prices.maximumValue.value}"/>
		<c:if test="${empty maximumItemPrice}">						
			<c:set var="maximumItemPrice" value="${prices.value.value}"/>
		</c:if>
	</c:if>
</c:forEach>

<c:choose>
	<c:when test="${!empty thumbNail}">	<!-- added -->
		<c:set var="productThumbNailImage" value="${thumbNail}"/>
		<c:set var="productThumbNail160Image" value="${thumbNail}"/>
	</c:when>
	<c:otherwise>
		<c:set var="productThumbNailImage" value="${hostPath}${jspStoreImgDir}images/NoImageIcon.jpg"/>
		<c:set var="productThumbNail160Image" value="${hostPath}${jspStoreImgDir}images/NoImageIcon.jpg"/>
	</c:otherwise>
</c:choose>


<%-- Find out all the subscription related attributes if any --%>
<c:set var="isRecurrable" value="true"/>
<c:if test="${catalogEntryDetails.disallowRecurringOrder}">
	<c:set var="isRecurrable" value="false"/>
</c:if>
<c:set var="isSubscription" value="false"/>
<c:if test="${!empty catalogEntryDetails.subscriptionTypeCode && catalogEntryDetails.subscriptionTypeCode != 'NONE'}">
	<c:set var="isSubscription" value="true"/>
</c:if>
<c:set var="fulfillmentFrequency" value=""/>
<c:set var="fulfillmentFrequencyAttrName" value=""/>
<c:set var="paymentFrequency" value=""/>
<c:set var="paymentFrequencyAttrName" value=""/>
<c:set var="aValidTimePeriod" value=""/>
<jsp:useBean id="validTimePeriodAttrValues" class="java.util.HashMap" scope="page" />

<div id="entitledItem_<c:out value='${catalogEntryID}'/>" style="display:none;">
		[
		<c:if test="${type == 'product'}">

				<%-- SwatchCode start --%>
				<c:if test="${!empty entitledItems}">
				<%-- Find out if we have angle image attachments in the product, if there is then we should retrieve that for all items. --%>
				<%-- Otherwise, we can use a lighter service. --%>
				<c:set var="hasAngleImages" value="false" />
				<c:set var="allAttachments" value="${catalogEntryDetails.attachments}" />
				<c:forEach var="anAttachment" items="${allAttachments}">
					<c:if test="${'ANGLEIMAGES_THUMBNAIL' eq anAttachment.usage}">
						<c:set var="hasAngleImages" value="true" />
					</c:if>
				</c:forEach>

				<c:set var="exprBuilder_PD" value="getCatalogEntryViewPriceWithAttributesByID"/>
				<c:set var="searchProfile_PD" value="IBM_findCatalogEntryPriceWithAttributes_PriceMode"/>
				<c:if test="${hasAngleImages}">
					<c:set var="exprBuilder_PD" value="getCatalogEntryViewDetailsWithAttachmentsByID"/>
					<c:set var="searchProfile_PD" value="IBM_findCatalogEntryDetailsWithAttachments"/>
				</c:if>
				
				<wcf:getData type="com.ibm.commerce.catalog.facade.datatypes.CatalogNavigationViewType" var="itemDetails" 
					expressionBuilder="${exprBuilder_PD}" varShowVerb="showCatalogNavigationView" recordSetStartNumber="0">
					<c:forEach var='entitledItem' items='${entitledItems}' varStatus='outerStatus'>
						<wcf:param name="UniqueID" value="${entitledItem.uniqueID}"/>
					</c:forEach>
					<wcf:contextData name="storeId" data="${storeId}" />
					<wcf:contextData name="catalogId" data="${catalogId}" />
					<wcf:param name="searchProfile" value="${searchProfile_PD}"/>
				</wcf:getData>

				</c:if>
				<%-- SwatchCode end --%>

				<c:forEach var='entitledItem' items='${entitledItems}' varStatus='outerStatus'>
					
					<c:set var="sku" value="${entitledItem}"/>
					<c:set var="skuID" value="${entitledItem.uniqueID}"/>

					{
					"catentry_id" : "<c:out value='${skuID}' />",
					"Attributes" :	{
						<c:set var="hasAttributes" value="false"/>											
						<c:forEach var="definingAttrValue2" items="${sku.attributes}" varStatus="innerStatus">
							<c:if test="${definingAttrValue2.identifier == env_subsFulfillmentFrequencyAttrName}">
								<c:set var="fulfillmentFrequency" value="${definingAttrValue2.values[0].value}"/>
								<c:set var="fulfillmentFrequencyAttrName" value="${definingAttrValue2.name}"/>
							</c:if>
							<c:if test="${definingAttrValue2.identifier == env_subsPaymentFrequencyAttrName}">
								<c:set var="paymentFrequency" value="${definingAttrValue2.values[0].value}"/>
								<c:set var="paymentFrequencyAttrName" value="${definingAttrValue2.name}"/>
							</c:if>
							<c:if test="${definingAttrValue2.identifier == env_subsTimePeriodAttrName}">
								<c:set var="aValidTimePeriod" value="${definingAttrValue2.values[0].value}"/>
								<c:set property="${definingAttrValue2.values[0].value}" value="${definingAttrValue2.values[0].value}" target="${validTimePeriodAttrValues}"/>	
							</c:if>
							<c:if test="${definingAttrValue2.usage == 'Defining'}">
								<c:if test='${hasAttributes eq "true"}'>,</c:if>
								"<c:out value="${fn:replace(definingAttrValue2.name, search01, replaceStr01)}_${fn:replace(fn:replace(definingAttrValue2.values[0].value, search01, replaceStr01), search, replaceStr02)}" />":"<c:out value='${innerStatus.count}' />"
								<c:set var="hasAttributes" value="true"/>
							</c:if>
						</c:forEach>
						},
						
						<%-- SwatchCode start --%>
						<c:forEach items = "${itemDetails.catalogEntryView}" var="itemDetail">
							<c:forEach var="metadata" items="${itemDetail.metaData}" varStatus="status2">		
									<c:if test="${metadata.key == 'ThumbnailPath'}">
										<c:set var="thumbnailImage" value="${env_imageContextPath}/${metadata.value}" />
										<c:set var="itemFullImage" value="${fn:replace(thumbnailImage, productThumbnailImage, productMasterImage)}" />
									</c:if>
							</c:forEach>
							<%-- Replace  1000x1000 images with 467x467 image dimensions --%>
							<c:set var="productMainImageSource" value="${fn:replace(itemFullImage, productMasterImage, productPageImage)}" />
							<c:if test="${itemDetail.uniqueID == entitledItem.uniqueID}">
								"ItemImage" : "<c:out value='${itemFullImage}' />",
								"ItemImage467" : "<c:out value='${productMainImageSource}' />",
								"ItemThumbnailImage" : "<c:out value='${fn:replace(itemFullImage, productMasterImage, productThumbnailImage)}' />"
								<c:if test="${fn:length(itemDetail.attachments) > 0}">
									,"ItemAngleThumbnail" : {
									<c:set var="imageCount" value="0" />
									<c:forEach var="itemAttachment" items="${itemDetail.attachments}" varStatus="status1">
										<c:if test="${itemAttachment.usage == 'ANGLEIMAGES_THUMBNAIL'}">
											<c:if test='${imageCount gt 0}'>,</c:if>
											<c:set var="imageCount" value="${imageCount+1}" />
											"image_${imageCount}" : "<c:out value='${env_imageContextPath}/${itemAttachment.attachmentAssetPath}' />"
										</c:if>
									</c:forEach>
									},
									"ItemAngleFullImage" : {
									<c:set var="imageCount" value="0" />
									<c:forEach var="itemAttachment" items="${itemDetail.attachments}" varStatus="status2">
										<%-- Replace  1000x1000 images with 467x467 --%>
										<c:set var="imgSource" value="${fn:replace(itemAttachment.attachmentAssetPath, productMasterImage, productPageImage)}" />
										<c:if test="${itemAttachment.usage == 'ANGLEIMAGES_FULLIMAGE'}">
											<c:if test='${imageCount gt 0}'>,</c:if>
											<c:set var="imageCount" value="${imageCount+1}" />
											"image_${imageCount}" : "<c:out value='${env_imageContextPath}/${imgSource}' />"
										</c:if>
									</c:forEach>
									}
								</c:if>
							</c:if>
						</c:forEach>
						<%-- SwatchCode end --%>
					}<c:if test='${!outerStatus.last}'>,</c:if>
				</c:forEach>
			
		</c:if>
		<c:if test="${type == 'package' || type == 'bundle' || type == 'item' || type == 'dynamickit'}">
			{
			"catentry_id" : "<c:out value='${catalogEntryID}'/>",
			"Attributes" :	{ }
			}
		</c:if>
		]
</div>

<%-- 
***
*	Start: Product Descriptive and Defining Attributes
* 	
* Defining attributes are properties of SKUs.  They are used for SKU resolution.
***
--%>

<wcf:useBean var="descriptiveAttributeList" classname="java.util.ArrayList"/>

<wcf:useBean var="descriptiveAttributeMap" classname="java.util.HashMap"/>

<wcf:useBean var="subsFulfillmentFrequencyAttrList" classname="java.util.ArrayList"/>

<wcf:useBean var="subsPaymentFrequencyAttrList" classname="java.util.ArrayList"/>

<wcf:useBean var="subsTimePeriodAttrList" classname="java.util.ArrayList"/>

<wcf:useBean var="swatchAttrList" classname="java.util.ArrayList"/>

<wcf:useBean var="definingAttributeList" classname="java.util.ArrayList"/>

<c:choose>
	<c:when test="${type eq 'product'}">
		<c:if test="${numberOfSKUs eq 1}">
			<%-- 
			If there is only one SKU then let's just display the attributes of the one item as text without selection.
			Also, initialize the JavaScript code to simulate attribute selections made already.
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
								<wcf:set target="${listValues}" value="${fn:replace(attribute.name, search01, replaceStr01)}" />
								<wcf:set target="${listValues}" value="${fn:replace(attribute.values[0].value, search01, replaceStr01)}" />
								<wcf:set target="${listValues}" value="${fn:replace(displayValue, search01, replaceStr01)}" />
								<wcf:set target="${definingAttributeList}" value="${listValues}" />
								<c:remove var="listValues"/>
							</c:if>
						</c:when>
						<c:when test="${attribute.identifier != env_subsFulfillmentFrequencyAttrName && attribute.identifier != env_subsPaymentFrequencyAttrName}">
							<wcf:useBean var="listValues" classname="java.util.ArrayList" capacity="2"/>
							<wcf:set target="${listValues}" value="${fn:replace(attribute.name, search01, replaceStr01)}" />
							<wcf:set target="${listValues}" value="${fn:replace(attribute.values[0].value, search01, replaceStr01)}" />
							<wcf:set target="${definingAttributeList}" value="${listValues}" />
							<c:remove var="listValues"/>
						</c:when>
					</c:choose>
				</c:if>
			</c:forEach>
		</c:if>

		<c:forEach var="attribute" items="${catalogEntryDetails.attributes}" varStatus="aStatus">
			<c:if test="${ attribute.usage=='Descriptive' and attribute.displayable}" >
				<wcf:useBean var="listValues" classname="java.util.ArrayList" capacity="3"/>
				<c:choose>
					<c:when test="${ !empty attribute.extendedValue['Image1']  }" >
						<wcf:set target="${listValues}" value="${attribute.name}"/>
						<wcf:set target="${listValues}" value="${attribute.values[0].value}"/>											
						<wcf:set target="${listValues}" value="${attribute.extendedValue['Image1']}" />
					</c:when>
					<c:otherwise >
						<wcf:set target="${listValues}" value="${attribute.name}"/>
						<wcf:set target="${listValues}" value="${attribute.values[0].value}"/>
					</c:otherwise>
				</c:choose>
				<wcf:set target="${descriptiveAttributeList}" value="${listValues}"/>
				<c:remove var="listValues"/>
			</c:if>
			<c:if test="${(attribute.usage eq 'Defining') and (numberOfSKUs gt 1)}" >
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
						<wcf:set target="${listValues}" value="${fn:replace(attribute.name, search01, replaceStr01)}"/>
						<wcf:set target="${listValues}" value="${fn:replace(fulfillmentFrequency, search01, replaceStr01)}"/>		
						<wcf:set target="${subsFulfillmentFrequencyAttrList}" value="${listValues}" />
						<c:remove var="listValues"/>
					</c:when>
					<c:when test="${attribute.identifier == env_subsPaymentFrequencyAttrName}">
						<wcf:useBean var="listValues" classname="java.util.ArrayList" capacity="3"/>
						<wcf:set target="${listValues}" value="${fn:replace(attribute.name, search01, replaceStr01)}"/>
						<wcf:set target="${listValues}" value="${fn:replace(paymentFrequency, search01, replaceStr01)}"/>
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
							
							<c:set var="attributeUOMKey" value="PD_ATTR_UOM_ANN" />
							<c:forEach var="extValue" items="${allowedValue.extendedValue}">
								<c:if test="${extendedValue.key == 'UnitOfMeasure'}">
									<c:set var="attributeUOMKey" value="PD_ATTR_UOM_${extValue.value}" />
								</c:if>
							</c:forEach>
							<fmt:message var="displayValue" key="${attributeUOMKey}" >
								<fmt:param value="${allowedValue.value}" />
							</fmt:message>
							
							<c:if test="${isValidValue}">
								<wcf:set target="${values}" value="${fn:replace(allowedValue.value, search01, replaceStr01)}" />
								<wcf:set target="${displayValues}" value="${fn:replace(displayValue, search01, replaceStr01)}" />
							</c:if>
						</c:forEach>
						
						<wcf:set target="${listValues}" value="${fn:replace(attribute.name, search01, replaceStr01)}"/>
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
							<c:set var="doNotDisable" value="${fn:replace(attribute.name, search01, replaceStr01)}"/>
						</c:if>

						<c:forEach var="swatchValue" items="${attribute.values}">
							<c:forEach var="swatchExtValue" items="${swatchValue.extendedValue}">
								<c:if test="${swatchExtValue.key == 'Image1Path'}">
									<wcf:set target="${swatchValues}" value="${fn:replace(swatchValue.value, search01, replaceStr01)}" />
									<wcf:set target="${swatchImages}" value="${env_imageContextPath}/${swatchExtValue.value}" />
								</c:if>
							</c:forEach>										
						</c:forEach>
						
						<wcf:set target="${listValues}" value="${fn:replace(attribute.name, search01, replaceStr01)}"/>
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
							<wcf:set target="${attributeValues}" value="${fn:replace(allowedValue.value, search01, replaceStr02)}" />
						</c:forEach>
						<wcf:useBean var="listValues" classname="java.util.ArrayList" capacity="3"/>
						<wcf:set target="${listValues}" value="${fn:replace(attribute.name, search01, replaceStr01)}" />
						<wcf:set target="${listValues}" value="${attributeValues}" />
						<wcf:set target="${definingAttributeList}" value="${listValues}" />
						<c:remove var="attributeValues" />
						<c:remove var="listValues" />
					</c:otherwise>
				</c:choose>
			</c:if>
		</c:forEach>
	</c:when>

	<c:when test="${type eq 'item'}">
		<c:forEach var="attribute" items="${catalogEntryDetails.attributes}" varStatus="aStatus">
			<c:if test="${attribute.usage eq 'Defining'}">
				<wcf:useBean var="attributeValues" classname="java.util.ArrayList" />
				<c:if test="${attribute.identifier != env_subsFulfillmentFrequencyAttrName && attribute.identifier != env_subsPaymentFrequencyAttrName}">
					<c:choose>
						<c:when test="${attribute.identifier == env_subsTimePeriodAttrName}">						
							<c:forEach var="allowedValue" items="${attribute.values}" varStatus="vStatus">							
								<c:set var="attributeUOMKey" value="PD_ATTR_UOM_ANN" />
								<c:forEach var="extValue" items="${allowedValue.extendedValue}">
									<c:if test="${extendedValue.key == 'UnitOfMeasure'}">
										<c:set var="attributeUOMKey" value="PD_ATTR_UOM_${extValue.value}" />
									</c:if>
								</c:forEach>
								<fmt:message var="displayValue" key="${attributeUOMKey}" >
									<fmt:param value="${allowedValue.value}" />
								</fmt:message>
								
								<wcf:set target="${attributeValues}" value="${fn:replace(displayValue, search01, replaceStr01)}" />
							</c:forEach>
						</c:when>
						<c:otherwise>
							<wcf:set target="${attributeValues}" value="${fn:replace(attribute.values[0].value, search01, replaceStr01)}"/>
						</c:otherwise>
					</c:choose>
				</c:if>
				<wcf:useBean var="listValues" classname="java.util.ArrayList" capacity="3"/>
				<wcf:set target="${listValues}" value="${fn:replace(attribute.name, search01, replaceStr01)}" />
				<wcf:set target="${listValues}" value="${attributeValues}" />
				<wcf:set target="${definingAttributeList}" value="${listValues}" />
				<c:remove var="attributeValues" />
				<c:remove var="listValues" />
			</c:if>
		</c:forEach>
	</c:when>
	<c:when test="${(type eq 'bundle') or (type eq 'package')}">
		<c:forEach var="attribute" items="${catalogEntryDetails.attributes}" varStatus="aStatus">
				<c:if test="${ attribute.usage=='Descriptive' and attribute.displayable}" >
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
		</c:forEach>
	</c:when>
</c:choose>
<%-- 
***
*	End: Product Descriptive and Defining Attributes
***
--%>

<%-- 
	Loop through all the SKUs and see if any one of them is marked 'buyable'. 
	Even if one of them is buyable, we show Add to Cart button.. Buyable flag set at product level is ignored 
--%>
<c:if test="${empty requestScope.bundleId and empty requestScope.packageId}">
	<c:set var="bundleKitAvailable" value="false" scope="request"/> <%-- set default value to false --%>
</c:if>
<c:set var="productAvailable" value="false" scope="request"/> <%-- set default value to false --%>
<c:set var="dynamicKitAvailable" value="false" scope="request"/> <%-- set default value to false --%>
<c:if test="${!empty maximumItemPrice}">
	<%-- We have price... Continue with other checks --%>
	<c:choose>
		<c:when test="${type eq 'bundle' or type eq 'package'}">
			<%--For bundle and package check the buyable flag at the bundle or pacakge level instead of looping through each individual components --%>
			<c:set var="bundleKitAvailable" value="${catalogEntryDetails.buyable}" scope="request"/>
		</c:when>
		<c:otherwise>
			<%-- It is not a Subscription item OR Subscription products with the well known 3 attributes set properly --%>
			<c:if test="${!isSubscription || (fulfillmentFrequency != '' && paymentFrequency != '' && aValidTimePeriod != '')}" >
				<c:choose>
					<%-- If it is a product iterate through all its SKUs --%>
					<c:when test="${type eq 'product'}">
						<c:forEach var="entitledItem" items="${entitledItems}">
							<c:if test = "${entitledItem.buyable eq 'true'}">
								<c:set var="productAvailable" value="true" scope="request"/> <%-- We have one item which is marked as buyable..Show AddToCart button --%>
							</c:if>
						</c:forEach>
					</c:when>
					<c:otherwise>
						<%-- Since it is an item, pick from buyable field --%>
						<c:set var="productAvailable" value="${catalogEntryDetails.buyable}" scope="request"/>
					</c:otherwise>
				</c:choose>
			</c:if>
		</c:otherwise>
	</c:choose>
</c:if>

<%-- For dynamic kit, check the buyable flag directly at the details level instead of looping through each individual components --%>
<c:if test="${type eq 'dynamickit'}">
	<c:set var="dynamicKitAvailable" value="${catalogEntryDetails.buyable}" scope="request"/>
</c:if>

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

<c:set var="buyable" value="${catalogEntryDetails.buyable}"/>

<c:set var="singleSKU" value="false"/>
<c:choose>
	<c:when test="${type == 'bundle'}">
		<c:set var="singleSKU" value="${catalogEntryDetails.hasSingleSKU}"/>
	</c:when>
	<c:when test="${type == 'product'}">
		<c:set var="singleSKU" value="${catalogEntryDetails.hasSingleSKU}"/>
	</c:when>
	<c:when test="${type == 'dynamickit'}">
		<c:set var="singleSKU" value="false"/>
		<c:set var="isDKConfigurable" value="${!empty catalogEntryDetails.dynamicKitModelReference}"/>
		<c:if test="${empty isDKConfigurable}">
			<c:set var="isDKConfigurable" value="true"/>
		</c:if>

		<c:if test="${empty isDKPreConfigured}">
			<%-- determine if the kit is pre-configured or not --%>
			<c:set var="isDKPreConfigured" value="${catalogEntryDetails.dynamicKitDefaultConfigurationComplete}" scope="request"/>
		</c:if>
	</c:when>
</c:choose>

<%-- END ProductDescription_Data.jsp --%>
