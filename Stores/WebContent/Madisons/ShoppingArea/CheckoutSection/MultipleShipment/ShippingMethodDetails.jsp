<%--
 =================================================================
  Licensed Materials - Property of IBM

  WebSphere Commerce

  (C) Copyright IBM Corp. 2008, 2009 All Rights Reserved.

  US Government Users Restricted Rights - Use, duplication or
  disclosure restricted by GSA ADP Schedule Contract with
  IBM Corp.
 =================================================================
--%>
<%--
  *****
  * This JSP file displays the shipping information such as shipping method, shipping instructions and requested
  * shipping date selections to the shopper in the multiple shipment page of the shipping and billing page.
  *****
--%>
<!-- BEGIN ShippingMethodDetails.jsp -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../../../include/JSTLEnvironmentSetup.jspf"%>

<c:set var="isAjaxCheckOut" value="true"/>
<%-- Check if its a non-ajax checkout..--%>
<flow:ifDisabled feature="AjaxCheckout"> 
	<c:set var="isAjaxCheckOut" value="false"/>
</flow:ifDisabled>

<script type="text/javascript">
	dojo.addOnLoad(function() { 
		SBServicesDeclarationJS.setCommonParameters('<c:out value='${WCParam.langId}'/>','<c:out value='${WCParam.storeId}'/>','<c:out value='${WCParam.catalogId}'/>');
		SBServicesDeclarationJS.setAjaxCheckOut('<c:out value='${isAjaxCheckOut}'/>');
	});
</script>

<c:set var="pageSize" value="${WCParam.pageSize}" />
<c:if test="${empty pageSize}">
	<c:set var="pageSize" value="${maxOrderItemsPerPage}"/>
</c:if>

<c:set var="beginIndex" value="${WCParam.beginIndex}" />
<c:if test="${empty beginIndex}">
	<c:set var="beginIndex" value="0" />
</c:if>

<c:set var="shipDetails" value="${requestScope.orderUsableShipping}"/>
<c:if test="${empty shipDetails || shipDetails==null}">	
	<c:choose>
		<c:when test="${empty param.orderId || param.orderId == null}">
			<wcf:getData type="com.ibm.commerce.order.facade.datatypes.OrderType"
			   var="shipDetails" expressionBuilder="findCurrentShoppingCart">
			   <wcf:param name="accessProfile" value="IBM_UsableShippingInfo" />
			</wcf:getData>
		</c:when>
		<c:otherwise>
			<wcf:getData type="com.ibm.commerce.order.facade.datatypes.OrderType"
			   		var="shipDetails" expressionBuilder="findUsableShippingInfoWithPagingOnItem" varShowVerb="ShowVerbUsableShippingInfo" maxItems="${pageSize}" recordSetStartNumber="${beginIndex}" recordSetReferenceId="usistatus" scope="request">
				<wcf:param name="orderId" value="${param.orderId}" />	
				<wcf:param name="accessProfile" value="IBM_UsableShippingInfo" />
			</wcf:getData>	
		</c:otherwise>
	</c:choose>
</c:if>

<%-- get the shipping method --%>
<c:set var="selectedShipModeId" value="${param.shipModeId}"/>

<c:set var="orderItemId" value="${param.orderItemId}"/>
<c:if test="${empty orderItemId}">
	<c:set var="orderItemId" value="${WCParam.orderItemId}"/>
</c:if>

<c:set var="shipInstructions" value="${param.shipInstructions}"/>
<c:if test="${empty shipInstructions}">
	<c:set var="shipInstructions" value="${WCParam.shipInstructions}"/>
</c:if>

<c:set var="requestedShipDate" value="${param.requestedShipDate}"/>
<c:if test="${empty requestedShipDate}">
	<c:set var="requestedShipDate" value="${WCParam.requestedShipDate}"/>
</c:if>

<c:set var="isFreeGift" value="${param.isFreeGift}"/>
<c:if test="${empty isFreeGift}">
	<c:set var="isFreeGift" value="false"/>
</c:if>

<c:set var="expediteCheckBoxStatus" value="${param.isExpedited}"/>
<c:if test="${empty expediteCheckBoxStatus}">
	<c:set var="expediteCheckBoxStatus" value="false"/>
</c:if>

<c:catch>
	<fmt:parseDate parseLocale="${dateLocale}" var="requestedShipDate" value="${requestedShipDate}" pattern="yyyy-MM-dd'T'HH:mm:ss.SSS'Z'" timeZone="GMT"/>
</c:catch>
<c:if test="${empty requestedShipDate}">
	<c:catch>
		<fmt:parseDate parseLocale="${dateLocale}" var="requestedShipDate" value="${requestedShipDate}" pattern="yyyy-MM-dd'T'HH:mm:ss'Z'" timeZone="GMT"/>
	</c:catch>
</c:if>

