<%--
 =================================================================
  Licensed Materials - Property of IBM

  WebSphere Commerce

  (C) Copyright IBM Corp. 2008, 2009 All Rights Reserved.

  US Government Users Restricted Rights - Use, duplication or
  disclosure restricted by GSA ADP Schedule Contract with
  IBM Corp.
 =================================================================
--%>
<%-- 
  *****
  * This JSP file displays the order items of the current shopping cart. It shows a table with product
  * name, product image, availability, quantity and unit price. This file is used for the single shipment
  * page only.
  *****
--%>
<!-- BEGIN OrderItemDetails.jsp -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../../../include/JSTLEnvironmentSetup.jspf"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<script type="text/javascript">
	categoryDisplayJS.setCommonParameters('<c:out value='${WCParam.langId}'/>','<c:out value='${WCParam.storeId}'/>','<c:out value='${WCParam.catalogId}'/>','<c:out value='${userType}'/>');
</script>

<flow:ifEnabled feature="AjaxCheckout"> 
	<c:set var="isAjaxCheckout" value="true" />
</flow:ifEnabled>
<flow:ifDisabled feature="AjaxCheckout"> 
	<c:set var="isAjaxCheckout" value="false" />
</flow:ifDisabled>

<flow:ifEnabled feature="AjaxAddToCart"> 
	<c:set var="isAjaxAddToCart" value="true" />
</flow:ifEnabled>
<flow:ifDisabled feature="AjaxAddToCart"> 
	<c:set var="isAjaxAddToCart" value="false" />
</flow:ifDisabled>

<flow:ifEnabled feature="AjaxMyAccountPage">
	<wcf:url var="WishListDisplayURL" value="AjaxLogonForm">
		<wcf:param name="storeId"   value="${WCParam.storeId}"  />
		<wcf:param name="catalogId" value="${WCParam.catalogId}"/>
		<wcf:param name="langId" value="${langId}" />
		<wcf:param name="listId" value="." />    
		<wcf:param name="page" value="customerlinkwishlist"/>
	</wcf:url>
	<wcf:url var="SOAWishListDisplayURL" value="AjaxLogonForm">
		<wcf:param name="storeId"   value="${WCParam.storeId}"  />
		<wcf:param name="catalogId" value="${WCParam.catalogId}"/>
		<wcf:param name="langId" value="${langId}" />
		<wcf:param name="listId" value="." />    
		<wcf:param name="page" value="customerlinkwishlist"/>
	</wcf:url>
</flow:ifEnabled>
<flow:ifDisabled feature="AjaxMyAccountPage">
	<wcf:url var="WishListDisplayURL" value="NonAjaxAccountWishListDisplayView">
		<wcf:param name="storeId"   value="${WCParam.storeId}"  />
		<wcf:param name="catalogId" value="${WCParam.catalogId}"/>
		<wcf:param name="langId" value="${langId}" />
		<wcf:param name="listId" value="." />           
	</wcf:url>
	<wcf:url var="SOAWishListDisplayURL" value="NonAjaxAccountWishListDisplayView">
		<wcf:param name="storeId"   value="${WCParam.storeId}"  />
		<wcf:param name="catalogId" value="${WCParam.catalogId}"/>
		<wcf:param name="langId" value="${langId}" />
		<wcf:param name="listId" value="." />           
	</wcf:url>
</flow:ifDisabled>

<wcf:url var="GuestWishListDisplayURL" value="InterestItemDisplay">
		<wcf:param name="storeId"   value="${WCParam.storeId}"  />
		<wcf:param name="catalogId" value="${WCParam.catalogId}"/>
		<wcf:param name="langId" value="${langId}" />
		<wcf:param name="listId" value="." />           
	</wcf:url>

<c:choose>
	<c:when test="${userType eq 'G'}">
		<c:set var="interestItemDisplayURL" value="${GuestWishListDisplayURL}"/>
	</c:when>
	<c:otherwise>
		<c:set var="interestItemDisplayURL" value="${WishListDisplayURL}"/>
	</c:otherwise>
</c:choose>



<%-- Set the view to use for returning to the current page in case of errors or success that should return to current page --%>
<c:set var="currentView" value="${param.returnView}" />
<c:if test="${empty currentView}">
	<c:set var="currentView" value="OrderShippingBillingView" />
</c:if> 

<!-- Get order Details using the ORDER SOI -->

<%-- Substring to search for --%>
<c:set var="search" value='"'/>
<%-- Substring to replace the search strng with --%>
<c:set var="replaceStr" value="'"/>
<c:set var="search01" value="'"/>
<c:set var="replaceStr01" value="\\'"/>
<c:set var="replaceStr02" value="inches"/>

<c:set var="pageSize" value="${WCParam.pageSize}" />
<c:if test="${empty pageSize}">
	<c:set var="pageSize" value="${maxOrderItemsPerPage}"/>
</c:if>	

<%-- Index to begin the order item paging with --%>
<c:set var="beginIndex" value="${WCParam.beginIndex}" />
<c:if test="${empty beginIndex}">
	<c:set var="beginIndex" value="0" />
</c:if>

<c:if test="${empty maxSKUs}">
	<c:set var="maxSKUs" value="1000"/>
</c:if>

<c:set var="currentPage" value="1"/>

<%-- Retrieve the current page of order & order item information from this request --%>
<c:set var="pgorder" value="${requestScope.order}" />
<c:if test="${empty pgorder || pgorder==null}">
<wcf:getData type="com.ibm.commerce.order.facade.datatypes.OrderType"
       var="pgorder" expressionBuilder="findCurrentShoppingCartWithPagingOnItem" varShowVerb = "ShowVerbShipment" maxItems="${pageSize}" recordSetStartNumber="${beginIndex}" recordSetReferenceId="ostatus">
       <wcf:param name="accessProfile" value="IBM_Details" />	 
	   <wcf:param name="sortOrderItemBy" value="orderItemID" />
       <wcf:param name="isSummary" value="false" />
</wcf:getData>
</c:if>

<c:if test="${beginIndex == 0}">
	<c:if test="${ShowVerbShipment.recordSetTotal > ShowVerbShipment.recordSetCount}">		
		<c:set var="pageSize" value="${ShowVerbShipment.recordSetCount}" />
	</c:if>
</c:if>	

<c:set var="orderUniqueId" value="${pgorder.orderIdentifier.uniqueID}"/>

<c:set var="numEntries" value="${ShowVerbShipment.recordSetTotal}"/>

