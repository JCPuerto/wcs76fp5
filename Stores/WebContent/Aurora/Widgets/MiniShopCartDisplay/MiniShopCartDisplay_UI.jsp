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

<%-- START MiniShopCartDisplay_UI.jsp --%>

<c:set var="search" value='"'/>
<c:set var="replaceStr" value="'"/>

<div id="widget_minishopcart" role="button" tabindex="0"
	onclick="javascript:showMiniShopCartDropDown('widget_minishopcart','quick_cart_container','orderItemsList');"
	onKeyPress="javascript:showMiniShopCartDropDownEvent(event,'widget_minishopcart','quick_cart_container','orderItemsList');" 
	onMouseOver="javascript:showMiniShopCartDropDown('widget_minishopcart','quick_cart_container','orderItemsListAutoClose');">
	<div id="miniShopCartLeftCorner" class="left_border"></div>
	<div id="miniShopCartBody" class="content">
		<div class="info">
			<div class="subtotal"><fmt:message key="MSC_SUBTOTAL"/> <span id="minishopcart_subtotal"><c:out value="${orderSubTotal}" escapeXml="false"/></span></div>
			<div class="cart"><fmt:message key="MSC_SHOPPING_CART"/> 
				<span id="minishopcart_total">
					<fmt:message key="MSC_ITEMS">
						<fmt:param value="${orderQuantity}"/>
					</fmt:message>
				</span>
			</div>
		</div>
		<div class="cart_icon"></div>
		<div class="arrow"></div>
	</div>
	<div id="miniShopCartRightCorner" class="right_border"></div>
	<div class="clear_float"></div>												
</div>

<div id="placeHolder"></div>

