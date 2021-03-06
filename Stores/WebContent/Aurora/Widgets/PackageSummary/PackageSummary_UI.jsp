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

<div class="widget_package_summary_position">
	<div id="widget_package_summary" class="widget_sidebar_container">
		<div class="top">
			<div class="left_border"></div>
			<div class="middle"></div>
			<div class="right_border"></div>
		</div>

		<div class="left_border">
			<div class="right_border">
				<div class="content">
					<div class="header_content">
						<h1 class="left"><fmt:message key='PKG_PACKAGE_SUMMARY'/>:</h1>
						<div class="clear_float"></div>
						<div class="price">
							<!-- Package Price -->
							${packagePrice}
						</div>
						<div class="clear_float"></div>
					</div>

					<c:if test="${requestScope.bundleKitAvailable eq 'true'}">
						<div class="item">
							<%out.flush();%>
								<c:import url = "${env_jspStoreDir}Widgets/InventoryStatus/InventoryStatus.jsp"/>
							<%out.flush();%>
						</div>
						<div class="divider"></div>
					</c:if>

					<div class="item">
						
						<%@ include file="../PriceQuantity/PriceQuantity.jsp" %>
						
						<c:if test="${requestScope.bundleKitAvailable eq 'true'}">
							<div class="product_quantity_addtolist">
								<div class="product_quantity left">
									<div class="quantity_section">
										<label for="packageQty" class="header"><fmt:message key="PKG_QUANTITY"/></label>
										<input id="packageQty" type="text" class="quantity_input" value="1" />
										<div class="clear_float"></div>
									</div>
								</div>
		
								<div class="clear_float"></div>
							</div>
							<div class="item_spacer_7px"></div>
						</c:if>
		
						<c:choose>
							<c:when test="${requestScope.bundleKitAvailable eq 'true'}">
								<a id="addToCartBtn" href="javascript:setCurrentId('addToCartBtn');shoppingActionsJS.AddItem2ShopCartAjax('${catalogEntryID}',dojo.byId('packageQty').value);" wairole="button" role="button" class="button_add_to_cart"
									title="<fmt:message key="PKG_ADD_TO_CART" />">
									<div class="left_border"></div>
									<div id="productPageAdd2Cart" class="button_text">
										<fmt:message key="PKG_ADD_TO_CART" />
									</div>
									<div class="right_border"></div>
								</a>
							</c:when>
							<c:otherwise>
								<div class="disabled">
									<div class="button_primary">
										<div class="left_border"></div>
										<div class="button_text" style="width: 116px;"><fmt:message key="PD_UNAVAILABLE"/></div>
										<div class="right_border"></div>
									</div>																	
								</div>
							</c:otherwise>
						</c:choose>
	
	
						<div class="clear_float"></div>
						<div class="item_spacer_7px"></div>
							
						<%out.flush();%>
							<c:import url = "${env_jspStoreDir}Widgets/ShoppingList/ShoppingList.jsp" />
						<%out.flush();%>
	
					</div>

					<div class="clear_float"></div>
					<div class="divider" style="visibility:hidden"></div>
				</div>
			</div>
		</div>
		
		<div class="clear_float"></div>
			<div class="bottom">
				<div class="left_border"></div>
				<div class="middle"></div>
				<div class="right_border"></div>
			</div>
		</div>
	</div>
