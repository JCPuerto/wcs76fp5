<%--
 =================================================================
  Licensed Materials - Property of IBM

  WebSphere Commerce

  (C) Copyright IBM Corp. 2011 All Rights Reserved.

  US Government Users Restricted Rights - Use, duplication or
  disclosure restricted by GSA ADP Schedule Contract with
  IBM Corp.
 =================================================================
--%>

<%--
*****
This object snippet displays a catalog entry on different places across the site. It is mainly used with eMarketingSpots
where each catalog entry snippet could be cached to improve the performance across the store. This snippet uses information
from the marketing service along with catalog databeans to display the desired catalog entry.
Depending on your input parameters different information is shown.
Users may specify display parameters to limit what is shown (see optional parameters) and much more.

Parameters required:
        emsName:		This .jsp file can be reused in different store pages by including it and assigning a unique value for the 
				emsName parameter. This value should match exactly with an eMarketingSpot name that is defined in the 
				Management Center when creating a new eMarketingSpot.
	catalogId: 		The catalogId parameter needs to be passed because it is required to build the proper URLs.
	storeId: 		The storeId parameter needs to be passed because it is required to build the proper URLs.
	mpe_id: 		The identifier of the eMarketingSpot.
	intv_id: 		The identifier of the Web Activity associated with the eMarketingSpot with mpe_id passed along.
	expDataType:		The type of the data to display in the eMarketingSpot. 
	clickInfoCommand:	The click info command name.
	absoluteUrl: 		The path to the click info command.

Optional display parameters:
	pageView:		Shows the catalog entry information in some pattern. It mainly defines how the catalog entry is shown. 
				Possible values are 'image','detailed', 'sidebar', 'imageForCompare', 'scrollESpot' and 'imageOnly'. Defaults to 'imageOnly'.
	useClickInfoURL:	If set to true, will use the variable 'ClickInfoURL' for the thumbnail image and name link.
	ClickInfoURL:		If 'useClickInfoURL' is set to true, this will be used as the link for the image and name links.
	catEntryIdentifier:	Is a unique identifier to differentiate the current catalog entry with respect to other ones 
				that may be displayed on the same page.
	skipAttachments:	The flag states whether to load the 40x40 image attachments for the catalog entry. These images are used for displaying the catalog 
				entry in the compare zone. If this catalog entry is not used in a page that has the compare zone then it is
				more efficient to set the skipAttachment flag to true to improve the load time of the page. 
	experimentId: 		The identifier of the marketing activity result experiment.
	testElementId: 		The identifier of the marketing activity result test element.
	categoryId: 		The category identifier used for the product link.
	top_category:		The top category identifier used for the product link.
	parent_category_rn: 	The top category identifier used for the product link.
	statusCount:		The counter for the loop that imports this jsp
*****
--%>
<!-- BEGIN CatalogEntryThumbnailDisplay.jsp -->

<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>
<%@ taglib uri="http://commerce.ibm.com/coremetrics"  prefix="cm" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../../../include/JSTLEnvironmentSetup.jspf"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ include file="../../../include/BrazilCommonESpots.jspf" %>
<c:set var="search" value='"'/>
<c:set var="replaceStr" value="'"/>
<c:set var="search01" value="'"/>
<c:set var="replaceStr01" value="\\'"/>
<c:set var="replaceCmprStr" value=""/>
<c:set var="showProductQuickView" value="false"/>
<c:set var="pageView" value="${param.pageView}"/>
<c:set var="storeId" value="${param.storeId}"/>
<c:set var="catalogId" value="${param.catalogId}"/>
<c:set var="emsName" value="${param.emsName}"/>	
<c:set var="useClickInfoURL" value="${param.useClickInfoURL}"/>			
<c:set var="statusCount" value="${param.statusCount}"/>
<c:set var="prefix" value="${param.prefix }"/>
<c:set var="contentAreaESpot" value="${param.contentAreaESpot}"/>

<flow:ifEnabled feature="ProductQuickView">   
	<c:set var="showProductQuickView" value="true"/>
</flow:ifEnabled>

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

<flow:ifEnabled feature="ShowProductInNewWindow">
	<c:set var="ShowProductInNewWindow" value="target=\"_blank\"" />
</flow:ifEnabled>

<%--
  ***
  * Host name of the URL that is used to point to the shared image directory.  Use this variable to reference images.
  ***
--%>
<c:set value="${pageContext.request.scheme}://${pageContext.request.serverName}" var="hostPath" />

<c:set var="catalogEntryID" value="${param.catEntryIdentifier}"/>
<c:set var="catEntryIDToUse" value="${param.catEntryIdentifier}"/>
<c:set var="catEntryIdentifier" value="${param.catEntryIdentifier}"/>

<%-- the catEntry variable is set in the requestScope from the E-spot JSPs. 
	Reuse the same variable to avoid re-instantiating databeans 
--%>

<wcf:getData type="com.ibm.commerce.catalog.facade.datatypes.CatalogNavigationViewType" var="catalogNavigationView" 
	expressionBuilder="getCatalogEntryViewDetailsWithAttachmentsByID" scope="request" varShowVerb="showCatalogNavigationView" maxItems="1" recordSetStartNumber="0" scope="request">
	<wcf:param name="UniqueID" value="${catalogEntryID}" />
	<wcf:contextData name="storeId" data="${storeId}" />
	<wcf:contextData name="catalogId" data="${catalogId}" />
</wcf:getData>

<c:set var="catEntry" value="${catalogNavigationView.catalogEntryView[0]}" />

<c:set var="buyable" value="${catEntry.buyable}" />

<%--
  ***
  * Price variables.
  ***
--%>
<c:set var="minimumPrice" value=""/>
<c:set var="maximumPrice" value=""/>
<c:set var="emptyPriceString" value=""/>
<c:set var="priceString" value=""/>
<c:choose>
		<c:when test="${catEntry.catalogEntryTypeCode == 'ProductBean'}">
			<c:set var="type" value="product" />
				
			<c:set var="isSubscription" value="false"/>
			<c:if test="${!empty catEntry.subscriptionTypeCode && catEntry.subscriptionTypeCode != 'NONE'}">
				<c:set var="isSubscription" value="true"/>
			</c:if>

			<c:set var="fulfillmentFrequency" value=""/>
			<c:set var="paymentFrequency" value=""/>
			<c:set var="aValidTimePeriod" value=""/>
			
			<c:set var="numberOfSKUs" value="${catEntry.numberOfSKUs}"/>

			<%-- set dragType to item if there is only 1 item for this product and there are no defining attributes
			     otherwise it has a dragType of product (indicating it is a product with attributes) --%>
			<c:set var="dragType" value="product" />
			<c:if test="${numberOfSKUs == 1}">			
	 			<c:set var="noAttributes" value="true" />
	 			<c:forEach var="attribute" items="${catEntry.SKUs[0].attributes}">
					<c:if test="${attribute.identifier == subsFulfillmentFrequencyAttrName}">
						<c:set var="fulfillmentFrequency" value="${attribute.values[0].value}"/>
					</c:if>
					<c:if test="${attribute.identifier == subsPaymentFrequencyAttrName}">
						<c:set var="paymentFrequency" value="${attribute.values[0].value}"/>
					</c:if>
					<c:if test="${attribute.identifier == subsTimePeriodAttrName}">
						<c:set var="aValidTimePeriod" value="${attribute.values[0].value}"/>
					</c:if>
					<c:if test="${attribute.usage == 'Defining'}">
						<c:set var="noAttributes" value="false" />
					</c:if>
				</c:forEach>
				<c:if test="${noAttributes}">
					<c:set var="dragType" value="item" />
				</c:if>						
			</c:if>
			
			<c:choose>
				<c:when test="${numberOfSKUs == 1}">
					<c:set var="singleSKU" value="true"/>
					<c:set var="catEntryIDToUse" value="${catEntry.SKUs[0].uniqueID}"/>
				</c:when>
				<c:otherwise>
					<c:set var="singleSKU" value="false"/>
				</c:otherwise>
			</c:choose>
			
			<c:if test="${empty catEntry.SKUs[0] || !catEntry.buyable}" >
				<c:set var="buyable" value="false"/>
			</c:if>
			<%-- Subscription products without the well know 3 attributes will not be allowed to add to cart --%>
			<c:if test="${isSubscription && (fulfillmentFrequency == '' || paymentFrequency != '' || aValidTimePeriod != '')}" >
				<c:set var="buyable" value="false"/>
			</c:if>
			
			<c:forEach var="prices" items="${catEntry.price}">
				<c:if test="${prices.priceUsage == 'Offer'}">
					<c:set var="minimumPrice" value="${prices.minimumValue.value}"/>
					<c:set var="maximumPrice" value="${prices.maximumValue.value}"/>
					<c:set var="offerPrice" value="${prices.value.value}"/>
				</c:if>
			</c:forEach>
		</c:when>
		<c:when test="${catEntry.catalogEntryTypeCode == 'ItemBean'}">
			<c:set var="type" value="item" />
			<c:set var="dragType" value="item" />
			<c:forEach var="prices" items="${catEntry.price}">
				<c:if test="${prices.priceUsage == 'Offer'}">
					<c:set var="offerPrice" value="${prices.value.value}"/>
				</c:if>
			</c:forEach>
		</c:when>
		<c:when test="${catEntry.catalogEntryTypeCode == 'PackageBean'}">
			<c:set var="type" value="package" />
			<c:set var="dragType" value="package" />

			<c:set var="maximumItemPrice" value="" />
			<c:forEach var="prices" items="${catEntry.price}">
				<c:if test="${prices.priceUsage == 'Offer'}">
					<c:set var="maximumItemPrice" value="${prices.maximumValue.value}"/>
					<c:if test="${empty maximumItemPrice}">						
						<c:set var="maximumItemPrice" value="${prices.value.value}"/>
					</c:if>
					<c:set var="offerPrice" value="${prices.value.value}"/>
				</c:if>
			</c:forEach>
			<c:if test="${empty maximumItemPrice || buyable eq 'false'}" >
				<c:set var="buyable" value="false"/>
			</c:if>
		</c:when>
		<c:when test="${catEntry.catalogEntryTypeCode == 'BundleBean'}">
			<c:set var="type" value="bundle" />
			<c:set var="dragType" value="bundle" />
			
			<c:forEach var="prices" items="${catEntry.price}">
				<c:if test="${prices.priceUsage == 'Offer'}">
					<c:set var="minimumPrice" value="${prices.minimumValue.value}"/>
					<c:set var="maximumPrice" value="${prices.maximumValue.value}"/>
					<c:set var="offerPrice" value="${prices.value.value}"/>
				</c:if>
			</c:forEach>
		</c:when>
		
		<c:when test="${catEntry.catalogEntryTypeCode == 'DynamicKitBean' && showDynamicKit == 'true'}">	
				<c:set var="type" value="dynamicKit" />
				<c:set var="dragType" value="dynamicKit" />			
				<c:set var="dynamicKitprice" value="${catEntry.price[0]}" />
				<c:set var="isDKPreConfigured" value="${catEntry.dynamicKitDefaultConfigurationComplete}"/>
				<c:set var="isDKConfigurable" value="${!empty catEntry.dynamicKitModelReference}"/>
		</c:when>
</c:choose>
<c:if test="${not (catEntry.catalogEntryTypeCode == 'DynamicKitBean' && showDynamicKit != 'true') }">
<c:choose>
	<%--
	***
	*	If there is no calculated contract price, then get a message 
	*   indicating there is no available price. This rule applies to
	*	any type of a catalog entry.
	*
	--%>	

	<c:when test="${empty minimumPrice && empty offerPrice}">
		<fmt:message var="emptyPriceString" key="NO_PRICE_AVAILABLE" bundle="${storeText}"/>
	</c:when>
	
	<%-- 
	***
	*	If there is a price range, then make the range as the price to 
	*	be displayed. We do not need to test if maximum price is empty,
	*   because as long as minimum price is not empty, nor will be 
	*   the maximum price. 
	***
	--%>
	<c:when test="${!empty minimumPrice && !empty maximumPrice && (minimumPrice != maximumPrice) && fn:indexOf(maximumPrice, minimumPrice)==-1 && fn:indexOf(minimumPrice, maximumPrice)==-1}">
		<c:set var="priceString" value="${minimumPrice} - ${maximumPrice}"/>
	</c:when>

</c:choose>


