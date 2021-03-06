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
		
		<div class="print_section">
			<span id="PrintTextLink" role="button" onclick="JavaScript: print();"><fmt:message key='BD_PRINT'/></span>
			<a id="PrintIconLink" role="button" href="JavaScript: print();" class="print_icon" title="<fmt:message key='BD_PRINT'/>"></a>
		</div>
		<div class="clear_float"></div>
		<div class="item_spacer_3px"></div>
		
		<span id="product_name_<c:out value='${catalogEntryID}'/>" class="main_header" role="heading" aria-level="1" itemprop="name"><c:out value="${name}" escapeXml="false"/></span>
		<span id="bundle_SKU" class="sku"><fmt:message key="CurrentOrder_SKU"/> <c:out value="${partnumber}" escapeXml="false"/></span>
		<div class="clear_float"></div>
		<c:if test="${requestScope.bundleKitAvailable ne 'true'}">
			<div class="not_available"><fmt:message key="PD_PRODUCT_NOT_AVAILABLE_MESSAGE"/></div>
		</c:if>

		<div class="clear_float"></div>
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

		<flow:ifEnabled feature="RatingReviewIntegration">
			<c:if test = "${type eq 'package'}">
				<c:set target="${reviewParameters}" property="display" value="summary" />
				<%@ include file="../Reviews/ReviewDisplay.jspf"%>
			</c:if>
		</flow:ifEnabled>

		<div class="clear_float"></div>
		
		
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
		<p itemprop="description"><c:out value="${longDescription}" escapeXml="false"/></p>
		<c:if test="${!empty descriptiveAttributeMap}">
			<ul class="info_list">
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
		</c:if>
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
