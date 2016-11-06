<%--
 =================================================================
  Licensed Materials - Property of IBM

  WebSphere Commerce

  (C) Copyright IBM Corp. 2006, 2010 All Rights Reserved.

  US Government Users Restricted Rights - Use, duplication or
  disclosure restricted by GSA ADP Schedule Contract with
  IBM Corp.
 =================================================================
--%>

<%-- 
  *****
  * This JSP page displays the store's top-level categories. It is used as the starter store's homepage. 
  * It imports three JSP pages:
  *  - CachedHeaderDisplay.jsp, which displays the header of the page
  *  - CachedTopCategoriesDisplay.jsp, which displays the top-level categories
  *  - CachedFooter.jsp, which displays the footer of the page
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

<c:set var="topCategoryPage" value="true" scope="request"/>
<c:set var="hasBreadCrumbTrail" value="true" scope="request"/>
<c:set var="useHomeRightSidebar" value="true" scope="request"/>

<wcf:getData type="com.ibm.commerce.infrastructure.facade.datatypes.OnlineStoreType"
			var="onlineStoreSEO" 
			expressionBuilder="findSEOPageDefintionByPageNameAndStoreID">
		<wcf:contextData name="storeId" data="${WCParam.storeId}"/>
		<wcf:param name="storeId" value="${WCParam.storeId}"/>
		<wcf:param name="dataLanguageIds" value="${WCParam.langId}"/>
		<wcf:param name="pageName" value="HOME_PAGE"/>
		<wcf:param name="accessProfile" value="IBM_Store_SEOPageDefinition_Details"/>
</wcf:getData>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<!-- BEGIN TopCategoriesDisplay.jsp -->
<html  xmlns:wairole="http://www.w3.org/2005/01/wai-rdf/GUIRoleTaxonomy#"
xmlns:waistate="http://www.w3.org/2005/07/aaa" lang="${shortLocale}" xml:lang="${shortLocale}">
<head>
<title><c:out value="${onlineStoreSEO.SEOPageDefinitions[0].title}"/></title>
<meta name="description" content="<c:out value="${onlineStoreSEO.SEOPageDefinitions[0].metaDescription}"/>"/>
<meta name="keyword" content="<c:out value="${onlineStoreSEO.SEOPageDefinitions[0].metaKeyword}"/>"/>
<link rel="stylesheet" href="<c:out value="${jspStoreImgDir}${vfileStylesheet}"/>" type="text/css"/>
<!--[if lte IE 6]>
<link rel="stylesheet" href="<c:out value="${jspStoreImgDir}${vfileStylesheetie}"/>" type="text/css"/>
<![endif]-->
<!--[if gte IE 7]>
<link rel="stylesheet" href="<c:out value="${jspStoreImgDir}${vfileStylesheetie7}"/>" type="text/css"/>	
<![endif]-->
<script type="text/javascript" src="<c:out value="${dojoFile}"/>" djConfig="${dojoConfigParams}"></script>
<%@ include file="../../../include/CommonJSToInclude.jspf"%>
<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/CatalogArea/CategoryDisplay.js"/>"></script>
<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/MessageHelper.js"/>"></script>
<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/ServicesDeclaration.js"/>"></script>

<script type="text/javascript">
	dojo.addOnLoad(function() {
		categoryDisplayJS.setCommonParameters('<c:out value="${WCParam.langId}"/>','<c:out value="${WCParam.storeId}"/>','<c:out value="${WCParam.catalogId}"/>','${userType}');
		
		<fmt:message key="ERR_RESOLVING_SKU" bundle="${storeText}" var="ERR_RESOLVING_SKU" />
		<fmt:message key="QUANTITY_INPUT_ERROR" bundle="${storeText}" var="QUANTITY_INPUT_ERROR" />
		<fmt:message key="WISHLIST_ADDED" bundle="${storeText}" var="WISHLIST_ADDED" />
		<fmt:message key="SHOPCART_ADDED" bundle="${storeText}" var="SHOPCART_ADDED" />
		<fmt:message key="SHOPCART_REMOVEITEM" bundle="${storeText}" var="SHOPCART_REMOVEITEM" />
		<fmt:message key="ERROR_CONTRACT_EXPIRED_GOTO_ORDER" bundle="${storeText}" var="ERROR_CONTRACT_EXPIRED_GOTO_ORDER" />
		<fmt:message key="GENERICERR_MAINTEXT" bundle="${storeText}" var="ERROR_RETRIEVE_PRICE">                                     
			<fmt:param><fmt:message key="GENERICERR_CONTACT_US" bundle="${storeText}" /></fmt:param>
		</fmt:message>
		
		MessageHelper.setMessage("ERROR_RETRIEVE_PRICE", <wcf:json object="${ERROR_RETRIEVE_PRICE}"/>);
		MessageHelper.setMessage("ERR_RESOLVING_SKU", <wcf:json object="${ERR_RESOLVING_SKU}"/>);
		MessageHelper.setMessage("QUANTITY_INPUT_ERROR", <wcf:json object="${QUANTITY_INPUT_ERROR}"/>);
		MessageHelper.setMessage("WISHLIST_ADDED", <wcf:json object="${WISHLIST_ADDED}"/>);
		MessageHelper.setMessage("SHOPCART_ADDED", <wcf:json object="${SHOPCART_ADDED}"/>);
		MessageHelper.setMessage("SHOPCART_REMOVEITEM", <wcf:json object="${SHOPCART_REMOVEITEM}"/>);
		MessageHelper.setMessage("ERROR_CONTRACT_EXPIRED_GOTO_ORDER", <wcf:json object="${ERROR_CONTRACT_EXPIRED_GOTO_ORDER}"/>);
		
		ServicesDeclarationJS.setCommonParameters('<c:out value="${WCParam.langId}"/>','<c:out value="${WCParam.storeId}"/>','<c:out value="${WCParam.catalogId}"/>');
	});
</script>

</head>

<body>
	<%@ include file="../../../include/StoreCommonUtilities.jspf"%>
	<div id="page">
	   	<!-- Header Nav Start -->
		<%@ include file="../../../include/LayoutContainerTop.jspf"%>
		<!-- Header Nav End -->

    
		<!-- Main Content Start -->
		<div id="content_wrapper_box">

			<!-- Content Start -->
			<%@ include file="../../../include/MessageDisplay.jspf"%>
			<%out.flush();%>		
			<c:import url="${jspStoreDir}Snippets/Catalog/CategoryDisplay/CachedTopCategoriesDisplay.jsp">
				<c:param name="storeId" value="${WCParam.storeId}"/>
				<c:param name="catalogId" value="${WCParam.catalogId}"/>
				<c:param name="langId" value="${langId}"/>
				<c:param name="showLanguageCurrency" value="true"/>
				<c:param name="showContractDisplayCustomization" value="false"/>
			</c:import>
			<%out.flush();%>
			<!-- Content End -->
			
		</div>
		<!-- Main Content End -->
		
		<!-- Footer Start Start -->
		<%@ include file="../../../include/LayoutContainerBottom.jspf"%>  
		<!-- Footer Start End -->
	</div>
	<div id="page_shadow" class="shadow"></div>
	
<flow:ifEnabled feature="Analytics"><cm:pageview/></flow:ifEnabled>

</body>
</html>
<!-- END TopCategoriesDisplay.jsp -->
