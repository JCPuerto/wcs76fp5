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
<div class="left_column">
	<div class="image_container">
		<img id="quickInfoMainImage" src="${quickInfoImageSource}" alt="${fullImageAltDescription}" title="${fullImageAltDescription}" width="330" height="330"/>
	</div>
	<div class="other_views">
		<ul>
			<c:forEach items="${angleThumbnailAttachmentMap}" varStatus="aStatus">
				<li id="quickInfoThumbnail${aStatus.count}" <c:if test="${aStatus.first}">class="selected"</c:if>>
					<a id="WC_QuickInfo_Link_thumbnail_${aStatus.count}" href="javaScript:QuickInfoJS.changeImage(${aStatus.count},'${angleFullImageAttachmentMap[aStatus.current.key]}');"
						title="${angleThumbnailAttachmentShortDescMap[aStatus.current.key]}">
						<img src="${angleThumbnailAttachmentMap[aStatus.current.key]}" alt="${angleThumbnailAttachmentShortDescMap[aStatus.current.key]}" width="70" height="70"/>
					</a>
				</li>
			</c:forEach>
		</ul>
	</div>
	
</div>
<div class="right_column">
	<a id="WC_QuickInfo_Link_close" href="javascript:QuickInfoJS.close('catalogEntry_img${param.productId}');" class="close_group" title="<fmt:message key="QI_CLOSE_BUTTON"/>">
		<div class="close"></div>
		<div class="close_text"><fmt:message key="CLOSE"/></div>
	</a>
	
	<span class="main_header">${name}</span>
	<div class="clear_float"></div>
	<span class="sku"><fmt:message key="CurrentOrder_SKU"/> ${partNumber}</span>
	<div class="clear_float"></div>
	
	<c:if test="${requestScope.available eq 'false'}">
		<div class="not_available"><fmt:message key="PD_PRODUCT_NOT_AVAILABLE_MESSAGE"/></div>
	</c:if>

	<div class="item_spacer_5px"></div>

	<%@ include file="../PriceDisplay/PriceDisplay.jsp" %>

	<c:choose>
		<c:when test="${env_fetchMarketingDetailsOnLoad}">
			<div id="quickInfoDiscountDetailsRefreshArea" class="content" dojoType="wc.widget.RefreshArea" controllerId="QuickInfoDiscountDetailsController">
			</div>
		</c:when>
		<c:otherwise>
		<%out.flush();%>
			<c:import url = "${env_jspStoreDir}Widgets/Discounts/Discounts.jsp"/>
		<%out.flush();%>
		</c:otherwise>
	</c:choose>
	<div class="clear_float"></div>

	<div class="divider"></div>
	<p>${longDescription}</p>
	<ul>
		<c:forEach var="descriptiveAttribute" items="${descriptiveAttributeMap}" varStatus="aStatus" >
			<li>
				<span id="descAttributeName_${aStatus.count}">
					<fmt:message key="ATTRNAMEKEY">
						<fmt:param value="${descriptiveAttribute.key}"/>
					</fmt:message>
				</span>
				<span id="descAttributeValue_${aStatus.count}"><c:out value="${descriptiveAttribute.value}"/></span>
			</li>
		</c:forEach>
	</ul>
	
	<c:if test="${not empty dynamicKitComponentList}">
		<div class="item_spacer_5px"></div>
		<p><fmt:message key="CONFIGURATION" />:</p>
		<ul id="configuredComponents">
			<c:forEach items="${dynamicKitComponentList}" var="componentName">
				<li>${componentName}</li>
			</c:forEach>
		</ul>
	</c:if>
	
	<a id="WC_QuickInfo_Link_viewdetails" href="${catalogEntryUrl}"><fmt:message key="QI_VIEW_FULL_DETAILS" /></a>
	<div class="clear_float"></div>

	<div class="divider"></div>
	<c:set var="hasAttributes" value="false"/>
	<c:choose>
		<c:when test="${numberOfSKUs == 1}">
			<c:forEach var="attribute" items="${definingAttributeList}">
				<c:set var="hasAttributes" value="true"/>
				<c:set var="attributeName" value="${attribute[0]}" />
				<c:set var="attributeValues" value="${attribute[1]}" />
				<c:set var="displayValue" value="${attribute[2]}" />
				<p>
					<fmt:message key="ATTRNAMEKEY">
						<fmt:param value="${attributeName}"/>
					</fmt:message>
					<c:if test="${empty displayValue}">
						<c:out value="${attributeValues}"/>
					</c:if>
					<c:out value="${displayValue}"/>
				</p>
			</c:forEach>
		</c:when>
		<c:otherwise>
			<div class="color_and_size">
				<c:set var="swatchNames" value=""/>
				<c:set var="updateItemImageOnly" value="true"/>
				<c:forEach var="attribute" items="${swatchAttrList}" varStatus="aStatus" >
					<c:set var="hasAttributes" value="true"/>
					<c:set var="swatchName" value="${fn:escapeXml(attribute[0])}" />
					<c:set var="swatchValues" value="${attribute[1]}" />
					<c:set var="swatchImages" value="${attribute[2]}" />
					<c:if test="${!empty swatchNames}">
						<c:set var="swatchNames" value="${swatchNames}_"/>
					</c:if>
					<c:set var="swatchNames" value="${swatchNames}${swatchName}"/>
					<div class="heading">
						<fmt:message key="ATTRNAMEKEY">
							<fmt:param value="${swatchName}"/>
						</fmt:message>
						<span class="selectedAttribute" id="quickinfo_swatch_selection_<c:out value='${swatchName}'/>"></span>
					</div>
					<span class="spanacce" id="swatch_ACCE_description_<c:out value="${fn:replace(swatchName, ' ', '-')}"/>"><fmt:message key="ACCE_Region_Price_Update"/></span>
					<div class="color_swatch_list" role="radiogroup" aria-label="${swatchName}" aria-describedby="swatch_ACCE_description_<c:out value="${fn:replace(swatchName, ' ', '-')}"/>">
						<ul>
							<c:forEach var="swatchValue" items="${swatchValues}" varStatus="vStatus">
								<c:set var="index" value="${vStatus.count-1}" />
								<li>
									<a role="radio" aria-setsize="${fn:length(swatchValues)}" aria-posinset="${vStatus.count}" aria-checked="false" id="WC_QuickInfo_Swatch_${swatchName}_${swatchValue}" href='javascript:QuickInfoJS.selectSwatch("${swatchName}","${fn:escapeXml(swatchValue)}","quickInfoSwatch_${swatchName}_${swatchValue}","quickInfoSwatch_${swatchName}_");
														QuickInfoJS.notifyAttributeChange();
														QuickInfoJS.selectItem(${displayPriceRange},${updateItemImageOnly});' title="<c:out value='${swatchValue}'/>">
										<img id="quickInfoSwatch_${swatchName}_${swatchValue}" alt="<c:out value='${swatchValue}'/>" src="<c:out value='${swatchImages[index]}'/>" class="color_swatch"/>
									</a>
								</li>
							</c:forEach>
						</ul>
					</div>
					<div class="clear_float"></div>
					<div class="item_spacer_10px"></div>
				</c:forEach>
				<input id="WC_QuickInfo_SwatchNames" type="hidden" value="${swatchNames}"/>
				<c:forEach var="attribute" items="${subsTimePeriodAttrList}" varStatus="aStatus" >
					<c:set var="hasAttributes" value="true"/>
					<c:set var="attributeName" value="${attribute[0]}" />
					<c:set var="attributeValues" value="${attribute[1]}" />
					<c:set var="attributeDisplayValues" value="${attribute[2]}" />
					<span class="heading"><c:out value="${attributeName}"/></span>
					<p>
						<label for="quickInfoAttrValue_<c:out value='${aStatus.count}'/>" style="display:none;"><c:out value='${attributeName}'/> <fmt:message key='QI_ACCE_required'/></label>
						<select name="quickInfoAttrValue" id="quickInfoAttrValue_<c:out value='${aStatus.count}'/>"
									onChange='JavaScript:QuickInfoJS.setSelectedAttribute("<c:out value='${attributeName}'/>",this.options[this.selectedIndex].value);
														QuickInfoJS.setSelectedAttribute("<c:out value='${fn:replace(fulfillmentFrequencyAttrName, singleQuote, escapeSingleQuote)}'/>","<c:out value="${fn:replace(fulfillmentFrequency, singleQuote, escapeSingleQuote)}"/>");
														QuickInfoJS.setSelectedAttribute("<c:out value='${fn:replace(paymentFrequencyAttrName, singleQuote, escapeSingleQuote)}'/>","<c:out value="${fn:replace(paymentFrequency, singleQuote, escapeSingleQuote)}"/>");
														QuickInfoJS.notifyAttributeChange();
														QuickInfoJS.selectItem(${displayPriceRange});
						'>
							<option value="">
								<fmt:message key="QI_SELECT">
									<fmt:param value="${attributeName}"/>
								</fmt:message>
							</option>
							<c:forEach var="allowedValue" items="${attributeValues}" varStatus="vStatus">
								<c:set var="index" value="${fn:trim(vStatus.count-1)}" />
								<option value='<c:out value="${allowedValue}"/>' <c:if test="${allowedValue == WCParam[attributeName]}">selected="selected"</c:if>>
									<c:out value="${attributeDisplayValues[index]}"/>
								</option>
							</c:forEach>
						</select>
					</p>
				</c:forEach>
				
				<c:forEach var="attribute" items="${definingAttributeList}" varStatus="aStatus" >
					<c:set var="hasAttributes" value="true"/>
					<c:set var="attributeName" value="${attribute[0]}" />
					<c:set var="attributeValues" value="${attribute[1]}" />
					<div class="heading"><c:out value="${attributeName}"/></div>
					<div class="color_swatch_list">
						<label for="quickInfoAttrValue_<c:out value='${aStatus.count}'/>" style="display:none;"><c:out value='${attributeName}'/> <fmt:message key='QI_ACCE_required' /></label>
						<select name="quickInfoAttrValue" id="quickInfoAttrValue_<c:out value='${aStatus.count}'/>" alt="<c:out value='${attributeName}'/>" onChange='JavaScript:QuickInfoJS.setSelectedAttribute("<c:out value='${attributeName}'/>",this.options[this.selectedIndex].value);
						  	QuickInfoJS.notifyAttributeChange();
							QuickInfoJS.selectItem(${displayPriceRange});
						'>
						<option value="">
							<fmt:message key="QI_SELECT">
								<fmt:param value="${attributeName}"/>
							</fmt:message>
						</option>
						<c:forEach var="allowedValue" items="${attributeValues}">
							<option value='<c:out value="${fn:replace(fn:replace(allowedValue, singleQuote, escapeSingleQuote), doubleQuote, escapeDoubleQuote)}"/>' <c:if test="${allowedValue == WCParam[attributeName]}">selected="selected"</c:if>>
								<c:out value="${allowedValue}"/>
							</option>
						</c:forEach>
						</select>
					</div>
					<div class="clear_float"></div>
					<div class="item_spacer_10px"></div>
				</c:forEach>
			</div>
		</c:otherwise>
	</c:choose>
	
	<c:if test="${hasAttributes}">
		<div class="clear_float"></div>
		<div class="divider"></div>
	</c:if>
	
	<div class="purchase_section" style="position:relative;${purchase_section}">

		<c:if test="${requestScope.available eq 'true' || updateAttributes || (type eq 'dynamickit' and isDKConfigurable)}">
			<span class="quantity_label left"><label for="WC_QuickInfo_input_quantity"><fmt:message key="QI_QUANTITY" />&nbsp;</label></span>
			<div class="content">
				<input id="WC_QuickInfo_input_quantity" type="text" class="quantity_input" value="1" onchange="javascript:QuickInfoJS.setCatEntryQuantity(this.value);">
			</div>
			<div class="clear_float"></div>
			<div class="item_spacer_7px"></div>
		</c:if>
		
		<c:choose>
			<c:when test="${updateAttributes}">
				<a id="WC_QuickInfo_Link_UpdateCartItem" class="button_add_to_cart" href="javascript:QuickInfoJS.replaceCartItem();" wairole="button" role="button" title="<fmt:message key="QI_UPDATE_CART_ITEM" />">
					<div class="left_border"></div>
					<div class="button_text"><fmt:message key="QI_UPDATE_CART_ITEM" /></div>
					<div class="right_border"></div>
				</a>
				<div class="clear_float"></div>
			</c:when>
			<c:when test="${type eq 'dynamickit'}">
				<%-- Default Customize button style is primary --%>
				<c:set var="customizeBtnStyle" value="button_add_to_cart"/>
				
				<%-- START : DISPLAY ADD 2 CART button or Unavailable --%>
				<c:choose>
					<c:when test="${requestScope.available eq 'true'}">
						<c:if test="${isDKPreConfigured}">
							<a id="WC_QuickInfo_Link_addtocart" class="button_add_to_cart" href="javascript:QuickInfoJS.add2ShopCart({catalogEntryType: 'dynamicKit'});" wairole="button" role="button" title="<fmt:message key="QI_ADD_TO_CART" />">
								<div class="left_border"></div>
								<div class="button_text"><fmt:message key="QI_ADD_TO_CART" /></div>
								<div class="right_border"></div>
							</a>
							<div class="clear_float"></div>
							<div class="item_spacer_5px"></div>
							
							<%-- If Add to Cart is present, change the Customize button style to secondary --%>
							<c:set var="customizeBtnStyle" value="button_secondary"/>
						</c:if>
					
						<c:if test="${isDKConfigurable}">
							<a id="QuickInfoCustomizeBtn" href="javascript:setCurrentId('QuickInfoCustomizeBtn');shoppingActionsJS.customizeDynamicKit('${param.productId}',dojo.byId('WC_QuickInfo_input_quantity').value);" class="${customizeBtnStyle}" title="<fmt:message key="CUSTOMIZE"/>">
							<div class="left_border"></div>
								<div class="button_text">
									<fmt:message key="CUSTOMIZE"/>
								</div>
								<div class="right_border"></div>
							</a>
							<div class="clear_float"></div>
							<div class="item_spacer_5px"></div>
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
						<div class="clear_float"></div>
						<div class="item_spacer_5px"></div>
					</c:otherwise>
				</c:choose>	
				<%-- END : DISPLAY ADD 2 CART button or Unavailable --%>
				
				<%out.flush();%>
					<c:import url = "../ShoppingList/ShoppingList.jsp">
						<c:param name="parentPage" value="QuickInfo"/>
						<c:param name="catalogId" value="${param.catalogId}"/>
						<c:param name="productId" value="${param.productId}"/>
					</c:import>
				<%out.flush();%>
			</c:when>
			<c:when test="${requestScope.available eq 'true'}">
				<a id="WC_QuickInfo_Link_addtocart" class="button_add_to_cart" href="javascript:QuickInfoJS.add2ShopCart();" wairole="button" role="button" title="<fmt:message key="QI_ADD_TO_CART" />">
					<div class="left_border"></div>
					<div class="button_text"><fmt:message key="QI_ADD_TO_CART" /></div>
					<div class="right_border"></div>
				</a>
				<div class="clear_float"></div>
				<div class="item_spacer_3px"></div>
			
				<%out.flush();%>
					<c:import url = "../ShoppingList/ShoppingList.jsp">
						<c:param name="parentPage" value="QuickInfo"/>
						<c:param name="catalogId" value="${param.catalogId}"/>
						<c:param name="productId" value="${param.productId}"/>
					</c:import>
				<%out.flush();%>
			</c:when>
			<c:otherwise>
				<div class="disabled">
					<div class="button_primary">
						<div class="left_border"></div>
						<div class="button_text" style="width: 116px;"><fmt:message key="PD_UNAVAILABLE"/></div>
						<div class="right_border"></div>
					</div>																	
				</div>
				<div class="clear_float"></div>
				<div class="item_spacer_7px"></div>
				
				<%out.flush();%>
					<c:import url = "../ShoppingList/ShoppingList.jsp">
						<c:param name="parentPage" value="QuickInfo"/>
						<c:param name="catalogId" value="${param.catalogId}"/>
						<c:param name="productId" value="${param.productId}"/>
					</c:import>
				<%out.flush();%>
			</c:otherwise>
		</c:choose>
		<input id="catEntryParamsForJS" type="hidden" value="${catEntryParams}"/>
	</div>

</div>
<div class="clear_float"></div>
