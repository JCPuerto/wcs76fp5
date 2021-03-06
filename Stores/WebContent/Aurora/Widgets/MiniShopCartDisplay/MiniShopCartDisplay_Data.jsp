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

<%-- START MiniShopCartDisplay_Data.jsp --%>

<%-- Get the list of items present in the customers shopping cart --%>

<c:set var="orderQuantity" value="0"/>
<c:set var="tooManyItems" value="false"/>

<c:if test="${!anonymousUser}">
	<c:catch>
	<wcf:getData type="com.ibm.commerce.order.facade.datatypes.OrderType"
		   var="orderInCart" expressionBuilder="findCurrentShoppingCartWithPagingOnItem" varShowVerb="ShowVerbCart" maxItems="${env_maxOrderItemsToInspect}" recordSetStartNumber="0" recordSetReferenceId="headerorder" scope="request">
		<wcf:param name="accessProfile" value="IBM_Details" />	 
		<wcf:param name="sortOrderItemBy" value="orderItemID" />
		<wcf:param name="isSummary" value="true" />
	</wcf:getData>
	</c:catch>
	<c:choose>	
		<c:when test="${ShowVerbCart.recordSetTotal > ShowVerbCart.recordSetCount}">
				<c:set var="orderQuantity" value="${ShowVerbCart.recordSetCount}+"/>
				<c:set var="tooManyItems" value="true"/>
			</c:when>
		<c:otherwise>
			<c:forEach var="orderItem" items="${orderInCart.orderItem}" varStatus="status">
				<c:set var="orderQuantity" value="${orderQuantity + orderItem.quantity.value}"/>
			</c:forEach>
		</c:otherwise>
	</c:choose>
</c:if>

<c:set var="orderAmountValue" value="${orderInCart.orderAmount.totalProductPrice.value}" />
<c:if test="${empty orderAmountValue}">
	<c:set var="orderAmountValue" value="0.00" />
</c:if>
<c:set var="orderAmountCurrency" value="${orderInCart.orderAmount.totalProductPrice.currency}" />
<c:if test="${empty orderAmountCurrency}">
	<c:set var="orderAmountCurrency" value="${CommandContext.currency}" />
</c:if>
<c:set var="orderAmountValue" value="${orderInCart.orderAmount.totalProductPrice.value}" />
<c:if test="${empty orderAmountValue}">
	<c:set var="orderAmountValue" value="0.00" />
</c:if>
<c:set var="orderAmountCurrency" value="${orderInCart.orderAmount.totalProductPrice.currency}" />
<c:if test="${empty orderAmountCurrency}">
	<c:set var="orderAmountCurrency" value="${CommandContext.currency}" />
</c:if>

<%-- Build URL to shopping cart page --%>
<wcf:url var="ShoppingCartURL" value="OrderCalculate" type="Ajax">
  <wcf:param name="langId" value="${langId}" />
  <wcf:param name="storeId" value="${storeId}" />
  <wcf:param name="catalogId" value="${catalogId}" />
  <wcf:param name="URL" value="AjaxOrderItemDisplayView" />
  <wcf:param name="errorViewName" value="AjaxOrderItemDisplayView" />
  <wcf:param name="updatePrices" value="1" />
  <wcf:param name="calculationUsageId" value="-1" />
  <wcf:param name="orderId" value="." />
</wcf:url>

<c:set var="showMoreLink" value="false"/> <%-- Display view more link when cart contains more than countMax number of items --%>
<c:set var="countMax" value="4"/>
<c:if test="${fn:length(orderInCart.orderItem) > countMax}">
	<%-- We have more than countMax number of items in cart. Display viewMore link --%>
	<c:set var="showMoreLink" value="true" />
</c:if>

<c:if test="${!tooManyItems}">
	<fmt:formatNumber value="${orderQuantity}" var="orderQuantity"/>
 </c:if>
					 