<c:choose>
		  <%-- If the price is unavailable, print out the corresponding message --%>
			<c:when test="${!empty emptyPriceString}">
					<c:set var="displayPriceString" value="${emptyPriceString}"/>
			</c:when>
			
			<%-- If the price string has been set, then we simply print it out. --%>
			<c:when test="${!empty priceString}">
				<fmt:message key="DisplayPriceIs" var="displayPriceString" bundle="${storeText}">
					<fmt:formatNumber var="priceStringLocalized_min" value="${minimumPrice}" type="currency" currencySymbol="${CurrencySymbolToFormat}" maxFractionDigits="${currencyDecimal}"/>
					<fmt:formatNumber var="priceStringLocalized_max" value="${maximumPrice}" type="currency" currencySymbol="${CurrencySymbolToFormat}" maxFractionDigits="${currencyDecimal}"/>
					<fmt:param value="${priceStringLocalized_min}${CurrencySymbol} - ${priceStringLocalized_max}${CurrencySymbol}"/>
				</fmt:message>
			</c:when>
			
			<c:otherwise>
				<fmt:message key="DisplayPriceIs" var="displayPriceString" bundle="${storeText}">
					<fmt:formatNumber var="priceStringLocalized" value="${offerPrice}" type="currency" currencySymbol="${CurrencySymbolToFormat}" maxFractionDigits="${currencyDecimal}"/>
					<fmt:param value="${priceStringLocalized}${CurrencySymbol}"/> 					
				</fmt:message>
			</c:otherwise>
</c:choose>
<c:remove var="minimumPrice"/>
<c:remove var="maximumPrice"/>
<c:remove var="emptyPriceString"/>
<c:remove var="priceString"/>

<c:choose>
	<c:when test="${empty WCParam.categoryId}">
		<%-- categoryId is empty..just display product URL --%>
		<c:set var="patternName" value="ProductURL"/>
		<c:set var="parent_category_rn" value="${WCParam.parent_category_rn}" />
		<c:set var="top_category" value="${WCParam.top_category}" />
		<c:set var="categoryId" value="${WCParam.categoryId}" />
	</c:when>
	<c:when test="${WCParam.parent_category_rn == WCParam.categoryId}">
			<%-- CategoryId is present..but it is same as parent category Id --%>
			<c:set var="patternName" value="ProductURLWithCategory"/>
			<c:set var="parent_category_rn" value="${WCParam.parent_category_rn}" />
			<c:set var="top_category" value="${WCParam.top_category}" />
			<c:set var="categoryId" value="${WCParam.categoryId}" />
	</c:when>
	<c:when test="${!empty WCParam.parent_category_rn && !empty WCParam.top_category}">
		<%-- both parent and top category are present.. display full product URL --%>
		<c:set var="parent_category_rn" value="${WCParam.parent_category_rn}" />
		<c:set var="top_category" value="${WCParam.top_category}" />
		<c:set var="categoryId" value="${WCParam.categoryId}" />
		<c:set var="patternName" value="ProductURLWithParentAndTopCategory"/>
		<c:if test="${top_category == parent_category_rn}">
			<%-- But both top and parent category are same..display only parent category in product URL --%>
			<c:set var="patternName" value="ProductURLWithParentCategory"/>
		</c:if>
	</c:when>
	<c:when test="${!empty WCParam.parent_category_rn}">
		<%-- parent category is not empty..use product URL with parent category --%>
		<c:set var="parent_category_rn" value="${WCParam.parent_category_rn}" />
		<c:set var="top_category" value="${WCParam.top_category}" />
		<c:set var="categoryId" value="${WCParam.categoryId}" />
		<c:set var="patternName" value="ProductURLWithParentCategory"/>
	</c:when>
	<%-- In a top category; use top category parameters --%>
	<c:when test="${WCParam.top == 'Y'}">
		<c:set var="parent_category_rn" value="${WCParam.categoryId}" />
		<c:set var="top_category" value="${WCParam.categoryId}" />
		<c:set var="categoryId" value="${WCParam.categoryId}" />
		<c:set var="patternName" value="ProductURLWithCategory"/>
	</c:when>
	<%-- Store front main page; usually eSpots, parents unknown --%>
	<c:otherwise>
		<c:set var="parent_category_rn" value="" />
		<c:set var="top_category" value="" />
		<%-- Just display productURL without any category info --%>
		<c:set var="patternName" value="ProductURL"/>
	</c:otherwise>
</c:choose>

<c:choose>
	<%-- The URL that links to the display page --%>
	<c:when test="${empty useClickInfoURL || useClickInfoURL == false}">
		<wcf:url var="catEntryDisplayUrl" patternName="${patternName}" value="Product2">
		    <wcf:param name="catalogId" value="${catalogId}"/>
		    <wcf:param name="storeId" value="${storeId}"/>
		    <wcf:param name="productId" value="${catalogEntryID}"/>
		    <wcf:param name="langId" value="${langId}"/>
			<wcf:param name="categoryId" value="${categoryId}" />
			<wcf:param name="top_category" value="${top_category}" />
			<wcf:param name="parent_category_rn" value="${parent_category_rn}" />
				<wcf:param name="urlLangId" value="${urlLangId}" />
		</wcf:url>
	</c:when>
	<c:otherwise>
		<%--
		 * Set up the URL to call when clicking on the image
		--%>
		<wcf:url value="Product2" var="TargetURL" patternName="${patternName}">
		  <wcf:param name="catalogId" value="${catalogId}" />
		  <wcf:param name="productId" value="${catEntryIdentifier}" />
		  <wcf:param name="storeId" value="${storeId}" />
		  <wcf:param name="langId" value="${langId}" />
		  <wcf:param name="categoryId" value="${param.categoryId}" />
		  <wcf:param name="parent_category_rn" value="${param.parent_category_rn}" />
		  <wcf:param name="top_category" value="${param.top_category}" />
		  <wcf:param name="urlLangId" value="${urlLangId}" />
		</wcf:url>
		<c:url value="${param.absoluteUrl}${param.clickInfoCommand}" var="ClickInfoURL" scope="request">
		  <c:param name="evtype" value="CpgnClick" />
		  <c:param name="mpe_id" value="${param.mpe_id}" />
		  <c:param name="intv_id" value="${param.intv_id}" />
		  <c:param name="storeId" value="${storeId}" />
		  <c:if test="${!empty param.experimentId && !empty param.testElementId}">
			<c:param name="experimentId" value="${param.experimentId}" />
			<c:param name="testElementId" value="${param.testElementId}" />
		  </c:if>
		  <c:param name="expDataType" value="${param.expDataType}" />
		  <c:param name="expDataUniqueID" value="${catEntryIdentifier}" />							    	
		  <c:param name="URL" value="${TargetURL}" />
		</c:url>			
		<c:set var="catEntryDisplayUrl" value="${ClickInfoURL}"/>
	</c:otherwise>
</c:choose>

<flow:ifDisabled feature="AjaxAddToCart">
	<c:if test="${add2CartForm != 'false' && dragType !='dynamicKit'}">
		<form name="OrderItemAddForm_${catEntryIDToUse}" action="OrderChangeServiceItemAdd" method="post" id="OrderItemAddForm_${catEntryIDToUse}">
			<input type="hidden" name="storeId" value="<c:out value="${WCParam.storeId}"/>" id="OrderItemAddForm_storeId_${catalogEntryID}"/>
			<input type="hidden" name="orderId" value="." id="OrderItemAddForm_orderId_${catalogEntryID}"/>
			<input type="hidden" name="catalogId" value="<c:out value="${WCParam.catalogId}"/>" id="OrderItemAddForm_catalogId_${catalogEntryID}"/>
			<input type="hidden" name="URL" value="AjaxOrderItemDisplayView?storeId=<c:out value="${WCParam.storeId}"/>&catalogId=<c:out value="${WCParam.catalogId}"/>&langId=<c:out value="${WCParam.langId}"/>" id="OrderItemAddForm_url_${catalogEntryID}"/>
			<input type="hidden" name="errorViewName" value="InvalidInputErrorView" id="OrderItemAddForm_errorViewName_${catalogEntryID}"/>
			<input type="hidden" name="catEntryId" value="${catEntryIDToUse}" id="OrderItemAddForm_catEntryId_${catalogEntryID}"/>
			<input type="hidden" name="productId" value="${catEntryIDToUse}" id="OrderItemAddForm_productId_${catalogEntryID}"/>
			<input type="hidden" value="" name="quantity" id="OrderItemAddForm_quantity_${catalogEntryID}"/>
			<input type="hidden" value="" name="page" id="OrderItemAddForm_page_${catalogEntryID}"/>
			<input type="hidden" name="calculationUsage" value="-1,-2,-3,-4,-5,-6,-7" id="OrderItemAddForm_calcUsage_${catalogEntryID}"/>
			<input type="hidden" name="updateable" value="0" id="OrderItemAddForm_updateable_${catalogEntryID}"/>
			<input type="hidden" name="listId" value="." id="OrderItemAddForm_wishlistId_${catalogEntryID}"/>
			<flow:ifEnabled feature="SOAWishlist">
			<input type="hidden" name="giftListId" value="<c:out value='${giftListId}'/>" id="<c:out value='OrderItemAddForm_${catEntryIDToUse}_giftListId_${giftListId}'/>"/>
			</flow:ifEnabled>
		</form>
	</c:if>