<%-- use value from WC_timeoffset to adjust to browser time zone --%>
<%-- Format the timezone retrieved from cookie since it is in decimal representation --%>
<%-- Convert the decimals back to the correct timezone format such as :30 and :45 --%>
<%-- Only .75 and .5 are converted as currently these are the only timezones with decimals --%>	
<c:set var="formattedTimeZone" value="${fn:replace(cookie.WC_timeoffset.value, '%2B', '+')}"/>
<c:set var="formattedTimeZone" value="${fn:replace(formattedTimeZone, '.75', ':45')}"/>	
<c:set var="formattedTimeZone" value="${fn:replace(formattedTimeZone, '.5', ':30')}"/>
<fmt:formatDate value="${requestedShipDate}" type="date" pattern="yyyy-MM-dd" var="formattedReqShipDate" timeZone="${formattedTimeZone}" dateStyle="long"/>

<!-- If shipping instructions are empty, then hide the div which displays the date and instructions -->
<c:choose>
	<c:when test="${empty shipInstructions && empty requestedShipDate}">
		<c:set var="checkBoxStatus" value="false"/>
		<c:set var="divVisibleStatus" value="hidden"/>
	</c:when>
	<c:otherwise>
		<c:set var="checkBoxStatus" value="true"/>
		<c:set var="divVisibleStatus" value="visible"/>
	</c:otherwise>
</c:choose>

<c:forEach var="shiporderItem" items="${shipDetails.orderItem}">
			<c:if test="${shiporderItem.orderItemIdentifier.uniqueID eq orderItemId}">
				<c:set var="usableShippingMode" value="${shiporderItem.usableShippingMode}"/>
			</c:if>