<c:if test="${numEntries > pageSize}">
	<fmt:formatNumber var="totalPages" value="${(numEntries/pageSize)}" maxFractionDigits="0"/>		
	<c:if test="${numEntries%pageSize < (pageSize/2)}">
		<fmt:formatNumber var="totalPages" value="${(numEntries+(pageSize/2)-1)/pageSize}" maxFractionDigits="0"/>
	</c:if>
	<fmt:parseNumber var="totalPages" value="${totalPages}" integerOnly="true"/>     
		
	<c:choose>
		<c:when test="${beginIndex + pageSize >= numEntries}">
			<c:set var="endIndex" value="${numEntries}" />
		</c:when>
		<c:otherwise>
			<c:set var="endIndex" value="${beginIndex + pageSize}" />
		</c:otherwise>
	</c:choose>

	<fmt:formatNumber var="currentPage" value="${(beginIndex/pageSize)+1}"/>
	<fmt:parseNumber var="currentPage" value="${currentPage}" integerOnly="true"/>

	<div class="shopcart_pagination" id="OrderItemDetailsPaginationText1">
		<br/>
		<span class="text">
			<fmt:message key="CATEGORY_RESULTS_DISPLAYING" bundle="${storeText}"> 
				<%-- Indicate the range of order items currently displayed --%>
				<%-- Each page displays <pageSize> of order items, from <beginIndex+1> to <endIndex> --%>						
				<fmt:param><fmt:formatNumber value="${beginIndex + 1}"/></fmt:param>
				<fmt:param><fmt:formatNumber value="${endIndex}"/></fmt:param>
				<fmt:param><fmt:formatNumber value="${numEntries}"/></fmt:param>
			</fmt:message>
			<span class="paging">
				<%-- Enable the previous page link if the current page is not the first page --%>
				<c:if test="${beginIndex != 0}">
					<a id="OrderItemDetailsPaginationText1_1" href="javaScript:if(!CheckoutHelperJS.checkForDirtyFlag()){ setCurrentId('OrderItemDetailsPaginationText1_1'); if(submitRequest()){ cursor_wait();	
					wc.render.updateContext('traditionalShipmentDetailsContext',{'beginIndex':'<c:out value='${beginIndex - pageSize}'/>','pageSize':'<c:out value='${pageSize}'/>'});}}">
				</c:if>
				<img src="<c:out value="${jspStoreImgDir}${vfileColorBIDI}" />paging_back.png" alt="<fmt:message key="CATEGORY_PAGING_LEFT_IMAGE" bundle="${storeText}"/>" />
				<c:if test="${beginIndex != 0}">
					</a>
				</c:if>
				<fmt:message key="CATEGORY_RESULTS_PAGES_DISPLAYING" bundle="${storeText}"> 
					<fmt:param><fmt:formatNumber value="${currentPage}"/></fmt:param>
					<fmt:param><fmt:formatNumber value="${totalPages}"/></fmt:param>
				</fmt:message>
				<%-- Enable the next page link if the current page is not the last page --%>	
				<c:if test="${numEntries > endIndex }">
					<a id="OrderItemDetailsPaginationText1_2" href="javaScript:if(!CheckoutHelperJS.checkForDirtyFlag()){ setCurrentId('OrderItemDetailsPaginationText1_2'); if(submitRequest()){ cursor_wait();	
					wc.render.updateContext('traditionalShipmentDetailsContext',{'beginIndex':'<c:out value='${beginIndex + pageSize}'/>','pageSize':'<c:out value='${pageSize}'/>','pageSize':'<c:out value='${pageSize}'/>'});}}">		
				</c:if>
				<img src="<c:out value="${jspStoreImgDir}${vfileColorBIDI}" />paging_next.png" alt="<fmt:message key="CATEGORY_PAGING_RIGHT_IMAGE" bundle="${storeText}"/>" />
				<c:if test="${numEntries > endIndex }">
					</a>
				</c:if>
			</span>
		</span>
	</div>
</c:if> 


