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
<flow:ifEnabled feature="Analytics">
<c:if test="${fn:contains(productDisplayUrl, '?')}">
   <c:set var="cmcrurl" value="${fn:replace(cmcrurl, '?', '&')}" />
</c:if>
</flow:ifEnabled>

	<div class="product">
		<div id="MiniListViewProdImg_${catalogEntryID}" class="product_image" onmouseout="hideSection('component_listing${catalogEntryID}');">			
			<a id="catalogEntry_img${catalogEntryID}" href="<c:out value="${productDisplayUrl}${cmcrurl}" escapeXml="false"/>"
				onkeydown="shiftTabHideSection('component_listing${catalogEntryID}',event);"
				onfocus="showSection('component_listing${catalogEntryID}');"
				title="${fn:escapeXml(name)}">														
				<img id="productThumbNailImage_${catalogEntryID}" src="${productThumbNail160Image}" 
				alt="${fn:escapeXml(name)}" 
				border="0" width="160" height="160"/>
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
									<img src="<c:out value='${ribbonadImage1}'/>"  id="ribbonad_${emsName}_${catEntryIdentifier}_${attrValue.value}" alt="${attrValue.value}" border="0"/>
								</div>								
							</c:if>		
						</c:forEach>								
					</c:if>
				</c:forEach>						
			</a>
			<div id="component_listing${catalogEntryID}" class="quick_info_toggle">
				<a id="MiniListQuickViewLink_${catalogEntryID}" href="javascript:setCurrentId('MiniListQuickViewLink_${catalogEntryID}');QuickInfoJS.showDetails('${catalogEntryID}');"
					onblur="hideSection('component_listing${catalogEntryID}');"><fmt:message key="QUICK_VIEW"/></a>			
			</div>
		</div>

	<div class="product_info left">

		<div id="product_name_${catalogEntryID}" class="product_name">
			<a id="MiniListViewDetailsLink_${catalogEntryID}" href='<c:out value="${productDisplayUrl}${cmcrurl}" escapeXml="false"/>'>
				<c:out value="${name}" escapeXml="false"/>
			</a>
		</div>
		<div class="product_description">
			<span id="product_SKU_<c:out value='${catalogEntryID}'/>" class="sku"><fmt:message key="BD_SKU"/>: <c:out value="${partnumber}" escapeXml="false"/></span>
		</div>
		
		<div class="clear_float"></div>

		<div id="price_display_${catalogEntryID}" class="product_price">
			<c:set var="displayPriceRange" value="true" />
			<%@ include file="../PriceDisplay/PriceDisplay.jsp" %>
		</div>

	
		<div class="product_description">
			<p id="product_shortdescription_${catalogEntryID}"><c:out value="${shortDescription}" escapeXml="false"/></p>
			<div class="clear_float"></div>
		</div>
		<div class="item_spacer_3px"></div>
		
	<c:choose>
		<c:when test="${param.type eq 'bundle'}">
			<c:if test="${!empty fulfillmentFrequencyAttrName}">
				<script type="text/javascript">
					dojo.addOnLoad(function() { 
						shoppingActionsJS.setSelectedAttributeOfProduct("${catalogEntryID}", "<c:out value="${fn:replace(fulfillmentFrequencyAttrName, search01, replaceStr01)}"/>","<c:out value="${fn:replace(fulfillmentFrequency, search01, replaceStr01)}"/>",true);
					});
				</script>
			</c:if>
			<c:if test="${!empty paymentFrequencyAttrName}">
				<script type="text/javascript">
					dojo.addOnLoad(function() { 
						shoppingActionsJS.setSelectedAttributeOfProduct("${catalogEntryID}", "<c:out value="${fn:replace(paymentFrequencyAttrName, search01, replaceStr01)}"/>","<c:out value="${fn:replace(paymentFrequency, search01, replaceStr01)}"/>",true);
					});
				</script>
			</c:if>
			<c:choose>
				<c:when test="${numberOfSKUs == 1}">
					<div class="product_sizes">
						<c:forEach var="attribute" items="${definingAttributeList}" varStatus="aStatus" >
							<c:set var="attributeName" value="${attribute[0]}" />
							<c:set var="attributeValues" value="${attribute[1]}" />
							<c:set var="displayValue" value="${attribute[2]}" />
							<div class="heading">
								<c:out value="${attributeName}"/>: 
								<c:if test="${empty displayValue}">
									<c:out value="${attributeValues}"/>
								</c:if>
								<c:out value="${displayValue}"/>
							</div>
							<script type="text/javascript">
								dojo.addOnLoad(function() { 
									shoppingActionsJS.setSelectedAttributeOfProduct("${catalogEntryID}", "<c:out value='${attributeName}'/>","<c:out value="${attributeValues}"/>",true);
								});
							</script>
						</c:forEach>
						<%-- For products with no attributes --%>
						<c:if test="${empty definingAttributeList}">
							<script type="text/javascript">
								dojo.addOnLoad(function() { 
									shoppingActionsJS.setSelectedAttributeOfProduct("${catalogEntryID}", "","",true);
								});
							</script>
						</c:if>
					</div>
				</c:when>
				<c:otherwise>
					<c:if test="${!empty subsTimePeriodAttrList}">	
						<div class="product_sizes">
							<c:forEach var="attribute" items="${subsTimePeriodAttrList}" varStatus="aStatus" >
								<c:set var="attributeName" value="${attribute[0]}" />
								<c:set var="attributeValues" value="${attribute[1]}" />
								<c:set var="attributeDisplayValues" value="${attribute[2]}" />
								<div class="heading"><c:out value="${attributeName}"/></div>
								<label for="attrValue_<c:out value='${catalogEntryID}_${aStatus.count}'/>" style="display:none;"><c:out value='${attributeName}'/><fmt:message key='PD_ACCE_required'/></label>
								<select name="attrValue" id="attrValue_<c:out value='${catalogEntryID}_${aStatus.count}'/>"
									onchange='javaScript:shoppingActionsJS.setSelectedAttributeOfProduct("${catalogEntryID}", "<c:out value='${attributeName}'/>",this.options[this.selectedIndex].value,false);'>
									<option value="">
										<fmt:message key="BD_SELECT">
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
						</div>
					</c:if>
					<c:if test="${!empty swatchAttrList}">					
						<c:set var="defaultSelected" value="false"/>
						<div class="product_sizes product_color_swatches">
							<c:forEach var="attribute" items="${swatchAttrList}" varStatus="aStatus" >
								<c:set var="swatchName" value="${attribute[0]}" />
								<c:if test="${aStatus.first}">
									<c:set var="firstSwatchName" value="${swatchName}" />
								</c:if>
								<c:set var="swatchValues" value="${attribute[1]}" />
								<c:set var="swatchImages" value="${attribute[2]}" />
								<div class="heading" id="swatch_selection_label_<c:out value='${catalogEntryID}_${swatchName}'/>" ><c:out value="${swatchName}"/>: 
									<label id="swatch_selection_<c:out value='${catalogEntryID}_${swatchName}'/>" style="display:none;"></label>
								</div>
								<div class="clear_float"></div>
								<span class="spanacce" id="swatch_ACCE_description_<c:out value="${catalogEntryID}_${fn:replace(swatchName, ' ', '-')}"/>"><fmt:message key="ACCE_Region_Price_Update"/></span>
								<div class="color_swatch_list" role="radiogroup" aria-label="${swatchName}" aria-describedby="swatch_ACCE_description_<c:out value="${catalogEntryID}_${fn:replace(swatchName, ' ', '-')}"/>">
									<ul>
										<c:forEach var="swatchValue" items="${swatchValues}" varStatus="vStatus">
											<c:set var="index" value="${fn:trim(vStatus.count-1)}" />
											<li>
												<a role="radio" aria-setsize="${fn:length(swatchValues)}" aria-posinset="${vStatus.count}" aria-checked="false" id="swatch_link_<c:out value='${catalogEntryID}_${swatchName}_${swatchValue}'/>" href='javascript: shoppingActionsJS.selectBundleItemSwatch("<c:out value='${catalogEntryID}'/>","<c:out value='${swatchName}'/>","<c:out value='${swatchValue}'/>","<c:out value='${firstSwatchName}'/>");' title="<c:out value='${swatchValue}'/>" >
													<img id="swatch_<c:out value='${catalogEntryID}_${swatchName}_${swatchValue}'/>" alt="<c:out value='${swatchValue}'/>" src="<c:out value='${swatchImages[index]}'/>" class="color_swatch"/>
												</a>
												<c:if test="${!defaultSelected}">
													<c:set var="defaultAttributeName" value="${swatchName}"/>
													<c:set var="defaultAttributeValue" value="${swatchValue}"/>
													<c:set var="defaultSelected" value="true"/>
												</c:if>									
											</li>
										</c:forEach>
									</ul>
								</div>
								<div class="clear_float"></div>
							</c:forEach>
						</div>
						<c:if test="${swatchEnabled == 'true'}">
							<script type="text/javascript">
								dojo.addOnLoad(function() {
									shoppingActionsJS.selectBundleItemSwatch("<c:out value='${catalogEntryID}'/>","<c:out value='${defaultAttributeName}'/>","<c:out value='${defaultAttributeValue}'/>","<c:out value='${firstSwatchName}'/>");
								});
							</script>
						</c:if>					
					</c:if>
					<c:if test="${!empty definingAttributeList}">	
						<div class="product_sizes">
							<c:forEach var="attribute" items="${definingAttributeList}" varStatus="aStatus" >
								<c:set var="attributeName" value="${attribute[0]}" />
								<c:set var="attributeValues" value="${attribute[1]}" />
								<c:choose>
									<c:when test="${type ne 'item'}">
										<div class="heading"><c:out value="${attributeName}"/></div>
										<label for="attrValue_<c:out value='${catalogEntryID}_${aStatus.count}'/>" style="display:none;"><c:out value='${attributeName}'/><fmt:message key='PD_ACCE_required'/></label>
										<select name="attrValue" id="attrValue_<c:out value='${catalogEntryID}_${aStatus.count}'/>" onchange='JavaScript:shoppingActionsJS.setSelectedAttributeOfProduct("${catalogEntryID}", "<c:out value='${attributeName}'/>",this.options[this.selectedIndex].value,false);'>
										<option value="">
											<fmt:message key="BD_SELECT">
												<fmt:param value="${attributeName}"/>
											</fmt:message>
										</option>
										<c:forEach var="allowedValue" items="${attributeValues}">
											<option value='<c:out value="${allowedValue}"/>' <c:if test="${allowedValue == WCParam[attributeName]}">selected="selected"</c:if>>
												<c:out value="${allowedValue}"/>
											</option>
										</c:forEach>
										</select>
									</c:when>
									<c:otherwise>
										<div class="heading">
											<c:out value="${attributeName}"/>: <c:out value="${attributeValues[0]}"/>							
										</div>
									</c:otherwise>
								</c:choose>								
								<div class="item_spacer_3px"></div>
								<div class="clear_float"></div>				
							</c:forEach>
						</div>
					</c:if>
				</c:otherwise>
			</c:choose>
			
			<%-- Component to display quantity based price. --%>
			<%@ include file="../PriceQuantity/PriceQuantity.jsp" %>
			
			<c:if test="${requestScope.bundleKitAvailable eq 'true'}"> 
				<div class="product_quantity_addtolist">
					<div class="product_quantity left">
		
						<div class="quantity_section">
							<label for="quantity_<c:out value='${catalogEntryID}'/>" class="header"><fmt:message key="BD_QTY" /></label>
							<input id="quantity_<c:out value='${catalogEntryID}'/>" type="text" class="quantity_input"  value="${param.quantity}"
								onchange="javascript:shoppingActionsJS.quantityChanged('${catalogEntryID}',this.value);"/>
							<div class="clear_float"></div>
						</div>
						<script type="text/javascript">
							dojo.addOnLoad(function() {
								shoppingActionsJS.setProductQuantity('${type}','${catalogEntryID}','${param.quantity}','${offerPrice}');									
							});
						</script>
					</div>
					<div class="clear_float"></div>
				</div>
			</c:if>

		</div>
			<c:if test="${requestScope.bundleKitAvailable eq 'true'}">
				<%out.flush();%>
					<c:import url = "${env_jspStoreDir}Widgets/InventoryStatus/InventoryStatus.jsp">
						<c:param name="productId" value="${catalogEntryID}"/>
					</c:import>
				<%out.flush();%>
			</c:if>
		</c:when>
		<c:otherwise>
			<div class="product_quantity_addtolist">
				<div class="product_quantity left">
					<div class="quantity_section">
						<label class="header"><fmt:message key="BD_QTY" />: ${param.quantity}</label>
						<div class="clear_float"></div>
					</div>
				</div>
			</div>
		</div>
		</c:otherwise>
	</c:choose>
	<div class="clear_float"></div>
</div>
<%-- END CatalogEntryDisplay_ListView_UI.jsp --%>