<%-- List of orderItem objects present in the cart. Each object in the list represent one orderItem and is modelled as a HashMap --%>
<wcf:useBean var="orderItemsDetailsList" classname="java.util.ArrayList"/>
<%-- List of orderItem objects recently added to the cart. Each object in the list represent one orderItem and is modelled as a HashMap --%>
<wcf:useBean var="orderItemsRecentlyAddedList" classname="java.util.ArrayList"/>
<wcf:useBean var="discountReferences" classname="java.util.HashMap" scope="page" />

<c:if test="${!empty orderInCart.orderItem }" >
	<c:forEach var="orderItem" items="${orderInCart.orderItem}" varStatus="status">
		
		<c:if test="${!empty param.addedOrderItemId}">
			<c:forEach var="orderItemId" items="${param.addedOrderItemId}">
				<c:if test="${orderItem.orderItemIdentifier.uniqueID == orderItemId}">
					<%-- Build orderItemRecentlyAddedMap with all the details and add it to orderItemsRecentlyAddedList ArrayList --%>
					<wcf:url var="catEntryDisplayUrl" patternName="ProductURL" value="Product1">
						<wcf:param name="catalogId" value="${catalogId}"/>
						<wcf:param name="storeId" value="${storeId}"/>
						<wcf:param name="productId" value="${orderItem.catalogEntryIdentifier.uniqueID}"/>
						<wcf:param name="langId" value="${langId}"/>
						<wcf:param name="urlLangId" value="${urlLangId}" />
					</wcf:url>
					<c:set var="totalFormattedProductPrice">
						<fmt:formatNumber value="${orderItem.orderItemAmount.unitPrice.price.value}" type="currency" currencySymbol="${env_CurrencySymbolToFormat}" maxFractionDigits="${env_currencyDecimal}"/>
					</c:set>	

					<wcf:useBean var="orderItemRecentlyAddedMap" classname="java.util.HashMap"/>
					<wcf:set target="${orderItemsRecentlyAddedList}" value="${orderItemRecentlyAddedMap}"/>

					<wcf:set target="${orderItemRecentlyAddedMap}" key="productPrice" value="${totalFormattedProductPrice}"/>
					<fmt:formatNumber var="qty" value="${orderItem.quantity.value}"  pattern='#####'/> <%-- Display 1.0 as 1 --%>
					<wcf:set target="${orderItemRecentlyAddedMap}" key="productQty" value="${qty}"/>
					<wcf:set target="${orderItemRecentlyAddedMap}" key="productURL" value="${catEntryDisplayUrl}"/>
					<wcf:set target="${orderItemRecentlyAddedMap}" key="catEntryId" value="${orderItem.catalogEntryIdentifier.uniqueID}"/>
					<c:remove var="orderItemRecentlyAddedMap"/>
				</c:if>
			</c:forEach>
		</c:if>

		<%-- Build itemDetailsMap with all the details and add it to orderItemsDetailsList ArrayList --%>
		<c:if test="${status.count <= countMax}">
			<%-- Keep track of catEntryIds which need more info to display in miniCart list --%>
			<wcf:useBean var="itemDetailsMap" classname="java.util.HashMap"/>
			
			<c:set var="totalFormattedProductPrice">
				<fmt:formatNumber value="${orderItem.orderItemAmount.orderItemPrice.value}" type="currency" currencySymbol="${env_CurrencySymbolToFormat}" maxFractionDigits="${env_currencyDecimal}"/>
			</c:set>
			<c:if test="${orderItem.orderItemAmount.freeGift}">
				<c:set var="totalFormattedProductPrice">
					<fmt:message key="OrderSummary_SHOPCART_FREE" />
				</c:set>
			</c:if>			
			
			<wcf:url var="catEntryDisplayUrl" patternName="ProductURL" value="Product1">
				<wcf:param name="catalogId" value="${catalogId}"/>
				<wcf:param name="storeId" value="${storeId}"/>
				<wcf:param name="productId" value="${orderItem.catalogEntryIdentifier.uniqueID}"/>
				<wcf:param name="langId" value="${langId}"/>
				<wcf:param name="urlLangId" value="${urlLangId}" />
			</wcf:url>

			<wcf:set target="${itemDetailsMap}" key="productPrice" value="${totalFormattedProductPrice}"/>
			<fmt:formatNumber var="qty" value="${orderItem.quantity.value}"  pattern='#####'/> <%-- Display 1.0 as 1 --%>
			<wcf:set target="${itemDetailsMap}" key="productQty" value="${qty}"/>
			<wcf:set target="${itemDetailsMap}" key="catEntryId" value="${orderItem.catalogEntryIdentifier.uniqueID}"/>
			<wcf:set target="${itemDetailsMap}" key="productURL" value="${catEntryDisplayUrl}"/>
			<wcf:set target="${itemDetailsMap}" key="orderItemId" value="${orderItem.orderItemIdentifier.uniqueID}"/>
			<wcf:set target="${itemDetailsMap}" key="productImage" value="${jspStoreImgDir}images/NoImageIcon_sm.jpg"/>
			<wcf:set target="${itemDetailsMap}" key="productName" value="${orderItem.catalogEntryIdentifier.externalIdentifier.partNumber}"/>
			
			<wcf:set target="${orderItemsDetailsList}" value="${itemDetailsMap}"/>
			<c:remove var="itemDetailsMap"/>
		</c:if>
		

	</c:forEach>
