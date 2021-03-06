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
			Reviews
		--%>
		<div class="print_section">
			<span id="PrintTextLink" role="button" onclick="JavaScript: print();"><fmt:message key='PD_PRINT'/></span>
			<a id="PrintIconLink" role="button" href="JavaScript: print();" class="print_icon" title="<fmt:message key='PD_PRINT'/>"></a>
		</div>

		<div class="clear_float"></div>
		<div class="item_spacer_3px"></div>
		<span id="product_name_<c:out value='${catalogEntryID}'/>" class="main_header" role="heading" aria-level="1" itemprop="name"><c:out value="${name}" escapeXml="false"/></span>

		<span id="product_SKU_<c:out value='${catalogEntryID}'/>" class="sku"><fmt:message key="CurrentOrder_SKU"/> <c:out value="${partnumber}" escapeXml="false"/></span>
		<div class="clear_float"></div>
		
		<c:if test="${requestScope.productAvailable eq 'false'}">
			<div class="not_available"><fmt:message key="PD_PRODUCT_NOT_AVAILABLE_MESSAGE"/></div>
		</c:if>
		
		<div class="item_spacer_10px"></div>
		<div id="price_display_<c:out value='${catalogEntryID}'/>">
			<c:set var="displayPriceRange" value="true" />
			<%@ include file="../PriceDisplay/PriceDisplay.jsp" %>
		</div>

		<c:choose>
			<c:when test="${env_fetchMarketingDetailsOnLoad}">
				<div id="discountDetailsRefreshArea" class="content" dojoType="wc.widget.RefreshArea" controllerId="DiscountDetailsController">
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
		
		<flow:ifEnabled feature="RatingReviewIntegration">
				<c:set target="${reviewParameters}" property="display" value="summary" />
				<%@ include file="../Reviews/ReviewDisplay.jspf"%>
		</flow:ifEnabled>

		<div class="clear_float"></div>
		
		
	</div>
	
	<div class="product_text">
				<p itemprop="description" id="product_shortdescription_<c:out value='${catalogEntryID}'/>"/><c:out value="${shortDescription}" escapeXml="false"/></p>
		
		<%-- Show Recurring Item link only if FlexFlow RecurringOrders is enabled --%>
		<flow:ifEnabled feature="RecurringOrders">
			<c:if test="${isRecurrable ne 'false'}">
				<div class="recurring">
					<div class="recurring_icon"></div>
					<a id="RecurringPopupLink" class="recurring_text" href="javaScript: shoppingActionsJS.showWCDialogPopup('widget_subscription_item_popup');"><fmt:message key="PD_RECURRING_ITEM"/></a>
				</div>
			</c:if>
		</flow:ifEnabled>
		<div class="clear_float"></div>		
	</div>
	
	<script type="text/javascript">
		dojo.addOnLoad(function() { 
			shoppingActionsJS.setSKUImageId('productMainImage');
		});
	</script>
	
	<c:if test="${!empty fulfillmentFrequencyAttrName}">
	<script type="text/javascript">
		dojo.addOnLoad(function() { 
			shoppingActionsJS.setSelectedAttribute("<c:out value="${fn:replace(fulfillmentFrequencyAttrName, search01, replaceStr01)}"/>","<c:out value="${fn:replace(fulfillmentFrequency, search01, replaceStr01)}"/>", "<c:out value="entitledItem_${catalogEntryID}"/>");
		});
	</script>
</c:if>
<c:if test="${!empty paymentFrequencyAttrName}">
	<script type="text/javascript">
		dojo.addOnLoad(function() { 
			shoppingActionsJS.setSelectedAttribute("<c:out value="${fn:replace(paymentFrequencyAttrName, search01, replaceStr01)}"/>","<c:out value="${fn:replace(paymentFrequency, search01, replaceStr01)}"/>", "<c:out value="entitledItem_${catalogEntryID}"/>");
		});
	</script>
</c:if>

<c:if test = "${requestScope.productAvailable ne 'true'}">
	<c:set var="additionalCSSClass" value="no_border"/>