<input type="hidden" name="OrderTotalAmount" value="<c:out value='${pgorder.orderAmount.grandTotal.value}'/>" id="OrderTotalAmount" />
<input type="hidden" name="currentPageNumber" value="${currentPage}" id="currentPageNumber"/>

 <table id="order_details" cellpadding="0" cellspacing="0" border="0" width="100%" summary="<fmt:message key="SHOPCART_TABLE_CONFIRM_SUMMARY" bundle="${storeText}"/>">
	<c:if test="${isChinaStore}">
	<tr class="orderDetailsHeader"><td colspan="5"><fmt:message key="ORDER_SUMMARY" bundle="${storeText}"/></td></tr>
	</c:if>
	  <tr class="nested">
		   <th class="align_left" id="SingleShipment_tableCell_productName"><fmt:message key="PRODUCT" bundle="${storeText}"/></th>
		   <flow:ifEnabled feature="ExpeditedOrders"><th class="align_center" id="SingleShipment_tableCell_expedite"><fmt:message key="SHIP_EXPEDITE_SHIPPING" bundle="${storeText}"/></th></flow:ifEnabled>
		   <th class="align_left" id="SingleShipment_tableCell_availability"><fmt:message key="AVAILABILITY" bundle="${storeText}"/></th>
		   <th class="align_center" id="SingleShipment_tableCell_quantity" abbr="<fmt:message key="QUANTITY1" bundle="${storeText}"/>"><fmt:message key="QTY" bundle="${storeText}"/></th>
		   <th class="align_right" id="SingleShipment_tableCell_unitPrice" abbr="<fmt:message key="UNIT_PRICE" bundle="${storeText}"/>"><fmt:message key="EACH" bundle="${storeText}"/></th>
		   <th class="align_right" id="SingleShipment_tableCell_totalPrice" abbr="<fmt:message key="TOTAL_PRICE" bundle="${storeText}"/>"><fmt:message key="TOTAL" bundle="${storeText}"/></th>
	  </tr>


	<c:if test="${!empty pgorder.orderItem}">
		<wcf:getData type="com.ibm.commerce.catalog.facade.datatypes.CatalogEntryType[]" var="catalogEntriesForAttributes" expressionBuilder="getStoreCatalogEntryAttributesByIDs">
			<wcf:contextData name="storeId" data="${WCParam.storeId}"/>
			<c:forEach var="orderItem" items="${pgorder.orderItem}">
				<wcf:param name="UniqueID" value="${orderItem.catalogEntryIdentifier.uniqueID}"/>
			</c:forEach>
			<wcf:param name="dataLanguageIds" value="${WCParam.langId}"/>
		</wcf:getData>
	</c:if>
	
	<%-- 
		The following snippet retrieves all the catalog entries associated with each item in the current order. 
		It was taken out of the larger c:forEach loop below for performance reasons.
	--%>
	<jsp:useBean id="catalogEntryDataBeansInThisOrder" class="java.util.HashMap" scope="page"/>
	<c:forEach var="orderItem0" items="${pgorder.orderItem}" varStatus="status">
		<wcbase:useBean id="catalogEntryDataBean" classname="com.ibm.commerce.catalog.beans.CatalogEntryDataBean" scope="request">
			<c:set property="catalogEntryID" value="${orderItem0.catalogEntryIdentifier.uniqueID}" target="${catalogEntryDataBean}" />
		</wcbase:useBean>
		<c:if test="${empty catalogEntryDataBeansInThisOrder[orderItem0.catalogEntryIdentifier.uniqueID]}">
			<c:set property="${orderItem0.catalogEntryIdentifier.uniqueID}" value="" target="${catalogEntryDataBeansInThisOrder}"/>
		</c:if>
		<c:set property="${orderItem0.catalogEntryIdentifier.uniqueID}" value="${catalogEntryDataBean}" target="${catalogEntryDataBeansInThisOrder}"/>
		<c:remove var="catalogEntryDataBean"/>
	</c:forEach>
	
	<%-- 
		The following code snippet checks if the catalog entry of any item in the current order has entitled items.  
	--%>
	<c:set var="hasEntitledItems" value="false"/>
	<c:set var="needAttributeService" value="false"/>
	<c:forEach var="currentOrderItem" items="${pgorder.orderItem}" varStatus="count">
			<c:set var="currentCatEntry" value="${catalogEntryDataBeansInThisOrder[currentOrderItem.catalogEntryIdentifier.uniqueID]}"/>
			<c:if test="${!empty currentCatEntry.itemDataBean.parentProductDataBean.entitledItems}">	
				<c:set var="hasEntitledItems" value="true"/>
				<c:set var="totalCount" value="${fn:length(currentCatEntry.itemDataBean.parentProductDataBean.entitledItems)}"/>
				<c:if test="${totalCount<maxSKUs}">
					<c:set var="needAttributeService" value="true"/>
				</c:if>
			</c:if>
	</c:forEach>
	
	
	<%-- 
		The following code snippet retrieves all the SKUs for each catalog entry associated with each item in the current oder.
		It was taken out of the larger c:forEach loop below for performance reasons. 
	--%>
	<c:if test="${hasEntitledItems && needAttributeService}">
		<wcf:getData type="com.ibm.commerce.catalog.facade.datatypes.CatalogEntryType[]" var="skus" expressionBuilder="getStoreCatalogEntryAttributesByIDs">
			<wcf:contextData name="storeId" data="${param.storeId}"/>
			<c:forEach var="orderItem1" items="${pgorder.orderItem}">
				<c:set var="catalogEntryForThisOrderItem" value="${catalogEntryDataBeansInThisOrder[orderItem1.catalogEntryIdentifier.uniqueID]}"/>
				<c:set var="totalItemsForProduct" value="${fn:length(catalogEntryForThisOrderItem.itemDataBean.parentProductDataBean.entitledItems)}"/>
				<c:if test="${totalItemsForProduct<maxSKUs}">
					<c:forEach var='entitledItemForThisCatEntry' items='${catalogEntryForThisOrderItem.itemDataBean.parentProductDataBean.entitledItems}' varStatus='outerStatus1'>	
						<wcf:param name="UniqueID" value="${entitledItemForThisCatEntry.itemID}"/>
					</c:forEach>
				</c:if>
			</c:forEach>
			<wcf:param name="dataLanguageIds" value="${WCParam.langId}"/>
		</wcf:getData>
	</c:if>
	
	<c:set var="numberOfNonFreeItemsOnThisPage" value="0"/>
	<c:forEach var="orderItem0" items="${pgorder.orderItem}" varStatus="status0">
		<c:set var="numberOfNonFreeItemsOnThisPage" value="${numberOfNonFreeItemsOnThisPage + 1}"/>
		<c:if test="${orderItem0.orderItemAmount.freeGift}">
			<c:set var="numberOfNonFreeItemsOnThisPage" value="${numberOfNonFreeItemsOnThisPage - 1}"/>
		</c:if>
	</c:forEach>
	
	<c:set var="callOrderPrepareOnItemRemove" value="true"/>
	<c:if test="${numberOfNonFreeItemsOnThisPage <= 1 && currentPage == 1}">
		<c:set var="callOrderPrepareOnItemRemove" value="false"/>
	</c:if>
		
	<c:forEach var="orderItem" items="${pgorder.orderItem}" varStatus="status">
		<c:set var="isFreeGift" value="${orderItem.orderItemAmount.freeGift}"/>
		<c:set var="itemUniqueId" value="${orderItem.orderItemIdentifier.uniqueID}"/>
		<c:set var="catEntryUniqueId" value="${orderItem.catalogEntryIdentifier.uniqueID}"/>
		
		<c:set var="catEntry" value="${catalogEntryDataBeansInThisOrder[orderItem.catalogEntryIdentifier.uniqueID]}"/>

		<%-- If this is a product and has defining attributes, then allow user to change --%>
		<c:set var="parentCatEntry" value="${catEntry.itemDataBean.parentProductDataBean.productID}"/>
		<c:set var="childrenSKUCount" value="0"/>
		<c:if test="${!empty parentCatEntry}">
			<c:set var="items1" value="${catEntry.itemDataBean.parentProductDataBean.entitledItems}"/>
			<c:set var="numberOfSKUs" value="${fn:length(items1)}"/>
			<c:choose>
				<c:when test="${numberOfSKUs<maxSKUs}">
					<div id="entitledItem_<c:out value='${parentCatEntry}'/>" style="display:none;">
					[
					<c:forEach var='entitledItem' items='${items1}' varStatus='outerStatus'>								
						{
						"orderItemId_remove":"<c:out value="${itemUniqueId}" />",
						"catentry_id" : "<c:out value='${entitledItem.itemID}' />",
						"Attributes" :	{
							<c:forEach var="sku" items="${skus}">
								<c:if test="${sku.catalogEntryIdentifier.uniqueID eq entitledItem.itemID}">
									<c:set var="hasAttributes" value="false"/>
									<c:forEach var="definingAttrValue2" items="${sku.catalogEntryAttributes.attributes}" varStatus="innerStatus">
										<c:if test="${definingAttrValue2.usage == 'Defining'}">
											<c:if test='${hasAttributes eq "true"}'>,</c:if>
											"<c:out value="${fn:replace(definingAttrValue2.name, search01, replaceStr01)}_${fn:replace(fn:replace(definingAttrValue2.value.value, search01, replaceStr01), search, replaceStr02)}" />":"<c:out value='${innerStatus.count}' />"
											<c:set var="hasAttributes" value="true"/>
										</c:if>	
									</c:forEach>
								</c:if>
							</c:forEach>
							}
						}<c:if test='${!outerStatus.last}'>,</c:if>
						<c:set var="childrenSKUCount" value="${outerStatus.count}"/>
					</c:forEach>
					]
					</div>
				</c:when>
				<c:otherwise>
					<div id="entitledItem_<c:out value='${parentCatEntry}'/>" style="display:none;">
						[
									<fmt:parseNumber var="numberOfLoops" value="${(numberOfSKUs/maxSKUs)+1}" integerOnly="true"/>
									<c:if test="${numberOfSKUs%maxSKUs == 0}">
										<fmt:parseNumber var="numberOfLoops" value="${numberOfSKUs/maxSKUs}" integerOnly="true"/>
									</c:if>
									
									<c:forEach var="x" begin="0" end="${numberOfLoops-1}" step="1">
										<c:set var="beginIndex" value="${x*maxSKUs}"/>
										<wcf:getData type="com.ibm.commerce.catalog.facade.datatypes.CatalogEntryType[]" var="newCatalogEntriesForAttributes" expressionBuilder="getCatalogEntryByParentCatalogEntryId"
													varShowVerb="attributesShowVerb" maxItems="${maxSKUs}" recordSetStartNumber="${beginIndex}" recordSetReferenceId="${attributesShowVerb.recordSetReferenceId}">
											<wcf:contextData name="storeId" data="${WCParam.storeId}"/>
											<wcf:param name="catEntryId" value="${parentCatEntry}"/>
											<wcf:param name="dataLanguageIds" value="${WCParam.langId}"/>
											<wcf:param name="accessProfile" value="IBM_Store_CatalogEntryAttributes"/>
										</wcf:getData>
										
										<c:forEach var="sku" items="${newCatalogEntriesForAttributes}" varStatus="outerStatus">
											{
											"orderItemId_remove":"<c:out value="${orderItem.orderItemIdentifier.uniqueID}" />",
											"catentry_id" : "<c:out value='${sku.catalogEntryIdentifier.uniqueID}' />",
											"Attributes" :	{
												<c:set var="hasAttributes" value="false"/>
												<c:forEach var="definingAttrValue2" items="${sku.catalogEntryAttributes.attributes}" varStatus="innerStatus">
													<c:if test="${definingAttrValue2.usage == 'Defining'}">
														<c:if test='${hasAttributes eq "true"}'>,</c:if>
														"<c:out value="${fn:replace(definingAttrValue2.name, search01, replaceStr01)}_${fn:replace(fn:replace(definingAttrValue2.value.value, search01, replaceStr01), search, replaceStr02)}" />":"<c:out value='${innerStatus.count}' />"
														<c:set var="hasAttributes" value="true"/>
													</c:if>	
												</c:forEach>
												}
											}<c:if test='${!outerStatus.last}'>,</c:if><c:if test='${outerStatus.last && x != numberOfLoops-1}'>,</c:if>
										</c:forEach>
									</c:forEach>
						]
					</div>
					<c:set var="childrenSKUCount" value="${numberOfSKUs}"/>
				</c:otherwise>
			</c:choose>
		</c:if>

		<!-- use this catalog services to get catalog entry attributes -->
		<%-- get the formatted qty for this item --%>
		<fmt:formatNumber	var="quickCartOrderItemQuantity" value="${orderItem.quantity.value}" type="number" maxFractionDigits="0"/>
		<%-- keep setting total number of items variable..in the last loop, it will contain correct value :-)better to get this value using length function.. --%>
		<c:set var="totalNumberOfItems" value="${status.count}"/>
		<input type="hidden" value='<c:out value="${itemUniqueId}"/>' name='orderItem_<c:out value="${status.count}"/>' id='orderItem_<c:out value="${status.count}"/>'/>
		<input type="hidden" value='<c:out value="${catEntryUniqueId}"/>' name='catalogId_<c:out value="${status.count}"/>' id='catalogId_<c:out value="${status.count}"/>'/>
		
				
		<c:forEach var="discounts" items="${orderItem.orderItemAmount.adjustment}">	
				<c:if test="${discounts.displayLevel == 'OrderItem'}">
					<c:set var="nobottom" value="th_align_left_no_bottom"/>
				</c:if>
		</c:forEach>
			
		<tr>
			<th class="th_align_left_normal <c:out value="${nobottom}"/>" id="SingleShipment_rowHeader_product<c:out value='${status.count}'/>" abbr="<fmt:message key="Checkout_ACCE_for" bundle="${storeText}"/> ${catEntry.description.name}"> 
				<div class="img" id="WC_OrderItemDetails_div_1_<c:out value='${status.count}'/>">
					<c:set var="catEntryIdentifier" value="${catEntry.catalogEntryID}"/>
					<c:set var="pageView" value="imageOnlyDisplay"/>
					<c:set var="showTooltip" value="false"/>
					<%@ include file="../../../Snippets/ReusableObjects/CatalogEntryDBThumbnailDisplay.jspf" %>   
				</div>
				<div class="itemspecs" id="WC_OrderItemDetails_div_2_<c:out value='${status.count}'/>">
					<p><c:out value="${catEntry.description.name}" escapeXml="false"/></p>
					<span><fmt:message key="CurrentOrder_SKU" bundle="${storeText}"/> <c:out value="${catEntry.partNumber}" escapeXml="false"/></span></br>
					<br />
					<%@ include file="../../../Snippets/ReusableObjects/OrderGiftItemDisplayExt.jspf" %>
					<%@ include file="../../../Snippets/ReusableObjects/GiftRegistryOrderGiftItemDisplayExt.jspf" %>
					<%--
					 ***
					 * Start: Display Defining attributes
					 * Loop through the attribute values and display the defining attributes
					 ***
					--%>
					
					<c:forEach var="catalogEntry1" items="${catalogEntriesForAttributes}" >
						<c:if test="${catalogEntry1.catalogEntryIdentifier.uniqueID == orderItem.catalogEntryIdentifier.uniqueID}">
							<c:remove var="selectedAttr"/>
							<c:forEach var="attribute" items="${catalogEntry1.catalogEntryAttributes.attributes}" varStatus="status2">
								<c:if test="${ attribute.usage=='Defining' }" >	
									<c:choose>
											<c:when test="${empty selectedAttr}">
												<c:set var="selectedAttr" value="${attribute.value.value}"/>
											</c:when>
											<c:otherwise>
												<c:set var="selectedAttr" value="${selectedAttr}|${attribute.value.value}"/>
											</c:otherwise>
									 </c:choose>
								</c:if>
							</c:forEach>
							<c:if test="${!empty selectedAttr && childrenSKUCount > 1}">
							<a class="order_link" id="WC_OrderItemDetails_links_1_<c:out value='${status.count}'/>_<c:out value='${status2.count}'/>" href="javascript:;"  onClick="JavaScript: if(this.disabled) return; setUpdateOrderItemIdsForItem(this.id,''); var actionListAttributeSS = new popupActionProperties(); actionListAttributeSS.showAddToCart=false; actionListAttributeSS.showWishList=false; actionListAttributeSS.showProductCompare=false; actionListAttributeSS.showReplaceCartItem=true; showPopup('<c:out value='${parentCatEntry}'/>',event,null,'',actionListAttributeSS,${quickCartOrderItemQuantity}); saveChangeOrderItemId('${itemUniqueId}');"> 
							<fmt:message key="CHANGE_ATTRIBUTES" bundle="${storeText}"/>
							</a>

							</c:if>
							 <input type="hidden" name="selectedAttr" id="selectedAttr_${orderItem.orderItemIdentifier.uniqueID}" value="${selectedAttr}"/>
						</c:if>
					</c:forEach>
					<%--
					 ***
					 * End: Display Defining attributes
					 ***
					--%>
					<br />
					<c:if test="${b2bStore}">
						<c:set var="isShoppingCartPage" value="false"/>
						<%@ include file="../../../Snippets/Order/Cart/B2BContractSelectExt.jspf" %>
					</c:if>
					<p>
					<c:if test="${!isFreeGift}">
						<flow:ifEnabled feature="AjaxCheckout">
							<a href="JavaScript:setCurrentId('WC_OrderItemDetails_links_2_<c:out value='${status.count}'/>'); CheckoutHelperJS.deleteFromCart('<c:out value='${itemUniqueId}'/>');" id="WC_OrderItemDetails_links_2_<c:out value='${status.count}'/>">
								<img src="<c:out value='${jspStoreImgDir}${vfileColor}'/>table_x_delete.png" alt="<fmt:message key="REMOVE" bundle="${storeText}"/>"/>
								<fmt:message key="REMOVE" bundle="${storeText}"/>
							</a>
						</flow:ifEnabled>
						<flow:ifDisabled feature="AjaxCheckout">
							<wcf:url var="OrderItemDelete" value="OrderChangeServiceItemDelete">
								<wcf:param name="orderItemId" value="${itemUniqueId}"/>
								<wcf:param name="orderId" value="${orderUniqueId}"/>
								<wcf:param name="langId" value="${WCParam.langId}" />
								<wcf:param name="storeId" value="${WCParam.storeId}" />
								<wcf:param name="catalogId" value="${WCParam.catalogId}" />
								<wcf:param name="calculationUsage" value="-1,-2,-3,-4,-5,-6,-7" />
								<wcf:param name="URL" value="${currentView}" />
								<c:if test="${callOrderPrepareOnItemRemove}">
									<wcf:param name="allocate" value="***" />
									<wcf:param name="backorder" value="***" />
									<wcf:param name="remerge" value="***" />
									<wcf:param name="check" value="*n" />
								</c:if>
								<wcf:param name="errorViewName" value="${currentView}" />
								<wcf:param name="beginIndex" value="${beginIndex}" />
							</wcf:url>
							<a href="#" onclick="Javascript:setPageLocation('${OrderItemDelete}');return false;" id="WC_OrderItemDetails_links_3_<c:out value='${status.count}'/>">
								<img src="<c:out value='${jspStoreImgDir}${vfileColor}'/>table_x_delete.png" alt="<fmt:message key="REMOVE" bundle="${storeText}"/>"/>
								<fmt:message key="REMOVE" bundle="${storeText}"/>
							</a>
						</flow:ifDisabled>
					</c:if>
					</p>
					<p>
					<c:if test="${!isFreeGift}">
						<c:if test="${userType eq 'R'}">
							<%-- displays move to wish list link if user is a registered shopper --%>
							<flow:ifEnabled feature="wishList">
								<%-- The following choose statement handles all aplicable cases of change flow: AjaxCheckout and AjaxAddToCart--%>
									<c:choose>
										<c:when test="${isAjaxCheckout && isAjaxAddToCart}">
											<a href = "JavaScript:setCurrentId('WC_OrderItemDetails_links_4_<c:out value='${status.count}'/>'); CheckoutHelperJS.addToWishListAndDeleteFromCart('<c:out value='${catEntryUniqueId}'/>','<c:out value='${itemUniqueId}'/>');" id="WC_OrderItemDetails_links_4_<c:out value='${status.count}'/>">
												<img src="<c:out value='${jspStoreImgDir}${vfileColor}'/>table_plus_add.png" alt="<fmt:message key="MOVE_TO_WISH_LIST" bundle="${storeText}"/>"/>
												<fmt:message key="MOVE_TO_WISH_LIST" bundle="${storeText}"/>
											</a>
										</c:when>
										<c:when test="${(isAjaxCheckout && !isAjaxAddToCart) || (!isAjaxCheckout && !isAjaxAddToCart)}">	
											<wcf:url var="OrderItemMove" value="OrderChangeServiceItemDelete">
												<wcf:param name="langId" value="${WCParam.langId}" />
												<wcf:param name="storeId" value="${WCParam.storeId}" />
												<wcf:param name="catalogId" value="${WCParam.catalogId}" />
												<wcf:param name="orderItemId" value="${orderItem.orderItemIdentifier.uniqueID}"/>
												<wcf:param name="orderId" value="${pagorder.orderIdentifier.uniqueID}"/>
												<wcf:param name="catEntryId" value="${orderItem.catalogEntryIdentifier.uniqueID}" />
												<wcf:param name="URL" value="InterestItemAdd?URL=${interestItemDisplayURL}" />
												<wcf:param name="errorViewName" value="${currentView}" />
												<wcf:param name="updateable" value="0" />
											</wcf:url>
											
											<a href="#" onclick="Javascript:setPageLocation('<c:out value='${OrderItemMove}'/>');return false;" id="WC_OrderItemDetails_links_4b_<c:out value='${status.count}'/>">
												<img src="<c:out value='${jspStoreImgDir}${vfileColor}'/>table_plus_add.png" alt="<fmt:message key="MOVE_TO_WISH_LIST" bundle="${storeText}"/>"/>
												<fmt:message key="MOVE_TO_WISH_LIST" bundle="${storeText}"/>
											</a>
										</c:when>
										<c:when test="${!isAjaxCheckout && isAjaxAddToCart}">
											<wcf:url var="OrderItemMove" value="OrderChangeServiceItemDelete">
												<wcf:param name="orderItemId" value="${itemUniqueId}"/>
												<wcf:param name="orderId" value="${orderUniqueId}"/>
												<wcf:param name="langId" value="${WCParam.langId}" />
												<wcf:param name="storeId" value="${WCParam.storeId}" />
												<wcf:param name="catalogId" value="${WCParam.catalogId}" />
												<wcf:param name="catEntryId" value="${catEntryUniqueId}" />
												<wcf:param name="calculationUsage" value="-1,-2,-3,-4,-5,-6,-7" />
												<wcf:param name="URL" value="InterestItemAdd?URL=${currentView}" />
												<c:if test="${callOrderPrepareOnItemRemove}">
													<wcf:param name="allocate" value="***" />
													<wcf:param name="backorder" value="***" />
													<wcf:param name="remerge" value="***" />
													<wcf:param name="check" value="*n" />
												</c:if>
												<wcf:param name="errorViewName" value="${currentView}" />
												<wcf:param name="beginIndex" value="${beginIndex}" />
												<wcf:param name="updateable" value="0" />
											</wcf:url>
											
											<a href="#" onclick="Javascript:setPageLocation('<c:out value='${OrderItemMove}'/>');return false;" id="WC_OrderItemDetails_links_5_<c:out value='${status.count}'/>">
												<img src="<c:out value='${jspStoreImgDir}${vfileColor}'/>table_plus_add.png" alt="<fmt:message key="MOVE_TO_WISH_LIST" bundle="${storeText}"/>"/>
												<fmt:message key="MOVE_TO_WISH_LIST" bundle="${storeText}"/>
											</a>
										</c:when>
									</c:choose>
							</flow:ifEnabled>

							<flow:ifEnabled feature="SOAWishlist">
								<%@ include file="../../../Snippets/MultipleWishList/GetDefaultWishList.jspf" %>
								<c:choose>
									<c:when test="${empty defaultWishList}">
										<fmt:message var="txtMoveToWishList" key="MOVE_TO_NEW_WISH_LIST" bundle="${remoteWidgetText}"/> 
									</c:when>
									<c:otherwise>
										<fmt:message var="txtMoveToWishList" key="MOVE_TO_WISH_LIST" bundle="${remoteWidgetText}"> 
											<fmt:param><c:out value="${defaultWishList.description.name}" escapeXml="false"/></fmt:param>
										</fmt:message>
									</c:otherwise>
								</c:choose>
								<fmt:message key="DEFAULT_WISHLIST" bundle="${remoteWidgetText}" var="txtDefaultWishList"/>

								<%-- The following choose statement handles all aplicable cases of change flow: AjaxCheckout and AjaxAddToCart--%>
								<c:choose>
									<c:when test="${isAjaxCheckout && isAjaxAddToCart}">
										
										<c:choose>
											<c:when test="${empty defaultWishList}">
												<a href="JavaScript:setCurrentId('WC_OrderItemDetailsf_links_4_<c:out value='${status.count}'/>'); MultipleWishLists.addToNewListAndDelete('<c:out value='${catEntryUniqueId}'/>','<c:out value='${itemUniqueId}'/>');" id="WC_OrderItemDetails_links_4_<c:out value='${status.count}'/>">
													<img src="<c:out value='${jspStoreImgDir}${vfileColor}'/>table_plus_add.png" alt="<c:out value="${txtMoveToWishList}"/>"/>
													<c:out value="${txtMoveToWishList}"/>
												</a>												
											</c:when>
											<c:otherwise>
												<a href = "JavaScript:setCurrentId('WC_OrderItemDetailsf_links_4_<c:out value='${status.count}'/>'); MultipleWishLists.addToListAndDelete('<c:out value='${catEntryUniqueId}'/>','<c:out value='${itemUniqueId}'/>');" id="WC_OrderItemDetails_links_4_<c:out value='${status.count}'/>">
													<img src="<c:out value='${jspStoreImgDir}${vfileColor}'/>table_plus_add.png" alt="<c:out value="${txtMoveToWishList}"/>"/>
													<c:out value="${txtMoveToWishList}"/>
												</a>												
											</c:otherwise>
										</c:choose>																				
									</c:when>
									<c:when test="${(isAjaxCheckout && !isAjaxAddToCart) || (!isAjaxCheckout && !isAjaxAddToCart)}">	
										<wcf:url var="OrderItemMove" value="OrderChangeServiceItemDelete">
											<wcf:param name="langId" value="${WCParam.langId}" />
											<wcf:param name="storeId" value="${WCParam.storeId}" />
											<wcf:param name="catalogId" value="${WCParam.catalogId}" />
											<wcf:param name="orderItemId" value="${orderItem.orderItemIdentifier.uniqueID}"/>
											<wcf:param name="orderId" value="${pagorder.orderIdentifier.uniqueID}"/>
											<wcf:param name="catEntryId" value="${orderItem.catalogEntryIdentifier.uniqueID}" />
											<wcf:param name="giftListId" value="${defaultWishList.giftListIdentifier.uniqueID}" />
											<wcf:param name="quantity" value="1" />
											<c:choose>
												<c:when test="${empty defaultWishList}">
													<wcf:param name="name" value="${txtDefaultWishList}" />
													<wcf:param name="URL" value="GiftListServiceCreate?URL=${SOAWishListDisplayURL}" />
												</c:when>
												<c:otherwise>
													<wcf:param name="URL" value="GiftListServiceAddItem?URL=${SOAWishListDisplayURL}" />
												</c:otherwise>
											</c:choose>
											<wcf:param name="errorViewName" value="${currentView}" />
											<wcf:param name="updateable" value="0" />
										</wcf:url>
										<a href="#" onclick="Javascript:setPageLocation('<c:out value='${OrderItemMove}'/>');return false;" id="WC_OrderItemDetails_links_4b_<c:out value='${status.count}'/>">
											<img src="<c:out value='${jspStoreImgDir}${vfileColor}'/>table_plus_add.png" alt="<c:out value="${txtMoveToWishList}"/>"/>
											<c:out value="${txtMoveToWishList}"/>
										</a>										
									</c:when>
									<c:when test="${!isAjaxCheckout && isAjaxAddToCart}">
										<wcf:url var="OrderItemMove" value="OrderChangeServiceItemDelete">
											<wcf:param name="orderItemId" value="${itemUniqueId}"/>
											<wcf:param name="orderId" value="${orderUniqueId}"/>
											<wcf:param name="langId" value="${WCParam.langId}" />
											<wcf:param name="storeId" value="${WCParam.storeId}" />
											<wcf:param name="catalogId" value="${WCParam.catalogId}" />
											<wcf:param name="catEntryId" value="${catEntryUniqueId}" />
											<wcf:param name="calculationUsage" value="-1,-2,-3,-4,-5,-6,-7" />
											<wcf:param name="giftListId" value="${defaultWishList.giftListIdentifier.uniqueID}" />
											<wcf:param name="quantity" value="1" />												
											<c:choose>
												<c:when test="${empty defaultWishList}">
													<wcf:param name="name" value="${txtDefaultWishList}" />
													<wcf:param name="URL" value="GiftListServiceCreate?URL=${currentView}" />
												</c:when>
												<c:otherwise>
													<wcf:param name="URL" value="GiftListServiceAddItem?URL=${currentView}" />
												</c:otherwise>
											</c:choose>												
											<c:if test="${callOrderPrepareOnItemRemove}">
												<wcf:param name="allocate" value="***" />
												<wcf:param name="backorder" value="***" />
												<wcf:param name="remerge" value="***" />
												<wcf:param name="check" value="*n" />
											</c:if>
											<wcf:param name="errorViewName" value="${currentView}" />
											<wcf:param name="beginIndex" value="${beginIndex}" />
											<wcf:param name="updateable" value="0" />
										</wcf:url>
										<a href="#" onclick="Javascript:setPageLocation('<c:out value='${OrderItemMove}'/>');return false;" id="WC_OrderItemDetails_links_5_<c:out value='${status.count}'/>">
											<img src="<c:out value='${jspStoreImgDir}${vfileColor}'/>table_plus_add.png" alt="<c:out value="${txtMoveToWishList}"/>"/>
											<c:out value="${txtMoveToWishList}"/>
										</a>
									</c:when>
								</c:choose>
							</flow:ifEnabled>							
						</c:if>
					</c:if>
					</p>
				</div>
			</th>
			<flow:ifEnabled feature="ExpeditedOrders">
				<td class="expedite <c:out value="${nobottom}"/>" id="WC_OrderItemDetails_td_expedite_<c:out value='${status.count}'/>" headers="SingleShipment_tableCell_expedite SingleShipment_rowHeader_product<c:out value='${status.count}'/>">
					<span class="checkbox">
						<input type="checkbox" class="checkbox" id="expediteShipping_<c:out value='${status.count}'/>" name="expediteShipping_<c:out value='${status.count}'/>" onclick="JavaScript: setCurrentId('expediteShipping_<c:out value='${status.count}'/>'); CheckoutHelperJS.expediteShipping(this, <c:out value='${itemUniqueId}'/>);"
							<c:if test="${orderItem.orderItemShippingInfo.expedite}">
								checked="checked"
							</c:if>
							<c:if test="${isFreeGift}">
								disabled="true"
							</c:if> />
						<label for="expediteShipping_<c:out value='${status.count}'/>">
							<span style="display:none"><fmt:message key="SHIP_EXPEDITE_SHIPPING" bundle="${storeText}"/></span>
						</label>
					</span>
				</td>
			</flow:ifEnabled>
			<td class="avail <c:out value="${nobottom}"/>" id="WC_OrderItemDetails_td_1_<c:out value='${status.count}'/>" headers="SingleShipment_tableCell_availability SingleShipment_rowHeader_product<c:out value='${status.count}'/>">
				<%@ include file="../../../Snippets/ReusableObjects/CatalogEntryAvailabilityDisplay.jspf" %>						
			</td>
			<td class="QTY <c:out value="${nobottom}"/>" id="WC_OrderItemDetails_td_2_<c:out value='${status.count}'/>" headers="SingleShipment_tableCell_quantity SingleShipment_rowHeader_product<c:out value='${status.count}'/>">
				<p class="item-quantity">
					<c:choose>
						<c:when test="${isFreeGift}">
							<%-- This is a free item..can't change the qty --%>
							<input type="hidden" value="-1" id='freeGift_qty_<c:out value="${status.count}"/>' name='qty_<c:out value="${status.count}"/>'><span><c:out value="${quickCartOrderItemQuantity}"/></span>
						</c:when>
						<c:otherwise>
							<input type="hidden" value="<c:out value="${quickCartOrderItemQuantity}"/>" id='qty_<c:out value="${status.count}"/>' name='qty_<c:out value="${status.count}"/>' /><span><c:out value="${quickCartOrderItemQuantity}"/></span>
						</c:otherwise>
					</c:choose>
				</p>
			</td>
			<td class="each <c:out value="${nobottom}"/>" id="WC_OrderItemDetails_td_3_<c:out value='${status.count}'/>" headers="SingleShipment_tableCell_unitPrice SingleShipment_rowHeader_product<c:out value='${status.count}'/>">
				<%-- unit price column of order item details table --%>
				<%-- shows unit price of the order item --%>
				<span class="price">
					<fmt:formatNumber value="${orderItem.orderItemAmount.unitPrice.price.value}" type="currency" maxFractionDigits="${currencyDecimal}" currencySymbol="${CurrencySymbolToFormat}"/>
					<c:out value="${CurrencySymbol}"/>
				</span>	
			</td>
			<td class="total <c:out value="${nobottom}"/>" id="WC_OrderItemDetails_td_4_<c:out value='${status.count}'/>" headers="SingleShipment_tableCell_totalPrice SingleShipment_rowHeader_product<c:out value='${status.count}'/>">
				<c:choose>
					<c:when test="${orderItem.orderItemAmount.freeGift}">
						<%-- the OrderItem is a freebie --%>
						<span class="details">
							<fmt:message key="Free" bundle="${storeText}"/>
						</span>
					</c:when>
					<c:otherwise>
						<span class="price">
							<fmt:formatNumber var="totalFormattedProductPrice" value="${orderItem.orderItemAmount.orderItemPrice.value}" type="currency" maxFractionDigits="${currencyDecimal}" currencySymbol="${CurrencySymbolToFormat}"/>
							<c:out value="${totalFormattedProductPrice}" escapeXml="false" />
							<c:out value="${CurrencySymbol}"/>
						</span>
					</c:otherwise>
				</c:choose>
			</td>
		</tr>
		<c:remove var="nobottom"/>
					
		<%-- row to display product level discount --%>
		<c:if test="${!empty orderItem.orderItemAmount.adjustment}">
			<jsp:useBean id="aggregatedDiscounts" class="java.util.HashMap" scope="page" />
			<jsp:useBean id="discountReferences" class="java.util.HashMap" scope="page" />
			
			<%-- Loop through the discounts, summing discounts with the same code --%>
			<c:forEach var="discounts" items="${orderItem.orderItemAmount.adjustment}">			
				<%-- only show the adjustment detail if display level is OrderItem, if display level is order, display it at the order summary section --%>
				<c:if test="${discounts.displayLevel == 'OrderItem'}">
					<c:set property="${discounts.code}" value="${discounts}" target="${discountReferences}"/> 
					<c:if test="${empty aggregatedDiscounts[discounts.code]}">
  						<c:set property="${discounts.code}" value="0" target="${aggregatedDiscounts}"/>	
  					</c:if>				
  					<c:set property="${discounts.code}" value="${aggregatedDiscounts[discounts.code]+discounts.amount.value}" target="${aggregatedDiscounts}"/>
				</c:if>
			</c:forEach>	
											
			<c:forEach var="discountsIterator" items="${discountReferences}" varStatus="status2">									
			    <c:set var="discounts" value="${discountsIterator.value}" />		
				<%-- only show the adjustment detail if display level is OrderItem, if display level is order, display it at the order summary section --%>
				<c:if test="${discounts.displayLevel == 'OrderItem'}">
					<tr>
						<th colspan="4" class="th_align_left_dotted_top_solid_bottom" abbr="<fmt:message key="Checkout_ACCE_prod_discount" bundle="${storeText}"/> ${catEntry.description.name}" id="SingleShipment_rowHeader_discount<c:out value='${status.count}'/>_<c:out value='${status2.count}'/>">
							<div class="itemspecs" id="WC_OrderItemDetails_div_3_<c:out value='${status.count}'/>_<c:out value='${status2.count}'/>">
								<c:url var="DiscountDetailsDisplayViewURL" value="DiscountDetailsDisplayView">
									<c:param name="code" value="${discounts.code}" />
									<c:param name="langId" value="${langId}" />
									<c:param name="storeId" value="${WCParam.storeId}" />
									<c:param name="catalogId" value="${WCParam.catalogId}" />
								</c:url>	
								<a class="discount" href='<c:out value="${DiscountDetailsDisplayViewURL}" />' id="WC_OrderItemDetails_Link_ItemDiscount_1_<c:out value='${status.count}'/>_<c:out value='${status2.count}'/>">
									<img src="<c:out value="${jspStoreImgDir}" />images/empty.gif" alt="<fmt:message key="Checkout_ACCE_prod_discount" bundle="${storeText}"/> <c:out value="${fn:replace(catalogEntry.description.name, search, replaceStr)}" escapeXml="false"/>"/>
									<c:out 	value="${discounts.description.value}" escapeXml="false"/>
								</a>
								<br />
							</div>
						</th>
						<td class="th_align_left_dotted_top_solid_bottom total" id="WC_OrderItemDetails_td_5_<c:out value='${status.count}'/>_<c:out value='${status2.count}'/>" headers="SingleShipment_rowHeader_discount<c:out value='${status.count}'/>_<c:out value='${status2.count}'/>">
							<fmt:formatNumber	var="formattedDiscountValue"	value="${aggregatedDiscounts[discounts.code]}" type="currency" maxFractionDigits="${currencyDecimal}" currencySymbol="${CurrencySymbolToFormat}"/>
							<c:out value="${formattedDiscountValue}" escapeXml="false" />
							<c:out value="${CurrencySymbol}"/>
							<br />
						</td>
					</tr>
				</c:if>
			</c:forEach>
			<c:remove var="aggregatedDiscounts"/>
			<c:remove var="discountReferences"/>
		</c:if>
		<c:remove var="catEntry"/>
	</c:forEach>
	<%-- dont change the name of this hidden input element. This variable is used in CheckoutHelper.js --%>
	<input type="hidden" id = "totalNumberOfItems" name="totalNumberOfItems" value='<c:out value="${totalNumberOfItems}"/>'/>
	<c:set var="selectedAddressId" value="${pgorder.orderItem[0].orderItemShippingInfo.shippingAddress.contactInfoIdentifier.uniqueID}"/>
	<c:set var="selectedShipModeId" value="${pgorder.orderItem[0].orderItemShippingInfo.shippingMode.shippingModeIdentifier.uniqueID}"/>
	<input type="hidden" value="<c:out value='${selectedAddressId}'/>" id="addressId_all" name="addressId_all"/>
	<input type="hidden" value="<c:out value='${selectedShipModeId}'/>" id="shipModeId_all" name="shipModeId_all"/>

	<flow:ifDisabled feature="AjaxCheckout">
		<form name="ReplaceItemForm" method="post" action="OrderChangeServiceItemDelete" id="ReplaceItemForm">
			<!-- Define all the hidden fields required for submitting this form in case of Non-Ajax Checkout -->
			<input type="hidden" name="storeId" value='<c:out value="${storeId}"/>' id="WC_OrderItemDetails_inputs_10"/>
			<input type="hidden" name="langId" value='<c:out value="${langId}" />' id="WC_OrderItemDetails_inputs_11"/>
			<input type="hidden" name="orderId" value='<c:out value="${pgorder.orderIdentifier.uniqueID}"/>' id="WC_OrderItemDetails_inputs_12"/>
			<input type="hidden" name="catalogId" value='<c:out value="${catalogId}"/>' id="WC_OrderItemDetails_inputs_13"/>
			<input type="hidden" name="errorViewName" value="${currentView}" id="WC_OrderItemDetails_inputs_14"/>
			<input type="hidden" name="orderItemId" value="" id="WC_OrderItemDetails_inputs_15"/>
			<input type="hidden" name="quickCheckoutProfileForPayment" value="<c:out value='${quickCheckoutProfileForPayment}'/>" id="WC_OrderItemDetails_inputs_1"/>
			<input type="hidden" name="quickCheckOut" value="<c:out value='${quickCheckOut}'/>" id="WC_OrderItemDetails_inputs_2"/>
			<input type="hidden" name="forceShipmentType" value="1" id="WC_OrderItemDetails_inputs_3"/>
			<input type="hidden" name="shipmentTypeId" value="1" id="WC_OrderItemDetails_inputs_4"/>
			<input type="hidden" name="URL" value="${currentView}" id="WC_OrderItemDetails_inputs_5"/>
			<input type="hidden" name="calculationUsage" value="-1,-2,-3,-4,-5,-6,-7" id="WC_OrderItemDetails_inputs_6"/>
		</form>
	</flow:ifDisabled>
