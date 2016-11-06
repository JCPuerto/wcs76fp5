<%--
 =================================================================
  Licensed Materials - Property of IBM

  WebSphere Commerce

  (C) Copyright IBM Corp. 2008, 2011 All Rights Reserved.

  US Government Users Restricted Rights - Use, duplication or
  disclosure restricted by GSA ADP Schedule Contract with
  IBM Corp.
 =================================================================
--%>

<%--
  *****
  * This JSP segment displays the checkout address entry form for an unregistered user
  * for the following countries/regions:
  *  - China
  * The display order is as follows (* means mandatory):
  *  - last name*
  *  - first name
  *  - country/region*
  *  - state/province*
  *  - city*
  *  - address*
  *  - zip/postal code*
  *  - phone
  *  - email*
  *****
--%>

<!-- BEGIN UnregisteredCheckoutAddressEntryForm_CN.jsp-->
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../../include/JSTLEnvironmentSetup.jspf"%>

<c:set var="formName" value="${param.formName}"/>
<c:set var="pageName" value="${param.pageName}"/>
<c:set var="address" value="${param.address}"/>
<c:set var="paramPrefix" value="${param.paramPrefix}"/>
<c:set var="divNum" value="${param.divNum}"/>

<%@ include file="AddressHelperCountrySelection.jspf" %>

<div id="WC_${formName}_requiredfield_div_1">
	<span class="required-field" id="WC_${formName}_requiredfield_div_2"> *</span>
	<fmt:message key="REQUIRED_FIELDS" bundle="${storeText}"/></div>
<br />

<div class="label_spacer" id="WC_${formName}_nickName_div_3">
	<label for="<c:out value='WC_${pageName}_ShoppingCartAddressEntryForm_${formName}_${paramPrefix}nickName'/>" class="nodisplay">
	<fmt:message key="SHIPPING_AND_BILLING_ADDRESS_LABEL_TEXT" bundle="${storeText}">
	<fmt:param><fmt:message key="AB_RECIPIENT" bundle="${storeText}"/></fmt:param>
	<fmt:param>${address}</fmt:param>
	<fmt:param><fmt:message key="Checkout_ACCE_required" bundle="${storeText}"/></fmt:param></fmt:message>
	</label>

	<span class="required-field" id="WC_${formName}_nickName_div_4"> *</span>
	<fmt:message key="AB_RECIPIENT" bundle="${storeText}"/>
	</div>

<div id="WC_${formName}_nickName_div_5">
	<c:choose>
		<c:when test="${!empty addressId && addressId != -1}" >
			<input type="hidden" name="addressId" value="<c:out value='${addressId}'/>" id="WC_${formName}_nickName_inputs_1"/>
			<input type="text" readonly="true" id="<c:out value='WC_${pageName}_ShoppingCartAddressEntryForm_${formName}_${paramPrefix}nickName'/>" name="nickName" size="35" class="form_input" value="<c:out value="${contact.contactInfoIdentifier.externalIdentifier.contactInfoNickName}"/>" />
		</c:when>
		<c:otherwise>
			<input type="text" id="<c:out value='WC_${pageName}_ShoppingCartAddressEntryForm_${formName}_${paramPrefix}nickName'/>" name="nickName" size="35" class="form_input" value="" />
		</c:otherwise>
	</c:choose>
</div>

<script type="text/javascript">
	dojo.addOnLoad(function() { 
		AddressHelper.setStateDivName("<c:out value="stateDiv${divNum}"/>");
	});
</script>


<%-- last name --%>
<div class="label_spacer" id="WC_${formName}_lastName_div_6">
	<label for="<c:out value='WC_${pageName}_ShoppingCartAddressEntryForm_${formName}_${paramPrefix}lastName_1'/>" class="nodisplay">
	<fmt:message key="SHIPPING_AND_BILLING_ADDRESS_LABEL_TEXT" bundle="${storeText}">
	<fmt:param><fmt:message key="LAST_NAME" bundle="${storeText}"/></fmt:param>
	<fmt:param>${address}</fmt:param>
	<fmt:param><fmt:message key="Checkout_ACCE_required" bundle="${storeText}"/></fmt:param></fmt:message>
	</label>
	<span class="required-field" id="WC_${formName}_lastName_div_7"> *</span>
	<fmt:message key="LAST_NAME" bundle="${storeText}"/></div>
