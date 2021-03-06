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

<wcf:url var="HelpViewURL" patternName="HelpURL" value="HelpView">
	<wcf:param name="urlLangId" value="${urlLangId}" />
	<wcf:param name="storeId"   value="${storeId}"  />
	<wcf:param name="catalogId" value="${catalogId}"/>
	<wcf:param name="langId" value="${langId}" />
	<wcf:param name="pageName" value="HelpPage" />
</wcf:url>

<wcf:url var="ContactUsViewURL" patternName="ContactUsURL" value="ContactUsView">
	<wcf:param name="urlLangId" value="${urlLangId}" />
	<wcf:param name="storeId"   value="${storeId}"  />
	<wcf:param name="catalogId" value="${catalogId}"/>
	<wcf:param name="langId" value="${langId}" />
	<wcf:param name="pageName" value="ContactUsPage" />
</wcf:url>

<wcf:url var="PrivacyViewURL" patternName="PrivacyURL" value="PrivacyPolicy">
	<wcf:param name="urlLangId" value="${urlLangId}" />
	<wcf:param name="storeId"   value="${storeId}"  />
	<wcf:param name="catalogId" value="${catalogId}"/>
	<wcf:param name="langId" value="${langId}" />
	<wcf:param name="pageName" value="PrivacyPolicyPage" />
</wcf:url>

<wcf:url var="ReturnPolicyViewURL" patternName="ReturnPolicyURL" value="ReturnPolicyPage">
	<wcf:param name="urlLangId" value="${urlLangId}" />
	<wcf:param name="storeId"   value="${storeId}"  />
	<wcf:param name="catalogId" value="${catalogId}"/>
	<wcf:param name="langId" value="${langId}" />
	<wcf:param name="pageName" value="ReturnPolicyPage" />
</wcf:url>

<wcf:url var="CorporateInfoViewURL" patternName="CorporateInfoURL" value="CorporateInfoPage">
	<wcf:param name="urlLangId" value="${urlLangId}" />
	<wcf:param name="storeId"   value="${storeId}"  />
	<wcf:param name="catalogId" value="${catalogId}"/>
	<wcf:param name="langId" value="${langId}" />
	<wcf:param name="pageName" value="CorporateInfoPage" />
</wcf:url>

<wcf:url var="CorporateContactUsViewURL" patternName="CorporateContactUsURL" value="CorporateContactUsPage">
	<wcf:param name="urlLangId" value="${urlLangId}" />
	<wcf:param name="storeId"   value="${storeId}"  />
	<wcf:param name="catalogId" value="${catalogId}"/>
	<wcf:param name="langId" value="${langId}" />
	<wcf:param name="pageName" value="CorporateContactUsPage" />
</wcf:url>

<wcf:url var="SiteMapURL" patternName="SitemapURL" value="SiteMap">
	<wcf:param name="urlLangId" value="${urlLangId}" />
	<wcf:param name="storeId"   value="${storeId}"  />
	<wcf:param name="catalogId" value="${catalogId}"/>
	<wcf:param name="langId" value="${langId}" />
	<wcf:param name="pageName" value="SiteMapPage" />
</wcf:url>

<flow:ifEnabled feature="QuickOrder">
	<wcf:url var="QuickOrderURL" value="QuickOrderView">
		<wcf:param name="storeId" value="${storeId}" />
		<wcf:param name="catalogId" value="${catalogId}" />
		<wcf:param name="langId" value="${langId}" />
	</wcf:url>
</flow:ifEnabled>

<flow:ifEnabled feature="StoreLocator">
	<wcf:url var="StoreLocatorURL" value="AjaxStoreLocatorDisplayView">
		<wcf:param name="storeId" value="${storeId}" />
		<wcf:param name="catalogId" value="${catalogId}" />
		<wcf:param name="langId" value="${langId}" />
	</wcf:url>
</flow:ifEnabled>

<%-- CoShopping --%>
<flow:ifEnabled feature="CoShopping">
	<%@ include file="../../ShoppingArea/coshopping/CoShopWidget.jspf"%>
</flow:ifEnabled>

<%-- Mobile store link --%>
<c:if test="${env_mobileStoreSupport == true}">
	<wcf:url var="mobileHome" value="mIndex">
		<wcf:param name="catalogId" value="${catalogId}"/>
		<wcf:param name="storeId" value="${storeId}"/>
	</wcf:url>
</c:if>
