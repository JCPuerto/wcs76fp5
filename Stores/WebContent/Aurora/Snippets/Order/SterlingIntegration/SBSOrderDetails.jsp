<%--
 =================================================================
  Licensed Materials - Property of IBM

  WebSphere Commerce

  (C) Copyright IBM Corp. 2008, 2012 All Rights Reserved.

  US Government Users Restricted Rights - Use, duplication or
  disclosure restricted by GSA ADP Schedule Contract with
  IBM Corp.
 =================================================================
--%>
<!-- BEGIN SBSOrderDetails.jsp -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/xml" prefix="x" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>
<%@ taglib uri="http://commerce.ibm.com/foundation-fep" prefix="wcfSSFS" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ page import="java.util.*"%>
<%@ page import="java.math.*"%>
<%@ page import="org.apache.commons.json.*"%> 
<%@ include file="../../../include/JSTLEnvironmentSetup.jspf"%> 
<%@ include file="../../../Common/CommonJSToInclude.jspf"%>
<flow:fileRef id="vfileLogo" fileId="vfile.logo"/>

<script type="text/javascript" src="<c:out value='${jsAssetsDir}javascript/CheckoutArea/CheckoutHelper.js'/>"></script>
<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/ServicesDeclaration.js"/>"></script>
<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/UserArea/SterlingIntegration.js"/>"></script>

<c:set var="pageSize" value="${WCParam.pageSize}" />
<c:if test="${empty pageSize}">
	<c:set var="pageSize" value="${maxOrderItemsPerPage}"/>
</c:if>
<fmt:parseNumber var="pageSize" value="${pageSize}"/>

<c:set var="formattedTimeZone" value="${fn:replace(cookie.WC_timeoffset.value, '%2B', '+')}"/>
<c:set var="formattedTimeZone" value="${fn:replace(formattedTimeZone, '.75', ':45')}"/>	
<c:set var="formattedTimeZone" value="${fn:replace(formattedTimeZone, '.5', ':30')}"/>
<c:set var="externalOrderId" value="${WCParam.externalOrderId }"/>



<wcfSSFS:getDataFromSSFS type="java.lang.String" var="order" scApi="getCompleteOrderDetails" scope="request">
	<wcf:param name="OrderHeaderKey" value="${WCParam.externalOrderId}"/>
	<wcf:param name="EnterpriseCode" value="${WCParam.storeId}"/>
	<wcf:param name="BuyerUserId" value="${userId}"/>	
	<wcf:param name="langId" value="${langId}"/>	
</wcfSSFS:getDataFromSSFS>

<script type="text/javascript">
	dojo.addOnLoad(function() {
		ServicesDeclarationJS.setCommonParameters('<c:out value="${WCParam.langId}"/>','<c:out value="${WCParam.storeId}"/>','<c:out value="${WCParam.catalogId}"/>');
		sterlingIntegrationJS.populateOrderLevelInfo('${order}');
		if (dojo.isIE == 7) {			
			document.getElementById('WC_OrderShipmentDetails_div_16').style.styleFloat='left';
		}
	});
</script>

<c:set var="shipmentTypeId" value="2" scope="request"/>
<c:set var="numberOfPaymentMethods" value="0" scope="request"/>
<c:set var="numEntries" value="1" scope="request"/>
<c:set var="orderNo" value="" scope="request"/>


<%String strOrder = (String)(request.getAttribute("order")); 
request.setAttribute("order", strOrder);
try{
JSONObject jsonObj = (JSONObject)JSON.parse(strOrder);
JSONObject rootObj = (JSONObject)jsonObj.get("Root");
JSONObject orderObj = (JSONObject)rootObj.get("Order");
int shipmentTypeId = Integer.parseInt(orderObj.get("shipmentTypeId").toString());
request.setAttribute("shipmentTypeId", shipmentTypeId);
int pmNumber = Integer.parseInt(orderObj.get("countOfPaymentMethods").toString());
request.setAttribute("numberOfPaymentMethods", pmNumber);
int oiNumber = Integer.parseInt(orderObj.get("countOfOrderLines").toString());
request.setAttribute("numEntries", oiNumber);
String orderNo = orderObj.get("OrderNo").toString();
String entryType = orderObj.get("EntryType").toString();
if(entryType.equalsIgnoreCase("WCS")){
	orderNo = orderNo.substring(3);
}
request.setAttribute("orderNo", orderNo);
}catch(JSONException ex){}%>


