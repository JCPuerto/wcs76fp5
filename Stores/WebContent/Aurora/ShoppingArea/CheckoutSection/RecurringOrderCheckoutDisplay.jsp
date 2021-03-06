<%--
 =================================================================
  Licensed Materials - Property of IBM

  WebSphere Commerce

  (C) Copyright IBM Corp. 2010, 2012 All Rights Reserved.

  US Government Users Restricted Rights - Use, duplication or
  disclosure restricted by GSA ADP Schedule Contract with
  IBM Corp.
 =================================================================
--%>
<%--
  *****
  * This JSP file renders the schedule order section on the shipping and billing page, order summary page and order confirmation page in the checkout flow.
  * This section is only displayed if the 'recurring order' flex flow option is enabled. 
  * Parameters for order scheduling can be edited on the shipping and billing page, but not on the order summary or confirmation page. 
  *****
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../../include/JSTLEnvironmentSetup.jspf" %>

<c:set var="orderId" value="${param.orderId}"/>
<c:set var="subscriptionId" value="${param.subscriptionId}" />
<c:if test="${WCParam.originalOrderId != null}">
	<c:set var="orderId" value="${WCParam.originalOrderId}"/>
</c:if>

<input type="hidden" id="orderIdToSchedule" name="orderIdToSchedule" value="${param.orderId}"/>
<input type="hidden" id="makeRecurringOrderMandatory" name="makeRecurringOrderMandatory" value="true"/>

<c:set var="key" value="WC_ScheduleOrder_${orderId}_interval"/>
<c:set var="interval" value="${cookie[key].value}"/>

<c:set var="key" value="WC_ScheduleOrder_${orderId}_strStartDate"/>
<c:set var="strStartDate" value="${cookie[key].value}"/>

<c:if test="${!empty subscriptionId}" >
	<wcf:getData type="com.ibm.commerce.subscription.facade.datatypes.SubscriptionType" var="recurringOrdersDetails"  expressionBuilder="getSubscriptionDetailsByUniqueID"  >
			<wcf:param name="UniqueID" value="${param.subscriptionId}" />
			<wcf:param name="storeId" value="${WCParam.storeId}" />
	</wcf:getData>
	
	<c:if test="${empty interval}">
		<fmt:parseNumber var="actualInterval" value="${recurringOrdersDetails.subscriptionInfo.fulfillmentSchedule.frequencyInfo.frequency.value}" integerOnly="true"/>
		<c:set var="actualIntervalUOM" value="${fn:trim(recurringOrdersDetails.subscriptionInfo.fulfillmentSchedule.frequencyInfo.frequency.uom)}"/>
		<c:if test="${!empty recurringOrdersDetails.subscriptionInfo.fulfillmentSchedule.endInfo.duration.value}">
			<fmt:parseNumber var="timePeriod" value="${recurringOrdersDetails.subscriptionInfo.fulfillmentSchedule.endInfo.duration.value}" integerOnly="true"/>
		</c:if>
		<c:choose>
			<c:when test="${!empty recurringOrdersDetails.subscriptionInfo.fulfillmentSchedule.endInfo.duration.value && timePeriod == 1}">
				<c:set var="interval" value="1"/>
			</c:when>
			<c:when test="${actualInterval == RecurringOrderFrequency2 && actualIntervalUOM == RecurringOrderFrequencyUOM2}">
				<c:set var="interval" value="2"/>
			</c:when>
			<c:when test="${actualInterval == RecurringOrderFrequency3 && actualIntervalUOM == RecurringOrderFrequencyUOM3}">
				<c:set var="interval" value="3"/>
			</c:when>
			<c:when test="${actualInterval == RecurringOrderFrequency4 && actualIntervalUOM == RecurringOrderFrequencyUOM4}">
				<c:set var="interval" value="4"/>
			</c:when>
			<c:when test="${actualInterval == RecurringOrderFrequency5 && actualIntervalUOM == RecurringOrderFrequencyUOM5}">
				<c:set var="interval" value="5"/>
			</c:when>
			<c:when test="${actualInterval == RecurringOrderFrequency6 && actualIntervalUOM == RecurringOrderFrequencyUOM6}">
				<c:set var="interval" value="6"/>
			</c:when> 
		</c:choose>
	</c:if>

	<c:if test="${empty strStartDate}">
		<c:set var="strStartDate" value="${recurringOrdersDetails.subscriptionInfo.fulfillmentSchedule.startInfo.startDate}"/>
	</c:if>