<!-- We need this form in case of non-ajax checkout process... In Non-Ajax checkout process we will submit the entire form 
	 All the required hidden fields are defined at the end of this page before closing form tag. Update Shopping Cart function will
	 submit this form.. 
 -->

<flow:ifDisabled feature="AjaxCheckout"> 
	<form name="ShopCartForm" method="post" action="" id="ShopCartForm">
		<!-- Define all the hidden fields required for submitting this form in case of Non-Ajax Checkout -->
		<!-- for requesteddate, shipModeId, addressId, instructions, shipAscomplete fields, value is not needed here.. since values will be
		reset in the updateShoppingCart javascript function.. -->
		<input type="hidden" name="storeId" value='<c:out value="${storeId}"/>' id="WC_OrderItemDetails_inputs_18"/>
		<input type="hidden" name="langId" value='<c:out value="${langId}" />' id="WC_OrderItemDetails_inputs_19"/>
		<input type="hidden" name="orderId" value='<c:out value="${orderUniqueId}"/>' id="WC_OrderItemDetails_inputs_20"/>
		<input type="hidden" name="catalogId" value='<c:out value="${catalogId}"/>' id="WC_OrderItemDetails_inputs_21"/>
		<input type="hidden" name="errorViewName" value="${currentView}" id="WC_OrderItemDetails_inputs_22"/>
		<c:forEach var="orderItem" items="${pgorder.orderItem}" varStatus="status">
			<flow:ifEnabled feature="StoreLocator">
				<input type="hidden" name='physicalStoreId_<c:out value="${status.count}"/>' id='physicalStoreId_<c:out value="${status.count}"/>' />
			</flow:ifEnabled>
			<flow:ifEnabled feature="ExpeditedOrders">
				<c:if test="${!orderItem.orderItemAmount.freeGift}">
					<input type="hidden" name='orderItemId_<c:out value="${status.count}"/>' id='orderItemId_<c:out value="${status.count}"/>' />
					<input type="hidden" name='isExpedited_<c:out value="${status.count}"/>' id='isExpedited_<c:out value="${status.count}"/>' />
				</c:if>
			</flow:ifEnabled>
		</c:forEach>
		<!-- shipAsComplete is at order level..not at orderItemLevels..so one variable is enough -->
		<input type="hidden" name="URL" value="" id="URL"/>
		<input type="hidden" name="quickCheckoutProfileForPayment" value="<c:out value='${quickCheckoutProfileForPayment}'/>" id="WC_OrderItemDetails_inputs_9"/>
		<input type="hidden" name="calculationUsage" value="-1,-2,-3,-4,-5,-6,-7" id="WC_OrderItemDetails_inputs_16"/>
	</form>
