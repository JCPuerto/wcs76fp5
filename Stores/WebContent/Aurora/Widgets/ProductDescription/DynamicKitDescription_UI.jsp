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
<%-- START ProductDescription_UI.jsp --%>

<!-- Widget Product Information Viewer -->
<div id="widget_product_info_viewer" itemscope itemtype="http://data-vocabulary.org/Product">
	<div class="top" itemprop="offerDetails" itemscope itemtype="http://data-vocabulary.org/Offer">
	
		<%-- Start displaying
			Print icon, 
			Product name, 
			SKU,
			Price Display
			Discount details
		--%>
		<div class="print_section">
			<span id="PrintTextLink" role="button" onclick="JavaScript: print();"><fmt:message key='BD_PRINT'/></span>
			<a id="PrintIconLink" role="button" href="JavaScript: print();" class="print_icon" title="<fmt:message key='BD_PRINT'/>"></a>
		</div>
		
		<div class="clear_float"></div>
		<div class="item_spacer_3px"></div>
		
		<span id="product_name_<c:out value='${catalogEntryID}'/>" class="main_header" itemprop="name"><c:out value="${name}" escapeXml="false"/></span>
		<span id="dynamicKit_SKU" class="sku"><fmt:message key="BD_SKU"/>: <c:out value="${partnumber}" escapeXml="false"/></span>
		
		<div class="clear_float"></div>
		
		<c:if test="${requestScope.dynamicKitAvailable eq 'false'}">
			<div class="not_available"><fmt:message key="PD_PRODUCT_NOT_AVAILABLE_MESSAGE"/></div>
		</c:if>
		
		<div class="item_spacer_10px"></div>

		<div id="price_display_<c:out value='${catalogEntryID}'/>">
			<c:set var="displayPriceRange" value="true" />
			<%@ include file="../PriceDisplay/PriceDisplay.jsp" %>
		</div>
		
		<c:choose>
			<c:when test="${env_fetchMarketingDetailsOnLoad}">
				<div id="discountDetailsRefreshArea" class="content" dojoType="wc.widget.RefreshArea" controllerId="DiscountDetailsController" role="wairole:region" waistate:live="polite" waistate:atomic="false" waistate:relevant="all">
				</div>
			</c:when>
			<c:otherwise>
			<%out.flush();%>
				<c:import url = "${env_jspStoreDir}Widgets/Discounts/Discounts.jsp">
					<c:param name="pageView" value="main" />
				</c:import>
			<%out.flush();%>
			</c:otherwise>
		</c:choose>
		
		<div class="clear_float"></div>
		<div class="item_spacer_10px"></div>		
	</div>
	
	<div class="product_text">
		<%-- Show Reccuring Item link only if FlexFlow RecurringOrders is enabled --%>
		<flow:ifEnabled feature="RecurringOrders">
			<c:if test="${isRecurrable ne 'false'}">
				<div class="subscription right">
					<div class="icon"></div>
					<a id="RecurringPopupLink" href="javaScript: shoppingActionsJS.showWCDialogPopup('widget_subscription_item_popup');"><fmt:message key="BD_RECURRING_ITEM"/></a>
				</div>
			</c:if>
		</flow:ifEnabled>
		<div class="clear_float"></div>
		<p itemprop="description"><c:out value="${shortDescription}" escapeXml="false"/></p>
	</div>
	
	<%-- Define the style class for Customize button --%>
	<c:choose>
		<c:when test="${isDKPreConfigured}">
			<c:set var="customizeBtnStyle" value="button_secondary"/>
		</c:when>
		<c:otherwise>
			<c:set var="customizeBtnStyle" value="button_add_to_cart"/>
		</c:otherwise>
	</c:choose>
	
	<div class="product_options">
		
		<div class="color_and_size left">
			<%out.flush();%>
				<c:import url = "${env_jspStoreDir}Widgets/PriceQuantity/PriceQuantity.jsp" />
			<%out.flush();%>
			
			<c:if test="${isDKConfigurable}">
				<div>
					<label for="quantity_<c:out value='${catalogEntryID}'/>" class="header"><fmt:message key="PD_QTY" /></label>
					<input name="quantity_<c:out value='${catalogEntryID}'/>" id="quantity_<c:out value='${catalogEntryID}'/>" type="text" class="quantity_input" value="1" onchange="javascript:shoppingActionsJS.notifyQuantityChange(this.value);">
					<div class="clear_float"></div>
				</div>
			</c:if>
			
			<div class="clear_float"></div>
			<div class="item_spacer_7px"></div>
			
			<%-- START : DISPLAY ADD 2 CART button or Unavailable --%>
			<c:choose>
				<c:when test="${requestScope.dynamicKitAvailable eq 'true'}">
					<c:if test="${isDKPreConfigured}">
						<a id="add2CartBtn" href="javascript:setCurrentId('add2CartBtn');shoppingActionsJS.Add2ShopCartAjax('entitledItem_<c:out value='${catalogEntryID}'/>',document.getElementById('quantity_<c:out value='${catalogEntryID}'/>').value, false, {catalogEntryType: 'dynamicKit'});" class="button_add_to_cart" wairole="button" role="button" title="<fmt:message key="PD_ADD_TO_CART" />">
							<div class="left_border"></div>
							<div id="productPageAdd2Cart" class="button_text">
								<fmt:message key="PD_ADD_TO_CART" />
							</div>
							<div class="right_border"></div>
						</a>
						
						<div class="clear_float"></div>
						<div class="item_spacer_7px"></div>
					</c:if>
	
					<c:if test="${isDKConfigurable}">
						<a id="customizeBtn" href="javascript:setCurrentId('customizeBtn');shoppingActionsJS.customizeDynamicKit('<c:out value='${catalogEntryID}'/>',dojo.byId('quantity_<c:out value='${catalogEntryID}'/>').value);" class="${customizeBtnStyle}" title="<fmt:message key="CUSTOMIZE" />">
							<div class="left_border"></div>
							<div class="button_text"><fmt:message key="CUSTOMIZE"/></div>
							<div class="right_border"></div>
						</a>
						<div class="clear_float"></div>
						<div class="item_spacer_2px"></div>
					</c:if>
				</c:when>
				<c:otherwise>
					<div class="item_spacer_10px"></div>
					<div class="item_spacer_5px"></div>
					<div class="disabled">
						<div class="button_primary">
							<div class="left_border"></div>
							<div class="button_text" style="width: 116px;"><fmt:message key="PD_UNAVAILABLE"/></div>
							<div class="right_border"></div>
						</div>																	
					</div>
				</c:otherwise>
			</c:choose>	
			<%-- END : DISPLAY ADD 2 CART button or Unavailable --%>
			
			<%--START : DISPLAY Wish List button --%>
			<%out.flush();%>
				<c:import url = "${env_jspStoreDir}Widgets/ShoppingList/ShoppingList.jsp" />
			<%out.flush();%>
			<div class="clear_float"></div>
			<%--END : DISPLAY Wish List button --%>
			
		</div>
		
		<%out.flush();%>
			<c:import url = "${env_jspStoreDir}Widgets/InventoryStatus/InventoryStatus.jsp" />
		<%out.flush();%>
		
		<div class="clear_float"></div>
		
	</div>	
	
