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
  * This JSP imports CachedBundleDisplay.
  * It also imports header, sidebar, and footer.
  *****
--%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ taglib uri="http://commerce.ibm.com/coremetrics"  prefix="cm" %>
<%@ include file="../../../include/JSTLEnvironmentSetup.jspf"%>
<%@ include file="../../../include/nocache.jspf"%>

<c:set var="productId" value="${WCParam.productId}" />
<c:set var="productPage" value="true" scope="request"/>
<c:set var="hasBreadCrumbTrail" value="true" scope="request"/>
<c:set var="useHomeRightSidebar" value="false" scope="request"/>
          
<wcf:getData type="com.ibm.commerce.catalog.facade.datatypes.CatalogNavigationViewType" var="catalogNavigationView"
	expressionBuilder="getCatalogEntryViewAllByID" varShowVerb="showCatalogNavigationView" maxItems="1" recordSetStartNumber="0">
	<wcf:param name="UniqueID" value="${productId}"/>
	<wcf:contextData name="storeId" data="${WCParam.storeId}" />
	<wcf:contextData name="catalogId" data="${WCParam.catalogId}" />
</wcf:getData>

<c:set var="catEntry" value="${catalogNavigationView.catalogEntryView[0]}" />
<c:set var="catalogEntryDetails" value="${catEntry}" scope="request" />
<c:set var="fullImageAltDescription" value="${catEntry.fullImageAltDescription}" scope="request" />

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<!-- BEGIN BundleDisplay.jsp -->
<html xmlns:wairole="http://www.w3.org/2005/01/wai-rdf/GUIRoleTaxonomy#"
xmlns:waistate="http://www.w3.org/2005/07/aaa" lang="${shortLocale}" xml:lang="${shortLocale}">
<head>
<title><c:out value="${catEntry.title}"/></title>
<meta name="description" content="<c:out value="${catEntry.metaDescription}"/>"/>
<meta name="keyword" content="<c:out value="${catEntry.keyword}"/>"/>
<wcf:url var="ProductDisplayURL" patternName="ProductURL" value="Product1">
	<wcf:param name="langId" value="${langId}" />
	<wcf:param name="storeId" value="${WCParam.storeId}" />
	<wcf:param name="catalogId" value="${WCParam.catalogId}" />
	<wcf:param name="productId" value="${productId}" />
	<wcf:param name="urlLangId" value="${urlLangId}" />
</wcf:url>
<link rel="canonical" href="<c:out value="${ProductDisplayURL}"/>" />
<link rel="stylesheet" href="<c:out value="${jspStoreImgDir}${vfileStylesheet}"/>" type="text/css"/>
<!--[if lte IE 6]>
<link rel="stylesheet" href="<c:out value="${jspStoreImgDir}${vfileStylesheetie}"/>" type="text/css"/>
<![endif]-->
<script type="text/javascript" src="<c:out value="${dojoFile}"/>" djConfig="${dojoConfigParams}"></script>
<%@ include file="../../../include/CommonJSToInclude.jspf"%>
<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/MessageHelper.js"/>"></script>
<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/CatalogArea/CategoryDisplay.js"/>"></script>

<script type="text/javascript">
	dojo.addOnLoad(function() {
		<fmt:message key="ERR_RESOLVING_SKU" bundle="${storeText}" var="ERR_RESOLVING_SKU"/> 
		<fmt:message key="QUANTITY_INPUT_ERROR" bundle="${storeText}" var="QUANTITY_INPUT_ERROR"/>
		<fmt:message key="WISHLIST_ADDED" bundle="${storeText}" var="WISHLIST_ADDED"/>
		<fmt:message key="SHOPCART_ADDED" bundle="${storeText}" var="SHOPCART_ADDED"/>
		<fmt:message key="SHOPCART_REMOVEITEM" bundle="${storeText}" var="SHOPCART_REMOVEITEM" />
		<fmt:message key="ERROR_MESSAGE_TYPE" bundle="${storeText}" var="ERROR_MESSAGE_TYPE"/>
		<fmt:message key="ERROR_CONTRACT_EXPIRED_GOTO_ORDER" bundle="${storeText}" var="ERROR_CONTRACT_EXPIRED_GOTO_ORDER"/>
		<fmt:message key="GENERICERR_MAINTEXT" bundle="${storeText}" var="ERROR_RETRIEVE_PRICE">                                     
			<fmt:param><fmt:message key="GENERICERR_CONTACT_US" bundle="${storeText}" /></fmt:param>
		</fmt:message>
		
		MessageHelper.setMessage("ERROR_RETRIEVE_PRICE", <wcf:json object="${ERROR_RETRIEVE_PRICE}"/>);
		MessageHelper.setMessage("ERR_RESOLVING_SKU", <wcf:json object="${ERR_RESOLVING_SKU}"/>);
		MessageHelper.setMessage("QUANTITY_INPUT_ERROR", <wcf:json object="${QUANTITY_INPUT_ERROR}"/>);
		MessageHelper.setMessage("WISHLIST_ADDED", <wcf:json object="${WISHLIST_ADDED}"/>);
		MessageHelper.setMessage("SHOPCART_ADDED", <wcf:json object="${SHOPCART_ADDED}"/>);
		MessageHelper.setMessage("SHOPCART_REMOVEITEM", <wcf:json object="${SHOPCART_REMOVEITEM}"/>);
		MessageHelper.setMessage("ERROR_MESSAGE_TYPE", <wcf:json object="${ERROR_MESSAGE_TYPE}"/>);
		MessageHelper.setMessage("ERROR_CONTRACT_EXPIRED_GOTO_ORDER", <wcf:json object="${ERROR_CONTRACT_EXPIRED_GOTO_ORDER}"/>);
		categoryDisplayJS.setCommonParameters('${WCParam.langId}','${WCParam.storeId}','${WCParam.catalogId}','${userType}');
	});
</script>
</head>

<body>
	<%@ include file="../../../include/StoreCommonUtilities.jspf"%>
	<%@ include file="../../../Snippets/ReusableObjects/CatalogEntryQuickInfoDetails.jspf" %>

	<div id="page">
		<%@ include file="../../../include/LayoutContainerTop.jspf"%>
		
		<div id="content_wrapper_box">
			<%-- 
			  ***
			  *	Start: Main Content
			  * Import JSP based on store configuration.
			  * If ProductOnlyDisplay is enabled, CachedProductOnlyDisplay.jsp is imported.  Otherwise, CachedProductItemDisplay is imported.
			  ***
			--%>
			<div id="content588">
				<%@ include file="../../../include/MessageDisplay.jspf"%>
				<%out.flush();%>
				<c:import url="${jspStoreDir}Snippets/Catalog/CatalogEntryDisplay/CachedBundleDisplay.jsp">
						<c:param name="storeId" value="${WCParam.storeId}"/>
						<c:param name="catalogId" value="${WCParam.catalogId}"/>
						<c:param name="langId" value="${langId}"/>
						<c:param name="productId" value="${productId}"/>
				</c:import>
				<%out.flush();%>
			</div>
			<%-- 
			  ***
			  *	End: Main Content
			  ***
			--%>
		</div>
		
		<%@ include file="../../../include/LayoutContainerBottom.jspf"%>
	</div>
	<div id="page_shadow" class="shadow"></div>
	<flow:ifEnabled feature="Analytics">
		<cm:product catentryId="${productId}" extraparms="null, ${cookie.analyticsFacetAttributes.value}"/>
		<cm:pageview/>
	</flow:ifEnabled>
	
</body>
</html>



<!-- END BundleDisplay.jsp -->
