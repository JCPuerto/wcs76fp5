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
<%-- Display only if there is some association --%>
<c:if test="${hasAssociations}">
	<script>
	var merchandisingAssociations = new Array();
	<c:forEach var="merchandisingAssociation" items="${merchandisingAssociationMap}" varStatus="iteration">
		merchandisingAssociations[${iteration.count-1}] = ${merchandisingAssociation.value};
	</c:forEach>
	MerchandisingAssociationJS.setValues(${storeParams}, ${baseItemParams}, merchandisingAssociations);
	MerchandisingAssociationJS.subscribeToEvents(${uniqueID});
	</script>
	<div id="widget_coordinate">
		<div class="middle">
			<div class="content">
				<c:if test="${hasMultipleAssociations}">
					<a id="up_arrow" href="javascript:MerchandisingAssociationJS.changeItem(-1);" class="up_arrow"><img onfocus="javascript: this.src='<c:out value='${jspStoreImgDir}${env_vfileColor}'/>widget_coordinate/up_arrow_hover.png'" onmouseover="javascript: this.src='<c:out value='${jspStoreImgDir}${env_vfileColor}'/>widget_coordinate/up_arrow_hover.png'" onmouseout="javascript: this.src='<c:out value='${jspStoreImgDir}${env_vfileColor}'/>widget_coordinate/up_arrow_default.png'" alt="<fmt:message key="MA_UP_ARROW_TITLE"/>" src="<c:out value='${jspStoreImgDir}${env_vfileColor}'/>widget_coordinate/up_arrow_default.png"/></a>
					<a id="down_arrow" href="javascript:MerchandisingAssociationJS.changeItem(1);" class="down_arrow down_active"><img onfocus="javascript: this.src='<c:out value='${jspStoreImgDir}${env_vfileColor}'/>widget_coordinate/down_arrow_hover.png'" onmouseover="javascript: this.src='<c:out value='${jspStoreImgDir}${env_vfileColor}'/>widget_coordinate/down_arrow_hover.png'" onmouseout="javascript: this.src='<c:out value='${jspStoreImgDir}${env_vfileColor}'/>widget_coordinate/down_arrow_default.png'" alt="<fmt:message key="MA_DOWN_ARROW_TITLE"/>" src="<c:out value='${jspStoreImgDir}${env_vfileColor}'/>widget_coordinate/down_arrow_default.png"/></a>
				</c:if>
				<div class="coordinate_title"><fmt:message key="MA_COORDINATE"/></div>
				<div class="coordinate_body">
					<div class="left_column">
						<div class="product"><img src="${catalogEntryThumbnail}" alt="${catalogEntryName}"/></div>
						<div class="cross_image">
							<div class="cross"><img src="<c:out value='${jspStoreImgDir}${env_vfileColor}'/>widget_coordinate/cross.png" alt="<fmt:message key="MA_PLUS"/>"/></div>
						</div>
						<div class="product" onmouseout="hideSection('merchandisingAssociation_QuickInfoDiv');">
							<a id="association_url" href="${firstMerchandisingAssociationUrl}" 
								onkeydown="shiftTabHideSection('merchandisingAssociation_QuickInfoDiv',event);"
								onfocus="showSection('merchandisingAssociation_QuickInfoDiv');" 
								title="${firstMerchandisingAssociationShortDesc}">
								<img id="association_thumbnail" src="${firstMerchandisingAssociationThumbnail}" alt="${firstMerchandisingAssociationName}"/>
							</a>
							<div id="merchandisingAssociation_QuickInfoDiv" class="quick_info_toggle">
								<a id="merchandisingAssociation_QuickInfo" title="<fmt:message key='QUICK_VIEW_BUTTON_ACCE'/>" role="button" wairole="button" href="javascript:setCurrentId('merchandisingAssociation_QuickInfo');
									QuickInfoJS.showDetails('${firstMerchandisingAssociationID}');"
									onblur="hideSection('merchandisingAssociation_QuickInfoDiv');"><fmt:message key="MA_QUICK_VIEW"/></a>
							</div>
						</div>
					</div>
					<div class="right_column">
						<div class="info">
							<div class="item_name">${catalogEntryName} + <span id="association_item_name">${firstMerchandisingAssociationName}</span></div>
							<div class="combined_total"><fmt:message key="MA_COMBINED"/>:
								<span id="list_total" class="list_value">${firstListedCombinedTotal}</span> 
								<span id="combined_total" class="value bold">${firstOfferedCombinedTotal}</span>
							</div>
							<div class="button">
								<a id="addBothToCartBtn" href="javascript:setCurrentId('addBothToCartBtn');MerchandisingAssociationJS.addBoth2ShopCart();" class="button_primary">
									<div class="left_border"></div>
									<span class="button_text" ><fmt:message key="MA_ADD_BOTH_TO_CART"/></span>
									<div class="right_border"></div>
								</a>							
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</c:if>