</c:if>

<c:set var="strStartDate" value="${fn:replace(strStartDate, '%3A', ':')}"/>

<c:if test="${(interval == null || strStartDate == null) && !empty requestScope.order}">
	<c:set var="order" value="${requestScope.order}"/>
	<c:set var="interval" value="${order.orderScheduleInfo.interval}"/>
	<c:set var="strStartDate" value="${order.orderScheduleInfo.startTime}"/>
</c:if>

<c:catch>
	<fmt:parseDate parseLocale="${dateLocale}" var="strStartDate" value="${strStartDate}" pattern="yyyy-MM-dd'T'HH:mm:ss.SSS'Z'" timeZone="GMT"/>
</c:catch>
<c:if test="${empty strStartDate}">
	<c:catch>
		<fmt:parseDate parseLocale="${dateLocale}" var="strStartDate" value="${strStartDate}" pattern="yyyy-MM-dd'T'HH:mm:ss'Z'" timeZone="GMT"/>
	</c:catch>
</c:if>

<c:if test="${param.isShippingBillingPage || (interval != null && strStartDate != null && strStartDate != '' && (strStartDate.year+1900 != 1970))}">
	
	<c:set var="formattedTimeZone" value="${fn:replace(cookie.WC_timeoffset.value, '%2B', '+')}"/>
	<c:set var="formattedTimeZone" value="${fn:replace(formattedTimeZone, '.75', ':45')}"/>	
	<c:set var="formattedTimeZone" value="${fn:replace(formattedTimeZone, '.5', ':30')}"/>
	<fmt:formatDate value="${strStartDate}" type="date" pattern="yyyy-MM-dd" var="formattedstrStartDate" dateStyle="long" timeZone="${formattedTimeZone}"/>
	<br/>&nbsp;
	<div class="myaccount_header" id="WC_ScheduleOrder_div_1">
		<div class="left_corner_straight" id="WC_ScheduleOrder_div_2"></div>
		<div class="left" id="WC_ScheduleOrder_div_3">
			<span class="main_header_text" id="WC_ScheduleOrder_span_1"><fmt:message key="SCHEDULE_ORDER_HEADER" bundle="${storeText}"/></span>
		</div>
		<div class="right_corner_straight" id="WC_ScheduleOrder_div_4"></div>
	</div>
	

	<c:if test="${empty order || strStartDate == null || empty strStartDate}">
		<div class="checkout_subheader" id="WC_ScheduleOrder_div_5">
			<div class="left" id="WC_ScheduleOrder_div_7">
				<span class="content_text" id="WC_ScheduleOrder_span_2"><fmt:message key="SCHEDULE_ORDER_HEADER_MESSAGE" bundle="${storeText}"/></span>
			</div>
		</div>
	</c:if
	
	<div class="body margin_below" id="scheduleOrderInputSection">
		<div id="WC_ScheduleOrder_div_9" class="scheduleOrderAreaInterval">
		
			<div id="WC_ScheduleOrder_div_10" class="my_account_content_bold">
				<c:if test="${param.isShippingBillingPage}">
				<label for="ScheduleOrderFrequency">
						<span class="required-field">*</span>
				</c:if>
					<fmt:message key="SCHEDULE_ORDER_INTERVAL_TITLE" bundle="${storeText}"/>
				<c:if test="${param.isShippingBillingPage}">
				</label>
				</c:if>
			</div>
			<div id="WC_ScheduleOrder_div_11">
				<c:choose>
					<c:when test="${param.isShippingBillingPage}">
						<select class="drop_down_shipping" name="ScheduleOrderFrequency" id="ScheduleOrderFrequency" onchange="this.blur();">
							<option value="undefined" <c:if test="${interval == null}">selected="selected"</c:if>><fmt:message key="SCHEDULE_ORDER_DROP_DOWN_SELECT_FREQUENCY" bundle="${storeText}"/></option>
							<option value="1" <c:if test="${interval == 1}">selected="selected"</c:if>><c:out value='${RecurringOrderFrequencyText1}'/></option>
							<option value="2" <c:if test="${interval == 2}">selected="selected"</c:if>><c:out value='${RecurringOrderFrequencyText2}'/></option>
							<option value="3" <c:if test="${interval == 3}">selected="selected"</c:if>><c:out value='${RecurringOrderFrequencyText3}'/></option>
							<option value="4" <c:if test="${interval == 4}">selected="selected"</c:if>><c:out value='${RecurringOrderFrequencyText4}'/></option>
							<option value="5" <c:if test="${interval == 5}">selected="selected"</c:if>><c:out value='${RecurringOrderFrequencyText5}'/></option>
							<option value="6" <c:if test="${interval == 6}">selected="selected"</c:if>><c:out value='${RecurringOrderFrequencyText6}'/></option>
						</select>
					</c:when>
					<c:otherwise>
						<c:choose>
							<c:when test="${interval == 1}">
								<c:out value='${RecurringOrderFrequencyText1}'/>
							</c:when>
							<c:when test="${interval == 2}">
								<c:out value='${RecurringOrderFrequencyText2}'/>
							</c:when>
							<c:when test="${interval == 3}">
								<c:out value='${RecurringOrderFrequencyText3}'/>
							</c:when>
							<c:when test="${interval == 4}">
								<c:out value='${RecurringOrderFrequencyText4}'/>
							</c:when>
							<c:when test="${interval == 5}">
								<c:out value='${RecurringOrderFrequencyText5}'/>
							</c:when>
							<c:when test="${interval == 6}">
								<c:out value='${RecurringOrderFrequencyText6}'/>
							</c:when> 
						</c:choose>
					</c:otherwise>
				</c:choose>
			</div>
		</div>
		<div id="WC_ScheduleOrder_div_12" class="scheduleOrderAreaStartDate">
			<div id="WC_ScheduleOrder_div_13" class="my_account_content_bold">
				<c:if test="${param.isShippingBillingPage}">
				<label for="ScheduleOrderStartDate">
						<span class="required-field">*</span>
				</c:if>
					<fmt:message key="SCHEDULE_ORDER_START_DATE_TITLE" bundle="${storeText}"/>
				<c:if test="${param.isShippingBillingPage}">
				</label>
				</c:if>
			</div>
			<div id="ScheduleOrderStartDate_inputField" class="dijitCalendarWidth">
				<c:choose>
					<c:when test="${param.isShippingBillingPage}">
						<input 
							id="ScheduleOrderStartDate" 
							name="ScheduleOrderStartDate" 
							size="6" 
							onclick="JavaScript:var now = new Date();now.setHours(0,0,0,0);this.constraints.min = now;dojo.byId('ScheduleOrderFrequency').focus(); dojo.byId('ScheduleOrderStartDate').focus();"
							onchange="JavaScript:CheckoutHelperJS.validateDate(this, 'ScheduleOrderStartDate');" 
							onblur="JavaScript:CheckoutHelperJS.validateDateOnBlur(this, 'ScheduleOrderStartDate');"
							dojoType="dijit.form.DateTextBox" 
							invalidMessage="<fmt:message key="INVALID_DATE_FORMAT_ERROR" bundle="${storeText}"/>"  
							rangeMessage="<fmt:message key="RANGE_ERROR_MESSAGE" bundle="${storeText}"/>" 
							value="<c:if test="${strStartDate != null}"><c:out value="${formattedstrStartDate}"/></c:if>"
						/>
						<script type="text/javascript">
							dojo.addOnLoad(function() { parseWidget("ScheduleOrderStartDate"); });
						</script>
					</c:when>
					<c:otherwise>
						<c:choose>
							<c:when test="${strStartDate.year+1900 != 1970}">
								<c:if test="${!param.isShippingBillingPage && !empty subscriptionId}" >
									<c:catch>
										<fmt:parseDate parseLocale="${dateLocale}" var="startTime" value="${recurringOrdersDetails.subscriptionInfo.fulfillmentSchedule.startInfo.startDate}" pattern="yyyy-MM-dd'T'HH:mm:ss.SSS'Z'" timeZone="GMT"/>
									</c:catch>

									<c:if test="${empty startTime}">
										<c:catch>
											<fmt:parseDate parseLocale="${dateLocale}" var="startTime" value="${recurringOrdersDetails.subscriptionInfo.fulfillmentSchedule.startInfo.startDate}" pattern="yyyy-MM-dd'T'HH:mm:ss'Z'" timeZone="GMT"/>
										</c:catch>
									</c:if>
									<c:set var="indexTime" value="${startTime}" />
									<fmt:formatDate var="formattedstrStartDate" value="${startTime}" dateStyle="long" timeZone="${formattedTimeZone}"/>
								</c:if>
								<c:out value="${formattedstrStartDate}"/>
							</c:when>
							<c:otherwise>
								<c:out value=""/>
							</c:otherwise>
						</c:choose>
					</c:otherwise>
				</c:choose>
			</div>
		</div>

		<c:if test="${!param.isShippingBillingPage && !empty subscriptionId}">
			<c:if test="${recurringOrdersDetails.state eq 'Active' || recurringOrdersDetails.state eq 'PendingCancel' || recurringOrdersDetails.state eq 'InActive'}">
				<div class="scheduleOrderAreaNextDelivery">	
					<div id="WC_ScheduleOrder_div_14" class="my_account_content_bold"><fmt:message key="NEXT_SCHEDULED_DELIVERY" bundle="${storeText}"/></div>
					<c:catch>
						<fmt:parseDate parseLocale="${dateLocale}" var="nextTime" value="${recurringOrdersDetails.subscriptionInfo.fulfillmentSchedule.frequencyInfo.nextOccurence}" pattern="yyyy-MM-dd'T'HH:mm:ss.SSS'Z'" timeZone="GMT"/>
					</c:catch>
	
					<c:if test="${empty nextTime}">
						<c:catch>
							<fmt:parseDate parseLocale="${dateLocale}" var="nextTime" value="${recurringOrdersDetails.subscriptionInfo.fulfillmentSchedule.frequencyInfo.nextOccurence}" pattern="yyyy-MM-dd'T'HH:mm:ss'Z'" timeZone="GMT"/>
						</c:catch>
					</c:if>
					<c:set var="indexTime" value="${nextTime}" />
					<fmt:formatDate var="formattedNextOrderDate" value="${nextTime}" dateStyle="long" timeZone="${formattedTimeZone}"/>
					<span><c:out value="${formattedNextOrderDate}"/></span>
				</div>
			</c:if>
		</c:if>

		<!---Calendar Icon --->
		<c:if test="${param.isShippingBillingPage}">
			<div id="WC_ScheduleOrder_div_16" class="startdate_calendar_icon" onclick="javascript:var now = new Date();now.setHours(0,0,0,0);dijit.byId('ScheduleOrderStartDate').constraints.min = now;dojo.byId('ScheduleOrderStartDate').focus()"></div>
		</c:if>

		<%@ include file="RecurringOrderCheckoutDisplayExt.jspf"%>
		<div id="ScheduleOrder_clearFloatDiv" class="clear_float"></div>
	</div>
</c:if>

