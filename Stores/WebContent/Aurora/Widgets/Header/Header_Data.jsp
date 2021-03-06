<%--
 =================================================================
  Licensed Materials - Property of IBM

  WebSphere Commerce

  (C) Copyright IBM Corp. 2011 All Rights Reserved.

  US Government Users Restricted Rights - Use, duplication or
  disclosure restricted by GSA ADP Schedule Contract with
  IBM Corp.
 =================================================================
--%>

<wcf:url var="StoreLocatorView" value="AjaxStoreLocatorDisplayView">
	<wcf:param name="storeId"   value="${storeId}"  />
	<wcf:param name="catalogId" value="${catalogId}"/>
	<wcf:param name="langId" value="${langId}" />
</wcf:url>

<wcf:url var="ContactUsViewURL" patternName="ContactUsURL" value="ContactUsView">
	<wcf:param name="storeId"   value="${storeId}"  />
	<wcf:param name="catalogId" value="${catalogId}"/>
	<wcf:param name="langId" value="${langId}" />
</wcf:url>

<wcf:url var="MyAccountURL" value="AjaxLogonForm">
  <wcf:param name="langId" value="${param.langId}" />
  <wcf:param name="storeId" value="${param.storeId}" />
  <wcf:param name="catalogId" value="${param.catalogId}" />
  <wcf:param name="myAcctMain" value="1" />
</wcf:url>

<%-- Build sign-in or sign-out links based on user type --%>
<c:choose>
	<c:when test="${userType eq 'G'}">
		<c:set var="SIGN_IN_OUT"><fmt:message key="HEADER_SIGN_IN_REGISTER"/></c:set>
		<c:set var="SIGN_IN_OUT_ID">SignInLink</c:set>
		<wcf:url var="Logon_LogoutURL" value="LogonForm">
		  <wcf:param name="langId" value="${langId}" />
		  <wcf:param name="storeId" value="${storeId}" />
		  <wcf:param name="catalogId" value="${catalogId}" />
		  <wcf:param name="myAcctMain" value="1" />
		</wcf:url>
		<wcf:url var="WishListDisplayURLOriginal" value="WishListDisplayView">
			<wcf:param name="listId" value="." />
			<wcf:param name="storeId"   value="${storeId}"  />
			<wcf:param name="catalogId" value="${catalogId}"/>
			<wcf:param name="langId" value="${langId}" />
		</wcf:url>
		<c:set var="WishListDisplayURL" value="javascript:redirectToSignOn('${WishListDisplayURLOriginal}');"/>
	</c:when>
	<c:otherwise>
		<c:set var="SIGN_IN_OUT"><fmt:message key="HEADER_SIGN_OUT"/></c:set>
		<c:set var="SIGN_IN_OUT_ID">SignOutLink</c:set>
		<wcf:url var="Logon_LogoutURL" value="Logoff">
		  <wcf:param name="langId" value="${langId}" />
		  <wcf:param name="storeId" value="${storeId}" />
		  <wcf:param name="catalogId" value="${catalogId}" />
		  <wcf:param name="myAcctMain" value="1" />
		  <wcf:param name="URL" value="LogonForm" />
		</wcf:url>
		<wcf:url var="WishListDisplayURL" value="WishListDisplayView">
			<wcf:param name="listId" value="." />
			<wcf:param name="storeId"   value="${storeId}"  />
			<wcf:param name="catalogId" value="${catalogId}"/>
			<wcf:param name="langId" value="${langId}" />
		</wcf:url>
	</c:otherwise>
</c:choose>

<wcf:getData type="com.ibm.commerce.infrastructure.facade.datatypes.OnlineStoreType" var="storeInfo" expressionBuilder="findByUniqueID">
   <wcf:param name="storeId" value="${storeId}" />
</wcf:getData>
<c:set var="storeInfoContact" value="${storeInfo.onlineStoreContactInfo[0]}" />		
<c:forEach var="storeInfoContacts" items="${storeInfo.onlineStoreContactInfo}">
   <c:if test="${storeInfoContacts.language == langId}">
	  <c:set var="storeInfoContact" value="${storeInfoContacts}" />		
   </c:if>
</c:forEach>
<c:set var="storeInfoContactTelephone" value="${storeInfoContact.telephone1.value}" />