<div id="box">
<script type="text/javascript">dojo.addOnLoad(function() { parseWidget("WC_OrderShipmentDetails_div_1"); });</script>
	<div class="my_account" id="WC_OrderShipmentDetails_div_1">
					<fmt:message key="X_DETAILS" bundle="${storeText}" var="OrderHistoryDetailBreadcrumbLinkLabel">
						<fmt:param><c:out value="${orderNo}"/></fmt:param> 						
					</fmt:message>
					<script type="text/javascript">
						dojo.addOnLoad(function() { 
							if(document.getElementById("OrderHistoryBreadcrumb")){
								document.getElementById("MyAccountBreadcrumbLink").style.display = "none";
								document.getElementById("OrderHistoryDetailBreadcrumbLink").innerHTML = "<c:out value='${OrderHistoryDetailBreadcrumbLinkLabel}' />";
								document.getElementById("OrderHistoryBreadcrumb").style.display = "inline";
							}
						});
					</script>
					<h2 class="myaccount_header">
					    <c:choose>
						    <c:when test="${WCParam.isQuote eq true}">
							    <fmt:message key="MO_QUOTEDETAILS" bundle="${storeText}"/>
						    </c:when>
						    <c:otherwise>
							    <fmt:message key="MO_ORDERDETAILS" bundle="${storeText}"/>
						    </c:otherwise>
					    </c:choose>
				    </h2>
				
				
	    <div class="body" id="WC_OrderShipmentDetails_div_6">
			<div class="order_details_my_account" id="WC_OrderShipmentDetails_div_7">
			<p>
				<span class="my_account_content_bold"><fmt:message key="MO_ORDER_NUMBER" bundle="${storeText}"/></span>
				
				<span id="OrderNo"><fmt:message key="MO_NOT_AVAILABLE" bundle="${storeText}"/></span>
					
			</p>
			<p>
				<span class="my_account_content_bold"><fmt:message key="MO_ORDER_DATE" bundle="${storeText}"/></span>				
				<span id="OrderDate"><fmt:message key="MO_NOT_AVAILABLE" bundle="${storeText}"/></span>
					
			</p>
			<br/>
		    </div>

	    
	        <div class="myaccount_header" id="WC_OrderShipmentDetails_div_8">
		        <div class="left_corner_straight" id="WC_OrderShipmentDetails_div_9"></div>
		        <div class="left" id="WC_OrderShipmentDetails_div_10"><span class="header"><fmt:message key="MO_SHIPPINGINFO" bundle="${storeText}"/></span></div>
		        <div class="right_corner_straight" id="WC_OrderShipmentDetails_div_11"></div>
	        </div>
	
	        <div class="myaccount_content margin_below" id="WC_OrderShipmentDetails_div_16">
		        <div id="shipping">
			    <c:choose>
				    <c:when test = "${shipmentTypeId == 1}">
					<div class="shipping_address" id="WC_OrderShipmentDetails_div_17">
						<p class="my_account_content_bold"><fmt:message key="MO_SHIPPINGADDRESS" bundle="${storeText}"/></p>
						<span id="Single_Shipping_Address"></span>	
																																		
					</div>
					<div class="shipping_method" id="WC_OrderShipmentDetails_div_18">
							<p>
							<flow:ifEnabled feature="ShipAsComplete">
								<span class="my_account_content_bold"><fmt:message key="SHIP_SHIP_AS_COMPLETE" bundle="${storeText}"/>: </span>						
								
										<span class="text" id="Shipping_As_Complete_Y"><fmt:message key="YES" bundle="${storeText}"/></span>
									
										<span class="text" style=display:none id="Shipping_As_Complete_N"><fmt:message key="NO" bundle="${storeText}"/></span>
									
							</flow:ifEnabled>
							</p>
							<br />
							
							<p class="my_account_content_bold"><fmt:message key="MO_SHIPPINGMETHOD" bundle="${storeText}"/></p>
								<span id="Single_Shipping_Method"></span>
							
							<p></p>
							<br clear="all"/>
														
							<flow:ifEnabled feature="ShippingInstructions">
							<div id="Single_Shipping_Instruction_Label" style=display:none>
									<p>
										<span class="my_account_content_bold" ><fmt:message key="SHIP_SHIPPING_INSTRUCTIONS" bundle="${storeText}" />: </span>
										<span class="text" id="Single_Shipping_Instruction"></span>
									</p> 
							</div>
									<br />
								
							</flow:ifEnabled>								
					</div>
					<span id="OrderConfirmPagingDisplay_ACCE_Label" class="spanacce"><fmt:message key="ACCE_Region_Order_Item_List"/></span>
					<div dojoType="wc.widget.RefreshArea" widgetId="OrderConfirmPagingDisplay" id="OrderConfirmPagingDisplay" 
							controllerId="SSFSOrderItemPaginationDisplayController" ariaMessage="<fmt:message key="ACCE_Status_Order_Item_List_Updated"/>" ariaLiveId="${ariaMessageNode}" role="region" aria-labelledby="OrderConfirmPagingDisplay_ACCE_Label">
												
									<%out.flush();%>
										<c:import url="../../../Snippets/Order/SterlingIntegration/SBSOrderItemDetailSummary.jsp">  
											<c:param name="catalogId" value="${WCParam.catalogId}" />
											<c:param name="langId" value="${WCParam.langId}" />
											<c:param name="storeId" value="${storeId}"/>
											<c:param name="order" value="${order}"/>
											<c:param name="numEntries" value="${numEntries}"/>										
										</c:import>
									<%out.flush();%>	
					</div>							
							<script type="text/javascript">dojo.addOnLoad(function() { 
								parseWidget("OrderConfirmPagingDisplay");
								});
							</script>
					</c:when>
					<c:otherwise>
						<div class="shipping_method" id="WC_OrderShipmentDetails_div_35">
							<p>
							<flow:ifEnabled feature="ShipAsComplete">
								<span class="my_account_content_bold"><fmt:message key="SHIP_SHIP_AS_COMPLETE" bundle="${storeText}"/>: </span>
									
										<span class="text" id="Shipping_As_Complete_Y"><fmt:message key="YES" bundle="${storeText}"/></span>
									
										<span class="text" style=display:none id="Shipping_As_Complete_N"><fmt:message key="NO" bundle="${storeText}"/></span>
								
							</flow:ifEnabled>
							</p>
						</div>
						<span id="MSOrderConfirmPagingDisplay_ACCE_Label" class="spanacce"><fmt:message key="ACCE_Region_Order_Item_List"/></span>
						<div dojoType="wc.widget.RefreshArea" widgetId="MSOrderConfirmPagingDisplay" id="MSOrderDetailPagingDisplay" 
							controllerId="SSFSMSOrderItemPaginationDisplayController" ariaMessage="<fmt:message key="ACCE_Status_Order_Item_List_Updated"/>" ariaLiveId="${ariaMessageNode}" role="region" aria-labelledby="MSOrderConfirmPagingDisplay_ACCE_Label">
						<%out.flush();%>
							<c:import url="../../../Snippets/Order/SterlingIntegration/SBSMSOrderItemDetailSummary.jsp">  
								<c:param name="catalogId" value="${WCParam.catalogId}" />
								<c:param name="langId" value="${WCParam.langId}" />
								<c:param name="storeId" value="${storeId}"/>
								<c:param name="order" value="${order}"/>
								<c:param name="numEntries" value="${numEntries}"/>	
							</c:import>
						<%out.flush();%>
						</div>
						<script type="text/javascript">dojo.addOnLoad(function() { 
							parseWidget("MSOrderDetailPagingDisplay");
							});
						</script>
					</c:otherwise>
				</c:choose>
				
				    <div id="total_breakdown">
					<table id="order_total" cellpadding="0" cellspacing="0" border="0" summary="<fmt:message key="ORDER_TOTAL_TABLE_SUMMARY" bundle="${storeText}"/>">
					
					<%-- ORDER SUBTOTAL--%>
					
					<tr> 
						<td class="total_details" id="WC_SingleShipmentOrderTotalsSummary_td_1"><fmt:message key="MO_ORDERSUBTOTAL" bundle="${storeText}"/></td>
						<td class="total_figures" id="WC_SingleShipmentOrderTotalsSummary_td_2">
							
									<span id="Order_SubTotal"><fmt:message key="MO_NOT_AVAILABLE" bundle="${storeText}"/></span>
								
						</td>
					</tr>

					<%-- DISCOUNT ADJUSTMENTS --%>
					
					<tr>
						<td class="total_details" id="WC_SingleShipmentOrderTotalsSummary_td_11"><fmt:message key="MO_DISCOUNTADJ" bundle="${storeText}"/></td>
						<td class="total_figures" id="WC_SingleShipmentOrderTotalsSummary_td_12">
							
									<span id="Order_Discount"><fmt:message key="MO_NOT_AVAILABLE" bundle="${storeText}"/></span>
								
						</td>
					</tr>
					
					<%-- TAX --%>
					
					<tr> 
						<td class="total_details" id="WC_SingleShipmentOrderTotalsSummary_td_5"><fmt:message key="MO_TAX" bundle="${storeText}"/></td>
						<td class="total_figures" id="WC_SingleShipmentOrderTotalsSummary_td_6">
							
									<span id="Order_Tax"><fmt:message key="MO_NOT_AVAILABLE" bundle="${storeText}"/></span>
								
						</td>
					</tr>	
								
					<%-- SHIPPING CHARGE --%>
					
					<tr>
						<td class="total_details" id="WC_SingleShipmentOrderTotalsSummary_td_7"><fmt:message key="MO_SHIPPING" bundle="${storeText}"/></td>
						<td class="total_figures" id="WC_SingleShipmentOrderTotalsSummary_td_8">
							
									<span id="Order_Shipping"><fmt:message key="MO_NOT_AVAILABLE" bundle="${storeText}"/></span>
								
						</td>
					</tr>				
					
					<%-- SHIPPING TAX --%>
						
					<tr>
						<td class="total_details" id="WC_SingleShipmentOrderTotalsSummary_td_14"><fmt:message key="MO_SHIPPING_TAX" bundle="${storeText}"/></td>
						<td class="total_figures" id="WC_SingleShipmentOrderTotalsSummary_td_15">
							
									<span id="Order_ShippingTax"><fmt:message key="MO_NOT_AVAILABLE" bundle="${storeText}"/></span>
								
						</td>
					</tr>
					
					<%-- ORDER TOTAL --%>
					<tr>
						<td class="total_details order_total" id="WC_SingleShipmentOrderTotalsSummary_td_9"><fmt:message key="MO_ORDERTOTAL" bundle="${storeText}"/></td>
						<td class="total_figures breadcrumb_current" id="WC_SingleShipmentOrderTotalsSummary_td_10">
							
											
									<span id="Order_Totals"><fmt:message key="MO_NOT_AVAILABLE" bundle="${storeText}"/></span>					
								
						</td>
					</tr>
				    </table>
				    </div>
				
			    
			    <br clear="all" />
		    </div>
	    </div>
		<div class="gift_section">
		    <div class="myaccount_section_header" id="WC_OrderShipmentDetails_div_21">
		        <div class="left_corner_straight" id="WC_OrderShipmentDetails_div_22"></div>
		        <div class="left" id="WC_OrderShipmentDetails_div_23"><span class="header"><fmt:message key="MO_BILLINGINFO" bundle="${storeText}"/></span></div>
		        <div class="right_corner_straight" id="WC_OrderShipmentDetails_div_24"></div>
		    </div>
		
		    <div class="body" id="WC_CheckoutPaymentAndBillingAddressSummaryf_div_1">
			    <div id="billing_summary">					       
			    <c:if test="${numberOfPaymentMethods ==0 }">			    
			        <div class="billing_summary" >
			            <p class="title"><fmt:message key="BILL_BILLING_ADDRESS" bundle="${storeText}"/></p>
			            	<span id="Billing_Address_With_No_Payment_Method"></span>
				    </div>
			    </c:if>
			
				<c:if test="${numberOfPaymentMethods > 0 }">
				<c:forEach begin="0" end="${numberOfPaymentMethods-1}" var="paymentCount">
					<div class="billing_summary" >
						<c:if test="${numberOfPaymentMethods > 1}">
							<div <c:if test="${paymentCount >= 1}">class="billing_border"</c:if> id="WC_CheckoutPaymentAndBillingAddressSummaryf_div_1_<c:out value='${paymentCount}'/>">
								<c:if test="${paymentCount >= 1}"> <br /> </c:if> 
									<p class="title"><fmt:message key="PAYMENT_CAPS" bundle="${storeText}"/><span><c:out value='${paymentCount+1}'/></span></p>
							</div>
							<br />
						 </c:if>						 
						<div class="billing_address" valign="top" id="WC_CheckoutPaymentAndBillingAddressSummaryf_div_2_<c:out value='${paymentCount}'/>">
							<p class="title"><fmt:message key="BILL_BILLING_ADDRESS" bundle="${storeText}"/></p>						
							<span id="Billing_Address_<c:out value='${paymentCount}'/>"></span>
							<br />
						</div>
						<div class="billing_method" id="WC_CheckoutPaymentAndBillingAddressSummaryf_div_3_<c:out value='${paymentCount}'/>">
							
							<p class="title"><fmt:message key="BILL_BILLING_METHOD" bundle="${storeText}"/></p>																													
										<span id="Payment_Method_Name_<c:out value='${paymentCount}'/>"><fmt:message key="MO_NOT_AVAILABLE" bundle="${storeText}"/></span>
									
							<p>	
							<br/>
								<div id="Div_CreditCard_<c:out value='${paymentCount}'/>" style=display:none>
									<p><span id="WC_PaymentType_CreditCard_<c:out value='${paymentCount}'/>"><fmt:message key="account" bundle="${storeText}"/></span></p>
									<p><span id="CreditCard_Account_<c:out value='${paymentCount}'/>"></span></p>
									
									<p><span><fmt:message key="expire_month" bundle="${storeText}"/></span></p>
									<p><span id="CreditCard_Expiration_Month_<c:out value='${paymentCount}'/>"></span></p>
									<p><span><fmt:message key="expire_year" bundle="${storeText}"/></span></p>
									<p><span id="CreditCard_Expiration_Year_<c:out value='${paymentCount}'/>"></span></p>
								</div>	
								
								<div id="Div_Check_<c:out value='${paymentCount}'/>" style=display:none>
									<p><span id="WC_PaymentType_Check_<c:out value='${paymentCount}'/>"><fmt:message key="account" bundle="${storeText}"/></span></p>
									<p><span id="Check_Account_<c:out value='${paymentCount}'/>"></span></p>
								</div>
								
								<div id="Div_LineOfCredit_<c:out value='${paymentCount}'/>" style=display:none>					
									<p><span id="WC_PaymentType_LineOfCredit_<c:out value='${paymentCount}'/>"><fmt:message key="account" bundle="${storeText}"/></span></p>
									<p><span id="LineOfCredit_Account_<c:out value='${paymentCount}'/>"></span></p>
								</div>
							
							<p><fmt:message key="AMOUNT" bundle="${storeText}"/>:</p>
							<p class="price">
						
									<span id="Payment_Method_Amount_<c:out value='${paymentCount}'/>"><fmt:message key="MO_NOT_AVAILABLE" bundle="${storeText}"/></span>
								
							</p>
							
						</div>
					</div>		
					<br clear="all"/>									
				</c:forEach>
				</c:if>
				<br clear="all" />
		        </div>
			</div>
		<div class="content_footer" id="WC_OrderShipmentDetails_div_29">
			<div class="left_corner" id="WC_OrderShipmentDetails_div_30"></div>
			<div class="button_footer_line" id="WC_OrderShipmentDetails_div_31">
				<div class="left" id="WC_OrderShipmentDetails_div_31_1">
					<a href="#" class="button_primary" id="WC_OrderDetailDisplay_Print_Link" tabindex="0" onclick="JavaScript: print();">
						<div class="left_border"></div>
						<div class="button_text"><fmt:message key="PRINT" bundle="${storeText}"/></div>
						<div class="right_border"></div>
					</a>
				</div>
				
				<div class="button_side_message" id="WC_OrderShipmentDetails_div_32_1">
					<fmt:message key="PRINT_RECOMMEND" bundle="${storeText}"/>
				</div>
			</div>
			
			<div class="right_corner" id="WC_OrderShipmentDetails_div_34"></div>
		</div>
	</div>
	</div>
	<div id="HiddenArea_Order" style=display:none>
		<span id="Locale_String"><c:out value="${locale}"/></span>
		<span id="jsonOrderStr"><c:out value="${order}"/></span>
	</div>
</div>

<script type="text/javascript">
//sterlingIntegrationJS.populateOrderLevelInfo('${order}');
</script>
<!-- END SBSOrderDetails.jsp -->