<div id="WC_${formName}_lastName_div_8">
	<input type="text" name="lastName" id="<c:out value='WC_${pageName}_ShoppingCartAddressEntryForm_${formName}_${paramPrefix}lastName_1'/>" size="35" class="form_input" value="<c:out value='${contact.contactName.lastName}'/>" />
</div>


<%-- first name --%>
<div class="label_spacer" id="WC_${formName}_firstName_div_9">
	<label for="<c:out value='WC_${pageName}_ShoppingCartAddressEntryForm_${formName}_${paramPrefix}firstName_1'/>" class="nodisplay">
	<fmt:message key="SHIPPING_AND_BILLING_ADDRESS_LABEL_TEXT" bundle="${storeText}">
	<fmt:param><fmt:message key="FIRST_NAME" bundle="${storeText}"/></fmt:param>
	<fmt:param>${address}</fmt:param>
	<fmt:param> </fmt:param></fmt:message>
	</label>
	<fmt:message key="FIRST_NAME" bundle="${storeText}"/></div>
<div id="WC_${formName}_firstName_div_10">
	<input type="text" name="firstName" id="<c:out value='WC_${pageName}_ShoppingCartAddressEntryForm_${formName}_${paramPrefix}firstName_1'/>" size="35" class="form_input" value="<c:out value='${contact.contactName.firstName}'/>" />
</div>


<%-- country/region --%>
<div class="label_spacer" id="WC_${formName}_country_div_11">
	<label for="<c:out value='WC_${pageName}_ShoppingCartAddressEntryForm_${formName}_${paramPrefix}country_1'/>" class="nodisplay">
	<fmt:message key="SHIPPING_AND_BILLING_ADDRESS_LABEL_TEXT" bundle="${storeText}">
	<fmt:param><fmt:message key="COUNTRY" bundle="${storeText}"/></fmt:param>
	<fmt:param>${address}</fmt:param>
	<fmt:param><fmt:message key="Checkout_ACCE_required" bundle="${storeText}"/></fmt:param></fmt:message>
	</label>
	<span class="required-field" id="WC_${formName}_country_div_12"> *</span>
	<fmt:message key="COUNTRY" bundle="${storeText}"/></div>
<div id="WC_${formName}_country_div_13">
	<select name="country" size="1" id="<c:out value='WC_${pageName}_ShoppingCartAddressEntryForm_${formName}_${paramPrefix}country_1'/>" class="drop_down_country" onkeydown="saveTabPress(event)" onblur="setFocus('WC_${pageName}_ShoppingCartAddressEntryForm_${formName}_${paramPrefix}state_1')" onchange="javascript:AddressHelper.loadStatesUI('<c:out value='${formName}'/>','<c:out value='${paramPrefix}'/>','<c:out value='${paramPrefix}stateDiv${divNum}'/>','<c:out value="WC_${pageName}_ShoppingCartAddressEntryForm_${formName}_${paramPrefix}state_1"/>')">
		<c:forEach var="country" items="${countryBean.countries}">
			<option value="<c:out value='${country.code}'/>" 
				<c:if test="${country.code eq contact.address.country || country.displayName eq contact.address.country}">
					selected="selected"
				</c:if>
			>
				<c:out value="${country.displayName}"/>
			</option>
		</c:forEach>
	</select>
</div>