</flow:ifDisabled>
<c:choose>
	<c:when test="${pageView == 'image'}">
		
			<div id="baseContent_${prefix}_<c:out value='${catEntryIdentifier}'/>" 
				<c:if test="${showProductQuickView eq 'true'}">
					onmouseover="showPopupButton('${prefix}_${catEntryIdentifier}');" onmouseout="hidePopupButton('${prefix}_${catEntryIdentifier}');"
				</c:if>
				>
				<div class="img" id="WC_CatalogEntryThumbnailDisplayJSPF_${catEntryIdentifier}_div_1">
				<c:if test="${addProductDnD eq 'true'}">
				
				<c:set var="dragTypeToUse" value="${dragType}"/>
				<c:if test="${singleSKU == true && dragType == 'product'}">
					<c:set var="dragTypeToUse" value="item"/>
				</c:if>
				
					<div dojoType="dojo.dnd.Source" jsId="dndSource" id="${prefix}_${catEntryIDToUse}" copyOnly="true" dndType="${dragTypeToUse}">
						<div class="dojoDndItem" dndType="${dragType}" id="WC_CatalogEntryThumbnailDisplayJSPF_${catEntryIdentifier}_div_2">
				</c:if>
							<c:choose>
								<c:when test="${!empty catEntry.thumbnail}">
									<a ${ShowProductInNewWindow} href="<c:out value="${catEntryDisplayUrl}" escapeXml="false"/>" id="img<c:out value="${catEntryIdentifier}"/>" class="itemhover" 
									<c:if test="${showProductQuickView eq 'true'}">
										onfocus="showPopupButton('${prefix}_${catEntryIdentifier}');"
										onkeydown="shiftTabHidePopupButton('${prefix}_${catEntryIdentifier}',event);"
									</c:if>
									onmouseout="javascript:hideBackgroundImage(this);" onmouseover="javascript:showBackgroundImage(this);"
									>
										<c:if test="${addProductDnD eq 'true'}">
											<!--[if lte IE 6.5]><iframe class="productDnDIFrame" scrolling="no" frameborder="0" src="<c:out value="${jspStoreImgDir}" />images/empty.gif"></iframe><![endif]-->
										</c:if>
										<img src="<c:out value='${catEntry.thumbnail}'/>" 
												alt="<c:out value='${fn:replace(catEntry.name, search, replaceStr)} ${displayPriceString}' escapeXml='false'/>" 
												border="0" width="70" height="70"/>
									</a>
								</c:when>
								<c:otherwise>
									<a ${ShowProductInNewWindow} href="<c:out value="${catEntryDisplayUrl}" escapeXml="false"/>" id="img<c:out value="${catEntryIdentifier}"/>" class="itemhover" 
									<c:if test="${showProductQuickView eq 'true'}">
										onfocus="showPopupButton('${prefix}_${catEntryIdentifier}');"
										onkeydown="shiftTabHidePopupButton('${prefix}_${catEntryIdentifier}',event);"
									</c:if>
									onmouseout="javascript:hideBackgroundImage(this);" onmouseover="javascript:showBackgroundImage(this);"
									>
										<c:if test="${addProductDnD eq 'true'}">
											<!--[if lte IE 6.5]><iframe class="productDnDIFrame" scrolling="no" frameborder="0" src="<c:out value="${jspStoreImgDir}" />images/empty.gif"></iframe><![endif]-->
										</c:if>
										<img src="<c:out value='${jspStoreImgDir}' />images/NoImageIcon_sm.jpg" 
												alt="<c:out value='${fn:replace(catEntry.name, search, replaceStr)} ${displayPriceString}' escapeXml='false'/>" 
												border="0" width="70" height="70"/>
									</a>
								</c:otherwise>
							</c:choose>
				<c:if test="${addProductDnD eq 'true'}">
						</div>
					</div>
					<script type="text/javascript">
					dojo.addOnLoad(function() { 
						var widgetText = "<c:out value='${prefix}_${catEntryIDToUse}'/>";
						parseWidget(widgetText);
					});
					</script>
				</c:if>
				</div>
				<c:if test="${showProductQuickView eq 'true'}">
					<c:choose>
						<c:when test="${myAccountPage}">
							<c:choose>
								<c:when test="${contentAreaESpot}">
									<div id="popupButton_${prefix}_${catEntryIdentifier}" class="main_quickinfo_button">
									
										<c:set var="buttonStyle" value="secondary"/>
										<c:set var="buttonAttributes">
											id="WC_CatalogEntryThumbnailDisplayJSPF_${catEntryIdentifier}_div_3"
										</c:set>
										<c:set var="buttonLink">
											<a class="strong" id="QuickInfoButton_${prefix}_${catEntryIdentifier}" href="#"
													onfocus="showPopupButton('${prefix}_${catEntryIdentifier}');"
													onclick="javaScript:var actionListImageAcct = new popupActionProperties(); actionListImageAcct.showProductCompare=false; actionListImageAcct.showWishList=${buyable}; actionListImageAcct.showAddToCart=${buyable}; showPopup('${catalogEntryID}',event,null,'popupButton_${prefix}_${catEntryIdentifier}',actionListImageAcct); return false;"  
													onkeypress="onclick();" onblur="hidePopupButton('${prefix}_${catEntryIdentifier}');" role="wairole:button" waistate:haspopup="true"><fmt:message key="QUICKINFO" bundle="${storeText}"/></a>
																																				
										</c:set>
										<%@ include file="../../ReusableObjects/StoreButton.jspf" %>		
		
											

									</div>
								</c:when>
								<c:otherwise>
									<div id="popupButton_${prefix}_${catEntryIdentifier}" class="main_quickinfo_button">
									
										<c:set var="buttonStyle" value="secondary"/>
										<c:set var="buttonAttributes">
											id="WC_CatalogEntryThumbnailDisplayJSPF_${catEntryIdentifier}_div_5"
										</c:set>
										<c:set var="buttonLink">
											<a class="strong"  id="QuickInfoButton_${prefix}_${catEntryIdentifier}" href="#"
													onfocus="showPopupButton('${prefix}_${catEntryIdentifier}');"
													onclick="javaScript:var actionListImageAcct = new popupActionProperties(); actionListImageAcct.showProductCompare=false; actionListImageAcct.showWishList=false; actionListImageAcct.showAddToCart=${buyable}; showPopup('${catalogEntryID}',event,null,'popupButton_${prefix}_${catEntryIdentifier}',actionListImageAcct); return false;"  
													onkeypress="onclick();" onblur="hidePopupButton('${prefix}_${catEntryIdentifier}');" role="wairole:button" waistate:haspopup="true"><fmt:message key="QUICKINFO" bundle="${storeText}"/></a>
																																																									
										</c:set>
										<%@ include file="../../ReusableObjects/StoreButton.jspf" %>		
		
											
										
									</div>
								</c:otherwise>
							</c:choose>								
						</c:when>					
						<c:otherwise>
							<div id="popupButton_${prefix}_${catEntryIdentifier}" class="main_quickinfo_button">
							
							
								<c:set var="buttonStyle" value="secondary"/>
								<c:set var="buttonAttributes">
									 id="WC_CatalogEntryThumbnailDisplayJSPF_${catEntryIdentifier}_div_7"
								</c:set>
								<c:set var="buttonLink">
									<a class="strong"  id="QuickInfoButton_${prefix}_${catEntryIdentifier}" href="#"
										onfocus="showPopupButton('${prefix}_${catEntryIdentifier}');"
										onclick="javaScript:var actionListImageAcct = new popupActionProperties(); <c:if test="${catEntry.catalogEntryTypeCode == 'DynamicKitBean'}">actionListImageAcct.showProductCompare = false;</c:if> actionListImageAcct.showWishList=${buyable}; actionListImageAcct.showAddToCart=${buyable}; showPopup('${catalogEntryID}',event,null,'popupButton_${prefix}_${catEntryIdentifier}',actionListImageAcct); return false;" 
										onkeypress="onclick();" onblur="hidePopupButton('${prefix}_${catEntryIdentifier}');" role="wairole:button" waistate:haspopup="true"><fmt:message key="QUICKINFO" bundle="${storeText}"/></a>
																																																																	
								</c:set>
								<%@ include file="../../ReusableObjects/StoreButton.jspf" %>	
		

							</div>
						</c:otherwise>	
					</c:choose>		
				</c:if>
			</div>
				
			<div class="description" id="WC_CatalogEntryThumbnailDisplayJSPF_${catEntryIdentifier}_div_9">
				<a id="WC_CatalogEntryThumbnailDisplayJSPF_${catEntryIdentifier}_link_9"
					<c:out value="${ShowProductInNewWindow}"/> href="<c:out value="${catEntryDisplayUrl}" escapeXml="false"/>" >
					<c:out value="${catEntry.name}" escapeXml="false"/>
				</a>
				
			</div>
			<c:choose>
				<c:when test="${isBrazilStore}">
					<%-- begin: use the brazil store price/espot container div --%>
					<c:choose> 
						<%-- Brazil store promotions does not handle Multiple SKU's at this time, that is,
						     promotions at the parent level. Therefore, we'll default to the first item(1st child) of the multiple sku list to 
						     see the promotions  --%>
						<c:when test="${!empty singleSKU && singleSKU == 'false'}">
							<c:set var="currentProductId" value="${catEntry.SKUs[0].uniqueID}" />
						</c:when>
						<c:otherwise>
						<%-- Normal single SKU product  --%>
							<c:set var="currentProductId" value="${catEntryIdentifier}" />
						</c:otherwise>
					</c:choose>
					<div class="brazil_price_espot_container">
						<div class="price brazil_price_container" id="WC_CatalogEntryThumbnailDisplayJSPF_<c:out value='${catEntryIdentifier}'/>_div_10">
							<c:set var="catalogEntry" value="${catEntry}" />
							<%@ include file="../../ReusableObjects/CatalogEntryPriceDisplay.jspf" %>
							<%--
							***
							*     Display the promotions of Brazil Store
							***
							--%>
			 				<%-- Show installment promotion if nonInstallment promotion not showing --%>
				        	<c:if test="${empty nonInstallmentDiscountMap}">
								<div class="promo_price" id="WC_CatalogEntryThumbnailDisplayJSPF_<c:out value='${catEntryIdentifier}'/>_eSpot_div_1">
									<% out.flush(); %>
			    	                <c:import url="${jspStoreDir}Snippets/Marketing/ESpot/ESpotNavDisplay.jsp">
			        	                       <c:param name="storeId" value="${WCParam.storeId}" />
			            	                   <c:param name="catalogId" value="${catalogId}" />
			                	               <c:param name="langId" value="${langId}" />
			                    	           <c:param name="emsName" value="${eSpotPaymentPromotion}" />
			                    	           <c:param name="currentProductId" value="${currentProductId}" />
			                        	       <c:param name="adclass" value="no_ad" />
			                            	   <c:param name="showPaymentDiscountPromotion" value="true" />
									</c:import> 
									<% out.flush(); %> 
								</div>
			        		</c:if>
						    <%--clean up, no longer need nonInstallmentDiscountMap, prepare for next featured item --%>
						    <c:if test='${!empty nonInstallmentDiscountMap}'>
						    	<c:remove var="nonInstallmentDiscountMap" /> 
						    </c:if>
						<%-- end: use the brazil store price container div --%>
						</div>
						<%-- 
						***
						* Pass the current product ID being displayed on this page to check for an eSpot activity
						***
						--%>
						<%-- Show Free Shipping Promotion --%> 
						<div id="WC_CatalogEntryThumbnailDisplayJSPF_<c:out value='${catEntryIdentifier}'/>_eSpot_div_2">
							<%-- Flush the buffer so this fragment JSP is not cached twice --%>
							<%out.flush();%>
							
			                <c:import url="${jspStoreDir}Snippets/Marketing/ESpot/ESpotNavDisplay.jsp">
			                        <c:param name="storeId" value="${WCParam.storeId}" />
			                        <c:param name="catalogId" value="${catalogId}" />
			                        <c:param name="langId" value="${langId}" />
			                        <c:param name="emsName" value="${eSpotFreeShipping}" />
			                        <c:param name="currentProductId" value="${currentProductId}" />
			                        <c:param name="adclass" value="no_ad" />
							</c:import> 
							<%out.flush();%>
						</div>
					</div>
					<c:remove var="currentProductId" /> <%--remove, no longer needed --%>
				<%--
				***
				* End: Display the promotions if BrazilStore feature is enable!
				***
				--%>

				</c:when>
				<c:otherwise>
					<div class="price" id="WC_CatalogEntryThumbnailDisplayJSPF_<c:out value='${catEntryIdentifier}'/>_div_10">
							<c:set var="catalogEntry" value="${catEntry}" />
							<%@ include file="../../ReusableObjects/CatalogEntryPriceDisplay.jspf" %>
					</div>					
				</c:otherwise>
			</c:choose>
			<div class="button" id="WC_CatalogEntryThumbnailDisplayJSPF_<c:out value='${catEntryIdentifier}'/>_div_11">
					<c:choose>
						<c:when test="${buyable}" >
							<flow:ifDisabled feature="HidePurchaseButton"> 
								<flow:ifEnabled feature="AjaxAddToCart"> 
									<div id="add2CartPopupButton_${catEntry.uniqueID}">
										<c:choose>
											<c:when test="${dragType == 'dynamicKit'}">
												<%@ include file="../../../ShoppingArea/Configurator/CatalogEntryThumbnailDisplayForDynamicKits.jspf" %>
											</c:when>										
											<c:when test="${dragType == 'item' || dragType == 'package' || (singleSKU == true && dragType == 'product')}">
											
													<c:set var="buttonStyle" value="primary"/>
													<c:set var="buttonAttributes">
														id="WC_CatalogEntryThumbnailDisplayJSPF_${catEntryIdentifier}_div_12"		
													</c:set>
													<c:set var="buttonLink">
														<a href="javascript: setCurrentId('WC_CatalogEntryThumbnailDisplayJSPF_${catEntryIdentifier}_links_1'); categoryDisplayJS.AddItem2ShopCartAjax('${catEntryIDToUse}',1)" id="WC_CatalogEntryThumbnailDisplayJSPF_${catEntryIdentifier}_links_1" waistate:controls="MiniShoppingCart"><fmt:message key="ADDTOCART" bundle="${storeText}"/></a>
													</c:set>
													<%@ include file="../../ReusableObjects/StoreButton.jspf" %>		
													
																				
											</c:when>
											<c:otherwise>
											
												<c:set var="buttonStyle" value="primary"/>
												<c:set var="buttonAttributes">
													id="WC_CatalogEntryThumbnailDisplayJSPF_${catEntryIdentifier}_div_14"
												</c:set>
												<c:set var="buttonLink">
													<a href="javascript:;" onkeypress="javascript: showPopup('${catalogEntryID}',event, null, 'add2CartPopupButton_${catEntry.uniqueID}')" onclick="javascript: showPopup('${catalogEntryID}',event, null, 'add2CartPopupButton_${catEntry.uniqueID}')" id="WC_CatalogEntryThumbnailDisplayJSPF_${catEntryIdentifier}_links_2" waistate:controls="MiniShoppingCart"><fmt:message key="ADDTOCART" bundle="${storeText}"/></a>
												</c:set>
												<%@ include file="../../ReusableObjects/StoreButton.jspf" %>		
		
													

											</c:otherwise>
										</c:choose>
									</div>
								</flow:ifEnabled>

								<flow:ifDisabled feature="AjaxAddToCart">
								<div id="add2CartPopupButton_${catEntry.uniqueID}">
									<c:choose>
										<c:when test="${dragType == 'dynamicKit'}">
											<%@ include file="../../../ShoppingArea/Configurator/CatalogEntryThumbnailDisplayForDynamicKits.jspf" %>
										</c:when>										
										<c:when test="${dragType == 'item' || dragType == 'package' || (singleSKU == true && dragType == 'product')}">
										
											<c:set var="buttonStyle" value="primary"/>
											<c:set var="buttonAttributes">
												id="WC_CatalogEntryThumbnailDisplayJSPF_${catEntryIdentifier}_div_16"
											</c:set>
											<c:set var="buttonLink">
												<a  href="#" onclick="javascript: categoryDisplayJS.AddItem2ShopCart(document.getElementById('OrderItemAddForm_${catEntryIDToUse}'),1);return false;" id="WC_CatalogEntryThumbnailDisplayJSPF_${catEntryIdentifier}_links_3" waistate:controls="MiniShoppingCart"><fmt:message key="ADDTOCART" bundle="${storeText}"/></a>
											</c:set>
											<%@ include file="../../ReusableObjects/StoreButton.jspf" %>	
		
												
											
										</c:when>
										<c:otherwise>
										
												<c:set var="buttonStyle" value="primary"/>
												<c:set var="buttonAttributes">
													id="WC_CatalogEntryThumbnailDisplayJSPF_${catEntryIdentifier}_div_18"
												</c:set>
												<c:set var="buttonLink">
																<a  href="javascript:;" onkeypress="javascript: showPopup('${catalogEntryID}',event, null, 'add2CartPopupButton_${catEntry.uniqueID}')" onclick="javascript: showPopup('${catalogEntryID}',event, null, 'add2CartPopupButton_${catEntry.uniqueID}')" id="WC_CatalogEntryThumbnailDisplayJSPF_${catEntryIdentifier}_links_4" waistate:controls="MiniShoppingCart"><fmt:message key="ADDTOCART" bundle="${storeText}"/></a>
												</c:set>
												<%@ include file="../../ReusableObjects/StoreButton.jspf" %>	
												
										</c:otherwise>
									</c:choose>
								</div>
							</flow:ifDisabled>
							</flow:ifDisabled>
						</c:when>
						<c:otherwise>
							<fmt:message key="SKU_NOT_BUYABLE" bundle="${storeText}" />
						</c:otherwise>
					</c:choose>
			</div>
		
		<c:if test="${addProductDnD eq 'true'}">
			<script type="text/javaScript">
				dojo.addOnLoad(function() {
					var src= new dojo.dnd.Source("${prefix}_${catEntryIDToUse}");
					src.copyOnly=true;
					src.setItem('imgPath','${catEntry.thumbnail}');
					src.setItem('productDisplayPath','${catEntryDisplayUrl}');
				});
				
			</script>
		</c:if>
	</c:when>
	<c:when test="${pageView == 'detailed' || pageView == 'detailedMyAccount'}">
				<tr>
				<td class="image" id="WC_CatalogEntryThumbnailDisplayJSPF_${catEntryIdentifier}_td_1">
					<div id="baseContent_${prefix}_<c:out value='${catEntryIdentifier}'/>" 
						<c:if test="${showProductQuickView eq 'true'}">
							onmouseover="showPopupButton('${prefix}_${catEntryIdentifier}');" onmouseout="hidePopupButton('${prefix}_${catEntryIdentifier}');"
						</c:if>
						<c:if test="${pageView == 'detailedMyAccount'}">
							class="image_wrapper"
						</c:if>
						>
						<c:if test="${addProductDnD eq 'true'}">
						
							<c:set var="dragTypeToUse" value="${dragType}"/>
							<c:if test="${singleSKU == true && dragType == 'product'}">
								<c:set var="dragTypeToUse" value="item"/>
							</c:if>
						
							<div dojoType="dojo.dnd.Source" jsId="dndSource" id="${prefix}_${catEntryIDToUse}" copyOnly="true" dndType="${dragTypeToUse}">
								<div class="dojoDndItem" dndType="${dragType}" id="WC_CatalogEntryThumbnailDisplayJSPF_${catEntryIdentifier}_div_20">
						</c:if>
								<c:choose>
									<c:when test="${!empty catEntry.thumbnail}">
										<a ${ShowProductInNewWindow} href="<c:out value="${catEntryDisplayUrl}" escapeXml="false"/>" id="img<c:out value="${catEntryIdentifier}"/>" class="itemhover"
										<c:if test="${showProductQuickView eq 'true'}">
											onfocus="showPopupButton('${prefix}_${catEntryIdentifier}');"
											onkeydown="shiftTabHidePopupButton('${prefix}_${catEntryIdentifier}',event);"
										</c:if>
										onmouseout="javascript:hideBackgroundImage(this);" onmouseover="javascript:showBackgroundImage(this);"
										>
											<c:if test="${addProductDnD eq 'true'}">
												<!--[if lte IE 6.5]><iframe class="productDnDIFrame" scrolling="no" frameborder="0" src="<c:out value="${jspStoreImgDir}" />images/empty.gif"></iframe><![endif]-->
											</c:if>
											<img src="<c:out value='${catEntry.thumbnail}'/>" 
													alt="<c:out value='${fn:replace(catEntry.name, search, replaceStr)} ${displayPriceString}' escapeXml='false'/>" 
													border="0" width="70" height="70"/>
										</a>
									</c:when>
									<c:otherwise>
										<a ${ShowProductInNewWindow} href="<c:out value="${catEntryDisplayUrl}" escapeXml="false"/>" id="img<c:out value="${catEntryIdentifier}"/>" class="itemhover"
										<c:if test="${showProductQuickView eq 'true'}">
											onfocus="showPopupButton('${prefix}_${catEntryIdentifier}');"
											onkeydown="shiftTabHidePopupButton('${prefix}_${catEntryIdentifier}',event);"
										</c:if>
										onmouseout="javascript:hideBackgroundImage(this);" onmouseover="javascript:showBackgroundImage(this);"
										>
											<c:if test="${addProductDnD eq 'true'}">
												<!--[if lte IE 6.5]><iframe class="productDnDIFrame" scrolling="no" frameborder="0" src="<c:out value="${jspStoreImgDir}" />images/empty.gif"></iframe><![endif]-->
											</c:if>
											<img src="<c:out value='${jspStoreImgDir}' />images/NoImageIcon_sm.jpg" 
													alt="<c:out value='${fn:replace(catEntry.name, search, replaceStr)} ${displayPriceString}' escapeXml='false'/>" 
													border="0" width="70" height="70"/>
										</a>
									</c:otherwise>
								</c:choose>
						<c:if test="${addProductDnD eq 'true'}">
								</div>
							</div>
							<script type="text/javascript">
							dojo.addOnLoad(function() { 
								var widgetText = "<c:out value='${prefix}_${catEntryIDToUse}'/>";
								parseWidget(widgetText);
							});
							</script>
						</c:if>
						<c:if test="${showProductQuickView eq 'true'}">
							<c:choose>
								<c:when test="${myAccountPage}">
									<c:choose>
										<c:when test="${contentAreaESpot}">
											<div id="popupButton_${prefix}_${catEntryIdentifier}" class="main_quickinfo_button">
											
													<c:set var="buttonStyle" value="secondary"/>
													<c:set var="buttonAttributes">
														id="WC_CatalogEntryThumbnailDisplayJSPF_${catEntryIdentifier}_div_21"
													</c:set>
													<c:set var="buttonLink">
														<a class="strong"  id="QuickInfoButton_${prefix}_${catEntryIdentifier}" href="#"
																onfocus="showPopupButton('${prefix}_${catEntryIdentifier}');"
																onclick="javaScript:var actionListDetailedAcct = new popupActionProperties(); actionListDetailedAcct.showProductCompare=false; actionListDetailedAcct.showWishList=${buyable}; actionListDetailedAcct.showAddToCart=${buyable}; showPopup('${catalogEntryID}',event,null,'popupButton_${prefix}_${catEntryIdentifier}',actionListDetailedAcct); return false;" 
																onkeypress="onclick();" onblur="hidePopupButton('${prefix}_${catEntryIdentifier}');" role="wairole:button" waistate:haspopup="true"><fmt:message key="QUICKINFO" bundle="${storeText}"/></a>
																																																																																				
													</c:set>
													<%@ include file="../../ReusableObjects/StoreButton.jspf" %>	
													
																								
												
											</div>
										</c:when>
										<c:otherwise>
											<div id="popupButton_${prefix}_${catEntryIdentifier}" class="main_quickinfo_button">
											
												<c:set var="buttonStyle" value="secondary"/>
												<c:set var="buttonAttributes">
													id="WC_CatalogEntryThumbnailDisplayJSPF_${catEntryIdentifier}_div_23"
												</c:set>
												<c:set var="buttonLink">
													<a class="strong"  id="QuickInfoButton_${prefix}_${catEntryIdentifier}" href="#"
														onfocus="showPopupButton('${prefix}_${catEntryIdentifier}');"
														onclick="javaScript:var actionListDetailedAcct = new popupActionProperties(); actionListDetailedAcct.showProductCompare=false; actionListDetailedAcct.showWishList=false; actionListDetailedAcct.showAddToCart=${buyable}; showPopup('${catalogEntryID}',event,null,'popupButton_${prefix}_${catEntryIdentifier}',actionListDetailedAcct); return false;" 
														onkeypress="onclick();" onblur="hidePopupButton('${prefix}_${catEntryIdentifier}');" role="wairole:button" waistate:haspopup="true"><fmt:message key="QUICKINFO" bundle="${storeText}"/></a>
																																																																																																
												</c:set>
												<%@ include file="../../ReusableObjects/StoreButton.jspf" %>	
		

											</div>
										</c:otherwise>
									</c:choose>
								</c:when>
								<c:otherwise>
									<div id="popupButton_${prefix}_${catEntryIdentifier}" class="main_quickinfo_button">	
									
											<c:set var="buttonStyle" value="secondary"/>
											<c:set var="buttonAttributes">
												id="WC_CatalogEntryThumbnailDisplayJSPF_${catEntryIdentifier}_div_25"
											</c:set>
											<c:set var="buttonLink">
												<a class="strong"  id="QuickInfoButton_${prefix}_${catEntryIdentifier}" href="#"
													onfocus="showPopupButton('${prefix}_${catEntryIdentifier}');"
													onclick="javaScript:var actionListDetailedAcct = new popupActionProperties(); <c:if test="${catEntry.catalogEntryTypeCode == 'DynamicKitBean'}">actionListImageAcct.showProductCompare = false;</c:if> actionListDetailedAcct.showWishList=${buyable}; actionListDetailedAcct.showAddToCart=${buyable}; showPopup('${catalogEntryID}',event,null,'popupButton_${prefix}_${catEntryIdentifier}',actionListDetailedAcct); return false;" 
													onkeypress="onclick();" onblur="hidePopupButton('${prefix}_${catEntryIdentifier}');" role="wairole:button" waistate:haspopup="true"><fmt:message key="QUICKINFO" bundle="${storeText}"/></a>
																																																																																																												
											</c:set>
											<%@ include file="../../ReusableObjects/StoreButton.jspf" %>
		
			

									</div>
								</c:otherwise>
							</c:choose>
						</c:if>
					</div>
				</td>
				<td class="desc" id="WC_CatalogEntryThumbnailDisplayJSPF_${catEntryIdentifier}_td_2">
					<c:if test="${pageView == 'detailedMyAccount'}">
						<div class="information">
							<h3><c:out value="${catEntry.name}" escapeXml="false"/></h3>
							<p class="brand"><c:out value="${catEntry.shortDescription}" escapeXml="false"/></p>
						</div>
					</c:if>
					<c:if test="${pageView == 'detailed'}">
						<p class="brand"><c:out value="${catEntry.name}" escapeXml="false"/></p>
						<p class="brand"><c:out value="${catEntry.shortDescription}" escapeXml="false"/></p>
					</c:if>					
				</td>
				<td class="price1" id="WC_CatalogEntryThumbnailDisplayJSPF_${catEntryIdentifier}_td_3">					
						<p <c:if test="${pageView == 'detailedMyAccount'}">class="price"</c:if> >	
								<c:set var="catalogEntry" value="${catEntry}" />
								<%@ include file="../../ReusableObjects/CatalogEntryPriceDisplay.jspf" %>
						</p>				
				</td>
				<td class="addbutton" id="WC_CatalogEntryThumbnailDisplayJSPF_${catEntryIdentifier}_td_4">
					<c:choose>
					<c:when test="${buyable && pageView == 'detailed'}" >
						<flow:ifEnabled feature="AjaxAddToCart"> 
							<c:choose>
								<c:when test="${dragType == 'dynamicKit'}">
									<%@ include file="../../../ShoppingArea/Configurator/CatalogEntryThumbnailDisplayForDynamicKits.jspf" %>
								</c:when>							
								<c:when test="${dragType == 'item' || dragType == 'package' || (singleSKU == true && dragType == 'product')}">
									<a href="javascript: setCurrentId('WC_CatalogEntryThumbnailDisplayJSPF_${catEntryIdentifier}_links_5'); categoryDisplayJS.AddItem2ShopCartAjax('${catEntryIDToUse}',1)" class="wishlist_detailed_link" id="WC_CatalogEntryThumbnailDisplayJSPF_${catEntryIdentifier}_links_5" waistate:controls="MiniShoppingCart"><fmt:message key="ADDTOCART" bundle="${storeText}"/></a>
								</c:when>
								<c:otherwise>
									<a href="javascript:;" onclick="javascript: showPopup('${catalogEntryID}',event)" class="wishlist_detailed_link" id="WC_CatalogEntryThumbnailDisplayJSPF_${catEntryIdentifier}_links_6" waistate:controls="MiniShoppingCart"><fmt:message key="ADDTOCART" bundle="${storeText}"/></a>						
								</c:otherwise>
							</c:choose>
						</flow:ifEnabled>
						
						<flow:ifDisabled feature="AjaxAddToCart">
							<c:choose>						
								<c:when test="${dragType == 'dynamicKit'}">
									<%@ include file="../../../ShoppingArea/Configurator/CatalogEntryThumbnailDisplayForDynamicKits.jspf" %>
								</c:when>							
								<c:when test="${dragType == 'item' || dragType == 'package' || (singleSKU == true && dragType == 'product')}">
									<a href="#" onclick="javascript: categoryDisplayJS.AddItem2ShopCart(document.getElementById('OrderItemAddForm_${catEntryIDToUse}'),1);return false;" class="wishlist_detailed_link" id="WC_CatalogEntryThumbnailDisplayJSPF_${catEntryIdentifier}_links_7" waistate:controls="MiniShoppingCart"><fmt:message key="ADDTOCART" bundle="${storeText}"/></a>
								</c:when>
								<c:otherwise>
									<a href="javascript:;" onclick="javascript: showPopup('${catalogEntryID}', event)" class="wishlist_detailed_link" id="WC_CatalogEntryThumbnailDisplayJSPF_${catEntryIdentifier}_links_8" waistate:controls="MiniShoppingCart"><fmt:message key="ADDTOCART" bundle="${storeText}"/></a>
								</c:otherwise>
							</c:choose>
						</flow:ifDisabled>
						<c:if test="${wishListPage}">
							<flow:ifDisabled feature="AjaxMyAccountPage">
								<a href="<c:out value="${interestItemDeleteURL}"/>" class="wishlist_detailed_link" id="WC_CatalogEntryThumbnailDisplayJSPF_${catEntryIdentifier}_links_9"><fmt:message key="WISHLIST_REMOVE" bundle="${storeText}" /></a>
							</flow:ifDisabled>
							<flow:ifEnabled feature="AjaxMyAccountPage">
								<a href="javaScript:AccountWishListDisplay.deleteInterestItem({catEntryId:'${catalogEntryID}',storeId:'<c:out value="${WCParam.storeId}"/>', catalogId:'<c:out value="${WCParam.catalogId}"/>', langId:'${langId}'},'${WishListResultDisplay}')" class="wishlist_detailed_link" id="WC_CatalogEntryThumbnailDisplayJSPF_${catEntryIdentifier}_links_10"><fmt:message key="WISHLIST_REMOVE" bundle="${storeText}" /></a>
							</flow:ifEnabled>
						</c:if>
					</c:when>
					<c:when test="${buyable && pageView == 'detailedMyAccount'}" >
						<flow:ifEnabled feature="AjaxAddToCart"> 
								<div id="add2CartPopupButton_${catEntryIdentifier}" class="button_wrapper">
									<c:choose>
										<c:when test="${dragType == 'dynamicKit'}">
											<%@ include file="../../../ShoppingArea/Configurator/CatalogEntryThumbnailDisplayForDynamicKits.jspf" %>
										</c:when>										
										<c:when test="${dragType == 'item' || dragType == 'package' || (singleSKU == true && dragType == 'product')}">
										
												<c:set var="buttonStyle" value="primary"/>
												<c:set var="buttonAttributes">
													id="WC_CatalogEntryThumbnailDisplayJSPF_${catEntryIdentifier}_div_12"
												</c:set>
												<c:set var="buttonLink">
															<a href="javascript: setCurrentId('WC_CatalogEntryThumbnailDisplayJSPF_${catEntryIdentifier}_links_1'); categoryDisplayJS.AddItem2ShopCartAjax('${catEntryIDToUse}',1)" id="WC_CatalogEntryThumbnailDisplayJSPF_${catEntryIdentifier}_links_1" waistate:controls="MiniShoppingCart"><fmt:message key="ADDTOCART" bundle="${storeText}"/></a>
												</c:set>
												<%@ include file="../../ReusableObjects/StoreButton.jspf" %>	
		
												
										
										</c:when>
										<c:otherwise>

													<c:set var="buttonStyle" value="primary"/>
													<c:set var="buttonAttributes">
														id="WC_CatalogEntryThumbnailDisplayJSPF_${catEntryIdentifier}_div_14"
													</c:set>
													<c:set var="buttonLink">
																<a href="javascript:;" onkeypress="javascript: showPopup('${catalogEntryID}', event, null, 'add2CartPopupButton_${catEntry.uniqueID}')" onclick="javascript: showPopup('${catalogEntryID}', event, null, 'add2CartPopupButton_${catEntry.uniqueID}')" id="WC_CatalogEntryThumbnailDisplayJSPF_${catEntryIdentifier}_links_2" waistate:controls="MiniShoppingCart"><fmt:message key="ADDTOCART" bundle="${storeText}"/></a>
													</c:set>
													<%@ include file="../../ReusableObjects/StoreButton.jspf" %>	


											
										</c:otherwise>
									</c:choose>
								</div>
							</flow:ifEnabled>

							<flow:ifDisabled feature="AjaxAddToCart">
								<div id="add2CartPopupButton_${catEntryIdentifier}" class="button_wrapper">
									<c:choose>
										<c:when test="${dragType == 'dynamicKit'}">
											<%@ include file="../../../ShoppingArea/Configurator/CatalogEntryThumbnailDisplayForDynamicKits.jspf" %>
										</c:when>										
										<c:when test="${dragType == 'item' || dragType == 'package' || (singleSKU == true && dragType == 'product')}">
										
												<c:set var="buttonStyle" value="primary"/>
												<c:set var="buttonAttributes">
													 id="WC_CatalogEntryThumbnailDisplayJSPF_${catEntryIdentifier}_div_16"
												</c:set>
												<c:set var="buttonLink">
															<a  href="#" onclick="javascript: categoryDisplayJS.AddItem2ShopCart(document.getElementById('OrderItemAddForm_${catEntryIDToUse}'),1);return false;" id="WC_CatalogEntryThumbnailDisplayJSPF_${catEntryIdentifier}_links_3" waistate:controls="MiniShoppingCart"><fmt:message key="ADDTOCART" bundle="${storeText}"/></a>
												</c:set>
												<%@ include file="../../ReusableObjects/StoreButton.jspf" %>	
		

										</c:when>
										<c:otherwise>

												<c:set var="buttonStyle" value="primary"/>
												<c:set var="buttonAttributes">
													 id="WC_CatalogEntryThumbnailDisplayJSPF_${catEntryIdentifier}_div_18"
												</c:set>
												<c:set var="buttonLink">
																<a  href="javascript:;" onkeypress="javascript: showPopup('${catalogEntryID}', event, null, 'add2CartPopupButton_${catEntry.uniqueID}')" onclick="javascript: showPopup('${catalogEntryID}', event, null, 'add2CartPopupButton_${catEntry.uniqueID}')" id="WC_CatalogEntryThumbnailDisplayJSPF_${catEntryIdentifier}_links_4" waistate:controls="MiniShoppingCart"><fmt:message key="ADDTOCART" bundle="${storeText}"/></a>
										
												</c:set>
												<%@ include file="../../ReusableObjects/StoreButton.jspf" %>	

	
										</c:otherwise>
									</c:choose>
								</div>
							</flow:ifDisabled>					
					</c:when>
					<c:otherwise>
						<c:if test="${pageView eq 'detailedMyAccount'}">
							<div class="button_wrapper">
						</c:if>
						<fmt:message key="SKU_NOT_BUYABLE" bundle="${storeText}" />
						<c:if test="${pageView eq 'detailedMyAccount'}">
							</div>
						</c:if>						
					</c:otherwise>
					</c:choose>
				</td>
		</tr>
		<c:if test="${addProductDnD eq 'true'}">
			<script type="text/javaScript">
				dojo.addOnLoad(function() { 
					var src= new dojo.dnd.Source("${prefix}_${catEntryIDToUse}");
					src.copyOnly=true;
					src.setItem('imgPath','${catEntry.thumbnail}');
					src.setItem('productDisplayPath','${catEntryDisplayUrl}');
				});
				
			</script>
		</c:if>
	</c:when>
	<c:when test="${pageView == 'scrollESpot' || pageView == 'scrollSideBarESpot'}">
		<div id="item_8_<c:out value='${emsName}'/>_<c:out value='${catEntryIdentifier}'/>">
			<div id="baseContent_${prefix}<c:out value='${emsName}'/>_<c:out value='${catEntryIdentifier}'/>" 
				<c:if test="${showProductQuickView eq 'true'}">
					onmouseover="showPopupButton('${prefix}${emsName}_${catEntryIdentifier}');" onmouseout="hidePopupButton('${prefix}${emsName}_${catEntryIdentifier}');"
				</c:if>
				>
				<div class="img" id="WC_CatalogEntryThumbnailDisplayJSPF_${emsName}_${catEntryIdentifier}_div_27">
				<c:if test="${addProductDnD eq 'true'}">
					<div dojoType="dojo.dnd.Source" jsId="dndSource" id="${prefix}${emsName}_${catEntryIDToUse}" copyOnly="true" dndType="${dragType}">
						<div class="dojoDndItem" dndType="${dragType}" id="WC_CatalogEntryThumbnailDisplayJSPF_${emsName}_${catEntryIdentifier}_div_28">
				</c:if>
							<c:choose>
								<c:when test="${pageView == 'scrollSideBarESpot'}">


									<c:forEach items="${catEntry.attachments}" var="attachment">
											<c:if test="${'IMAGE_SIZE_55' == attachment.usage}">
												<c:set var="image55Attachment" value="${attachment}" />
											</c:if>
									</c:forEach>	
									
									<c:choose>
											<c:when test="${!empty image55Attachment}">
												<c:set var="catEntryImagePath" value="${staticAssetContextRoot}/${image55Attachment.attachmentAssetPath}" />
											</c:when>
											<c:otherwise>
												<c:set var="catEntryImagePath" value="${jspStoreImgDir}images/NoImageIcon_sm45.jpg" />
											</c:otherwise>
									 </c:choose>
							
									<a ${ShowProductInNewWindow} href="<c:out value="${catEntryDisplayUrl}" escapeXml="false"/>" id="img<c:out value='${emsName}'/><c:out value="${catEntryIdentifier}"/>">
										<c:if test="${addProductDnD eq 'true'}">
											<!--[if lte IE 6.5]><iframe class="productDnDIFrame" scrolling="no" frameborder="0" src="<c:out value="${jspStoreImgDir}" />images/empty.gif"></iframe><![endif]-->
										</c:if>
										<img src="<c:out value='${catEntryImagePath}'/>" 
												alt="<c:out value='${fn:replace(catEntry.name, search, replaceStr)} ${displayPriceString}' escapeXml='false'/>" 
												border="0" width="55" height="55"/>
									</a>
								</c:when>							
								<c:when test="${!empty catEntry.thumbnail}">
									<a ${ShowProductInNewWindow} href="<c:out value="${catEntryDisplayUrl}" escapeXml="false"/>" id="img<c:out value='${emsName}'/><c:out value="${catEntryIdentifier}"/>"
										<c:if test="${showProductQuickView eq 'true'}">
											onfocus="showPopupButton('${prefix}${emsName}_${catEntryIdentifier}');"
											onkeydown="shiftTabHidePopupButton('${prefix}${emsName}_${catEntryIdentifier}',event);"
										</c:if>
										>
										<c:if test="${addProductDnD eq 'true'}">
											<!--[if lte IE 6.5]><iframe class="productDnDIFrame" scrolling="no" frameborder="0" src="<c:out value="${jspStoreImgDir}" />images/empty.gif"></iframe><![endif]-->
										</c:if>
										<img src="<c:out value='${catEntry.thumbnail}'/>" 
												alt="<c:out value='${fn:replace(catEntry.name, search, replaceStr)} ${displayPriceString}' escapeXml='false'/>" 
												border="0" width="70" height="70"/>
									</a>
								</c:when>
								<c:otherwise>
									<a ${ShowProductInNewWindow} href="<c:out value="${catEntryDisplayUrl}" escapeXml="false"/>" id="img<c:out value='${emsName}'/><c:out value="${catEntryIdentifier}"/>"
										<c:if test="${showProductQuickView eq 'true'}">
											onfocus="showPopupButton('${prefix}${emsName}_${catEntryIdentifier}');"
											onkeydown="shiftTabHidePopupButton('${prefix}${emsName}_${catEntryIdentifier}',event);"
										</c:if>
										>
										<c:if test="${addProductDnD eq 'true'}">
											<!--[if lte IE 6.5]><iframe class="productDnDIFrame" scrolling="no" frameborder="0" src="<c:out value="${jspStoreImgDir}" />images/empty.gif"></iframe><![endif]-->
										</c:if>
										<img src="<c:out value='${jspStoreImgDir}' />images/NoImageIcon_sm.jpg" 
											alt="<c:out value='${fn:replace(catEntry.name, search, replaceStr)} ${displayPriceString}' escapeXml='false'/>" 
											border="0" width="70" height="70"/>
									</a>
								</c:otherwise>
							</c:choose>
				<c:if test="${addProductDnD eq 'true'}">
						</div>
					</div>
				</c:if>
				</div>
				<c:if test="${showProductQuickView eq 'true'}">
					<div class="button_fit_padder">
						<div id="popupButton_${prefix}${emsName}_${catEntryIdentifier}" class="main_quickinfo_button">
						
							<c:set var="buttonStyle" value="secondary"/>
							<c:set var="buttonAttributes">
								id="WC_CatalogEntryThumbnailDisplayJSPF_${emsName}_${catEntryIdentifier}_div_29"
							</c:set>
							<c:set var="buttonLink">
								<a class="strong"  id="QuickInfoButton_${prefix}${emsName}_${catEntryIdentifier}" href="#"
									onfocus="showPopupButton('${prefix}${emsName}_${catEntryIdentifier}');"
									onclick="javaScript:var actionListScroll = new popupActionProperties(); actionListScroll.showProductCompare=<c:out value='${param.showProductCompareInQuickInfo}' default='false'/>; actionListScroll.showWishList=${buyable}; actionListScroll.showAddToCart=${buyable}; showPopup('${catalogEntryID}',event,null,'popupButton_${prefix}${emsName}_${catEntryIdentifier}',actionListScroll); return false;"  
									onkeypress="javaScript:var actionListScroll = new popupActionProperties(); actionListScroll.showProductCompare=<c:out value='${param.showProductCompareInQuickInfo}' default='false'/>; actionListScroll.showWishList=${buyable}; actionListScroll.showAddToCart=${buyable}; showPopup('${catalogEntryID}',event,null,'popupButton_${prefix}${emsName}_${catEntryIdentifier}',actionListScroll);" onblur="hidePopupButton('${prefix}${emsName}_${catEntryIdentifier}');" role="wairole:button" waistate:haspopup="true"><fmt:message key="QUICKINFO" bundle="${storeText}"/></a>
																																																																																																																
							</c:set>
							<%@ include file="../../ReusableObjects/StoreButton.jspf" %>
		
		
		

						</div>
					</div>
				</c:if>
			</div>
				
			<div class="scrollPaneDescription" id="WC_CatalogEntryThumbnailDisplayJSPF_${emsName}_${catEntryIdentifier}_div_31">
				<c:set var="itemDescription" value="${catEntry.name}"/>
				<c:if test="${pageView == 'scrollSideBarESpot'}">
						<%--This is the variable that controls how many characters from the wish list name are displayed before dots are added as suffix --%>
						<c:set var="maxCharsToDisplay" value="30"/>
						<%-- for double byte, we need to lower the maximum number of characters to be displayed --%>
						<c:if test="${CommandContext.locale == 'zh_TW' || CommandContext.locale == 'ja_JP' || CommandContext.locale == 'zh_CN' || CommandContext.locale == 'ko_KR'}" >
							<c:set var="maxCharsToDisplay" value="${maxCharsToDisplay/2}"/>
						</c:if>
						
						<c:if test="${fn:length(itemDescription) > maxCharsToDisplay}">
							<c:set var="itemDescription" value="${fn:substring(catEntry.name, 0, maxCharsToDisplay)}..."/>
						</c:if>
				</c:if>
				<a ${ShowProductInNewWindow} href="<c:out value="${catEntryDisplayUrl}" escapeXml="false"/>" title="<c:out value='${catEntry.name}' escapeXml='false'/>" >
					<c:out value="${itemDescription}" escapeXml="false"/>
				</a>
			</div>
			<div class="scrollPanePrice" id="WC_CatalogEntryThumbnailDisplayJSPF_${emsName}_${catEntryIdentifier}_div_32">
					<c:set var="catalogEntry" value="${catEntry}" />
					<%@ include file="../../ReusableObjects/CatalogEntryPriceDisplay.jspf" %>
			</div>
			
		</div>
		<c:if test="${pageView == 'scrollESpot'}">
			<c:choose>
				<c:when test="${buyable}" >
					<flow:ifDisabled feature="HidePurchaseButton"> 
						<flow:ifEnabled feature="AjaxAddToCart"> 
							<c:choose>
								<c:when test="${dragType == 'dynamicKit'}">
									<%@ include file="../../../ShoppingArea/Configurator/CatalogEntryThumbnailDisplayForDynamicKits.jspf" %>
								</c:when>	
								
								<c:when test="${dragType == 'item' || dragType == 'package' || (singleSKU == true && dragType == 'product')}">
									<div class="button_fit_padder">
									
										<c:set var="buttonStyle" value="primary"/>
										<c:set var="buttonAttributes">
											id="WC_CatalogEntryThumbnailDisplayJSPF_${emsName}_${catEntryIdentifier}_div_33"
										</c:set>
										<c:set var="buttonLink">
												<a href="javascript: setCurrentId('WC_CatalogEntryThumbnailDisplayJSPF_${emsName}_${catEntryIdentifier}_links_11'); categoryDisplayJS.AddItem2ShopCartAjax('${catEntryIDToUse}',1)" id="WC_CatalogEntryThumbnailDisplayJSPF_${emsName}_${catEntryIdentifier}_links_11" waistate:controls="MiniShoppingCart"><fmt:message key="ADDTOCART" bundle="${storeText}"/></a>
								
										</c:set>
										<%@ include file="../../ReusableObjects/StoreButton.jspf" %>
		
											
									
									</div>
								</c:when>
								<c:otherwise>
									<div class="button_fit_padder">
									
										<c:set var="buttonStyle" value="primary"/>
										<c:set var="buttonAttributes">
											id="WC_CatalogEntryThumbnailDisplayJSPF_${emsName}_${catEntryIdentifier}_div_35"
										</c:set>
										<c:set var="buttonLink">
															<a id="WC_CatalogEntryThumbnailDisplayJSPF_${emsName}_${catEntryIdentifier}_links_11" href="javascript:;"  onclick="javascript:var actionListScroll = new popupActionProperties(); actionListScroll.showProductCompare=<c:out value='${param.showProductCompareInQuickInfo}' default='false'/>; actionListScroll.showWishList=${buyable}; actionListScroll.showAddToCart=${buyable}; showPopup('${catalogEntryID}', event, null, null, actionListScroll);" onkeypress="javascript:var actionListScroll = new popupActionProperties(); actionListScroll.showProductCompare=<c:out value='${param.showProductCompareInQuickInfo}' default='false'/>; actionListScroll.showWishList=${buyable}; actionListScroll.showAddToCart=${buyable}; showPopup('${catalogEntryID}', event, null, null, actionListScroll)" waistate:controls="MiniShoppingCart"><fmt:message key="ADDTOCART" bundle="${storeText}"/></a>
								
										</c:set>
										<%@ include file="../../ReusableObjects/StoreButton.jspf" %>
		
											

									</div>
								</c:otherwise>
							</c:choose>
						</flow:ifEnabled>
							
						<flow:ifDisabled feature="AjaxAddToCart">
					<c:choose>
						<c:when test="${dragType == 'dynamicKit'}">
							<%@ include file="../../../ShoppingArea/Configurator/CatalogEntryThumbnailDisplayForDynamicKits.jspf" %>
						</c:when>						
						<c:when test="${dragType == 'item' || dragType == 'package' || (singleSKU == true && dragType == 'product')}">
							<div class="button_fit_padder">
							

									<c:set var="buttonStyle" value="primary"/>
									<c:set var="buttonAttributes">
										id="WC_CatalogEntryThumbnailDisplayJSPF_${emsName}_${catEntryIdentifier}_div_37"
									</c:set>
									<c:set var="buttonLink">
												<a href="#" onclick="javascript:categoryDisplayJS.AddItem2ShopCart(document.getElementById('OrderItemAddForm_${catEntryIDToUse}'),1);return false;" id="WC_CatalogEntryThumbnailDisplayJSPF_${emsName}_${catEntryIdentifier}_links_11" waistate:controls="MiniShoppingCart"><fmt:message key="ADDTOCART" bundle="${storeText}"/></a>
																						
							
									</c:set>
									<%@ include file="../../ReusableObjects/StoreButton.jspf" %>
		
									
								
							</div>
						</c:when>
						<c:otherwise>
							<div class="button_fit_padder">


									<c:set var="buttonStyle" value="primary"/>
									<c:set var="buttonAttributes">
										id="WC_CatalogEntryThumbnailDisplayJSPF_${emsName}_${catEntryIdentifier}_div_37"
									</c:set>
									<c:set var="buttonLink">
										<a id="WC_CatalogEntryThumbnailDisplayJSPF_${emsName}_${catEntryIdentifier}_links_11" href="javascript:;" onclick="javascript:var actionListScroll = new popupActionProperties(); actionListScroll.showProductCompare=<c:out value='${param.showProductCompareInQuickInfo}' default='false'/>; actionListScroll.showWishList=${buyable}; actionListScroll.showAddToCart=${buyable}; showPopup('${catalogEntryID}', event, null, null, actionListScroll);" onkeypress="javascript:var actionListScroll = new popupActionProperties(); actionListScroll.showProductCompare=<c:out value='${param.showProductCompareInQuickInfo}' default='false'/>; actionListScroll.showWishList=${buyable}; actionListScroll.showAddToCart=${buyable}; showPopup('${catalogEntryID}', event, null, null, actionListScroll)" waistate:controls="MiniShoppingCart"><fmt:message key="ADDTOCART" bundle="${storeText}"/></a>
							
									</c:set>
									<%@ include file="../../ReusableObjects/StoreButton.jspf" %>
		
									
								
							</div>
						</c:otherwise>
					</c:choose>
				</flow:ifDisabled>
					</flow:ifDisabled>
				</c:when>
			<c:otherwise>
				<fmt:message key="SKU_NOT_BUYABLE" bundle="${storeText}" />
			</c:otherwise>
		</c:choose>
		</c:if>
		<c:if test="${addProductDnD eq 'true'}">
			<script type="text/javaScript">
				dojo.addOnLoad(function() { 
					var src= new dojo.dnd.Source("${prefix}${emsName}_${catEntryIDToUse}");
					src.copyOnly=true;
					src.setItem('imgPath','${catEntry.thumbnail}');
					src.setItem('productDisplayPath','${catEntryDisplayUrl}');
				});
			</script>
		</c:if>
	</c:when>
	<c:when test="${pageView eq 'rankingList'}">
		<c:set var="maxNumberCharactersAllowedToDisplay" value="24"/>
		<%-- for double byte, we need to lower the maximum number of characters to be displayed --%>
		<c:if test="${CommandContext.locale == 'zh_TW' || CommandContext.locale == 'ja_JP' || CommandContext.locale == 'zh_CN' || CommandContext.locale == 'ko_KR'}" >
			<c:set var="maxNumberCharactersAllowedToDisplay" value="${maxNumberCharactersAllowedToDisplay/2}"/>
		</c:if>			
		<div id="ranking_list_table" class="ranking_list_table" role="grid"" aria-describedby="">
			<div id="ranking_list_table_row_${statusCount}" class="ul" role="row">
				<div id="baseContent_${prefix}<c:out value='${emsName}'/>_<c:out value='${catEntryIdentifier}'/>" class="li" role="gridcell">
					<div class="img" id="WC_CatalogEntryThumbnailDisplayJSPF_${emsName}_${catEntryIdentifier}_div_27">
						<c:if test="${addProductDnD eq 'true'}">
							<div dojoType="dojo.dnd.Source" jsId="dndSource" id="${prefix}${emsName}_${catEntryIDToUse}" copyOnly="true" dndType="${dragType}">
								<div class="dojoDndItem" dndType="${dragType}" id="WC_CatalogEntryThumbnailDisplayJSPF_${emsName}_${catEntryIdentifier}_div_28">
						</c:if>


						<c:forEach items="${catEntry.attachments}" var="attachment">
								<c:if test="${'IMAGE_SIZE_40' == attachment.usage}">
									<c:set var="image40Attachment" value="${attachment}" />
								</c:if>
						</c:forEach>	
						
						<c:choose>
								<c:when test="${!empty image40Attachment}">
									<c:set var="catEntryImagePath" value="${staticAssetContextRoot}/${image40Attachment.attachmentAssetPath}" />
								</c:when>
								<c:otherwise>
									<c:set var="catEntryImagePath" value="${jspStoreImgDir}images/NoImageIcon_sm45.jpg" />
								</c:otherwise>
						 </c:choose>
							
						<a ${ShowProductInNewWindow} href="<c:out value="${catEntryDisplayUrl}" escapeXml="false"/>" id="img<c:out value='${emsName}'/><c:out value="${catEntryIdentifier}"/>">
							<c:if test="${addProductDnD eq 'true'}">
								<!--[if lte IE 6.5]><iframe class="productDnDIFrame" scrolling="no" frameborder="0" src="<c:out value="${jspStoreImgDir}" />images/empty.gif"></iframe><![endif]-->
							</c:if>
							<img src="<c:out value='${catEntryImagePath}'/>" 
								alt="<c:out value='${fn:replace(catEntry.name, search, replaceStr)} ${displayPriceString}' escapeXml='false'/>" 
								border="0" width="40" height="40"/>
						</a>
						<c:if test="${addProductDnD eq 'true'}">
								</div>
							</div>
						</c:if>
					</div>
					<c:if test="${addProductDnD eq 'true'}">
						<script type="text/javaScript">
							dojo.addOnLoad(function() { 
								var src= new dojo.dnd.Source("${prefix}${emsName}_${catEntryIDToUse}");
								src.copyOnly=true;
								src.setItem('imgPath','${catEntry.thumbnail}');
								src.setItem('productDisplayPath','${catEntryDisplayUrl}');
							});
						</script>
					</c:if>
				</div>
				<div id="rank_${statusCount}_icon" class="li rank_icon_spacing" role="gridcell">
					<c:out value="${statusCount}"/>.
				</div>
				<div id="rank_${statusCount}_catEntry" class="li rank_catEntry_description" role="gridcell">
					<div class="scrollPaneDescription" id="WC_CatalogEntryThumbnailDisplayJSPF_${emsName}_${catEntryIdentifier}_div_31">
						<c:set var="itemDescription" value="${catEntry.name}"/>
						<c:if test="${fn:length(itemDescription) > maxNumberCharactersAllowedToDisplay}">
							<c:set var="itemDescription" value="${fn:substring(catEntry.name, 0, maxNumberCharactersAllowedToDisplay)}..."/>
						</c:if>
						<a ${ShowProductInNewWindow} href="<c:out value="${catEntryDisplayUrl}" escapeXml="false"/>" >
							<c:out value="${itemDescription}" escapeXml="false"/>
						</a>
					</div>
					
					<div class="scrollPanePrice" id="WC_CatalogEntryThumbnailDisplayJSPF_${emsName}_${catEntryIdentifier}_div_32">
							<c:set var="catalogEntry" value="${catEntry}" />
							<%@ include file="../../ReusableObjects/CatalogEntryPriceDisplay.jspf" %>
					</div>
					
				</div>
			</div>
		</div>
	</c:when>
	<c:when test="${pageView == 'sidebar'}">
		<table id="WC_CatalogEntryThumbnailDisplayJSPF_${catEntryIdentifier}_table_1">
			<tr>
				<td id="WC_CatalogEntryThumbnailDisplayJSPF_${catEntryIdentifier}_td_5">
					<div id="baseContent_${prefix}_<c:out value='${catEntryIdentifier}'/>" class="itemcontainer"
						<c:if test="${showProductQuickView eq 'true'}">
							onmouseover="showPopupButton('${prefix}_${catEntryIdentifier}');" onmouseout="hidePopupButton('${prefix}_${catEntryIdentifier}');"
						</c:if>
						>
						
						<c:if test="${addProductDnD eq 'true'}">
							<div dojoType="dojo.dnd.Source" jsId="dndSource" id="${prefix}_${catEntryIDToUse}" copyOnly="true" dndType="${dragType}">
								<div class="dojoDndItem" dndType="${dragType}" id="WC_CatalogEntryThumbnailDisplayJSPF_${catEntryIdentifier}_div_41">
						</c:if>

						<c:forEach items="${catEntry.attachments}" var="attachment">
								<c:if test="${'IMAGE_SIZE_55' == attachment.usage}">
									<c:set var="image55Attachment" value="${attachment}" />
								</c:if>
						</c:forEach>	
						
						<c:choose>
								<c:when test="${!empty image55Attachment}">
									<c:set var="sidebarImagePath" value="${staticAssetContextRoot}/${image55Attachment.attachmentAssetPath}" />
								</c:when>
								<c:otherwise>
									<c:set var="sidebarImagePath" value="${jspStoreImgDir}images/NoImageIcon_sm45.jpg" />
								</c:otherwise>
						</c:choose>


						<a ${ShowProductInNewWindow} href="<c:out value="${catEntryDisplayUrl}" escapeXml="false"/>" id="img<c:out value="${catEntryIdentifier}"/>" class="itemhover"
						<c:if test="${showProductQuickView eq 'true'}">
							onfocus="showPopupButton('${prefix}_${catEntryIdentifier}');"
							onkeydown="shiftTabHidePopupButton('${prefix}_${catEntryIdentifier}',event);"
						</c:if>
						 onmouseout="javascript:hideBackgroundImage(this);" onmouseover="javascript:this.style.backgroundImage='url(\'<c:out value="${hostPath}"/><c:out value="${jspStoreImgDir}${vfileColor}" />recommend_hover_background.png\')';" 
						 >
							<c:if test="${addProductDnD eq 'true'}">
								<!--[if lte IE 6.5]><iframe class="productSidebarDnDIFrame" scrolling="no" frameborder="0" src="<c:out value="${jspStoreImgDir}" />images/empty.gif"></iframe><![endif]-->
							</c:if>
							<img src="<c:out value='${sidebarImagePath}'/>" 
									alt="<c:out value='${fn:replace(catEntry.name, search, replaceStr)} ${displayPriceString}' escapeXml='false'/>" 
									border="0" width="55" height="55"/>
						</a>
						<c:if test="${addProductDnD eq 'true'}">
								</div>
							</div>
						</c:if>
						<c:if test="${showProductQuickView eq 'true'}">
							<c:choose>
								<c:when test="${shoppingCartPage}">						
									<div id="popupButton_${prefix}_${catEntryIdentifier}" class="rightside_quickinfo_button">
									
											<c:set var="buttonStyle" value="secondary"/>
											<c:set var="buttonAttributes">
												id="WC_CatalogEntryThumbnailDisplayJSPF_${catEntryIdentifier}_div_42"
											</c:set>
											<c:set var="buttonLink">
												<a class="strong" id="QuickInfoButton_${prefix}_${catEntryIdentifier}" href="#"
													alt="<fmt:message key="QUICKINFO" bundle="${storeText}"/>"
													onfocus="showPopupButton('${prefix}_${catEntryIdentifier}');"
													onclick="javaScript:var actionListForSidebar = new popupActionProperties(); actionListForSidebar.showProductCompare=false; actionListForSidebar.showWishList=${buyable}; actionListForSidebar.showAddToCart=${buyable}; showPopup('${catalogEntryID}',event,null,'popupButton_${prefix}_${catEntryIdentifier}',actionListForSidebar); return false;" 
													onkeypress="javaScript:var actionListForSidebar = new popupActionProperties(); actionListForSidebar.showProductCompare=false; actionListForSidebar.showWishList=${buyable}; actionListForSidebar.showAddToCart=${buyable}; showPopup('${catalogEntryID}',event,null,'popupButton_${prefix}_${catEntryIdentifier}',actionListForSidebar);" onblur="hidePopupButton('${prefix}_${catEntryIdentifier}');" role="wairole:button" waistate:haspopup="true"><fmt:message key="QUICKINFO" bundle="${storeText}"/></a>
																																																
											</c:set>
											<%@ include file="../../ReusableObjects/StoreButton.jspf" %>		
		
		
											

									</div>
								</c:when>
								<c:otherwise>
									<div id="popupButton_${prefix}_${catEntryIdentifier}" class="rightside_quickinfo_button">
									
											<c:set var="buttonStyle" value="secondary"/>
											<c:set var="buttonAttributes">
												id="WC_CatalogEntryThumbnailDisplayJSPF_${catEntryIdentifier}_div_44"
											</c:set>
											<c:set var="buttonLink">
												<a class="strong"  id="QuickInfoButton_${prefix}_${catEntryIdentifier}" href="#"
															alt="<fmt:message key="QUICKINFO" bundle="${storeText}"/>"
															onfocus="showPopupButton('${prefix}_${catEntryIdentifier}');"
															onclick="javaScript:var actionListForSidebar = new popupActionProperties(); actionListForSidebar.showWishList=${buyable}; actionListForSidebar.showAddToCart=${buyable}; showPopup('${catalogEntryID}',event,null,'popupButton_${prefix}_${catEntryIdentifier}',actionListForSidebar); return false;" 
															onkeypress="javaScript:var actionListForSidebar = new popupActionProperties(); actionListForSidebar.showWishList=${buyable}; actionListForSidebar.showAddToCart=${buyable}; showPopup('${catalogEntryID}',event,null,'popupButton_${prefix}_${catEntryIdentifier}',actionListForSidebar);" onblur="hidePopupButton('${prefix}_${catEntryIdentifier}');" role="wairole:button" waistate:haspopup="true"><fmt:message key="QUICKINFO" bundle="${storeText}"/></a>
																																																									
											</c:set>
											<%@ include file="../../ReusableObjects/StoreButton.jspf" %>										
									
										
									</div>
								</c:otherwise>
							</c:choose>								
						</c:if>
					</div>
				</td>
				<td id="WC_CatalogEntryThumbnailDisplayJSPF_${catEntryIdentifier}_td_6">
					<div class="text" id="WC_CatalogEntryThumbnailDisplayJSPF_${catEntryIdentifier}_div_46">
						<p class="brand">
							<a ${ShowProductInNewWindow} href="<c:out value="${catEntryDisplayUrl}" escapeXml="false"/>" >
								<c:out value="${catEntry.name}" escapeXml="false"/>
							</a>
						</p>
						
							<p class="price">
									<c:set var="catalogEntry" value="${catEntry}" />
									<%@ include file="../../ReusableObjects/CatalogEntryPriceDisplay.jspf" %>
							</p>
						
						<p>
							<c:choose>
							<c:when test="${buyable}" >								
								<flow:ifEnabled feature="AjaxAddToCart"> 
									<c:choose>
										<c:when test="${dragType == 'dynamicKit'}">
											<%@ include file="../../../ShoppingArea/Configurator/CatalogEntryThumbnailDisplayForDynamicKits.jspf" %>
										</c:when>										
										<c:when test="${dragType == 'item' || dragType == 'package' || (singleSKU == true && dragType == 'product')}">
											<a href="javascript: setCurrentId('WC_CatalogEntryThumbnailDisplayJSPF_${catEntryIdentifier}_links_11'); categoryDisplayJS.AddItem2ShopCartAjax('${catEntryIDToUse}',1)" class="wishlist_detailed_link" id="WC_CatalogEntryThumbnailDisplayJSPF_${catEntryIdentifier}_links_11" waistate:controls="MiniShoppingCart"><fmt:message key="ADDTOCART" bundle="${storeText}"/></a>
										</c:when>
										<c:otherwise>
											<a href="javascript:;" onclick="javascript: showPopup('${catalogEntryID}', event)" class="wishlist_detailed_link" id="WC_CatalogEntryThumbnailDisplayJSPF_${catEntryIdentifier}_links_11" waistate:controls="MiniShoppingCart"><fmt:message key="ADDTOCART" bundle="${storeText}"/></a>
										</c:otherwise>
									</c:choose>
								</flow:ifEnabled>
								
								<flow:ifDisabled feature="AjaxAddToCart">
									<c:choose>
										<c:when test="${dragType == 'dynamicKit'}">
											<%@ include file="../../../ShoppingArea/Configurator/CatalogEntryThumbnailDisplayForDynamicKits.jspf" %>
										</c:when>										
										<c:when test="${dragType == 'item' || dragType == 'package' || (singleSKU == true && dragType == 'product')}">
											<a href="#" onclick="javascript:categoryDisplayJS.AddItem2ShopCart(document.getElementById('OrderItemAddForm_${catEntryIDToUse}'),1);return false;" class="wishlist_detailed_link" id="WC_CatalogEntryThumbnailDisplayJSPF_${catEntryIdentifier}_links_11" waistate:controls="MiniShoppingCart"><fmt:message key="ADDTOCART" bundle="${storeText}"/></a>
										</c:when>
										<c:otherwise>
											<a href="javascript:;" onclick="javascript: showPopup('${catalogEntryID}', event)" class="wishlist_detailed_link" id="WC_CatalogEntryThumbnailDisplayJSPF_${catEntryIdentifier}_links_11" waistate:controls="MiniShoppingCart"><fmt:message key="ADDTOCART" bundle="${storeText}"/></a>
										</c:otherwise>
									</c:choose>
								</flow:ifDisabled>
							</c:when>
							<c:otherwise>
								<fmt:message key="SKU_NOT_BUYABLE" bundle="${storeText}" />
							</c:otherwise>
							</c:choose>
						</p>
					</div>
				</td>
			</tr>
		</table>
					
					<br clear="all" />
					<br />
					<c:if test="${addProductDnD eq 'true'}">
						<script type="text/javaScript">
							dojo.addOnLoad(function() { 
								var src= new dojo.dnd.Source("${prefix}_${catEntryIDToUse}");
								src.copyOnly=true;
								src.setItem('imgPath','${catEntry.thumbnail}');
								src.setItem('productDisplayPath','${catEntryDisplayUrl}');
							});
						</script>
					</c:if>
	</c:when>
		
	<c:when test="${pageView == 'imageForCompare'}">
		<td class="product_image" id="WC_CatalogEntryThumbnailDisplayJSPF_${catEntryIdentifier}_td_7">
			<div id="baseContent_${prefix}_<c:out value='${catEntryIdentifier}'/>" 
				<c:if test="${showProductQuickView eq 'true'}">
					onmouseover="showPopupButton('${prefix}_${catEntryIdentifier}');" onmouseout="hidePopupButton('${prefix}_${catEntryIdentifier}');"
				</c:if>
				>
				<c:if test="${addProductDnD eq 'true'}">
					<div dojoType="dojo.dnd.Source" jsId="dndSource" id="${prefix}_${catEntryIDToUse}" copyOnly="true" dndType="${dragType}">
						<div class="dojoDndItem" dndType="${dragType}" id="WC_CatalogEntryThumbnailDisplayJSPF_${catEntryIdentifier}_div_47">
				</c:if>
							<c:choose>
								<c:when test="${!empty catEntry.thumbnail}">
									<a ${ShowProductInNewWindow} href="<c:out value="${catEntryDisplayUrl}" escapeXml="false"/>" id="img<c:out value="${catEntryIdentifier}"/>" class="itemhover"
										<c:if test="${showProductQuickView eq 'true'}">
											onfocus="showPopupButton('${prefix}_${catEntryIdentifier}');"
											onkeydown="shiftTabHidePopupButton('${prefix}_${catEntryIdentifier}',event);"
										</c:if>
										onmouseout="javascript:hideBackgroundImage(this);" onmouseover="javascript:showBackgroundImage(this);"
										>
										<c:if test="${addProductDnD eq 'true'}">
											<!--[if lte IE 6.5]><iframe class="productDnDIFrame" scrolling="no" frameborder="0" src="<c:out value="${jspStoreImgDir}" />images/empty.gif"></iframe><![endif]-->
										</c:if>
										<img src="<c:out value='${catEntry.thumbnail}'/>" alt="<c:out value='${catEntry.shortDescription}' />" border="0" width="70" height="70"/>
									</a>
								</c:when>
								<c:otherwise>
									<a ${ShowProductInNewWindow} href="<c:out value="${catEntryDisplayUrl}" escapeXml="false"/>" id="img<c:out value="${catEntryIdentifier}"/>" class="itemhover"
										<c:if test="${showProductQuickView eq 'true'}">
											onfocus="showPopupButton('${prefix}_${catEntryIdentifier}');"
											onkeydown="shiftTabHidePopupButton('${prefix}_${catEntryIdentifier}',event);"
										</c:if>
										onmouseout="javascript:hideBackgroundImage(this);" onmouseover="javascript:showBackgroundImage(this);"
										>
										<c:if test="${addProductDnD eq 'true'}">
											<!--[if lte IE 6.5]><iframe class="productDnDIFrame" scrolling="no" frameborder="0" src="<c:out value="${jspStoreImgDir}" />images/empty.gif"></iframe><![endif]-->
										</c:if>
										<img src="<c:out value='${jspStoreImgDir}' />images/NoImageIcon_sm.jpg" alt="<fmt:message key='No_Image' bundle='${storeText}'/>" border="0" width="70" height="70"/>
									</a>
								</c:otherwise>
							</c:choose>
				<c:if test="${addProductDnD eq 'true'}">
						</div>
					</div>
				</c:if>
				<c:if test="${showProductQuickView eq 'true'}">
					<div id="popupButton_${prefix}_${catEntryIdentifier}" class="compare_quickinfo_button">
					
							<c:set var="buttonStyle" value="secondary"/>
							<c:set var="buttonAttributes">
								id="WC_CatalogEntryThumbnailDisplayJSPF_${catEntryIdentifier}_div_48"
							</c:set>
							<c:set var="buttonLink">
								<a class="strong"  id="QuickInfoButton_${prefix}_${catEntryIdentifier}" href="#"
										onfocus="showPopupButton('${prefix}_${catEntryIdentifier}');"
										onclick="javaScript:var actionListCompare = new popupActionProperties(); actionListCompare.showProductCompare=false; actionListCompare.showWishList=${buyable}; actionListCompare.showAddToCart=${buyable}; showPopup('${catalogEntryID}',event,null,'popupButton_${prefix}_${catEntryIdentifier}',actionListCompare); return false;" 
										onkeypress="javaScript:var actionListCompare = new popupActionProperties(); actionListCompare.showProductCompare=false; actionListCompare.showWishList=${buyable}; actionListCompare.showAddToCart=${buyable}; showPopup('${catalogEntryID}',event,null,'popupButton_${prefix}_${catEntryIdentifier}',actionListCompare);" onblur="hidePopupButton('${prefix}_${catEntryIdentifier}');" role="wairole:button" waistate:haspopup="true"><fmt:message key="QUICKINFO" bundle="${storeText}"/></a>
																																																												
							</c:set>
							<%@ include file="../../ReusableObjects/StoreButton.jspf" %>
		
							

					</div>
				</c:if>
			</div>
			<c:choose>
			<c:when test="${buyable}" >
				<flow:ifEnabled feature="AjaxAddToCart"> 
					<c:choose>
						<c:when test="${dragType == 'dynamicKit'}">
							<%@ include file="../../../ShoppingArea/Configurator/CatalogEntryThumbnailDisplayForDynamicKits.jspf" %>
						</c:when>						
						<c:when test="${dragType == 'item' || dragType == 'package' || (singleSKU == true && dragType == 'product')}">
						
							<c:set var="buttonStyle" value="primary"/>
							<c:set var="buttonAttributes">
								id="WC_CatalogEntryThumbnailDisplayJSPF_${catEntryIdentifier}_div_50"
							</c:set>
							<c:set var="buttonLink">
									<a href="javascript: setCurrentId('WC_CatalogEntryThumbnailDisplayJSPF_${catEntryIdentifier}_links_19'); categoryDisplayJS.AddItem2ShopCartAjax('${catEntryIDToUse}',1)" id="WC_CatalogEntryThumbnailDisplayJSPF_${catEntryIdentifier}_links_19" waistate:controls="MiniShoppingCart"><fmt:message key="ADDTOCART" bundle="${storeText}"/></a>
					
							</c:set>
							<%@ include file="../../ReusableObjects/StoreButton.jspf" %>
		

						</c:when>
						<c:otherwise>
						
								<c:set var="buttonStyle" value="primary"/>
								<c:set var="buttonAttributes">
									id="WC_CatalogEntryThumbnailDisplayJSPF_${catEntryIdentifier}_div_52"
								</c:set>
								<c:set var="buttonLink">
										<a href="javascript:;" onclick="javascript:var actionListCompare = new popupActionProperties(); actionListCompare.showProductCompare=false; showPopup('${catalogEntryID}', event,null,'',actionListCompare)" id="WC_CatalogEntryThumbnailDisplayJSPF_${catEntryIdentifier}_links_20" waistate:controls="MiniShoppingCart"><fmt:message key="ADDTOCART" bundle="${storeText}"/></a>
									
								</c:set>
								<%@ include file="../../ReusableObjects/StoreButton.jspf" %>
		

						</c:otherwise>
					</c:choose>
				</flow:ifEnabled>
				
				<flow:ifDisabled feature="AjaxAddToCart">
					<c:choose>
						<c:when test="${dragType == 'dynamicKit'}">
							<%@ include file="../../../ShoppingArea/Configurator/CatalogEntryThumbnailDisplayForDynamicKits.jspf" %>
						</c:when>						
						<c:when test="${dragType == 'item' || dragType == 'package' || (singleSKU == true && dragType == 'product')}">
						
							<c:set var="buttonStyle" value="primary"/>
							<c:set var="buttonAttributes">
								id="WC_CatalogEntryThumbnailDisplayJSPF_${catEntryIdentifier}_div_54"
							</c:set>
							<c:set var="buttonLink">
										<a href="#" onclick="javascript: categoryDisplayJS.AddItem2ShopCart(document.getElementById('OrderItemAddForm_${catEntryIDToUse}'),1);return false;" id="WC_CatalogEntryThumbnailDisplayJSPF_${catEntryIdentifier}_links_21" waistate:controls="MiniShoppingCart"><fmt:message key="ADDTOCART" bundle="${storeText}"/></a>				
							</c:set>
							<%@ include file="../../ReusableObjects/StoreButton.jspf" %>
		
		
		
							
						</c:when>
						<c:otherwise>
						
							<c:set var="buttonStyle" value="primary"/>
							<c:set var="buttonAttributes">
								id="WC_CatalogEntryThumbnailDisplayJSPF_${catEntryIdentifier}_div_56"
							</c:set>
							<c:set var="buttonLink">
								<a href="javascript:;" onclick="javascript:var actionListCompare = new popupActionProperties(); actionListCompare.showProductCompare=false; showPopup('${catalogEntryID}', event,null,'',actionListCompare)" id="WC_CatalogEntryThumbnailDisplayJSPF_${catEntryIdentifier}_links_22" waistate:controls="MiniShoppingCart"><fmt:message key="ADDTOCART" bundle="${storeText}"/></a>
							</c:set>
							<%@ include file="../../ReusableObjects/StoreButton.jspf" %>
		
								

						</c:otherwise>
					</c:choose>
					</flow:ifDisabled>
			</c:when>
			<c:otherwise>
				<fmt:message key="SKU_NOT_BUYABLE" bundle="${storeText}" />
			</c:otherwise>
			</c:choose>
		</td>
	</c:when>
		
	<c:otherwise>
						<c:set var="CatalogEntryThumbnailDisplayExtExcuted" value="false" />
						<%@ include file="../../ReusableObjects/CatalogEntryThumbnailDisplayExt.jspf"%>
						<c:if test="${CatalogEntryThumbnailDisplayExtExcuted==false}">
							<c:choose>
								<c:when test="${!empty catEntry.thumbnail}">
									<a ${ShowProductInNewWindow} href="<c:out value="${catEntryDisplayUrl}" escapeXml="false"/>" id="img<c:out value="${catEntryIdentifier}"/>">
										<img src="<c:out value='${catEntry.thumbnail}'/>" alt="<c:out value='${fn:replace(catEntry.name, search, replaceStr)}' />" width="70" height="70" border="0"/>
									</a>
								</c:when>
								<c:otherwise>
									<a ${ShowProductInNewWindow} href="<c:out value="${catEntryDisplayUrl}" escapeXml="false"/>" id="img<c:out value="${catEntryIdentifier}"/>">
										<img src="<c:out value='${jspStoreImgDir}' />images/NoImageIcon_sm.jpg" alt="<c:out value='${fn:replace(catEntry.name, search, replaceStr)}' />" width="70" height="70" border="0"/>
									</a>
								</c:otherwise>
							</c:choose>
						</c:if>
	</c:otherwise>
