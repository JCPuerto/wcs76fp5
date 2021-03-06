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

<%-- START CatalogEntryDisplay_ListView_UI.jsp --%>
<%-- showCompareBox will be set to true by default. Pass the value as param to override the value. --%>
<c:choose>
	<c:when test="${not empty param.showCompareBox}">
		<c:set var="showCompareBox" value="${param.showCompareBox}" />
	</c:when>
	<c:otherwise>
		<c:set var="showCompareBox" value="true" />
	</c:otherwise>
</c:choose>

<flow:ifEnabled feature="Analytics">
<c:if test="${fn:contains(productDisplayUrl, '?')}">
   <c:set var="cmcrurl" value="${fn:replace(cmcrurl, '?', '&')}" />
</c:if>
</flow:ifEnabled>

<c:if test="${type eq 'package' || type eq 'bundle' || type eq 'dynamickit'}">
	<c:set var="showCompareBox" value="false" />
</c:if>

<div class="product">
		<div class="product_image"
		<c:if test="${showCompareBox eq 'true'}">
			onmouseout="if(!dojo.byId('comparebox_${catalogEntryID}').checked){
				hideSection('compare_${catalogEntryID}');
			}"
		</c:if>>
			<a id="CatalogEntryDisplayLink_${catalogEntryID}" href='<c:out value="${productDisplayUrl}${cmcrurl}" escapeXml="false"/>'
				<c:if test="${showCompareBox eq 'true'}">
					onkeydown="if(!dojo.byId('comparebox_${catalogEntryID}').checked){shiftTabHideSection('compare_${catalogEntryID}',event);}"
					onfocus="showSection('compare_${catalogEntryID}');"
				</c:if> title="<c:out value='${name}' escapeXml='false'/>">	
				<img id="productThumbNailImage_${catalogEntryID}" src="${productThumbNailImage}" 
				alt="<c:out value='${name}' escapeXml='false'/>" 
				border="0"/>
				<c:forEach var="attribute" items="${attributes}" varStatus="status2">
					<c:if test="${attribute.usage == 'Descriptive' && fn:startsWith(attribute.identifier,'ribbonad')}">
						<c:forEach var="attrValue" items="${attribute.values}">
							<c:remove var="ribbonadImage1"/>
							<c:forEach var="extVal" items="${attrValue.extendedValue}">
								<c:if test="${extVal.key == 'Image1Path'}">
									<c:set var="ribbonadImage1" value="${env_imageContextPath}/${extVal.value}"/>																								
								</c:if>									
							</c:forEach>
							<c:if test="${!empty ribbonadImage1}">
								<div class="ribbonad_<c:out value='${attrValue.value}'/>">
									<img src="<c:out value='${ribbonadImage1}'/>"  id="ribbonad_list_${catEntryIdentifier}_${attrValue.value}" alt="${attrValue.value}" border="0"/>
								</div>
							</c:if>		
						</c:forEach>								
					</c:if>
				</c:forEach>				
			</a>
			<c:if test="${showCompareBox eq 'true'}">
				<div id="compare_${catalogEntryID}" class="compare_target">
					<input id="comparebox_${catalogEntryID}" type="checkbox" name="comparebox_${catalogEntryID}" onclick="javascript:shoppingActionsJS.addOrRemoveFromCompare('${catalogEntryID}',this.checked)">
					<a id="CompareLink_${catalogEntryID}" href="javascript:shoppingActionsJS.changeCompareBox('comparebox_${catalogEntryID}','${catalogEntryID}');"
						onkeydown="if(!dojo.byId('comparebox_${catalogEntryID}').checked){
								tabHideSection('compare_${catalogEntryID}',event,'CatalogEntryViewDetailsLink_${catalogEntryID}');
							}">
						<label for="comparebox_${catalogEntryID}"><fmt:message key="COMPARE"/></label>
					</a>
				</div>
				<c:if test="${param.fromPage ne 'compare'}">
					<script>
						if(dojo.byId("comparebox_${catalogEntryID}").checked){
							dojo.addOnLoad(function(){
								dojo.byId("comparebox_${catalogEntryID}").checked = '';
							});
						}
					</script>
				</c:if>
			</c:if>
		</div>

	<div class="product_info">
		<div id="product_name_${catalogEntryID}" class="product_name">
			<c:if test="${not empty searchScore}">
				<div class="caption" style="display:none">
					<div class="searchResultSpot">[<fmt:message key='SEARCH_SCORE'/> <c:out value="${searchScore}"/>]</div>
				</div>
			</c:if>
			<a id="CatalogEntryViewDetailsLink_${catalogEntryID}" href='<c:out value="${productDisplayUrl}${cmcrurl}" escapeXml="false"/>'>
				<c:out value="${name}" escapeXml="false"/>
			</a>
		</div>
		<c:if test="${(requestScope.bundleKitAvailable eq 'false') and (requestScope.productAvailable eq 'false') and (requestScope.dynamicKitAvailable eq 'false')}" >
			<div class="not_available"><fmt:message key="PD_PRODUCT_NOT_AVAILABLE_MESSAGE"/></div>
		</c:if>
		<div id="price_display_${catalogEntryID}" class="product_price">
			<c:set var="displayPriceRange" value="true" />
			<%@ include file="../PriceDisplay/PriceDisplay.jsp" %>
		</div>

		<div class="product_description">
			<p id="product_shortdescription_${catalogEntryID}"><c:out value="${shortDescription}" escapeXml="false"/></p>
			<div class="clear_float"></div>
		</div>
		<div class="item_spacer_7px"></div>
		<c:choose>
			<c:when test="${numberOfSKUs == 1}">
				<c:if test="${deffAttrCount != 0}" >
					
						<c:forEach items="${definingAttributeMap}" varStatus="aStatus" >
							<c:set var="attributeName" value="${aStatus.current.key}" />
							<c:set var="attributeValues" value="${aStatus.current.value}" />
							<c:out value="${attributeName}"/>: <c:out value="${attributeValues}"/>
							<script type="text/javascript">
								dojo.addOnLoad(function() { 
									shoppingActionsJS.setSelectedAttribute("<c:out value='${attributeName}'/>","<c:out value="${attributeValues}"/>", "<c:out value="entitledItem_${catalogEntryID}"/>", "<c:out value="productThumbNailImage_${catalogEntryID}"/>", "ItemThumbnailImage");
								});
							</script>
						</c:forEach>
					
				</c:if>
			</c:when>
			<c:when test="${!empty subsTimePeriodAttrList}" >
				<c:if test="${subsFulfillmentFrequencyAttrCount != 0}" >
					<c:forEach items="${subsFulfillmentFrequencyAttrMap}" varStatus="aStatus">
						<c:set var="attributeName" value="${aStatus.current.key}" />
						<c:set var="attributeValues" value="${aStatus.current.value}" />
						<script type="text/javascript">
							dojo.addOnLoad(function() { 
								shoppingActionsJS.setSelectedAttribute("<c:out value='${attributeName}'/>","<c:out value="${attributeValues}"/>", "<c:out value="entitledItem_${catalogEntryID}"/>", "<c:out value="productThumbNailImage_${catalogEntryID}"/>", "ItemThumbnailImage");
							});
						</script>
					</c:forEach>
				</c:if>
				<c:if test="${subsPaymentFrequencyAttrCount != 0}" >
					<c:forEach items="${subsPaymentFrequencyAttrMap}" varStatus="aStatus">
						<c:set var="attributeName" value="${aStatus.current.key}" />
						<c:set var="attributeValues" value="${aStatus.current.value}" />
						<script type="text/javascript">
							dojo.addOnLoad(function() { 
								shoppingActionsJS.setSelectedAttribute("<c:out value='${attributeName}'/>","<c:out value="${attributeValues}"/>", "<c:out value="entitledItem_${catalogEntryID}"/>", "<c:out value="productThumbNailImage_${catalogEntryID}"/>", "ItemThumbnailImage");
							});
						</script>
					</c:forEach>
				</c:if>
				<c:forEach var="attribute" items="${subsTimePeriodAttrList}" varStatus="aStatus" >
					<c:set var="attributeName" value="${attribute[0]}" />
					<c:set var="attributeValues" value="${attribute[1]}" />
					<c:set var="attributeDisplayValues" value="${attribute[2]}" />
					<div class="header"><c:out value="${attributeName}"/></div>
					<label for="attrValue_<c:out value='${catalogEntryID}'/>_<c:out value='${aStatus.count}'/>" style="display:none;"><c:out value='${attributeName}'/><fmt:message key='PD_ACCE_required'/></label>
					<select name="attrValue" id="attrValue_<c:out value='${catalogEntryID}'/>_<c:out value='${aStatus.count}'/>"
						onChange='JavaScript:shoppingActionsJS.setSelectedAttribute("<c:out value='${attributeName}'/>",this.options[this.selectedIndex].value, "<c:out value="entitledItem_${catalogEntryID}"/>", "<c:out value="productThumbNailImage_${catalogEntryID}"/>", "ItemThumbnailImage");
								shoppingActionsJS.setSelectedAttribute("<c:out value='${fn:replace(fulfillmentFrequencyAttrName, search01, replaceStr01)}'/>","<c:out value="${fn:replace(fulfillmentFrequency, search01, replaceStr01)}"/>", "<c:out value="entitledItem_${catalogEntryID}"/>", "<c:out value="productThumbNailImage_${catalogEntryID}"/>", "ItemThumbnailImage");
								shoppingActionsJS.setSelectedAttribute("<c:out value='${fn:replace(paymentFrequencyAttrName, search01, replaceStr01)}'/>","<c:out value="${fn:replace(paymentFrequency, search01, replaceStr01)}"/>", "<c:out value="entitledItem_${catalogEntryID}"/>", "<c:out value="productThumbNailImage_${catalogEntryID}"/>", "ItemThumbnailImage");
								<c:if test="${env_displayListPriceInProductPage == 'true'}">
									shoppingActionsJS.changePrice("entitledItem_<c:out value='${catalogEntryID}'/>",false,${displayPriceRange},"<c:out value='${catalogEntryID}'/>");
								</c:if>
					'>
						<option value="">
							<fmt:message key="PD_SELECT">
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
				</c:forEach>
			</c:when>
			<c:otherwise>
					<c:if test="${!empty swatchAttrList}">
						<c:set var="defaultSelected" value="false"/>
						<c:forEach var="attribute" items="${swatchAttrList}" varStatus="aStatus" >
							<c:set var="swatchName" value="${attribute[0]}" />
							<c:set var="swatchValues" value="${attribute[1]}" />
							<c:set var="swatchImages" value="${attribute[2]}" />
							<div class="header color_swatch_label" id="swatch_selection_label_entitledItem_<c:out value='${catalogEntryID}'/>_<c:out value='${swatchName}'/>" ><c:out value="${swatchName}"/>: </div>
							<div class="header" id="swatch_selection_entitledItem_<c:out value='${catalogEntryID}'/>_<c:out value='${swatchName}'/>"></div>
							<div class="item_spacer_3px"></div>
							<div class="product_color_swatches">
								<span class="spanacce" id="swatch_ACCE_description_<c:out value='${catalogEntryID}'/>_<c:out value="${fn:replace(swatchName, ' ', '-')}"/>"><fmt:message key="ACCE_Region_Price_Update"/></span>
								<div class="color_swatch_list" role="radiogroup" aria-label="${swatchName}" aria-describedby="swatch_ACCE_description_<c:out value='${catalogEntryID}'/>_<c:out value="${fn:replace(swatchName, ' ', '-')}"/>">
									<ul>
										<c:forEach var="swatchValue" items="${swatchValues}" varStatus="vStatus">
											<c:set var="index" value="${fn:trim(vStatus.count-1)}" />
											<li>
												<a role="radio" aria-setsize="${fn:length(swatchValues)}" aria-posinset="${vStatus.count}" aria-checked="false" id="swatch_link_entitledItem_<c:out value='${catalogEntryID}'/>_<c:out value='${swatchValue}'/>" title="<c:out value='${swatchValue}'/>" href='javascript: shoppingActionsJS.selectSwatch("<c:out value='${swatchName}'/>","<c:out value='${swatchValue}'/>","entitledItem_<c:out value='${catalogEntryID}'/>","<c:out value='${doNotDisable}'/>","productThumbNailImage_<c:out value='${catalogEntryID}'/>","ItemThumbnailImage");'>
													<img id="swatch_entitledItem_<c:out value='${catalogEntryID}'/>_<c:out value='${swatchValue}'/>" alt="<c:out value='${swatchValue}'/>" src="<c:out value='${swatchImages[index]}'/>" class="color_swatch <c:if test='${aStatus.last}'>last_swatch</c:if>"/>
												</a>
											</li>
											<c:if test="${!defaultSelected}">
												<c:set var="defaultAttributeName" value="${swatchName}"/>
												<c:set var="defaultAttributeValue" value="${swatchValue}"/>
												<c:set var="defaultSelected" value="true"/>
											</c:if>									
											<script type="text/javascript">			
													shoppingActionsJS.addToAllSwatchsArray("<c:out value='${swatchName}'/>","<c:out value='${swatchValue}'/>","<c:out value='${swatchImages[index]}'/>","entitledItem_<c:out value='${catalogEntryID}'/>","ItemThumbnailImage");
											</script>
											<a id="swatch_array_<c:out value='${catalogEntryID}'/>_${vStatus.count}_<c:out value="${fn:replace(swatchName, ' ', '-')}"/>_<c:out value="${fn:replace(swatchValue, ' ', '-')}"/>" class="nodisplay" href='javascript:shoppingActionsJS.addToAllSwatchsArray("<c:out value='${swatchName}'/>","<c:out value='${swatchValue}'/>","<c:out value='${swatchImages[index]}'/>","entitledItem_<c:out value='${catalogEntryID}'/>");'></a>
										</c:forEach>
									</ul>
								</div>
							</div>
							<c:if test="${!aStatus.last}">
								<div class="item_spacer_3px"></div>
							</c:if>
						</c:forEach>
						<c:if test="${defaultSelected == 'true'}">
							<script type="text/javascript">
									shoppingActionsJS.setSKUImageId("productThumbNailImage_<c:out value='${catalogEntryID}'/>");			
									shoppingActionsJS.selectSwatch("<c:out value='${defaultAttributeName}'/>","<c:out value='${defaultAttributeValue}'/>","entitledItem_<c:out value='${catalogEntryID}'/>","<c:out value='${doNotDisable}'/>","productThumbNailImage_<c:out value='${catalogEntryID}'/>","ItemThumbnailImage");	
							</script>
							<a id="swatch_setSkuImage_<c:out value='${catalogEntryID}'/>_${vStatus.count}" class="nodisplay" href='javascript:shoppingActionsJS.setSKUImageId("productThumbNailImage_<c:out value='${catalogEntryID}'/>");'></a>
							<a id="swatch_selectDefault_<c:out value='${catalogEntryID}'/>_${vStatus.count}" class="nodisplay" href='javascript:shoppingActionsJS.selectSwatch("<c:out value='${defaultAttributeName}'/>","<c:out value='${defaultAttributeValue}'/>","entitledItem_<c:out value='${catalogEntryID}'/>","<c:out value='${doNotDisable}'/>","productThumbNailImage_<c:out value='${catalogEntryID}'/>","ItemThumbnailImage");'></a>							
						</c:if>			
					</c:if>				
				
					<c:forEach var="attribute" items="${definingAttributeList}" varStatus="aStatus" >
						<c:set var="attributeName" value="${attribute[0]}" />
						<c:set var="attributeValues" value="${attribute[1]}" />
						<div class="header"><c:out value="${attributeName}"/></div>
						<label for="attrValue_<c:out value='${catalogEntryID}'/>_<c:out value='${aStatus.count}'/>" style="display:none;"><c:out value='${attributeName}'/><fmt:message key='PD_ACCE_required'/></label>
						<select name="attrValue" id="attrValue_<c:out value='${catalogEntryID}'/>_<c:out value='${aStatus.count}'/>" onChange='JavaScript:shoppingActionsJS.setSelectedAttribute("<c:out value='${attributeName}'/>",this.options[this.selectedIndex].value, "<c:out value="entitledItem_${catalogEntryID}"/>", "<c:out value="productThumbNailImage_${catalogEntryID}"/>", "ItemThumbnailImage");
							<c:if test="${env_displayListPriceInProductPage == 'true'}">
								shoppingActionsJS.changePrice("entitledItem_<c:out value='${catalogEntryID}'/>",false,${displayPriceRange},"<c:out value='${catalogEntryID}'/>");
							</c:if>
						'>
						<option value="">
							<fmt:message key="PD_SELECT">
								<fmt:param value="${attributeName}"/>
							</fmt:message>
						</option>
						<c:forEach var="allowedValue" items="${attributeValues}">
							<option value='<c:out value="${allowedValue}"/>' <c:if test="${allowedValue == WCParam[attributeName]}">selected="selected"</c:if>>
								<c:out value="${allowedValue}"/>
							</option>
						</c:forEach>
						</select>
						<div class="item_spacer_3px"></div>
						<div class="clear_float"></div>				
					</c:forEach>

			</c:otherwise>
		</c:choose>
		
		<div class="product_quantity_addtolist">
			<div class="product_quantity left">

				<div class="quantity_section">
					<label for="quantity_<c:out value='${catalogEntryID}'/>" class="header"><fmt:message key="PD_QTY" /></label>
					<input id="quantity_<c:out value='${catalogEntryID}'/>" type="text" class="quantity_input"  value="1"/>
					<div class="clear_float"></div>
				</div>
			</div>
			<div class="clear_float"></div>
		</div>
		<c:choose>
			<c:when test="${(requestScope.bundleKitAvailable eq 'true') or (requestScope.productAvailable eq 'true') or (requestScope.dynamicKitAvailable eq 'true')}" >
				<flow:ifDisabled feature="HidePurchaseButton">
					<c:choose>											
						<c:when test="${type == 'dynamickit' && showDynamicKit == 'true'}">
							<%@ include file="CatalogEntryDisplayForDynamicKits_ImageView.jspf" %>
						</c:when>
						<c:when test="${type == 'item' || type == 'package' || type == 'product'}">
							<div class="product_option">
								<a id="listViewAdd2Cart_<c:out value='${catalogEntryID}'/>" href="javascript:setCurrentId('listViewAdd2Cart_<c:out value='${catalogEntryID}'/>');shoppingActionsJS.Add2ShopCartAjax('entitledItem_<c:out value='${catalogEntryID}'/>',document.getElementById('quantity_<c:out value='${catalogEntryID}'/>').value, false)" class="button_primary" wairole="button" role="button" title="<fmt:message key="ADD_TO_CART" />">
									<div class="left_border"></div>
									<div class="button_text"><fmt:message key="ADD_TO_CART" /></div>
									<div class="right_border"></div>
								</a>	
							</div>
						</c:when>
						<c:otherwise>
							<div class="product_option">
								<a id="listViewAdd2Cart_<c:out value='${catalogEntryID}'/>"  href="javascript:setCurrentId('listViewAdd2Cart_<c:out value='${catalogEntryID}'/>');QuickInfoJS.showDetails('${catEntryIdentifier}');" class="button_primary" wairole="button" role="button" title="<fmt:message key="QUICK_VIEW" />">
									<div class="left_border"></div> 
									<div id="ListViewQuickViewButton_${catalogEntryID}" class="button_text">
										<fmt:message key="QUICK_VIEW"/>
									</div>
									<div class="right_border"></div>
								</a>	
							</div>
						</c:otherwise>
					</c:choose>
				</flow:ifDisabled> 
			</c:when>
			<c:otherwise>
				<div class="product_option disabled">
					<div onclick="" class="button_primary">
						<div class="left_border"></div>
						<div class="button_text"><fmt:message key="PD_UNAVAILABLE"/></div>
						<div class="right_border"></div>
					</div>	
				</div>
			</c:otherwise>
		</c:choose>
		
		<c:if test="${not empty attachmentsList}">
			<div class="product_attachment">
				<c:forEach var="attachmentDetails" items="${attachmentsList}" varStatus="status">
					<div class="icon">
						<img src="${attachmentDetails['image']}" alt="${attachmentDetails['description']}" />
					</div>
					<div class="details">
						<p><c:out value="${attachmentDetails['name']}"/></p>
						<p>
							<a href="${attachmentDetails['assetPath']}" target="_blank" id="Attachment_${catalogEntryID}_${status.count}" title="${attachmentDetails['description']}">
								<c:out value="${attachmentDetails['linkName']}"/>
							</a>
						</p>
						<div class="clear_float"></div>
					</div>
					<div class="clear_float"></div>
					<div class="item_spacer_5px"></div>
				</c:forEach>
			</div>
		</c:if>
		
	</div>
</div>
<%-- END CatalogEntryDisplay_ListView_UI.jsp --%>