<%-- state/province --%>
<div class="label_spacer" id="WC_${formName}_state_div_14">
	<label for="<c:out value='WC_${pageName}_ShoppingCartAddressEntryForm_${formName}_${paramPrefix}state_1'/>" class="nodisplay">
	<fmt:message key="SHIPPING_AND_BILLING_ADDRESS_LABEL_TEXT" bundle="${storeText}">
	<fmt:param><fmt:message key="STATE_PROVINCE" bundle="${storeText}"/></fmt:param>
	<fmt:param>${address}</fmt:param>
	<fmt:param><fmt:message key="Checkout_ACCE_required" bundle="${storeText}"/></fmt:param></fmt:message>
	</label>
	<span class="required-field" id="WC_${formName}_state_div_15"> *</span>
	<fmt:message key="STATE_PROVINCE" bundle="${storeText}"/>
</div>

<div id="<c:out value='${paramPrefix}stateDiv${divNum}'/>">
<jsp:setProperty name="countryBean" property="countryCode" value="${contact.address.country}" />
<c:choose>
	<c:when test="${!empty countryBean.countryCodeStates}">
		<select id="<c:out value='WC_${pageName}_ShoppingCartAddressEntryForm_${formName}_${paramPrefix}state_1'/>" name="state" class="drop_down_country">
			<c:forEach var="state" items="${countryBean.countryCodeStates}">
				<option value="<c:out value='${state.code}'/>" 
					<c:if test="${state.code eq contact.address.stateOrProvinceName || state.displayName eq contact.address.stateOrProvinceName}">
						selected="selected"
					</c:if>
				>
					<c:out value="${state.displayName}"/>
				</option>
			</c:forEach>
		</select>
	</c:when>
	<c:otherwise>
		<input type="text" name="state" id="<c:out value='WC_${pageName}_ShoppingCartAddressEntryForm_${formName}_${paramPrefix}state_1'/>" size="35" class="form_input" value="<c:out value='${contact.address.stateOrProvinceName}'/>" />
	</c:otherwise>
</c:choose>
</div>


<%-- city --%>
<div class="label_spacer" id="WC_${formName}_city_div_16">
	<label for="<c:out value='WC_${pageName}_ShoppingCartAddressEntryForm_${formName}_${paramPrefix}city_1'/>" class="nodisplay">
	<fmt:message key="SHIPPING_AND_BILLING_ADDRESS_LABEL_TEXT" bundle="${storeText}">
	<fmt:param><fmt:message key="CITY" bundle="${storeText}"/></fmt:param>
	<fmt:param>${address}</fmt:param>
	<fmt:param><fmt:message key="Checkout_ACCE_required" bundle="${storeText}"/></fmt:param></fmt:message>
	</label>
	<span class="required-field" id="WC_${formName}_city_div_17"> *</span>
	<fmt:message key="CITY" bundle="${storeText}"/></div>
<div id="WC_${formName}_city_div_18">
	<input type="text" name="city" id="<c:out value='WC_${pageName}_ShoppingCartAddressEntryForm_${formName}_${paramPrefix}city_1'/>" size="35" class="form_input" value="<c:out value='${contact.address.city}'/>" />
</div>


<%-- address --%>
<div class="label_spacer" id="WC_${formName}_address1_div_19">
	<label for="<c:out value='WC_${pageName}_ShoppingCartAddressEntryForm_${formName}_${paramPrefix}address1_1'/>" class="nodisplay">
	<fmt:message key="SHIPPING_AND_BILLING_ADDRESS_LABEL_TEXT" bundle="${storeText}">
	<fmt:param><fmt:message key="STREET_ADDRESS" bundle="${storeText}"/></fmt:param>
	<fmt:param>${address}</fmt:param>
	<fmt:param><fmt:message key="Checkout_ACCE_required" bundle="${storeText}"/></fmt:param></fmt:message>
	</label>
	<span class="required-field" id="WC_${formName}_address1_div_20"> *</span>
	<fmt:message key="STREET_ADDRESS" bundle="${storeText}"/></div>