</c:choose>
<c:if test="${empty param.skipAttachments || param.skipAttachments != 'true'}">
    
	<c:forEach items="${catEntry.attachments}" var="attachment">
			<c:if test="${'IMAGE_SIZE_40' == attachment.usage}">
				<c:set var="image40Attachment" value="${attachment}" />
			</c:if>
	</c:forEach>	
	
	<c:choose>
			<c:when test="${!empty image40Attachment}">
				<c:set var="productCompareImagePath" value="${staticAssetContextRoot}/${image40Attachment.attachmentAssetPath}" />
			</c:when>
			<c:when test="${!empty catEntry.thumbnail}">
				<c:set var="productCompareImagePath" value="${catEntry.thumbnail}" />
			</c:when>
			<c:otherwise>
				<c:set var="productCompareImagePath" value="${jspStoreImgDir}images/NoImageIcon_sm45.jpg" />
			</c:otherwise>
	 </c:choose>

	<c:set var="compareImageDescription" value="${fn:replace(catEntry.shortDescription, search, replaceCmprStr)}"/>
    <c:set var="compareImageDescription" value="${fn:replace(compareImageDescription, search01, replaceCmprStr)}"/>
    <input type="hidden" id="compareImgPath_${catEntryIDToUse}" value="${productCompareImagePath}"/>
    <input type="hidden" id="compareProductDetailsPath_${catEntryIDToUse}" value="${catEntryDisplayUrl}"/>
    <input type="hidden" id="compareImgDescription_${catEntryIDToUse}" value="<c:out value='${compareImageDescription}'/>"/>
	<c:if test="${singleSKU}" >
		<input type="hidden" id="compareProductParentId_<c:out value='${catEntryIDToUse}'/>" value="<c:out value='${catalogEntryID}'/>"/>
	</c:if>
</c:if>

<c:remove var="catalogEntryDB"/>
</c:if>
<!-- END CatalogEntryThumbnailDisplay.jsp -->