</c:if>

	<div class="product_options">

		<div class="color_and_size left ${additionalCSSClass}">

			<%--START : DISPLAYING ATTRIBUTES FOR SHOPPER TO SELECT --%>
			<c:set var="attributesSelected" value="false"/>
			<c:choose>
				<c:when test="${numberOfSKUs == 1}">
						
					<c:forEach var="attribute" items="${definingAttributeList}" varStatus="aStatus" >
						<c:set var="attributeName" value="${attribute[0]}" />
						<c:set var="attributeValues" value="${attribute[1]}" />
						<c:set var="displayValue" value="${attribute[2]}" />
						<div class="heading">
							<fmt:message key="ATTRNAMEKEY">
								<fmt:param value="${attributeName}"/>
							</fmt:message>
							<c:if test="${empty displayValue}">
								<c:out value="${attributeValues}"/>
							</c:if>
							<c:out value="${displayValue}"/>
						</div>
						<script type="text/javascript">
							dojo.addOnLoad(function() { 
								shoppingActionsJS.setSKUImageId('productMainImage');
								shoppingActionsJS.setSelectedAttribute("<c:out value='${attributeName}'/>","<c:out value="${fn:replace(attributeValues, search, replaceStr02)}"/>", "<c:out value="entitledItem_${catalogEntryID}"/>");
							});
						</script>
						<c:set var="attributesSelected" value="true"/>
					</c:forEach>
						
				</c:when>
				<c:when test="${!empty subsTimePeriodAttrList}" >
					
					<c:forEach var="attribute" items="${subsTimePeriodAttrList}" varStatus="aStatus" >
						<c:set var="attributeName" value="${attribute[0]}" />
						<c:set var="attributeValues" value="${attribute[1]}" />
						<c:set var="attributeDisplayValues" value="${attribute[2]}" />
						<div class="heading">
							<fmt:message key="ATTRNAMEKEY">
								<fmt:param value="${attributeName}"/>
							</fmt:message>
						</div>
						<div class="clear_float"></div>
						<div class="options_dropdown">
							<label for="attrValue_<c:out value='${aStatus.count}'/>" style="display:none;"><c:out value='${attributeName}'/><fmt:message key='PD_ACCE_required'/></label>
							<select name="attrValue" id="attrValue_<c:out value='${aStatus.count}'/>"
										onChange='JavaScript:shoppingActionsJS.setSKUImageId("productMainImage");shoppingActionsJS.setSelectedAttribute("<c:out value='${attributeName}'/>",this.options[this.selectedIndex].value, "<c:out value="entitledItem_${catalogEntryID}"/>");
															shoppingActionsJS.notifyAttributeChange("${catalogEntryID}");
															<c:if test="${env_displayListPriceInProductPage == 'true'}">
																shoppingActionsJS.changePrice("entitledItem_<c:out value='${catalogEntryID}'/>",false,${displayPriceRange},"<c:out value='${catalogEntryID}'/>");
															</c:if>
							'>
								<option value="">
									<fmt:message key="PD_SELECT">
										<fmt:param value="${attributeName}"/>
									</fmt:message>
								</option>
								<c:if test="${not empty WCParam[attributeName]}">
									<script type="text/javascript">
										dojo.addOnLoad(function() { 
										shoppingActionsJS.setSelectedAttribute("<c:out value='${attributeName}'/>",'<c:out value="${WCParam[attributeName]}"/>', "<c:out value="entitledItem_${catalogEntryID}"/>");
									});
									</script>
									<c:set var="attributesSelected" value="true"/>
								</c:if>
								<c:forEach var="allowedValue" items="${attributeValues}" varStatus="vStatus">
									<c:set var="index" value="${fn:trim(vStatus.count-1)}" />
									<option value='<c:out value="${allowedValue}"/>' <c:if test="${allowedValue == WCParam[attributeName]}">selected="selected"</c:if>>
										<c:out value="${attributeDisplayValues[index]}"/>
									</option>
								</c:forEach>
							</select>
						</div>
						<div class="item_spacer_3px"></div>
						<div class="clear_float"></div>
					</c:forEach>					
				</c:when>
				<c:otherwise>
					<c:if test="${!empty swatchAttrList}">
						<c:set var="defaultSelected" value="false"/>
						<c:forEach var="attribute" items="${swatchAttrList}" varStatus="aStatus" >
							<c:set var="swatchName" value="${attribute[0]}" />
							<c:set var="swatchValues" value="${attribute[1]}" />
							<c:set var="swatchImages" value="${attribute[2]}" />
							<div class="heading color_swatch_label" id="swatch_selection_label_entitledItem_<c:out value='${catalogEntryID}'/>_<c:out value='${swatchName}'/>" >
								<fmt:message key="ATTRNAMEKEY">
									<fmt:param value="${swatchName}"/>
								</fmt:message>
							</div>
							<div class="heading" id="swatch_selection_entitledItem_<c:out value='${catalogEntryID}'/>_<c:out value='${swatchName}'/>"></div>
							<div class="clear_float"></div>
							<span class="spanacce" id="swatch_ACCE_description_<c:out value='${catalogEntryID}'/>_<c:out value="${fn:replace(swatchName, ' ', '-')}"/>"><fmt:message key="ACCE_Region_Price_Update"/></span>
							<div class="color_swatch_list" role="radiogroup" aria-label="${swatchName}" aria-describedby="swatch_ACCE_description_<c:out value='${catalogEntryID}'/>_<c:out value="${fn:replace(swatchName, ' ', '-')}"/>">
								<ul>
									<c:forEach var="swatchValue" items="${swatchValues}" varStatus="vStatus">
										<c:set var="index" value="${fn:trim(vStatus.count-1)}" />
										<li>
											<a role="radio" aria-setsize="${fn:length(swatchValues)}" aria-posinset="${vStatus.count}" aria-label="${swatchValue}" aria-checked="false" id="swatch_link_entitledItem_<c:out value='${catalogEntryID}'/>_<c:out value='${swatchValue}'/>" href='javascript: shoppingActionsJS.setSKUImageId("productMainImage");shoppingActionsJS.selectSwatch("<c:out value='${swatchName}'/>","<c:out value='${swatchValue}'/>","entitledItem_<c:out value='${catalogEntryID}'/>","<c:out value='${doNotDisable}'/>");
												shoppingActionsJS.notifyAttributeChange("${catalogEntryID}");
												<c:if test="${env_displayListPriceInProductPage == 'true'}">
													shoppingActionsJS.changePrice("entitledItem_<c:out value='${catalogEntryID}'/>",false,${displayPriceRange},"<c:out value='${catalogEntryID}'/>");
												</c:if>'
												title="<c:out value='${swatchValue}'/>">
												<img id="swatch_entitledItem_<c:out value='${catalogEntryID}'/>_<c:out value='${swatchValue}'/>" alt="<c:out value='${swatchValue}'/>" src="<c:out value='${swatchImages[index]}'/>" class="color_swatch"/>
											</a>
											<c:if test="${!defaultSelected}">
												<c:set var="defaultAttributeName" value="${swatchName}"/>
												<c:set var="defaultAttributeValue" value="${swatchValue}"/>
												<c:set var="defaultSelected" value="true"/>
											</c:if>
											<script type="text/javascript">
												dojo.addOnLoad(function() {
													shoppingActionsJS.addToAllSwatchsArray("<c:out value='${swatchName}'/>","<c:out value='${swatchValue}'/>","<c:out value='${swatchImages[index]}'/>", "entitledItem_<c:out value='${catalogEntryID}'/>");
												});
											</script>
										</li>
									</c:forEach>
								</ul>
							</div>
							<div class="clear_float"></div>
						</c:forEach>
						<c:forEach var="attribute" items="${swatchAttrList}" varStatus="aStatus" >
							<c:set var="swatchName" value="${attribute[0]}" />
							<c:if test="${not empty WCParam[swatchName]}">
								<script type="text/javascript">
									dojo.addOnLoad(function() {
										shoppingActionsJS.setSKUImageId('productMainImage');
										shoppingActionsJS.selectSwatch("<c:out value='${swatchName}'/>","<c:out value='${WCParam[swatchName]}'/>","entitledItem_<c:out value='${catalogEntryID}'/>","<c:out value='${doNotDisable}'/>");
									});
								</script>
								<c:set var="attributesSelected" value="true"/>
							</c:if>
						</c:forEach>
						<c:if test="${defaultSelected == 'true' and (not attributesSelected)}">
							<script type="text/javascript">
								dojo.addOnLoad(function() {
									shoppingActionsJS.setSKUImageId('productMainImage');
									shoppingActionsJS.selectSwatch("<c:out value='${defaultAttributeName}'/>","<c:out value='${defaultAttributeValue}'/>","entitledItem_<c:out value='${catalogEntryID}'/>","<c:out value='${doNotDisable}'/>");
									shoppingActionsJS.notifyAttributeChange("${catalogEntryID}");
									<c:if test="${env_displayListPriceInProductPage == 'true'}">
										shoppingActionsJS.changePrice("entitledItem_<c:out value='${catalogEntryID}'/>",false,${displayPriceRange},"<c:out value='${catalogEntryID}'/>");
									</c:if>
								});
							</script>
						</c:if>
					</c:if>					
					<c:forEach var="attribute" items="${definingAttributeList}" varStatus="aStatus" >
						<c:set var="attributeName" value="${attribute[0]}" />
						<c:set var="attributeValues" value="${attribute[1]}" />
						<div class="heading"><c:out value="${attributeName}"/></div>
						<div class="clear_float"></div>
						<div class="options_dropdown">
							<label for="attrValue_<c:out value='${aStatus.count}'/>" style="display:none;"><c:out value='${attributeName}'/><fmt:message key='PD_ACCE_required' /></label>
							<select name="attrValue" id="attrValue_<c:out value='${aStatus.count}'/>" onChange='JavaScript:shoppingActionsJS.setSKUImageId("productMainImage");shoppingActionsJS.setSelectedAttribute("<c:out value='${attributeName}'/>",this.options[this.selectedIndex].value, "<c:out value="entitledItem_${catalogEntryID}"/>");
								shoppingActionsJS.notifyAttributeChange("${catalogEntryID}");
							  <c:if test="${env_displayListPriceInProductPage == 'true'}">
								shoppingActionsJS.changePrice("entitledItem_<c:out value='${catalogEntryID}'/>",false,${displayPriceRange},"<c:out value='${catalogEntryID}'/>");
							  </c:if>
							'>
							<option value="">
								<fmt:message key="PD_SELECT">
									<fmt:param value="${attributeName}"/>
								</fmt:message>
							</option>
							<c:if test="${not empty WCParam[attributeName]}">
								<script type="text/javascript">
									dojo.addOnLoad(function() { 
									shoppingActionsJS.setSelectedAttribute("<c:out value='${attributeName}'/>",'<c:out value="${fn:replace(WCParam[attributeName], search, replaceStr02)}"/>', "<c:out value="entitledItem_${catalogEntryID}"/>");
								});
								</script>
								<c:set var="attributesSelected" value="true"/>
							</c:if>
							<c:forEach var="allowedValue" items="${attributeValues}">
								<option value='<c:out value="${fn:replace(allowedValue, search, replaceStr02)}"/>' <c:if test="${allowedValue == WCParam[attributeName]}">selected="selected"</c:if>>
									<c:out value="${allowedValue}"/>
								</option>
							</c:forEach>
							</select>
						</div>
						<div class="item_spacer_3px"></div>
						<div class="clear_float"></div>
					</c:forEach>
				</c:otherwise>
			</c:choose>	
			<c:if test="${attributesSelected}">
				<script type="text/javascript">
					dojo.addOnLoad(function() {
						if( typeof(InventoryStatusJS_${param.productId}) != "undefined"){
							InventoryStatusJS_${param.productId}.isFetchInventoryStatus = true;
						}
						shoppingActionsJS.notifyAttributeChange("${catalogEntryID}");
						<c:if test="${env_displayListPriceInProductPage == 'true'}">
							shoppingActionsJS.changePrice("entitledItem_<c:out value='${catalogEntryID}'/>",false,${displayPriceRange},"<c:out value='${catalogEntryID}'/>");
						</c:if>
					});
				</script>
			</c:if>
			<%--END : DISPLAYING ATTRIBUTES FOR SHOPPER TO SELECT --%>
			
			<%@ include file="../PriceQuantity/PriceQuantity.jsp" %>
			
			<%-- START : DISPLAY ADD 2 CART button or Unavailable --%>
			<c:choose>
				<c:when test="${requestScope.productAvailable eq 'true'}">
					<div class="quantity_section">
						<label for="quantity_<c:out value='${catalogEntryID}'/>" class="header"><fmt:message key="PD_QTY" /></label>
						<input name="quantity_<c:out value='${catalogEntryID}'/>" id="quantity_<c:out value='${catalogEntryID}'/>" type="text" class="quantity_input" value="1" onchange="javascript:shoppingActionsJS.notifyQuantityChange(this.value);">
						<div class="clear_float"></div>
					</div>
				
					<div class="clear_float"></div>
					<div class="item_spacer_7px"></div>
					<a id="add2CartBtn" href="javascript:setCurrentId('add2CartBtn');shoppingActionsJS.Add2ShopCartAjax('entitledItem_<c:out value='${catalogEntryID}'/>',document.getElementById('quantity_<c:out value='${catalogEntryID}'/>').value, false)" wairole="button" role="button" class="button_add_to_cart"
						title="<fmt:message key="PD_ADD_TO_CART" />">
						<div class="left_border"></div>
						<div id="productPageAdd2Cart" class="button_text">
							<fmt:message key="PD_ADD_TO_CART" />
						</div>
						<div class="right_border"></div>
					</a>
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

			<div class="clear_float"></div>
			<div class="item_spacer_7px"></div>			

			<%--START : DISPLAY Wish List button --%>
			<%out.flush();%>
				<c:import url = "${env_jspStoreDir}Widgets/ShoppingList/ShoppingList.jsp" />
			<%out.flush();%>
			<div class="clear_float"></div>
			<%--END : DISPLAY Wish List button --%>
			
		</div>
		
		<c:if test="${requestScope.productAvailable eq 'true'}">
			<%out.flush();%>
				<c:import url = "${env_jspStoreDir}Widgets/InventoryStatus/InventoryStatus.jsp" >
					<c:param name="productId" value="${param.productId}"/> <%-- Need to pass this parameter, since InventoryStatus.jsp is not cached...--%>
				</c:import>
			<%out.flush();%>
		</c:if>
		
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
										<span><fmt:message key="PD_RECURRING_ITEM"/></span>
										<a id="widget_subscription_item_popup_close" class="close" href="javascript:dijit.byId('widget_subscription_item_popup').hide();"><img role="button" onmouseover="this.src='<c:out value='${jspStoreImgDir}'/>images/colors/color1/close_hover.png'" onmouseout="this.src='<c:out value='${jspStoreImgDir}'/>images/colors/color1/close_normal.png'" src="<c:out value='${jspStoreImgDir}'/>images/colors/color1/close_normal.png" alt="<fmt:message key='LC_CLOSE'/>"/></a>
										<div class="clear_float"></div>
									</div>
									<div class="clear_float"></div>
									<div class="input_section">
										<span><fmt:message key="PD_RECURRING_ITEM_DESC"/></span>
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

<%out.flush();%>
	<c:import url = "${env_jspStoreDir}Widgets/ESpot/ContentRecommendation/ContentRecommendation.jsp">
		<c:param name="storeId" value="${storeId}" />
		<c:param name="catalogId" value="${catalogId}" />
		<c:param name="emsName" value="ProductCenter_Content" />
	</c:import>
<%out.flush();%>		

<%-- END ProductDescription_UI.jsp --%>
