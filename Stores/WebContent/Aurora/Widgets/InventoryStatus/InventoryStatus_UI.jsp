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
<c:choose>
<c:when test="${hasInventory}">
<script>
	InventoryStatusJS_${param.productId} = new InventoryStatusJS(${storeParams}, ${catEntryParams}, [${physicalStores}], '${param.productId}');
</script>
<div class="left" id="progressbar_${param.productId}"></div>
<div id="InventoryStatus_Availability_Section_${param.productId}" class="left available" <c:if test="${!showAvailability}">style="display:none;"</c:if>>
	<div class="header"><fmt:message key="AVAILABLE_ONLINE"/></div>
	
	<div class="sublist">
		<span>
			<img id="InventoryStatus_OnlineStatus_Img_${param.productId}" src="${jspStoreImgDir}${env_vfileColor}widget_product_info/<fmt:message key="IMG_NAME_${onlineInventoryStatus}"/>" 
				alt="<fmt:message key="IMG_INV_STATUS_${onlineInventoryStatus}"/>" border="0" />
		</span>
		<c:choose>
			<c:when test="${onlineInventoryStatus == 'Available'}">
				<c:set var="richSnippetContent" value="in_stock"/>
			</c:when>
			<c:otherwise>
				<c:set var="richSnippetContent" value="out_of_stock"/>
			</c:otherwise>
		</c:choose>
		<span id="InventoryStatus_OnlineStatus_${param.productId}" class="text" itemprop="availability" content="${richSnippetContent}"><fmt:message key="INV_STATUS_${onlineInventoryStatus}"/></span>
		<div class="clear_float"></div>
	</div>
	<div class="item_spacer_7px"></div>
	
	<flow:ifEnabled feature="StoreLocator">
		<div id="InventoryStatus_InStore_Heading_${param.productId}" class="header"><fmt:message key="AVAILABLE_INSTORE"/></div>
		
		<%-- Display physical store inventory status section only if at least one physical store inventory status is available --%>
		<c:if test="${storeCounter ne 0}">
			<div id="InventoryStatus_InStore_Section_${param.productId}" class="sublist">
				<c:forEach var="inStoreInventoryName" items="${inStoreInventoryNameMap}" varStatus="status">
				
					<a id="WC_InventoryStatus_Link_${param.productId}_store_${status.count}" href="javascript:InventoryStatusJS_${param.productId}.fetchStoreDetails('${inStoreInventoryName.key}');" class="store_name">${inStoreInventoryName.value}</a>
					<div class="clear_float"></div>
					<span>
						<img src="${jspStoreImgDir}${env_vfileColor}widget_product_info/<fmt:message key="IMG_NAME_${inStoreInventoryStatusMap[inStoreInventoryName.key]}"/>" 
							alt="<fmt:message key="IMG_INV_STATUS_${inStoreInventoryStatusMap[inStoreInventoryName.key]}"/>" />
					</span>
					<span id="instore_inventory_status_${param.productId}_store_${status.count}" class="text"><fmt:message key="INV_STATUS_${inStoreInventoryStatusMap[inStoreInventoryName.key]}"/></span>
					<div class="clear_float"></div>
					<div class="item_spacer_3px"></div>
					
				</c:forEach>
			</div>
		</c:if>
		<div class="item_spacer_10px"></div>
		<a id="InventoryStatus_SelectStoreLink_${param.productId}" href="javascript:InventoryStatusJS_${param.productId}.loadStoreLocator('${StoreLocatorView}','${bundleId}');" class="check_stores">${invStatusCheckStores}</a>
	</flow:ifEnabled>
</div>

<div id="InventoryStatus_ShowLink_Section_${param.productId}" class="left available" <c:if test="${!showAvailabilityLink}">style="display:none;"</c:if>>
	<span class="text"><fmt:message key="INV_SELECT_ATTRIBUTES_TO_SEE_AVAILABILITY"/></span>
</div>

<flow:ifEnabled feature="StoreLocator">
	<div id="InventoryStatus_Store_Details_${param.productId}" dojoType="dijit.Dialog" style="display:none;">
		<div class="widget_store_details_popup">
			<!-- Top Border Styling -->
			<div class="top">
				<div class="left_border"></div>
				<div class="middle"></div>
				<div class="right_border"></div>
			</div>
			<div class="clear_float"></div>
			<!-- Main Content Area -->
			<div class="middle">
				<div class="content_left_border">
					<div class="content_right_border">
						<div class="content">
							<div class="header">
								<span><fmt:message key="INV_STORE_DETAILS"/></span>
								<a id="WC_InventoryStatus_Link_${param.productId}_2" href="javascript:dijit.byId('InventoryStatus_Store_Details_${param.productId}').hide();" 
									class="close" title='<fmt:message key="INV_CLOSE_BUTTON"/>'><img role="button" onmouseover="this.src='<c:out value='${jspStoreImgDir}'/>images/colors/color1/close_hover.png'" onmouseout="this.src='<c:out value='${jspStoreImgDir}'/>images/colors/color1/close_normal.png'" src="<c:out value='${jspStoreImgDir}'/>images/colors/color1/close_normal.png" alt="<fmt:message key='LC_CLOSE'/>"/></a>
								<div class="clear_float"></div>
							</div>
							<div id="Store_Details_Template_${param.productId}" style="display:none;">
								<div class="container_store_address">
									<div class="header">
										<fmt:message key="INV_STORE_NAME_AND_ADDRESS"/>
									</div>
									<div class="item_spacer_10px"></div>
									<div class="item_spacer_3px"></div>
									<p>{address.name}</p>
									<p>{address.addressLine}</p>
									<p>{address.city}, {address.stateOrProvinceName}, {address.postalCode}</p>
									<p>{address.country}</p>
									<p>{address.telephone}</p>
								</div>
								
								<div class="container_hours">
									<div class="header">
										<fmt:message key="INV_STORE_HOURS"/>
									</div>
									<div class="item_spacer_10px"></div>
									<div class="item_spacer_3px"></div>
									<p>{hours}</p>
								</div>
								
								<div class="container_availability">
									<div class="header">
										<fmt:message key="INV_STORE_AVAILABILITY"/>
									</div>
									<div class="item_spacer_10px"></div>
									<div class="item_spacer_3px"></div>
									<span class="status_img_div">{imageTag}</span><span>{statusText} {availabilityDetails}</span>
								</div>
								
								<div class="clear_float"></div>
							</div>
							<div id="Store_Details_${param.productId}" class="body"></div>
							<div class="clear_float"></div>
						<!-- End content Section -->	
						</div>
					<!-- End content_right_border -->
					</div>
				<!-- End content_left_border -->
				</div>
			</div>
			<div class="clear_float"></div>
			<!-- Bottom Border Styling -->
			<div class="bottom">
				<div class="left_border"></div>
				<div class="middle"></div>
				<div class="right_border"></div>
			</div>
			<div class="clear_float"></div>
		</div>
	</div>
</flow:ifEnabled>
</c:when>
<c:otherwise>
	<script>
		InventoryStatusJS_${param.productId} = false;
	</script>
</c:otherwise>
</c:choose>