</flow:ifDisabled> 
 </table>
<c:if test="${numEntries > pageSize}">
	<div class="shopcart_pagination" id="OrderItemDetailsPaginationText2">
		<span class="text">
			<fmt:message key="CATEGORY_RESULTS_DISPLAYING" bundle="${storeText}"> 
				<fmt:param><fmt:formatNumber value="${beginIndex + 1}"/></fmt:param>
				<fmt:param><fmt:formatNumber value="${endIndex}"/></fmt:param>
				<fmt:param><fmt:formatNumber value="${numEntries}"/></fmt:param>
			</fmt:message>
			<span class="paging">
				<c:if test="${beginIndex != 0}">
					<a id="OrderItemDetailsPaginationText2_1" href="javaScript:if(!CheckoutHelperJS.checkForDirtyFlag()){ setCurrentId('OrderItemDetailsPaginationText2_1'); if(submitRequest()){ cursor_wait();	
					wc.render.updateContext('traditionalShipmentDetailsContext',{'beginIndex':'<c:out value='${beginIndex - pageSize}'/>','pageSize':'<c:out value='${pageSize}'/>'});}}">
				</c:if>
				<img src="<c:out value="${jspStoreImgDir}${vfileColorBIDI}" />paging_back.png" alt="<fmt:message key="CATEGORY_PAGING_LEFT_IMAGE" bundle="${storeText}"/>" />
				<c:if test="${beginIndex != 0}">
					</a>
				</c:if>
				<fmt:message key="CATEGORY_RESULTS_PAGES_DISPLAYING" bundle="${storeText}"> 
					<fmt:param><fmt:formatNumber value="${currentPage}"/></fmt:param>
					<fmt:param><fmt:formatNumber value="${totalPages}"/></fmt:param>
				</fmt:message>
				<c:if test="${numEntries > endIndex }">
					<a id="OrderItemDetailsPaginationText2_2" href="javaScript:if(!CheckoutHelperJS.checkForDirtyFlag()){ setCurrentId('OrderItemDetailsPaginationText2_2'); if(submitRequest()){ cursor_wait();	
					wc.render.updateContext('traditionalShipmentDetailsContext',{'beginIndex':'<c:out value='${beginIndex + pageSize}'/>','pageSize':'<c:out value='${pageSize}'/>'});}}">
				</c:if>
				<img src="<c:out value="${jspStoreImgDir}${vfileColorBIDI}" />paging_next.png" alt="<fmt:message key="CATEGORY_PAGING_RIGHT_IMAGE" bundle="${storeText}"/>" />
				<c:if test="${numEntries > endIndex }">
					</a>
				</c:if>
			</span>
		</span>
	</div>
</c:if> 
<div class="free_gifts_block">
	<%out.flush();%>
		<c:import url="${jspStoreDir}Snippets/Marketing/Promotions/PromotionPickYourFreeGift.jsp"/>
	<%out.flush();%>				
</div>	
<!-- END OrderItemDetails.jsp -->