</div>

<%-- Show Reccuring Item link only if FlexFlow RecurringOrders is enabled --%>
<flow:ifEnabled feature="RecurringOrders">
	<c:if test="${isRecurrable ne 'false'}">
		<div id="widget_subscription_item" style="display:none;">
			<div id="widget_subscription_item_popup" dojoType="wc.widget.WCDialog" closeOnTimeOut="false" parseOnLoad="true" title="<fmt:message key="PD_RECURRING_ITEM"/>">
				<div class="widget_subscription_item">
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
									<div class="header">
										<span><fmt:message key="BD_RECURRING_ITEM"/></span>
										<a id="widget_subscription_item_popup_close" class="close" href="javascript:dijit.byId('widget_subscription_item_popup').hide();"><img role="button" onmouseover="this.src='<c:out value='${jspStoreImgDir}'/>images/colors/color1/close_hover.png'" onmouseout="this.src='<c:out value='${jspStoreImgDir}'/>images/colors/color1/close_normal.png'" src="<c:out value='${jspStoreImgDir}'/>images/colors/color1/close_normal.png" alt="<fmt:message key='LC_CLOSE'/>"/></a>
										<div class="clear_float"></div>
									</div>
									<div class="clear_float"></div>
									<div class="input_section">
										<span><fmt:message key="BD_RECURRING_ITEM_DESC"/></span>
									</div>
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
			</div>
		</div>
	</c:if>
</flow:ifEnabled>
<%-- END ProductDescription_UI.jsp --%>