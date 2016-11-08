<%--
 =================================================================
  Licensed Materials - Property of IBM

  WebSphere Commerce

  (C) Copyright IBM Corp. 2009, 2012 All Rights Reserved.

  US Government Users Restricted Rights - Use, duplication or
  disclosure restricted by GSA ADP Schedule Contract with
  IBM Corp.
 =================================================================
--%>
<!-- BEGIN PromotionChoiceOfFreeGiftsPopupContent.jsp -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../../../Common/EnvironmentSetup.jspf"%>

<script type="text/javascript">
	dojo.addOnLoad(function() {
		<fmt:message key="PROMOTION_FREE_GIFTS_POPUP_ERROR_EXCEED_GIFT_QUANTITY" var="PROMOTION_FREE_GIFTS_POPUP_ERROR_EXCEED_GIFT_QUANTITY"/>
		<fmt:message key="PROMOTION_FREE_GIFTS_POPUP_NUMBER_OF_SELECTIONS" var="PROMOTION_FREE_GIFTS_POPUP_NUMBER_OF_SELECTIONS"><fmt:param value="%0"/></fmt:message>
		<fmt:message key="PROMOTION_FREE_GIFTS_POPUP_NUMBER_OF_SELECTIONS_ONE" var="PROMOTION_FREE_GIFTS_POPUP_NUMBER_OF_SELECTIONS_ONE"/>
		MessageHelper.setMessage("PROMOTION_FREE_GIFTS_POPUP_ERROR_EXCEED_GIFT_QUANTITY", <wcf:json object="${PROMOTION_FREE_GIFTS_POPUP_ERROR_EXCEED_GIFT_QUANTITY}"/>);
		MessageHelper.setMessage("PROMOTION_FREE_GIFTS_POPUP_NUMBER_OF_SELECTIONS", <wcf:json object="${PROMOTION_FREE_GIFTS_POPUP_NUMBER_OF_SELECTIONS}"/>);
		MessageHelper.setMessage("PROMOTION_FREE_GIFTS_POPUP_NUMBER_OF_SELECTIONS_ONE", <wcf:json object="${PROMOTION_FREE_GIFTS_POPUP_NUMBER_OF_SELECTIONS_ONE}"/>);                            
	});
</script>

<c:set var="order" value="${requestScope.order}"/>
<c:if test="${empty order}">
	<c:set var="order" value="${requestScope.orderInCart}"/>
</c:if>
<c:if test="${empty order}"> 
	<wcf:getData type="com.ibm.commerce.order.facade.datatypes.OrderType"
		var="order" expressionBuilder="findCurrentShoppingCart">
		<wcf:param name="accessProfile" value="IBM_Details" />
	</wcf:getData>
</c:if> 

<c:set var="rewardOptionID" value="${param.rewardOptionID}"/>
<c:set var="promotionStatus" value="inactive"/>

<c:forEach var="rewardOptions" items="${order.rewardOption}">
	<c:if test="${rewardOptions.rewardOptionIdentifier.uniqueID == rewardOptionID}">
		<c:set var="promotionStatus" value="active"/>
		<c:set var="giftSetSpec" value="${rewardOptions.rewardSpecification.giftSetSpecification}"/>
		<c:set var="noOfFreeGifts" value="${giftSetSpec.maximumQuantity.value}"/>
		<c:set var="giftSet" value="${rewardOptions.rewardChoice.giftSet}"/>
	</c:if>