</c:if>
<%-- Adjustments, promotions and discounts --%>
<%-- Loop through the discounts, summing discounts with the same code --%>
<c:forEach var="adjustment" items="${orderInCart.orderAmount.adjustment}">
	
		<c:set var="orderAmountValue" value="${orderAmountValue + adjustment.amount.value}" />
		<wcf:useBean var="discountsMap" classname="java.util.HashMap"/>
		<wcf:set target="${discountsMap}" key="discountDescription" value="${adjustment.description.value}" />
		<c:if test="${empty adjustment.description.value}">
			<fmt:message var="defaultDescription" key="DISCOUNT_DETAILS_TITLE"/>
			<wcf:set target="${discountsMap}" key="discountDescription" value="${defaultDescription}" />
		</c:if>
		<wcf:url var="DiscountDetailsDisplayViewURL" value="DiscountDetailsDisplayView">
			<wcf:param name="code" value="${adjustment.code}" />
			<wcf:param name="langId" value="${langId}" />
			<wcf:param name="storeId" value="${WCParam.storeId}" />
			<wcf:param name="catalogId" value="${WCParam.catalogId}" />
		</wcf:url>
		<wcf:set target="${discountsMap}" key="displayURL" value="${DiscountDetailsDisplayViewURL}" />
		<fmt:formatNumber var="formattedDiscountValue" value="${adjustment.amount.value}" type="currency" maxFractionDigits="${env_currencyDecimal}" currencySymbol="${env_CurrencySymbolToFormat}"/>
		<wcf:set target="${discountsMap}" key="aggregatedDiscount" value="${formattedDiscountValue}" />			
		<wcf:set key="${adjustment.code}" value="${discountsMap}" target="${discountReferences}" />
		<c:remove var="discountsMap"/>
	
</c:forEach>
<c:set var="orderSubTotal">
	<fmt:formatNumber value="${orderAmountValue}" type="currency" currencySymbol="${env_CurrencySymbolToFormat}" maxFractionDigits="${env_currencyDecimal}"/>
</c:set>

<%-- Get more info for the catEntryIds which needs to be displayed in the miniCart page --%>
<c:if test="${!empty orderItemsDetailsList}">
	<wcf:getData type="com.ibm.commerce.catalog.facade.datatypes.CatalogNavigationViewType" var="catalogNavigationView" expressionBuilder="getCatalogEntryViewForShoppingCart">
		<c:forEach var="itemDetailsMap" items="${orderItemsDetailsList}">
			<wcf:param name="UniqueID" value="${itemDetailsMap['catEntryId']}"/>
		</c:forEach>
		<wcf:contextData name="storeId" data="${storeId}" />
		<wcf:contextData name="catalogId" data="${catalogId}" />
	</wcf:getData>
</c:if>