<div id="quick_cart_container">
	<span class="spanacce" id="quick_cart_container_ACCE_Label"><fmt:message key="ACCE_MSC_SHOPPING_CART_POPUP_REGION"/></span>
	<div id="quick_cart">
		<div id ="MiniShopCartProductsList" style="display:none">
			<div id="widget_minishopcart_popup">
				<div class="top">
					<div class="left_border"></div>
					<div class="middle_tile"></div>
					<div class="right_border"></div>
				</div>
				<div class="middle">
					<div class="left_border">
						<div class="right_border">
							<div class="content">
							<a id="MiniShopCartCloseButton_1" href="javascript:dijit.byId('quick_cart_container').hide();" class="close_control">
								<div class="icon"></div>
								<span class="close"><fmt:message key="CLOSE"/></span>
							</a>
								<div class="notification"><fmt:message key="MSC_ITEMS_IN_CART"/></div>
									<c:choose>
										<c:when test="${!empty orderItemsDetailsList}">
											<div class="products">
												<c:forEach var="itemDetails" items="${orderItemsDetailsList}" varStatus="status">
													<div class="product">
														<div class="product_image">
																
															<c:set var="altImgText">
																<c:out value="${fn:replace(itemDetails['productName'], search, replaceStr)}" escapeXml="false"/>
															</c:set>

															<a id="MiniShopCartProdImg_${itemDetails['orderItemId']}" href="${itemDetails['productURL']}">
																<img src="${itemDetails['productImage']}" alt="${altImgText}">
															</a>
														</div>
														<div class="product_name">
															<a id="MiniShopCartProdName_${itemDetails['orderItemId']}" href="${itemDetails['productURL']}">${itemDetails['productName']}</a>
														</div>
														<div class="item_spacer_3px"></div>
														<span class="product_quantity"><fmt:message key="MSC_QTY"/> ${itemDetails['productQty']}</span>
														<span class="product_price">${itemDetails['productPrice']}</span>
													</div>
												</c:forEach>
											</div>
											<c:if test="${showMoreLink == 'true'}">
												<div class="view_more">
													<span class="view_more_items"><a id="MiniShopCartMoreLink" href="${ShoppingCartURL}"><fmt:message key="MSC_VIEW_MORE_ITEMS"/></a></span>
												</div>
											</c:if>
											<c:forEach var="discountsIterator" items="${discountReferences}">
												<c:set var="discounts" value="${discountsIterator.value}" />
												<div class="subtotal adjustment_price">
													<span class="product_price">
														<c:out value="${discounts['aggregatedDiscount']}" escapeXml="false" />
														<c:out value="${CurrencySymbol}"/>													
													</span>
													<a class="hover_underline" href='<c:out value="${discounts['displayURL']}" />' >
														<c:out value="${discounts['discountDescription']}" escapeXml="false"/>
													</a>
												</div>
											</c:forEach>
											<c:remove var="discountReferences"/>
											<div class="subtotal">
												<span class="product_price">${orderSubTotal}</span>
												<span>
													<fmt:message key="MSC_SUBTOTAL_FOR_ITEMS">
														<fmt:param value="${orderQuantity}"/>
													</fmt:message>
												</span>
											</div>
										</c:when>
										<c:otherwise>
											<div class="empty"><fmt:message key="MSC_EMPTY_SHOP_CART"/></div>
										</c:otherwise>
									</c:choose>
								<div class="go_to_cart">
									<a id="GotoCartButton1" href="javascript:location.href='${ShoppingCartURL}'" class="button_primary" tabindex="0">
										<div class="left_border"></div>
										<div class="button_text"><fmt:message key="MSC_GO_TO_CART"/></div>
										<div class="right_border"></div>
									</a>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="bottom">
					<div class="left_border"></div>
					<div class="middle_tile"></div>
					<div class="right_border"></div>
				</div>
			</div>
		</div>

		<div id = "MiniShopCartProductAdded" style="display:none">
			<div id="widget_minishopcart_popup_1">
				<div class="top">
					<div class="left_border"></div>
					<div class="middle_tile"></div>
					<div class="right_border"></div>
				</div>
				<div class="middle">
					<div class="left_border">
						<div class="right_border">
							<div class="content">
								<a id="MiniShopCartCloseButton_2" href="javascript:dijit.byId('quick_cart_container').hide();" class="close_control">
									<div class="icon"></div>
									<span class="close"><fmt:message key="CLOSE"/></span>
								</a>
								<div class="notification"><fmt:message key="MSC_ITEM_ADDED"/></div>
								<div class="products added">
									<c:forEach var="orderItemRecentlyAddedMap" items="${orderItemsRecentlyAddedList}">
										<div class="product">
											<div class="product_image">
												<a id="MiniShopCartAddedProdImg_${orderItemRecentlyAddedMap['productName']}" href="${orderItemRecentlyAddedMap['productURL']}" title="${orderItemRecentlyAddedMap['productName']}">
													
													<c:set var="altImgText">
														<c:out value="${fn:replace(orderItemRecentlyAddedMap['productName'], search, replaceStr)}" escapeXml="false"/>
													</c:set>

													<img src="${orderItemRecentlyAddedMap['productImage']}" alt="${altImgText}">
												</a>
											</div>
											<div class="product_name">
												<a id="MiniShopCartAddedProdName_${orderItemRecentlyAddedMap['productName']}" href="${orderItemRecentlyAddedMap['productURL']}">${orderItemRecentlyAddedMap['productName']}</a>
											</div>
											<div class="item_spacer_7px"></div>
											<c:forEach var="attribute" items="${orderItemRecentlyAddedMap['productAttributes']}">
												<div class="product_color">
												<fmt:message key="ATTRNAMEKEY">
													<fmt:param value="${attribute['attributeName']}"/>
												</fmt:message>
												${attribute['attributeValue']}</div>
											</c:forEach>
											<div class="item_spacer_3px"></div>
											<span class="product_quantity"><fmt:message key="MSC_QTY"/> ${orderItemRecentlyAddedMap['productQty']}</span>
											<span class="product_price">${orderItemRecentlyAddedMap['productPrice']}</span>
										</div>
									</c:forEach>
								</div>
								<div class="go_to_cart">
									<a id="GotoCartButton2" href="javascript:location.href='${ShoppingCartURL}'" class="button_primary" tabindex="0">
										<div class="left_border"></div>
										<div class="button_text"><fmt:message key="MSC_GO_TO_CART"/></div>
										<div class="right_border"></div>
									</a>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="bottom">
					<div class="left_border"></div>
					<div class="middle_tile"></div>
					<div class="right_border"></div>
				</div>
			</div>
		</div>
	</div>
</div>
											
<%-- END MiniShopCartDisplay_UI.jsp --%>