<div id="WC_${formName}_address1_div_21">
	<input type="text" name="address1" id="<c:out value='WC_${pageName}_ShoppingCartAddressEntryForm_${formName}_${paramPrefix}address1_1'/>" size="35" class="form_input" value="<c:out value='${contact.address.addressLine[0]}'/>" />
	<input type="text" name="address2" id="<c:out value='WC_${pageName}_ShoppingCartAddressEntryForm_${formName}_${paramPrefix}address2_1'/>" size="35" class="form_input" value="<c:out value='${contact.address.addressLine[1]}'/>" />
	<label for="<c:out value='WC_${pageName}_ShoppingCartAddressEntryForm_${formName}_${paramPrefix}address2_1'/>" class="nodisplay"><fmt:message key="STREET_ADDRESS" bundle="${storeText}"/></label>
</div>


<%-- zipcode --%>
<div class="label_spacer" id="WC_${formName}_zipCode_div_22">
	<label for="<c:out value='WC_${pageName}_ShoppingCartAddressEntryForm_${formName}_${paramPrefix}zipCode_1'/>" class="nodisplay">
	<fmt:message key="SHIPPING_AND_BILLING_ADDRESS_LABEL_TEXT" bundle="${storeText}">
	<fmt:param><fmt:message key="ZIP_CODE" bundle="${storeText}"/></fmt:param>
	<fmt:param>${address}</fmt:param>
	<fmt:param><fmt:message key="Checkout_ACCE_required" bundle="${storeText}"/></fmt:param></fmt:message>
	</label>
	<span class="required-field" id="WC_${formName}_zipCode_div_23"> *</span>
	<fmt:message key="ZIP_CODE" bundle="${storeText}"/></div>
<div id="WC_${formName}_zipCode_div_24">
	<input type="text" name="zipCode" id="<c:out value='WC_${pageName}_ShoppingCartAddressEntryForm_${formName}_${paramPrefix}zipCode_1'/>" size="35" class="form_input" value="<c:out value='${contact.address.postalCode}'/>" />
</div>


<%-- phone --%>
<div class="label_spacer" id="WC_${formName}_phone1_div_25"><label for="<c:out value='WC_${pageName}_ShoppingCartAddressEntryForm_${formName}_${paramPrefix}phone1_1'/>" class="nodisplay">
<fmt:message key="SHIPPING_AND_BILLING_ADDRESS_LABEL_TEXT" bundle="${storeText}">
	<fmt:param><fmt:message key="PHONE_NUMBER" bundle="${storeText}"/></fmt:param>
	<fmt:param>${address}</fmt:param>
	<fmt:param> </fmt:param></fmt:message>
	</label>
<fmt:message key="PHONE_NUMBER" bundle="${storeText}"/></div>
<div id="WC_${formName}_phone1_div_26">
	<input type="text" name="phone1" id="<c:out value='WC_${pageName}_ShoppingCartAddressEntryForm_${formName}_${paramPrefix}phone1_1'/>" size="35" class="form_input" value="<c:out value='${contact.telephone1.value}'/>" />
</div>


<%-- email --%>
<div class="label_spacer" id="WC_${formName}_email1_div_27">
	<label for="<c:out value='WC_${pageName}_ShoppingCartAddressEntryForm_${formName}_${paramPrefix}email1_1'/>" class="nodisplay">
	<fmt:message key="SHIPPING_AND_BILLING_ADDRESS_LABEL_TEXT" bundle="${storeText}">
	<fmt:param><fmt:message key="EMAIL" bundle="${storeText}"/></fmt:param>
	<fmt:param>${address}</fmt:param>
	<fmt:param><fmt:message key="Checkout_ACCE_required" bundle="${storeText}"/></fmt:param></fmt:message>
	</label>
	<span class="required-field" id="WC_${formName}_email1_div_28"> *</span>
	<fmt:message key="EMAIL" bundle="${storeText}"/></div>
<div id="WC_${formName}_email1_div_29">
	<input type="text" name="email1" id="<c:out value='WC_${pageName}_ShoppingCartAddressEntryForm_${formName}_${paramPrefix}email1_1'/>" size="35" class="form_input" value="<c:out value='${contact.email1.value}'/>" />
</div>
<!-- END UnregisteredCheckoutAddressEntryForm_CN.jsp-->