</c:forEach>
<div class="widget_site_popup" role="dialog" aria-labelledby="popupHeader">
	<div class="top">
		<div class="left_border"></div>
		<div class="middle"></div>
		<div class="right_border"></div>
	</div>
	<div class="clear_float"></div>
	<div class="middle">
		<div class="content_left_border">
			<div class="content_right_border">
				<div class="content">
					<c:choose>
						<c:when test="${promotionStatus == 'active'}">
							<c:set var="singleOrMultipleGiftItems"/>
							<c:choose>
								<c:when test="${noOfFreeGifts == 1}">
									<c:set var="singleOrMultipleGiftItems" value="single"/>
								</c:when>
								<c:when test="${noOfFreeGifts > 1}">
									<c:set var="singleOrMultipleGiftItems" value="multiple"/>       
								</c:when>       
							</c:choose>
							<div class="header" id="popupHeader">
								<span>
									<c:choose>
										<c:when test="${singleOrMultipleGiftItems == 'single'}">
											<fmt:message key="PROMOTION_FREE_GIFTS_POPUP_PICK_GIFT"/>
										</c:when>
										<c:when test="${singleOrMultipleGiftItems == 'multiple'}">
											<fmt:message key="PROMOTION_FREE_GIFTS_POPUP_PICK_GIFTS"/>
										</c:when>
									</c:choose>
								</span>
								<a role="button" id="promotionChoice_closeLink" class="close" title="<fmt:message key='PROMOTION_FREE_GIFTS_POPUP_CLOSE'/>" href="javascript: PromotionChoiceOfFreeGiftsJS.hideFreeGiftsPopup('free_gifts_popup');"></a>
								<div class="clear_float"></div>
							</div>
							<div class="body">              
								<div id="radio_choices">
									<div id="WC_PromotionChoiceOfFreeGiftsPopupContent_div_2">
										<input type="radio" name="choose_gift_type" id="free_item" checked="checked" onclick="PromotionChoiceOfFreeGiftsJS.rewardChoicesEnabledStatus();"/>              
										<c:choose>
											<c:when test="${singleOrMultipleGiftItems == 'single'}">
												<label for="free_item"><fmt:message key="PROMOTION_FREE_GIFTS_POPUP_PICK_ONE_GIFT"/></label>
											</c:when>
											<c:when test="${singleOrMultipleGiftItems == 'multiple'}">
												<fmt:parseNumber var="maxQuantity" type="number" value="${giftSetSpec.maximumQuantity.value}"/>
												<label for="free_item"><fmt:message key="PROMOTION_FREE_GIFTS_POPUP_PICK_MULTIPLE_GIFTS"><fmt:param><c:out value="${maxQuantity}"/></fmt:param></fmt:message></label>
											</c:when>
										</c:choose>       
									</div>
									<div id="WC_PromotionChoiceOfFreeGiftsPopupContent_div_3">
										<input type="radio" name="choose_gift_type" id="no_gifts" onclick="PromotionChoiceOfFreeGiftsJS.rewardChoicesEnabledStatus();"/> 
										<c:choose>
											<c:when test="${singleOrMultipleGiftItems == 'single'}">
												<label for="no_gifts"><fmt:message key="PROMOTION_FREE_GIFTS_POPUP_PICK_NO_GIFT"/></label>
											</c:when>
											<c:when test="${singleOrMultipleGiftItems == 'multiple'}">
												<label for="no_gifts"><fmt:message key="PROMOTION_FREE_GIFTS_POPUP_PICK_NO_GIFTS"/></label>
											</c:when>
										</c:choose>                        
									</div>
								</div>
								<flow:ifDisabled feature="AjaxCheckout"> 
									<c:set var="redirectURL" value="OrderShippingBillingView"/>
									<c:if test="${param.isShoppingCartPage =='true'}">
										<c:set var="redirectURL" value="AjaxOrderItemDisplayView"/>
									</c:if>
									<form name="updateRewardChoicesForm" action="OrderChangeServiceRewardOptionUpdate" method="post" id="updateRewardChoicesForm">
										<input type="hidden" name="langId" value="<c:out value="${WCParam.langId}" />" id="WC_PromotionChoiceOfFreeGiftsPopupContent_FormInput_langId"/>
										<input type="hidden" name="storeId" value="<c:out value="${WCParam.storeId}" />" id="WC_PromotionChoiceOfFreeGiftsPopupContent_FormInput_storeId"/>
										<input type="hidden" name="catalogId" value="<c:out value="${WCParam.catalogId}" />" id="WC_PromotionChoiceOfFreeGiftsPopupContent_FormInput_catalogId"/>
										<input type="hidden" name="orderId" value="<c:out value='${order.orderIdentifier.uniqueID}'/>" id="WC_PromotionChoiceOfFreeGiftsPopupContent_FormInput_orderId"/>
										<input type="hidden" name="rewardOptionId" value="<c:out value='${rewardOptionID}'/>" id="WC_PromotionChoiceOfFreeGiftsPopupContent_FormInput_rewardOptionId"/>
										<input type="hidden" name="calculationUsage" value="-1,-2,-3,-4,-5,-6,-7" id="WC_PromotionChoiceOfFreeGiftsPopupContent_FormInput_calculationUsage"/>
										<input type="hidden" name="allocate" value="***" id="WC_PromotionChoiceOfFreeGiftsPopupContent_FormInput_allocate"/>
										<input type="hidden" name="backorder" value="***" id="WC_PromotionChoiceOfFreeGiftsPopupContent_FormInput_backorder"/>
										<input type="hidden" name="URL" value="OrderCalculate?updatePrices=1&orderId=.&calculationUsageId=-1&URL=<c:out value="${redirectURL}"/>" id="URL"/> 
										<input type="hidden" name="errorViewName" value="AjaxOrderItemDisplayView" id="errorView"/>
									</form>                                   
								</flow:ifDisabled> 
								<c:set var="totalNumberOfItems" value="0"/>              
								<div id="free_gifts_table">
									<div class="gifts_wrapper" id="WC_PromotionChoiceOfFreeGiftsPopupContent_div_4">
										<c:forEach var="giftSetSpecItems" items="${giftSetSpec.giftItem}" varStatus="status">
											
											<wcf:getData type="com.ibm.commerce.catalog.facade.datatypes.CatalogNavigationViewType" var="catalogNavigationView" 
													expressionBuilder="getCatalogEntryViewPriceWithAttributesByID" varShowVerb="showCatalogNavigationView" maxItems="1" recordSetStartNumber="0" scope="request">
												<wcf:param name="UniqueID" value="${giftSetSpecItems.catalogEntryIdentifier.uniqueID}" />
												<wcf:contextData name="storeId" data="${WCParam.storeId}" />
												<wcf:contextData name="catalogId" data="${WCParam.catalogId}" />
											</wcf:getData>
											<c:set var="catalogEntry" value="${catalogNavigationView.catalogEntryView[0]}" />
								
											<%-- Get online inventory availability of item --%>
											<c:if test="${giftSetSpecItems.catalogEntryIdentifier.uniqueID != null && giftSetSpecItems.catalogEntryIdentifier.uniqueID != ''}">
												<c:catch var="inventoryException">
													<wcf:getData type="com.ibm.commerce.inventory.facade.datatypes.InventoryAvailabilityType[]"
														var="onlineInventory" expressionBuilder="findInventoryAvailabilityByCatalogEntryIdsAndOnlineStoreIdsAndPhysicalStoreIds">
														<wcf:param name="accessProfile" value="IBM_Store_Details" />
														<wcf:param name="catalogEntryId" value="${giftSetSpecItems.catalogEntryIdentifier.uniqueID}" />
														<wcf:param name="onlineStoreId" value="${WCParam.storeId}" />
													</wcf:getData>
												</c:catch>
												
												<%-- If an exception is thrown, it means the store has no inventory --%>
												<c:choose>
													<c:when test="${empty inventoryException}">
														<c:set var="showInventory" value="true"/>
													</c:when>
													<c:otherwise>
														<c:set var="showInventory" value="false"/>
													</c:otherwise>
												</c:choose>
											</c:if>
									                                   	
											<fmt:parseNumber var="maxItemQuantity" type="number" value="${giftSetSpecItems.quantity.value}" parseLocale="en_US"/>                            
											<c:forEach var="i" begin="1" end="${maxItemQuantity}" varStatus="status2">
												<c:set var="totalNumberOfItems" value="${totalNumberOfItems + 1}"/>
											               
												<c:set var="match" value=""/>                                                        
												<c:forEach var="giftSetItems" items="${giftSet.giftItem}">
													<c:set var="giftSetItemID" value="${giftSetItems.catalogEntryIdentifier.uniqueID}"/>
													<fmt:parseNumber var="giftSetItemQuantity" type="number" value="${giftSetItems.quantity.value}"/>
													<c:set var="giftSetSpecItemID" value="${giftSetSpecItems.catalogEntryIdentifier.uniqueID}"/>
													<c:if test="${giftSetSpecItemID==giftSetItemID && i<=giftSetItemQuantity}">
														<c:set var="match" value="checked"/>
													</c:if>
												</c:forEach>
						                                   
												<div class="gift_item_container" id="WC_PromotionChoiceOfFreeGiftsPopupContent_div_5_${status.count}_${status2.count}">
													<input type="hidden" name="catalogEntryID" value="${giftSetSpecItems.catalogEntryIdentifier.uniqueID}" id="CatalogEntryID_${totalNumberOfItems}" />
													<input type="hidden" name="giftItemQuantity" value="1" id="GiftItemQuantity_${totalNumberOfItems}" />
													<c:choose>
														<c:when test="${singleOrMultipleGiftItems == 'single'}">
															<div class="selection" id="WC_PromotionChoiceOfFreeGiftsPopupContent_div_6_${status.count}_${status2.count}"><input type="radio" id="SelectFreeGift_${totalNumberOfItems}" name="freeGift" <c:out value="${match}"/> onclick="PromotionChoiceOfFreeGiftsJS.checkNumberOfAllowedItems('<c:out value='${noOfFreeGifts}'/>');" /></div>
														</c:when>
														<c:when test="${singleOrMultipleGiftItems == 'multiple'}">
															<div class="selection" id="WC_PromotionChoiceOfFreeGiftsPopupContent_div_6_${status.count}_${status2.count}"><input type="checkbox" id="SelectFreeGift_${totalNumberOfItems}" name="freeGift" <c:out value="${match}"/> onclick="PromotionChoiceOfFreeGiftsJS.checkNumberOfAllowedItems('<c:out value='${noOfFreeGifts}'/>');" /></div>
														</c:when>
													</c:choose>                                   
													<div class="image" id="WC_PromotionChoiceOfFreeGiftsPopupContent_div_7_${status.count}_${status2.count}">
														<c:choose>
															<c:when test="${!empty catalogEntry.metaData['ThumbnailPath']}">
																<img src="<c:out value="${env_imageContextPath}/${catalogEntry.metaData['ThumbnailPath']}"/>" name="catEntryImage" width="70" height="70" alt="<c:out value="${catalogEntry.name}"/> <fmt:message key="Checkout_ACCE_for" /> <c:out value="${offerPrice}"/>" escapeXml="false"/>
															</c:when>
															<c:otherwise>
																<img src="<c:out value="${hostPath}"/><c:out value="${jspStoreImgDir}" />images/NoImageIcon_sm.jpg" name="noImage" alt="" border="0"/>
															</c:otherwise>
														</c:choose>       
													</div>
													<div class="product_info" id="WC_PromotionChoiceOfFreeGiftsPopupContent_div_8_${status.count}_${status2.count}">        
														<h2><label for="SelectFreeGift_${totalNumberOfItems}"><c:out value="${catalogEntry.name}"/></label></h2>
														<p><c:out value="${catalogEntry.shortDescription}"/></p>
														<c:if test="${showInventory}">
															<p class="online_availability"/><fmt:message key="PRODUCT_INV_ONLINE"/></p>
															<c:choose>
																<c:when test="${(giftSetSpecItems.catalogEntryIdentifier.uniqueID != null && giftSetSpecItems.catalogEntryIdentifier.uniqueID != '') && (!empty onlineInventory) && (onlineInventory[0] != null)}">
																	<c:set var="invStatus" value="${onlineInventory[0].inventoryStatus}"/>
																	<input type="hidden" name="onlineAvailability" value="${onlineInventory[0].inventoryStatus}" id="OnlineAvailability_${totalNumberOfItems}" />
																	<fmt:message key="INV_STATUS_${invStatus}" var="invStatusDisplay"/> 
																</c:when>
																<c:otherwise>
																	<c:set var="invStatus" value="NA"/>
																	<input type="hidden" name="onlineAvailability" value="NA" id="OnlineAvailability_${totalNumberOfItems}" />
																	<fmt:message key="INV_INV_NA" var="invStatusDisplay"/>
																</c:otherwise>
															</c:choose>
															<p class="stock_status"/><img id="WC_PromotionChoiceOfFreeGiftsPopupContent_div_8b_${status.count}_${status2.count}" src="${jspStoreImgDir}images/${invStatus}.gif" alt="<c:out value="${invStatusDisplay}"/>" border="0" />&nbsp;<span><c:out value="${invStatusDisplay}"/></span></p>
														</c:if>
														<div class="price" id="WC_PromotionChoiceOfFreeGiftsPopupContent_div_9_${status.count}_${status2.count}">
															<%@ include file="../../../Snippets/ReusableObjects/CatalogEntryPriceDisplay.jspf"%>
														</div>                                               	
													</div>
													<br/>                                                             
													<div class="clear_float" id="WC_PromotionChoiceOfFreeGiftsPopupContent_div_10_${status.count}_${status2.count}"></div>
												</div>                                          
											</c:forEach>                                                 
										</c:forEach>       
									</div>
								</div>      
								<div id="FreeGiftsMessageArea">
									<p id="message">
									
									</p>                               
								</div>
								<div class="clear_float"></div>
							</div>
							<div class="footer">
								<div class="button_container" id="submit_div_1">
									<a href="#" role="button" aria-labelledby="WC_PromotionChoiceOfFreeGiftsPopupContent_Cancel_ACCE_Label" class="button_secondary button_left_padding" id="cancel" onclick="JavaScript:PromotionChoiceOfFreeGiftsJS.hideFreeGiftsPopup('free_gifts_popup');">
										<div class="left_border"></div>
										<div class="button_text"><fmt:message key="CANCEL"/><span id="WC_PromotionChoiceOfFreeGiftsPopupContent_Cancel_ACCE_Label" class="spanacce"><fmt:message key="Checkout_ACCE_promo_free_gifts_cancel"/></span></div>
										<div class="right_border"></div>
									</a>
									<a href="#" role="button" aria-labelledby="WC_PromotionChoiceOfFreeGiftsPopupContent_Apply_ACCE_Label" class="button_primary" id="submitChoices" onclick="JavaScript:setCurrentId('PickYourFreeGift'); PromotionChoiceOfFreeGiftsJS.updateRewardChoices('updateRewardChoicesForm','<c:out value='${totalNumberOfItems}'/>','<c:out value='${rewardOptionID}'/>');">
										<div class="left_border"></div>
										<div class="button_text"><fmt:message key="APPLY"/><span id="WC_PromotionChoiceOfFreeGiftsPopupContent_Apply_ACCE_Label" class="spanacce"><fmt:message key="Checkout_ACCE_promo_free_gifts_apply"/></span></div>
										<div class="right_border"></div>
									</a>
								</div>
								<div class="clear_float"></div>
							</div>					
						</c:when>
						<c:otherwise>
							<div class="header" id="popupHeader">
								<span>
									<c:choose>
										<c:when test="${singleOrMultipleGiftItems == 'multiple'}">
											<fmt:message key="PROMOTION_FREE_GIFTS_POPUP_PICK_GIFTS"/>
										</c:when>
										<c:otherwise>
											<fmt:message key="PROMOTION_FREE_GIFTS_POPUP_PICK_GIFT"/>
										</c:otherwise>
									</c:choose>
								</span>
								<a role="button" id="promotionChoice_closeLink" class="close" title="<fmt:message key='PROMOTION_FREE_GIFTS_POPUP_CLOSE'/>" href="javascript: PromotionChoiceOfFreeGiftsJS.hideFreeGiftsPopup('free_gifts_popup');"></a>
								<div class="clear_float"></div>
							</div>
							<div class="body">
								<fmt:message key="PROMOTION_FREE_GIFTS_PROMOTION_UNAVAILABLE"/>
								<div class="clear_float"></div>
							</div>
							<div class="footer">
								<div class="button_container" id="submit_div_1">
									<a role="button" href="javascript:PromotionChoiceOfFreeGiftsJS.hideFreeGiftsPopup('free_gifts_popup');" class="button_primary">
										<div class="left_border"></div>
										<div class="button_text"><fmt:message key="CONTINUE_SHOPPING" /></div>
										<div class="right_border"></div>
									</a>
								</div>
								<div class="clear_float"></div>
							</div>
						</c:otherwise>       
					</c:choose>
				</div>
			</div>
		</div>
	</div>
	<div class="clear_float"></div>
	<div class="bottom">
		<div class="left_border"></div>
		<div class="middle"></div>
		<div class="right_border"></div>
	</div>
	<div class="clear_float"></div>
</div>
 
<!-- END PromotionChoiceOfFreeGiftsPopupContent.jsp -->