</c:forEach>
<!-- this will update the Shipping info(Instructions, shipAsComplete and requested ship date) for each orderItem -->
<c:set var="selectedShippingMode" value=""/>
<div class="shipping_method_MS_shipping_info_page" id="WC_ShippingMethodDetails_div_<c:out value='${orderItemId}'/>">
	<p>
		<label for="MS_ShippingMode_<c:out value='${orderItemId}'/>"></label>
		<select class="drop_down" name="MS_ShippingMode_<c:out value='${orderItemId}'/>" id="MS_ShippingMode_<c:out value='${orderItemId}'/>" onchange="JavaScript:setCurrentId(this.id); CheckoutHelperJS.updateShipModeForThisItem(this,'<c:out value="${orderItemId}"/>')">
			<c:forEach var="shippingMode" items="${usableShippingMode}">
				<c:set var="shippingModeIdentifier" value="${shippingMode.shippingModeIdentifier}"/>
				<c:if test="${shippingModeIdentifier.externalIdentifier.shipModeCode != 'PickupInStore'}">
					<%-- Show all the shipping options available except for pickUp in Store --%>
					<%-- This block is to select the shipMode Id in the drop down box.. if this shipMode is selected then set selected = true --%>
					<option shipModeCode="${shippingModeIdentifier.externalIdentifier.shipModeCode}" <c:if test="${(shippingModeIdentifier.uniqueID eq selectedShipModeId)}"><c:set var="selectedShippingMode" value="${shippingModeIdentifier.externalIdentifier.shipModeCode}"/>selected="selected"</c:if> value="<c:out value='${shippingModeIdentifier.uniqueID}'/>">
						<c:choose>
							<c:when test="${!empty shippingMode.description.value}">
								<c:out value="${shippingMode.description.value}"/>
							</c:when>
							<c:otherwise>
								<c:out value="${shippingModeIdentifier.externalIdentifier.shipModeCode}"/>
							</c:otherwise>
						</c:choose>
					</option>						
				</c:if>
			</c:forEach>
		</select>
	</p>
	

	<c:if test="${!isFreeGift}">
		<flow:ifEnabled feature="ShippingInstructions">
			<c:if test="${empty disableShippingInstructions || disableShippingInstructions != 'true'}">
			<c:choose>
				<c:when test="${empty shipInstructions}">
					<c:set var="shippingInstructionsDivDisplay" value="none"/>
					<c:set var="shippingInstructionsChecked" value="false"/>
				</c:when>
				<c:otherwise>
					<c:set var="shippingInstructionsDivDisplay" value="block"/>
					<c:set var="shippingInstructionsChecked" value="true"/>
				</c:otherwise>
			</c:choose>
			<p>
				<span class="checkbox">
					<label for="MS_shippingInstructionsCheckbox_<c:out value='${orderItemId}'/>"></label>
					<input type="checkbox" class="checkbox" id="MS_shippingInstructionsCheckbox_<c:out value='${orderItemId}'/>" name="MS_shippingInstructionsCheckbox_<c:out value='${orderItemId}'/>" onclick="JavaScript:setCurrentId(this.id);CheckoutHelperJS.checkShippingInstructionsBox('MS_shippingInstructionsCheckbox','MS_shippingInstructionsDiv','<c:out value='${orderItemId}'/>')"
						<c:if test="${shippingInstructionsChecked}">
							checked="checked"
						</c:if>
					/>
					<span class="text"><fmt:message key="SHIP_SHIPPING_INSTRUCTIONS_ADD" bundle="${storeText}"/></span>
				</span>
			</p>
			<div name = "MS_shippingInstructionsDiv_<c:out value='${orderItemId}'/>" id = "MS_shippingInstructionsDiv_<c:out value='${orderItemId}'/>" style="display:<c:out value='${shippingInstructionsDivDisplay}'/>">
				<span>
					<p>
						<label for="MS_shipInstructions_<c:out value='${orderItemId}'/>">
							<span style="display:none"><fmt:message key="SHIP_SHIPPING_INSTRUCTIONS_LABEL" bundle="${storeText}"/></span>
						</label>
					</p>
					<p>
						<textarea id="MS_shipInstructions_<c:out value='${orderItemId}'/>" name="MS_shipInstructions_<c:out value='${orderItemId}'/>" rows="2" onchange="JavaScript:setCurrentId(this.id);CheckoutHelperJS.updateShippingInstructionsForThisItem(this,'<c:out value='${orderItemId}'/>')"><c:out value = "${shipInstructions}" /></textarea>
					</p>
				</span>
			</div>
			</c:if>
		</flow:ifEnabled>
		
		<flow:ifEnabled feature="FutureOrders">
			<c:choose>
				<c:when test="${empty requestedShipDate}">
					<c:set var="requestShippingDateDivDisplay" value="none"/>
					<c:set var="requestShippingDateChecked" value="false"/>
				</c:when>
				<c:otherwise>
					<c:set var="requestShippingDateDivDisplay" value="block"/>
					<c:set var="requestShippingDateChecked" value="true"/>
				</c:otherwise>
			</c:choose>
			<p>
				<span class="checkbox">
					<label for="MS_requestShippingDateCheckbox_<c:out value='${orderItemId}'/>"></label>
					<input type="checkbox" class="checkbox" id="MS_requestShippingDateCheckbox_<c:out value='${orderItemId}'/>" name="MS_requestShippingDateCheckbox_<c:out value='${orderItemId}'/>" onclick="JavaScript:setCurrentId(this.id);CheckoutHelperJS.checkRequestShippingDateBox('MS_requestShippingDateCheckbox','MS_requestShippingDateDiv','<c:out value='${orderItemId}'/>')"
						<c:if test="${requestShippingDateChecked}">
							checked="checked"
						</c:if>
					/>
					<span class="text"><fmt:message key="SHIP_REQUESTED_DATE_ADD" bundle="${storeText}"/></span>
				</span>
			</p>
			<div name="MS_requestShippingDateDiv_<c:out value='${orderItemId}'/>" id="MS_requestShippingDateDiv_<c:out value='${orderItemId}'/>" style="display:<c:out value='${requestShippingDateDivDisplay}'/>">
				<div id="MS_requestedShippingDate_<c:out value='${orderItemId}'/>_label">
					<label for="MS_requestedShippingDate_<c:out value='${orderItemId}'/>">
						<span style="display:none"><fmt:message key="SHIP_REQUESTED_DATE_LABEL" bundle="${storeText}" /></span>
					</label>
				</div>
				<div id="MS_requestedShippingDate_<c:out value='${orderItemId}'/>_inputField" class="dijitCalendarWidth">
					<input 
						id="MS_requestedShippingDate_<c:out value='${orderItemId}'/>" 
						name="MS_requestedShippingDate_<c:out value='${orderItemId}'/>" 
						size="6" 
						onChange="JavaScript:setCurrentId(this.id);CheckoutHelperJS.updateRequestedShipDateForThisItem(this, '<c:out value='${orderItemId}'/>'); <c:if test="${!isAjaxCheckOut}">setDirtyFlag()</c:if>" 
						dojoType="dijit.form.DateTextBox" 
						invalidMessage="<fmt:message key="SHIP_REQUESTED_ERROR" bundle="${storeText}"/>" 
						value="<c:out value="${formattedReqShipDate}"/>" 
					/>
					<script type="text/javascript">
					dojo.addOnLoad(function() { 
						var widgetText = "MS_requestedShippingDate_" + "<c:out value="${orderItemId}"/>";
						parseWidget(widgetText);
					});
					</script>
				</div>
			</div>
		</flow:ifEnabled>
		<flow:ifEnabled feature="ExpeditedOrders">
			<span class="checkbox">
				<input type="checkbox" class="checkbox" id="MS_expediteShipping_<c:out value='${orderItemId}'/>" name="MS_expediteShipping_<c:out value='${orderItemId}'/>" onclick="JavaScript: setCurrentId(this.id); CheckoutHelperJS.expediteShipping(this, <c:out value='${orderItemId}'/>);"
					<c:if test="${expediteCheckBoxStatus}">
						checked="checked"
					</c:if> />
				<span class="text">
					<label for="MS_expediteShipping_<c:out value='${orderItemId}'/>"><fmt:message key="SHIP_EXPEDITE_SHIPPING" bundle="${storeText}"/></label>
				</span>
			</span>
		</flow:ifEnabled>
		<%@ include file="ShippingMethodDetailsExt.jspf"%>
	</c:if>
</div>
<c:remove var="selectedShippingMode"/>
<c:if test="${!empty disableShippingInstructions}">
	<c:remove var="disableShippingInstructions"/>
</c:if>
<!-- END ShippingMethodDetails.jsp -->