<%-- Populate our hashMap stored in orderItemDetails list with the catEntry details like thumbnail and name --%>
<c:forEach items="${catalogNavigationView.catalogEntryView}" var="catalogEntryDetails">
	<c:forEach items="${orderItemsDetailsList}" var="itemDetailsMap">
		<c:if test="${itemDetailsMap.catEntryId == catalogEntryDetails.uniqueID}">
			<c:set var="miniCartListImage" value="${fn:replace(catalogEntryDetails.metaData['ThumbnailPath'], itemThumbnailImage, miniImage)}" />
			<wcf:set target="${itemDetailsMap}" key="productImage" value="${env_imageContextPath}/${miniCartListImage}"/>
			<wcf:set target="${itemDetailsMap}" key="productName" value="${catalogEntryDetails.name}"/>
		</c:if>
	</c:forEach>
</c:forEach>

<%-- Get more info for the catEntryIds which are recently added, so that it can be displayed in the miniCart page --%>
<%-- Need to get the attributes, therefore we use the getCatalogEntryViewDetailsByID profile --%>
<c:if test="${!empty orderItemsRecentlyAddedList}">
	<wcf:getData type="com.ibm.commerce.catalog.facade.datatypes.CatalogNavigationViewType" var="catalogNavigationView" expressionBuilder="getCatalogEntryViewDetailsByID">
		<c:forEach var="orderItemRecentlyAddedMap" items = "${orderItemsRecentlyAddedList}">
			<wcf:param name="UniqueID" value="${orderItemRecentlyAddedMap['catEntryId']}"/>
		</c:forEach>
		<wcf:contextData name="storeId" data="${storeId}" />
		<wcf:contextData name="catalogId" data="${catalogId}" />
	</wcf:getData>

	<%-- Populate our hashMap stored in orderItemsRecentlyAddedList list with the catEntry details like thumbnail, name and also attributes --%>
	<c:forEach items="${catalogNavigationView.catalogEntryView}" var="catalogEntryDetails">
		
		<c:forEach items="${orderItemsRecentlyAddedList}" var="orderItemRecentlyAddedMap">
			<c:if test="${orderItemRecentlyAddedMap.catEntryId == catalogEntryDetails.uniqueID}">
				<c:set var="miniCartImage" value="${fn:replace(catalogEntryDetails.metaData['ThumbnailPath'], productThumbnailImage, miniShopCartImage)}" />
				<wcf:set target="${orderItemRecentlyAddedMap}" key="productImage" value="${env_imageContextPath}/${miniCartImage}"/>
				<wcf:set target="${orderItemRecentlyAddedMap}" key="productName" value="${catalogEntryDetails.name}"/>
				
				<%-- Get details of attributes --%>
				<wcf:useBean var="attributeList" classname="java.util.ArrayList"/>
				<c:forEach var="attribute" items="${catalogEntryDetails.attributes}" varStatus="aStatus">
					<wcf:useBean var="listValues" classname="java.util.HashMap" capacity="2"/>
					<c:if test="${ attribute.usage == 'Defining' }" >
						<c:if test="${attribute.identifier != env_subsFulfillmentFrequencyAttrName && attribute.identifier != env_subsPaymentFrequencyAttrName}">
							<wcf:set target="${listValues}" key="attributeName" value="${attribute.name}"/>
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
										
										<wcf:set target="${listValues}" key="attributeValue" value="${fn:replace(displayValue, search01, replaceStr01)}" />
										
									</c:forEach>
								</c:when>
								<c:otherwise>
									<wcf:set target="${listValues}" key="attributeValue" value="${attribute.values[0].value}"/>
								</c:otherwise>
							</c:choose>
							<wcf:set target="${attributeList}" value="${listValues}"/>
							<c:remove var="listValues"/>
						</c:if>
					</c:if>
				</c:forEach>

				<wcf:set target="${orderItemRecentlyAddedMap}" key="productAttributes" value="${attributeList}"/>
				<c:remove var="attributeList"/>
			</c:if>
		</c:forEach>
	</c:forEach>
</c:if>

<%-- END MiniShopCartDisplay_Data.jsp --%>
